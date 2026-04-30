from fastapi import APIRouter,Depends
from app.schemas.employee import EmployeeCreate
from app.crud.employee import create_employee,get_all_employees
from app.core.dependencies import require_role

router=APIRouter(prefix="/employees")

@router.post("/")
async def create(emp:EmployeeCreate,user=Depends(require_role(["Admin"]))):
    return await create_employee(emp)

@router.get("/")
async def list_all(user=Depends(require_role(["Admin","Manager"]))):
    return await get_all_employees()

@router.get("/me")
async def my_profile(user=Depends(require_role(["Admin","Manager","Employee"]))):
    return user
