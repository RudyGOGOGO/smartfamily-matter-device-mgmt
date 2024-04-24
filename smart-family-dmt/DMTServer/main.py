import json
from typing import Dict, Any, List
from fastapi import FastAPI, HTTPException

from model.profileAccount import ProfileAccount
from model.profileDeviceAccessDto import ProfileDeviceAccessDto
from model.profileDeviceAccessResponse import ProfileDeviceAccessResponse, ProfileDeviceAccess
from model.profileMDResponse import MatterDeviceResponse, DeviceResponse, ProfileMDResponse
from model.profileMatterDeviceOnPid import ProfileMatterDevice
from model.updateDeviceRequest import UpdateDeviceRequest
from utils import utils
from integration import dmt_db

app = FastAPI()


db_operator = dmt_db.DmtDBOperation()


@app.get("/profile", status_code=200)
def get_all_users(user_name: str, password: str) -> Dict[str, Any]:
    pa_list = db_operator.get_profile_account(user_name, password)
    if len(pa_list) == 0:
        raise HTTPException(status_code=404, detail="Item not found")
    return utils.get_api_response(200, ProfileAccount(**pa_list[0]).dict())


@app.delete("/matterDevices", status_code=200)
def get_all_users(node_id: int) -> Dict[str, Any]:
    db_operator.delete_matter_devices_on_matter_node_id(node_id)
    return utils.get_api_response(200, {})


@app.get("/matterDevices", status_code=200)
def get_matter_devices(profile_id: int, node_id: int = 0, device_id: int = 0, operation: str = "") -> Dict[str, Any]:
    if operation == "getDevicesAccessOfAllProfiles":
        return get_matter_devices_on_account_nid_did(profile_id, node_id, device_id)
    elif operation == "getDevicesAccessOfSingleProfile":
        return get_matter_devices_on_pid_nid_did(profile_id, node_id, device_id)
    elif node_id != 0:
        return get_matter_devices_on_pid_and_nid(profile_id, node_id)
    else:
        return get_matter_devices_on_pid(profile_id)


def get_matter_devices_on_pid(profile_id: int) -> Dict[str, Any]:
    pmd_list = db_operator.get_profile_matter_devices_on_pid(profile_id)
    return get_matter_devices_helper(pmd_list)


def get_matter_devices_on_pid_and_nid(profile_id: int, nid_id: int) -> Dict[str, Any]:
    pmd_list = db_operator.get_profile_matter_devices_on_pid_and_nid(profile_id, nid_id)
    return get_matter_devices_helper(pmd_list)


def get_matter_devices_helper(pmd_list) -> Dict[str, Any]:
    if len(pmd_list) == 0:
        raise HTTPException(status_code=404, detail="Item not found")
    profile_matter_device_list: List[ProfileMatterDevice] = []
    for pmd in pmd_list:
        profile_matter_device_list.append(ProfileMatterDevice(**pmd))

    nid_md: Dict[int, MatterDeviceResponse] = {}
    for pmd in profile_matter_device_list:
        md_response = nid_md.get(pmd.node_id)
        if md_response is None:
            md_response = MatterDeviceResponse(pmd.node_id, pmd.node_name, [])
        md_response.devices.append(DeviceResponse(pmd.device_id, pmd.device_name, pmd.access, pmd.status, pmd.location))
        nid_md[pmd.node_id] = md_response

    pmd_response = ProfileMDResponse(list(nid_md.values()))
    pmd_response.matter_list.sort(key=lambda x: x.node_id, reverse=True)
    resp = utils.get_api_response(200, json.loads(json.dumps(pmd_response, default=lambda o: o.__dict__)))
    return resp


def get_matter_devices_on_account_nid_did(profile_id: int, node_id: int, device_id: int) -> Dict[str, Any]:
    pda_list = db_operator.get_profile_matter_devices_on_account_nid_did(profile_id, node_id, device_id)
    if len(pda_list) == 0:
        raise HTTPException(status_code=404, detail="Item not found")
    profile_device_access_dto_list: List[ProfileDeviceAccessDto] = []
    for pda in pda_list:
        profile_device_access_dto_list.append(ProfileDeviceAccessDto(**pda))
    pda_list = []
    for pda_dto in profile_device_access_dto_list:
        pda_list.append(ProfileDeviceAccess(pda_dto.device_id, pda_dto.node_id, pda_dto.access, pda_dto.location, pda_dto.profile_id, pda_dto.profile_name, pda_dto.profile_role))
    pmd_response = ProfileDeviceAccessResponse(pda_list)
    return utils.get_api_response(200, json.loads(json.dumps(pmd_response, default=lambda o: o.__dict__)))


def get_matter_devices_on_pid_nid_did(profile_id: int, node_id: int, device_id: int) -> Dict[str, Any]:
    pda_list = db_operator.get_profile_matter_devices_on_pid_nid_did(profile_id, node_id, device_id)
    if len(pda_list) == 0:
        raise HTTPException(status_code=404, detail="Item not found")
    profile_device_access_dto_list: List[ProfileDeviceAccessDto] = []
    for pda in pda_list:
        profile_device_access_dto_list.append(ProfileDeviceAccessDto(**pda))
    pda_list = []
    for pda_dto in profile_device_access_dto_list:
        pda_list.append(ProfileDeviceAccess(pda_dto.device_id, pda_dto.node_id, pda_dto.access, pda_dto.location, pda_dto.profile_id, pda_dto.profile_name, pda_dto.profile_role))
    pmd_response = ProfileDeviceAccessResponse(pda_list)
    return utils.get_api_response(200, json.loads(json.dumps(pmd_response, default=lambda o: o.__dict__)))


'''
{
    "profile_id": 1001,
    "node_id": 1001,
    "operation": "updateWithSingleStatus",
    "devices": [
        {
            "device_id": 1001,
            "status": "ON"
        }
    ]
}
{
    "operation": "updateWithAccess",
    "profiles": [
        "profile_id": 1001,
        "node_id": 1001,
        "devices": [
            {
                "device_id": 1001,
                "access": true,
            }
        ]
    ] 
    
}
'''


@app.put("/matterDevices", status_code=200)
def update_matter_devices(req_dict: Dict[str, Any]) -> Dict[str, Any]:
    req = UpdateDeviceRequest(req_dict)
    if req.operation == "updateWithSingleStatus":
        device_id_list = [device.device_id for device in req.devices]
        db_operator.update_device_status(device_id_list, req.devices[0].status)
    elif req.operation == "updateWithSingleAccess":
        db_operator.update_profile_device_access(req.profile_id, req.node_id, req.devices[0].device_id, req.devices[0].access)
    elif req.operation == "updateWithSingleLocation":
        db_operator.update_device_location(req.devices[0].device_id, req.devices[0].location)
    return utils.get_api_response(200, {})


@app.post("/discover", status_code=200)
def discover_new_matter_devices(profile_id: int) -> Dict[str, Any]:
    db_operator.discover_new_matter_devices()
    return get_matter_devices_on_pid(profile_id)
