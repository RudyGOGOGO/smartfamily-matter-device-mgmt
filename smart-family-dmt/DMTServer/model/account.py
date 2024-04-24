from pydantic import BaseModel


class Account(BaseModel):
    account_id: int
    ts: int
