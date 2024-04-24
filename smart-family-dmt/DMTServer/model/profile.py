from pydantic import BaseModel


class Profile(BaseModel):
    profile_id: int
    name: str
    role: str
