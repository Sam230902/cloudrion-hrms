from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.openapi.utils import get_openapi
from fastapi.security import HTTPBearer
from app.api import employee,auth,role,leave,leave_balance,leave_document,attendance,work_location,holiday,attendance_exception,timesheet,notification,leave_analytics,leave_prediction,employee_profile
from app.database import db
from app.api import dashboard
from fastapi.staticfiles import StaticFiles

app = FastAPI()

#jwt security
security = HTTPBearer()

#cors
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
#image
app.mount(
    "/uploads",
    StaticFiles(directory="uploads"),
    name="uploads",
)
# Routers
app.include_router(auth.router, prefix="/auth", tags=["Authentication"])
app.include_router(dashboard.router,prefix="/dashboard",tags=["Dashboard"])
app.include_router(employee.router)
app.include_router(employee_profile.router)
app.include_router(attendance.router)
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

#database
@app.on_event("startup")
async def startup_db():
    try:
        await db.command("ping")
        print("✅ MongoDB Connected")
    except Exception as e:
        print("❌ MongoDB Error:", e)


# Swagger JWT Authorize Button
def custom_openapi():

    if app.openapi_schema:
        return app.openapi_schema

    openapi_schema = get_openapi(
        title="HRMS API",
        version="1.0.0",
        description="HRMS Backend APIs",
        routes=app.routes,
    )

    openapi_schema["components"]["securitySchemes"] = {
        "BearerAuth": {
            "type": "http",
            "scheme": "bearer",
            "bearerFormat": "JWT"
        }
    }

    openapi_schema["security"] = [
        {
            "BearerAuth": []
        }
    ]

    app.openapi_schema = openapi_schema

    return app.openapi_schema


app.openapi = custom_openapi


@app.get("/")
async def root():
    return {
        "message": "HRMS Backend Running"
    }