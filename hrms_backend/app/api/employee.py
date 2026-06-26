from fastapi import APIRouter, Depends, UploadFile, File, Form
from app.schemas.employee import EmployeeCreate
from app.crud.employee import create_employee,get_all_employees,get_employee,update_employee,delete_employee
from app.core.dependencies import require_role
import os

router = APIRouter(prefix="/employees",tags=["Employees"])

# create emp
@router.post("/")
async def create(
    employee_id: str = Form(...),
    employee_code: str = Form(...),
    first_name: str = Form(...),
    middle_name: str = Form(""),
    last_name: str = Form(...),
    email: str = Form(...),
    phone: str = Form(...),
    password: str = Form(...),
    role: str = Form(...),
    manager_id: str = Form(""),
    department: str = Form(...),
    designation: str = Form(...),
    joining_date: str = Form(...),
    status: str = Form("Active"),
    profile_image: UploadFile = File(None),
):

    image_path = ""
    image_url=""

    if profile_image:

        os.makedirs("uploads", exist_ok=True)
        filename=profile_image.filename

        image_path = f"uploads/{filename}"

        with open(image_path, "wb") as buffer:
            buffer.write(await profile_image.read())

        image_url=f"http://127.0.0.1:8000/uploads/{filename}"

    employee_data = {
        "employee_id": employee_id,
        "employee_code": employee_code,
        "first_name": first_name,
        "middle_name": middle_name,
        "last_name": last_name,
        "email": email,
        "phone": phone,
        "password": password,
        "role": role,
        "manager_id": manager_id,
        "department": department,
        "designation": designation,
        "joining_date": joining_date,
        "status": status,
        "profile_image": image_url if profile_image else "",
    }

    return await create_employee(employee_data)

#get all
@router.get("/")
async def list_all( ):
    return await get_all_employees()

#my profile
@router.get("/me")
async def my_profile(user=Depends(require_role(["Super Admin","Admin","HR Manager","Employee"]))):
    return user

#get single emp
@router.get("/{id}")
async def get_single_employee(id: str,user=Depends(require_role(["Super Admin","Admin","HR Manager"]))):
    return await get_employee(id)

#update
@router.put("/{id}")
async def update_emp(id: str,data: dict):
    return await update_employee(id,data)

#del
@router.delete("/{id}")
async def delete_emp(id: str):
    return await delete_employee(id)