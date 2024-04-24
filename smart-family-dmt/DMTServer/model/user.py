from pydantic import BaseModel


class User(BaseModel):
    name: str
    password: str
    account_id: int
    profile_id: int
