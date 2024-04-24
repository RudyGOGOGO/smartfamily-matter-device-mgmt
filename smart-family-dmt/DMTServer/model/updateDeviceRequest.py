from typing import Dict, Any

from pydantic import BaseModel


class Device:
    device_id: int
    access: bool
    status: str
    location: str

    def __init__(self, device_dict: Dict[str, Any]):
        self.device_id = device_dict.get("device_id")
        self.access = device_dict.get("access")
        self.status = device_dict.get("status")
        self.location = device_dict.get("location")


class UpdateDeviceRequest:
    profile_id: int
    node_id: int
    operation: str
    devices: [Device]

    def __init__(self, req_dict: Dict[str, Any]):
        self.profile_id = req_dict.get("profile_id")
        self.node_id = req_dict.get("node_id")
        self.operation = req_dict.get("operation")
        self.devices = [Device(device_dict) for device_dict in req_dict.get("devices")]
