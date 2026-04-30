from pydantic import BaseModel
from datetime import datetime,date

class LeavePredictionResponse(BaseModel):
    id:str
    employee_id:str
    prediction_date:date
    leave_probability:float
    risk_leave:str
    model_version:str
    created_at:datetime