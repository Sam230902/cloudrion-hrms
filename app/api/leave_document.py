from fastapi import APIRouter,UploadFile,File,Depends
import shutil
import os
from app.crud.leave_document import save_document,get_documents
from app.core.dependencies import require_role

router=APIRouter(prefix="/leave-docs",tags=["Leave Document"])

UPLOAD_DIR="uploads"

os.makedirs(UPLOAD_DIR,exist_ok=True)

@router.post("/{leave_id}")
async def upload_doc(leave_id:str,file:UploadFile=File(...),user=Depends(require_role(["Employee","Manager"]))):
    file_path=f"{UPLOAD_DIR}/{file.filename}"
    with open(file_path,"wb")as buffer:
        shutil.copyfileobj(file.file,buffer)

    #save url
    file_url=file_path

    return await save_document(leave_id,file_url)

#get doc leave

@router.get("/{leave_id}")
async def get_docs(leave_id:str,user=Depends(require_role(["Employee","Manager","Admin"]))):
    return await get_documents(leave_id)