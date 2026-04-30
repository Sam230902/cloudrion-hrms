from pydantic import BaseModel
from typing import Optional

class LeaveBalanceCreate(BaseModel):
    employee_id:str
    cl_balance:int=0
    sl_balance:int=0
    el_balance:int=0

class LeaveBalanceUpdate(BaseModel):
    cl_balance:Optional[int]=None
    sl_balance:Optional[int]=None
    el_balance:Optional[int]=None