from fastapi import APIRouter, HTTPException
from datetime import datetime

from app.database import db
from app.schemas.auth import LoginSchema
from app.schemas.employee import EmployeeCreate

from app.core.auth import create_token
from app.core.security import (
    verify_password,
    hash_password
)

router = APIRouter()

# ================= LOGIN =================
@router.post("/login")
async def login(data: LoginSchema):

    try:

        user = await db.employees.find_one({
            "email": data.email
        })

        if not user:

            raise HTTPException(
                status_code=404,
                detail="User Not Found"
            )

        if not verify_password(
            data.password,
            user["password_hash"]
        ):

            raise HTTPException(
                status_code=401,
                detail="Invalid Password"
            )

        token = create_token({

            "email": user["email"],
            "role": user["role"]
        })

        return {

            "message": "Login Successful",

            "access_token": token,

            "role": user["role"],

            "name": user["first_name"]
        }

    except HTTPException:
        raise

    except Exception as e:

        print("LOGIN ERROR:", repr(e))

        raise HTTPException(
            status_code=500,
            detail=str(e)
        )

# ================= REGISTER =================
@router.post("/register")
async def register(emp: EmployeeCreate):

    try:

        existing = await db.employees.find_one({
            "email": emp.email
        })

        if existing:

            raise HTTPException(
                status_code=400,
                detail="Email already exists"
            )

        emp_dict = emp.dict()

        emp_dict["joining_date"] = datetime(

            emp.joining_date.year,
            emp.joining_date.month,
            emp.joining_date.day
        )

        emp_dict["password_hash"] = hash_password(
            emp.password
        )

        del emp_dict["password"]

        await db.employees.insert_one(
            emp_dict
        )

        return {
            "message":
                "Registration successful"
        }

    except HTTPException:
        raise

    except Exception as e:

        print("REGISTER ERROR:", repr(e))

        raise HTTPException(
            status_code=500,
            detail=str(e)
        )