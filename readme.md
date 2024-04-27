# App Introduction
The smart family device management app is a utility designed to discover, fetch, and manage smart devices that support the specific protocol known as MATTER. In addition to device management, the app also provides capabilities for managing family members’ access, including profile roles.

# Project Components && Setup Guidance
## Database
1)Path
`smartfamily-matter-device-mgmt/smart-family-dmt/DMTDB/Script.sql` 

2)Intro
The `Script.sql` file contains all MySQL queries necessary for creating tables, setting up test accounts/profiles, and initializing test devices.

3)Setup
- Ensure that the MySQL server is running
- Execute all scripts in `Script.sql` using a MySQL client (such as DBeaver).

## Server with all APIs
1)Path
`smartfamily-matter-device-mgmt/smart-family-dmt/DMTServer`

2)Intro
The `DMTServer` is based on the `FastAPI` package, implemented in Python. It exposes 9 different APIs to support all functionalities required by the current device management app.

3)Setup
- Ensure Python 3.x is installed
- install `FastAPI` package
- Run the following command to start the server on the local host (127.0.0.1) and port 8000
```
uvicorn main:app --reload --host 127.0.0.1 --port 8000
```
- Access the API documentation at http://127.0.0.1:8000/docs
- Optionally, import the provided `smartfamily-matter-device-mgmt/smart-family-dmt/Postman-APIs` into Postman for testing the APIs

## APP
1)Path
`smartfamily-matter-device-mgmt/smart-family-dmt/SmartF-DMT`

2)Intro
This app allows different users to log in, check the database script for test profiles, and call APIs to save data into the database.

3)Setup
- The app relies on API communication because different users can change device status at any time. Therefore, loading data locally is not suitable in this scenario. 
- Before running the app, ensure that the database and server are correctly set up.

# Code Coverage
- With the database and server successfully set up, all test cases defined in UITest/Unit Test can achieve 66% code coverage. Refer to the screenshot `smartfamily-matter-device-mgmt/Code Coverage.png`.
- Note that the app does not currently support mocked connections, so test execution relies on the live server