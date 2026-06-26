from app.database import db
from app.core.security import hash_password
from datetime import datetime
from fastapi import HTTPException
from bson import ObjectId
from pymongo.errors import DuplicateKeyError

#create emp
async def create_employee(emp_dict):

    existing = await db.employees.find_one({
        "email":emp_dict["email"]
    })
    if existing:
        raise HTTPException(
            status_code=400,
            detail="Email already exists"
        )
    emp_dict["password_hash"] = hash_password(
        emp_dict["password"]
    )
    del emp_dict["password"]
    emp_dict["joining_date"] = str(

        emp_dict["joining_date"]
    )
    emp_dict["status"] = "Active"
    emp_dict["created_at"] = datetime.utcnow()
    emp_dict["updated_at"] = datetime.utcnow()
    result = await db.employees.insert_one(emp_dict)
    return {
        "message":"Employee Created Successfully",
        "id":str(result.inserted_id)
    }


#all emp
async def get_all_employees():
    employees = []
    async for emp in db.employees.find():
        emp["id"] = str(emp["_id"])
        del emp["_id"]
        if "password_hash" in emp:
            del emp["password_hash"]
        employees.append(emp)
    return employees

#single emp
async def get_employee(id: str):
    employee = await db.employees.find_one({"_id":ObjectId(id)})
    if not employee:
        raise HTTPException(
            status_code=404,
            detail="Employee not found"
        )
    employee["id"] = str(employee["_id"])
    del employee["_id"]
    if "password_hash" in employee:
        del employee["password_hash"]
    return employee

#update emp
async def update_employee(id: str, data: dict):

    try:

        # Email already used by another employee?
        if "email" in data:

            existing = await db.employees.find_one({
                "email": data["email"],
                "_id": {"$ne": ObjectId(id)}
            })

            if existing:
                raise HTTPException(
                    status_code=400,
                    detail="Email already exists"
                )

        if "password" in data:
            data["password_hash"] = hash_password(
                data["password"]
            )
            del data["password"]

        if "joining_date" in data:
            data["joining_date"] = str(
                data["joining_date"]
            )

        data["updated_at"] = datetime.utcnow()

        result = await db.employees.update_one(
            {"_id": ObjectId(id)},
            {"$set": data}
        )

        return {
            "message": "Employee Updated Successfully"
        }

    except DuplicateKeyError:

        raise HTTPException(
            status_code=400,
            detail="Email already exists"
        )
#del emp
async def delete_employee(id: str):
    result = await db.employees.delete_one({"_id": ObjectId(id)})
    if result.deleted_count == 0:
        raise HTTPException(
            status_code=404,
            detail="Employee not found"
        )
    return {
        "message":"Employee Deleted Successfully"
    }