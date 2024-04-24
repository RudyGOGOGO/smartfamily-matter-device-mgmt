from pydantic import BaseModel


class ProfileAccount(BaseModel):
    account_id: int
    profile_id: int
    profile_name: str
    profile_role: str
