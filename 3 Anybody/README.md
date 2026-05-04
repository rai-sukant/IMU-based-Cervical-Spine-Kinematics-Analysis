## AnyBody Modeling System (AMS) Integration

This section details the workflow for performing kinetic analysis and musculoskeletal modeling using the AnyBody Modeling System (AMS).

### 1. File Placement
Place the **C7 Occipital Markers** folder in the following directory to ensure the scripts can locate the necessary marker data:
`C:\Users\[YourUsername]\Documents`

---

### 2. Data Conversion
To translate the processed IMU data into a format compatible with AnyBody scripts (`.any`), use the provided MATLAB routines:

*   **Single Subject:** Run `Xsens_raw_to_anybody.m`
*   **Multiple Subjects:** Run `Batch_Xsens_raw_to_anybody.m`

---

### 3. Model Loading & Execution
Once the data is converted, proceed with the musculoskeletal simulation in AMS:

1.  **Load the Model:** Open AnyBody Modeling System and load the main model file found in the `Model` folder.
2.  **Define Drivers:** Ensure the scripts are pointing to the converted data from the previous step to drive the cervical spine segments.
3.  **Run Inverse Kinematics (IK):** Execute the **IK operation** in the Operations tree to synchronize the musculoskeletal model with your IMU-derived motion data.