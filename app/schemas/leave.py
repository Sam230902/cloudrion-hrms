from pydantic import BaseModel
from datetime import date
from typing import Optional

class LeaveCreate(BaseModel):
    employee_id:str
    leave_type:str
    start_date:date
    end_date:date
    reason:str

class LeaveApprove(BaseModel):
    status:str
    comments:Optional[str]=None