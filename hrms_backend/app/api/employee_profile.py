from fastapi import APIRouter
from app.schemas.employee_profile import EmployeeProfile
from app.crud.employee_profile import *

router = APIRouter(
    prefix="/employee-profile",
    tags=["Employee Profile"]
)


@router.post("/")
async def create_employee_profile(
    profile: EmployeeProfile
):
    return await create_profile(
        profile.dict()
    )


@router.get("/")
async def get_all_employee_profiles():
    return await get_profiles()


@router.get("/{employee_id}")
async def get_employee_profile(
    employee_id: str
):
    return await get_profile(
        employee_id
    )


@router.put("/{id}")
async def update_employee_profile(
    id: str,
    profile: EmployeeProfile
):
    return await update_profile(
        id,
        profile.dict()
    )


@router.delete("/{id}")
async def delete_employee_profile(
    id: str
):
    return await delete_profile(id)