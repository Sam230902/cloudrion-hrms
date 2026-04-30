from pydantic import BaseModel
from datetime import datetime

class LeaveAnalyticsResponse(BaseModel):
    id:str
    employee_id:str
    month:str
    friday_leave_count:int
    monday_leave_count:int
    bridge_leave_count:int
    continuous_leave_blocks:int
    misuse_score:int
    risk_level:str
    generated_at:datetime

