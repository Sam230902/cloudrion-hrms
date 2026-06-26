from pydantic import BaseModel
from typing import Optional
from datetime import date,datetime

class AttendanceCreate(BaseModel):
    employee_id:str
    date:date
    check_in_time:Optional[str]=None
    check_out_time:Optional[str]=None

class AttendanceResponse(BaseModel):
    id:str
    employee_id:str
    date:date
    check_in_time:Optional[str]=None
    check_out_time:Optional[str]=None
    check_hours:Optional[float]=None
    status:str
    late_flag:bool
    early_exit_flag:bool
    created_at:Optional[datetime]=None

class CheckoutSchema(BaseModel):
    employee_id:str
    date:str
    check_out_time:str
