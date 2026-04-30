from pydantic import BaseModel
from typing import Optional
from datetime import datetime

class ExceptionCreate(BaseModel):
    employee_id:str
    attendance:str
    exception_type:str
    reason:str
    requested_changes:dict

class ExceptionApprove(BaseModel):
    status:str

class ExceptionResponse(BaseModel):
    id:str
    employee_id:str
    attendance:str
    exception_type:str
    reason:str
    requested_changes:dict
    approved_by:Optional[str]
    approved_at:Optional[datetime]
