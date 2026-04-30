from fastapi import APIRouter, Depends
from typing import List
from app.schemas.role import RoleCreate, RoleUpdate, RoleResponse
from app.crud.role import (
    create_role, get_roles, update_role, delete_role
)
from app.core.dependencies import require_role

router = APIRouter(prefix="/roles", tags=["Role Management"])


@router.post("/", response_model=RoleResponse)
async def create(role: RoleCreate, user=Depends(require_role(["Admin"]))):
    return await create_role(role)


@router.get("/", response_model=List[RoleResponse])
async def list_all(user=Depends(require_role(["Admin", "Manager"]))):
    return await get_roles()


@router.put("/{role_id}", response_model=RoleResponse)
async def update(role_id: str, data: RoleUpdate, user=Depends(require_role(["Admin"]))):
    return await update_role(role_id, data)


@router.delete("/{role_id}")
async def delete(role_id: str, user=Depends(require_role(["Admin"]))):
    return await delete_role(role_id)