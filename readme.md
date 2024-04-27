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
Server `DMTServer` is based on `FastAPI` package by using `Python`, it exposes 9 different APIs to support all functionalities required by the current device management APP. 

3)Setup
- Python 3.x is required
- install `FastAPI` package
- run the following command `uvicorn main:app --reload --host 127.0.0.1 --port 8000` to start the server using the local host 127.0.0.1
- use the following URL in the browser to check whether the server successfully gets up `http://127.0.0.1:8000/docs` which supports the API calls
- Note: You can import `smartfamily-matter-device-mgmt/smart-family-dmt/Postman-APIs` to Postman if u want to play with those APIs in Postman

## APP
1)Path
`smartfamily-matter-device-mgmt/smart-family-dmt/SmartF-DMT`

2)Intro
This app allows different users to login, check the Database script for test profiles. It calls APIs to save data into the database

3)Setup
This app replies on the API communication since different users can change the device status at any time, so loading data locally does not work in this scenario. Therefore, please make sure you set up the database and the server correctly before running the app.

# Code Coverage
With database and server successfully set up, all test cases defined in UITest/Unit Test can have 66% code coverage, check the screen shot `smartfamily-matter-device-mgmt/Code Coverage.png`. It has not supported the mocked connection, therefore, the test execution relies on the up server.