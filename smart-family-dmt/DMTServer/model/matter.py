from pydantic import BaseModel


class Matter(BaseModel):
    node_id: int
    name: str
