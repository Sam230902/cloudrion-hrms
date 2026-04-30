from fastapi import APIRouter,Depends
from app.schemas.holiday import HolidayCreate
from app.crud.holiday import create_holiday, get_holidays
from app.core.dependencies import require_role

router=APIRouter(prefix="/holidays",tags=["Holiday"])

#create holiday

@router.post("/")
async def create(data:HolidayCreate,user=Depends(require_role(["Admin"]))):
    return await create_holiday(data)

@router.get("/")
async def list_all(user=Depends(require_role(["Admin","Manager","Employee"]))):
    return await get_holidays()