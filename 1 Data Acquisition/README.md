## Installation and Setup

To ensure all dependencies (including the Movella DOT PC SDK and system libraries like **openssl** and **zlib**) are installed correctly, use the provided `environment.yml` file.

### 1. Create the Environment
Open your terminal or Anaconda Prompt, navigate to this project folder, and run:

```bash
conda env create -f environment.yml
```

### 2. Activate the Environment
Once the installation is complete, activate the environment to load the dependencies:

```bash
conda activate
```

---

## Data Acquisition

After activating the environment, you can run the example scripts to interface with your sensors.

### Run the Export Script
To collect and export data from a dual IMU setup, use:

```bash
python dual_imu_export.py
```

> **Note:** Ensure your Movella DOT sensors are powered on and within range of your Bluetooth adapter.
