from pydantic import BaseModel
from datetime import datetime
from typing import Optional

class RoleCreate(BaseModel):
    role_name:str
    description:Optional[str]=None

class RoleUpdate(BaseModel):
    role_name:Optional[str]=None
    description:Optional[str]=None

class RoleResponse(BaseModel):
    id:str
    role_name:str
    description:Optional[str]=None
    created_at:Optional[datetime]=None
