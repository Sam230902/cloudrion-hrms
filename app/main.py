from fastapi import FastAPI
from app.api import(
    employee, auth, role, leave, leave_balance, leave_document,attendance,work_location,holiday,attendance_exception,timesheet,notification,leave_analytics,leave_prediction)
from app.database import db
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()



app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(auth.router)
app.include_router(employee.router)
app.include_router(role.router)
app.include_router(leave.router)
app.include_router(leave_balance.router)
app.include_router(leave_document.router)
app.include_router(attendance.router)
app.include_router(work_location.router)
app.include_router(holiday.router)
app.include_router(attendance_exception.router)
app.include_router(timesheet.router)
app.include_router(notification.router)
app.include_router(leave_analytics.router)
app.include_router(leave_prediction.router)


@app.get("/test_db")
async def test_db():
    data = []
    async for doc in db.roles.find():
        doc["_id"] = str(doc["_id"])
        data.append(doc)
    return data


