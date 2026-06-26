from pydantic import BaseModel
from datetime import date,datetime
from typing import Optional

class HolidayCreate(BaseModel):
    holiday_name:str
    date:date
    type:str
    created_by:str

class HolidayResponse(BaseModel):
    id:str
    holiday_name:str
    date:date
    type:str
    created_by:str
    created_at:str