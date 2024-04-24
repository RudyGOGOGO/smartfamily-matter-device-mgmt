from pydantic import BaseModel


class ProfileDeviceAccessDto(BaseModel):
    device_id: int
    node_id: int
    access: bool
    location: str
    profile_id: int
    profile_name: str
    profile_role: str

