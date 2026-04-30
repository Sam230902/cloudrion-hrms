from pydantic import BaseModel
from datetime import date,datetime
from typing import Optional

class TimesheetCreate(BaseModel):
    employee_id:str
    date:date
    project_name:str
    task_description:str
    hours_logged:float
    billable:bool

class TimesheetApprove(BaseModel):
    status:str

class TimesheetResponse(BaseModel):
    id:str
    employee_id:str
    date:date
    project_name:str
    task_description:str
    hours_logged:float
    billable:bool
    status:str
    created_at:datetime