from pydantic import BaseModel


class ProfileMatterDevice(BaseModel):
    device_id: int
    device_name: str
    node_id: int
    node_name: str
    access: bool
    status: str
    location: str

