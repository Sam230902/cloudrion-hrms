from app.database import db
from bson import ObjectId
from datetime import datetime

async def save_document(leave_id:str,file_url:str):
    doc={
        "leave_id":ObjectId(leave_id),
        "file_url":file_url,
        "upload_at":datetime.utcnow()
    }
    result=await db.leave_documents.insert_one(doc)
    return str(result.inserted_id)

async def get_documents(leave_id:str):
    docs=[]
    async for d in db.leave_documents.find({"leave_id":ObjectId(leave_id)}):
        d["_id"]=str(d["_id"])
        docs.append(d)
    return docs