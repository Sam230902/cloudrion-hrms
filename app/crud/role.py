from app.database import db
from datetime import datetime
from bson import ObjectId

# CREATE ROLE
async def create_role(role):
    role_dict = role.dict()
    role_dict["created_at"] = datetime.utcnow()

    result = await db.roles.insert_one(role_dict)
    return str(result.inserted_id)


# GET ALL ROLES
async def get_roles():
    roles = []
    async for role in db.roles.find():
        role["id"] = str(role["_id"])   
        del role["_id"]                 
        roles.append(role)
    return roles


# GET SINGLE ROLE
async def get_role(role_id: str):
    role = await db.roles.find_one({"_id": ObjectId(role_id)})
    if role:
        role["id"] = str(role["_id"])
        del role["_id"]
    return role


# UPDATE ROLE
async def update_role(role_id: str, data):
    await db.roles.update_one(
        {"_id": ObjectId(role_id)},   
        {"$set": data.dict(exclude_none=True)}
    )

    return await get_role(role_id)  


# DELETE ROLE
async def delete_role(role_id: str):
    await db.roles.delete_one({"_id": ObjectId(role_id)})  
    return {"message": "Role deleted"}