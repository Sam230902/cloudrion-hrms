from app.database import db
from app.core.security import hash_password
from datetime import datetime

async def create_employee(emp):
    emp_dict=emp.dict()
    emp_dict["hash_password"] = hash_password(emp.password)
    del emp_dict["password"]

    emp_dict["status"]="Active"
    emp_dict["created_at"]=datetime.utcnow()
    emp_dict["updated_at"]=datetime.utcnow()

    result=await db.employees.insert_one(emp_dict)
    return str(result.inserted_id)

async def get_all_employees():
    employees=[]
    async for emp in db.employees.find():
        emp["id"]=str(emp["id"])
        employees.append(emp)
    return employees
