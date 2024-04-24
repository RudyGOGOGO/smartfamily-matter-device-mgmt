class ProfileDeviceAccess:
    device_id: int
    node_id: int
    access: bool
    location: str
    profile_id: int
    profile_name: str
    profile_role: str

    def __init__(self, device_id, node_id, access, location, profile_id, profile_name, profile_role):
        self.device_id = device_id
        self.node_id = node_id
        self.access = access
        self.location = location
        self.profile_id = profile_id
        self.profile_name = profile_name
        self.profile_role = profile_role


class ProfileDeviceAccessResponse:
    pda_list: [ProfileDeviceAccess] = []

    def __init__(self, pda_list):
        self.pda_list = pda_list
