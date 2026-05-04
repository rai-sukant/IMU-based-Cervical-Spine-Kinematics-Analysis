from xdpchandler import *
import movelladot_pc_sdk
import csv
import math
import numpy as np
import threading

# ================= CONFIG =================
FILTER_PROFILE = "General"
OUTPUT_RATE_HZ = 60 # Frequency of the Xsens DOT sensor
CSV_FILE = "xsens_data.csv"
# =========================================


# W4 -- neck 
# W5 -- head 

DEVICE_NAME_MAP = {
    "D4:22:CD:00:A9:12": "W4",  
    "D4:22:CD:00:A1:93": "W5",
}   

stop_flag = False

def wait_for_enter():
    global stop_flag
    input("\nPress ENTER to stop recording...\n")
    stop_flag = True

# ---------- HELPERS ----------
def device_label(device):
    addr = device.bluetoothAddress()
    return DEVICE_NAME_MAP.get(addr, addr)

def safe(v):
    if v is None:
        return float("nan")
    try:
        if math.isnan(v):
            return float("nan")
    except:
        pass
    return float(v)

def vec3(v):
    if v is None:
        return [float("nan")] * 3

    if isinstance(v, np.ndarray):
        return [safe(v[0]), safe(v[1]), safe(v[2])]

    try:
        return [safe(v.x()), safe(v.y()), safe(v.z())]
    except:
        return [float("nan")] * 3


def quat4(q):
    if q is None:
        return [float("nan")] * 4

    if isinstance(q, np.ndarray):
        return [safe(q[0]), safe(q[1]), safe(q[2]), safe(q[3])]

    try:
        return [safe(q.w()), safe(q.x()), safe(q.y()), safe(q.z())]
    except:
        return [float("nan")] * 4


# ================= MAIN =================
if __name__ == "__main__":

    xdpcHandler = XdpcHandler()

    if not xdpcHandler.initialize():
        print("SDK initialization failed")
        xdpcHandler.cleanup()
        exit(-1)

    print("Scanning for DOT devices...")
    xdpcHandler.scanForDots()

    dots = xdpcHandler.detectedDots()
    if len(dots) < 2:
        print("Need at least TWO DOT IMUs.")
        xdpcHandler.cleanup()
        exit(-1)

    xdpcHandler.connectDots()
    devices = xdpcHandler.connectedDots()[:2]


    # ---------- SELECT ONLY W4 & W5 ----------
    devices = [
        d for d in devices
        if d.bluetoothAddress() in DEVICE_NAME_MAP
    ]

    if len(devices) != 2:
        print("Could not find both W4 and W5 devices.")
        xdpcHandler.cleanup()
        exit(-1)

    # enforce fixed order: W4 first, W5 second
    devices.sort(key=lambda d: device_label(d))

    print("\nConnected devices:")
    for d in devices:
        print(f"  {device_label(d)} ({d.bluetoothAddress()})")

    print("\nConnected devices:")
    for d in devices:
        print(" ", d.bluetoothAddress())

    # ---------- CONFIGURE ----------
    for d in devices:
        d.setOnboardFilterProfile(FILTER_PROFILE)
        d.setOutputRate(OUTPUT_RATE_HZ)

    # ---------- START MEASUREMENT ----------
    payload = movelladot_pc_sdk.XsPayloadMode_CustomMode5

    for d in devices:
        if not d.startMeasurement(payload):
            print("Failed to start measurement:", d.bluetoothAddress())
            xdpcHandler.cleanup()
            exit(-1)

    # ---------- ENTER THREAD ----------
    threading.Thread(target=wait_for_enter, daemon=True).start()

    # ---------- CSV ----------
    with open(CSV_FILE, "w", newline="") as f:
        writer = csv.writer(f)

        header = ["sampleTimeFine"]
        for d in devices:
            addr = d.bluetoothAddress()
            header += [
                f"{addr}_acc_x", f"{addr}_acc_y", f"{addr}_acc_z",
                f"{addr}_gyro_x", f"{addr}_gyro_y", f"{addr}_gyro_z",
                f"{addr}_quat_w", f"{addr}_quat_x",
                f"{addr}_quat_y", f"{addr}_quat_z",
            ]
        writer.writerow(header)

        print("\nRecording at TRUE 100 Hz (CustomMode5)...")

        while not stop_flag:

            if not xdpcHandler.packetsAvailable():
                continue

            row = []
            ref_ts = None

            for d in devices:
                packet = xdpcHandler.getNextPacket(
                    d.portInfo().bluetoothAddress()
                )

                if packet is None:
                    row += [float("nan")] * 10
                    continue

                ts = packet.sampleTimeFine()
                if ref_ts is None:
                    ref_ts = ts

                acc = vec3(packet.calibratedAcceleration())
                gyro = vec3(packet.calibratedGyroscopeData())
                quat = quat4(packet.orientationQuaternion())

                row += acc + gyro + quat

            writer.writerow([ref_ts] + row)

    # ---------- CLEANUP ----------
    print("\nStopping measurement...")
    for d in devices:
        d.stopMeasurement()

    xdpcHandler.cleanup()

    print("\nFinished.")
    print("CSV saved as:", CSV_FILE)
