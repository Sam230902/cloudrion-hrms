from pydantic import BaseModel
from datetime import date
from typing import Optional

class WorkLocationCreate(BaseModel):
    employee_id:str
    date:date
    location_type:str
    office_name:Optional[str]=None
    remarks:Optional[str]=None

class WorkLocationResponse(BaseModel):
    id:str
    employee_id:str
    date:date
    location_type:str
    office_name:Optional[str]
    remarks:Optional[str]
