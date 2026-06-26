from pydantic import BaseModel,EmailStr
from typing import Optional
from datetime import date


class EmployeeCreate(BaseModel):
    employee_id:str
    employee_code:str
    first_name:str
    middle_name:Optional[str]=None
    last_name:str
    email:EmailStr
    phone:str
    password:str
    role:str
    manager_id:Optional[str]=None
    department:str
    designation:str
    joining_date:date
    status:Optional[str]=None

class EmployeeResponse(BaseModel):
    id:str
    employee_id:str
    employee_code:str
    first_name:str
    middle_name:Optional[str]=None
    last_name:str
    email:str
    role:str
    phone: Optional[str] = None
    department: Optional[str] = None
    designation: Optional[str] = None
    joining_date: Optional[date] = None
    status:Optional[str]=None
    profile_image: Optional[str] = None

    