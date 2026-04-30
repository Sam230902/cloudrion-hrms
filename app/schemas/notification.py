from pydantic import BaseModel
from datetime import datetime
from typing import Optional

class NotificationCreate(BaseModel):
    employee_id:str
    title:str
    message:str
    type:str

class NotificationResponse(BaseModel):
    id:str
    employee_id:str
    title:str
    message:str
    type:str
    is_read:bool
    created_at:datetime