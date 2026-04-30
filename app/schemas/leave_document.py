from pydantic import BaseModel

class LeaveDocumentResponse(BaseModel):
    id:str
    leave_id:str
    file_url:str