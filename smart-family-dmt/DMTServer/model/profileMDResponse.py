

class DeviceResponse:
    device_id: int
    device_name: str
    access: int
    status: str
    location: str

    def __init__(self, device_id, device_name, access, status, location):
        self.device_id = device_id
        self.device_name = device_name
        self.access = access
        self.status = status
        self.location = location


class MatterDeviceResponse:
    node_id: int
    node_name: str
    devices: [DeviceResponse]

    def __init__(self, node_id, node_name, devices):
        self.node_id = node_id
        self.node_name = node_name
        self.devices = devices


class ProfileMDResponse:
    matter_list: [MatterDeviceResponse] = []

    def __init__(self, matter_list):
        self.matter_list = matter_list


# def to_dict(obj):
#     if isinstance(obj, (ProfileMDResponse, MatterDeviceResponse, DeviceResponse)):
#         return vars(obj)
#     elif isinstance(obj, list):
#         return [to_dict(item) for item in obj]
#     elif isinstance(obj, dict):
#         return {key: to_dict(value) for key, value in obj.items()}
#     else:
#         return obj
#
