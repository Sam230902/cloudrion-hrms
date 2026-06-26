from fastapi import APIRouter,Depends
from app.schemas.work_location import WorkLocationCreate
from app.crud.work_location import create_location,get_locations
from app.core.dependencies import require_role

router=APIRouter(prefix="/work-location",tags=["Work Location"])

#create wfo/remote

@router.post("/")
async def create(data:WorkLocationCreate,user=Depends(require_role(["Employee"]))):
    return await create_location(data)

#get employee

@router.get("/{eemployee_id}")
async def get(employee_id:str,user=Depends(require_role(["Admin","Manager","Employee"]))):
    return await get_locations(employee_id)