from fastapi import APIRouter,Depends
from app.schemas.notification import NotificationCreate
from app.crud.notification import create_notification,get_notification,mark_as_read
from app.core.dependencies import require_role

router=APIRouter(prefix="/notifications",tags=["Notification"])

#create admin

@router.post("/")
async def create(data:NotificationCreate,user=Depends(require_role(["Admin","Manager"]))):
    return await create_notification(data)

#get me notification

@router.get("/{employee_id}")
async def get_all(employee_id:str,user=Depends(require_role(["Employee","Manager","Admin"]))):
    return await get_notification(employee_id)

#mark as read

@router.put("/{notification_id}")
async def read(notification_id:str,user=Depends(require_role(["Employee","Manager","Admin"]))):
    return await mark_as_read(notification_id)
