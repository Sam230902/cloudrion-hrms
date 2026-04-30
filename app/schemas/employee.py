from pydantic import BaseModel,EmailStr
from typing import Optional
from datetime import date

class EmployeeCreate(BaseModel):
    employee_code:str
    first_name:str
    last_name:str
    email:EmailStr
    phone:str
    password:str
    role:str
    manager_id:Optional[str]=None
    department:str
    designation:str
    joining_date:date

class EmployeeResponse(BaseModel):
    id:str
    employee_code:str
    first_name:str
    last_name:str
    email:str
    role:str
    phone: Optional[str] = None
    department: Optional[str] = None
    designation: Optional[str] = None
    joining_date: Optional[date] = None