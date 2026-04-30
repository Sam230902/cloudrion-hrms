from app.database import db
from datetime import datetime
from collections import defaultdict

async def generate_leave_analytics(employee_id,month):
    leaves=[]
    async for doc in db.leave_requests.find({"employee_id":employee_id}):
        leaves.append(doc)
    friday=0
    monday=0
    bridge=0
    continuous=0

    dates=sorted([l["start_date"]for l in leaves])
    for d in dates:
        if d.weekday()==4:
            friday+=1
        elif d.weekday()==0:
            monday+=1
    #score continuous detection
    for i in range(len(dates)-1):
        if (dates[i+1]-dates[i]).days==1:
            continuous+=1
    #missuse score
    score=friday+monday+bridge+continuous

    if score>=8:
        risk="High"
    elif score>=4:
        risk="Warning"
    else:
        risk="Normal"
    result={
        " employee_id":employee_id,
        "month":month,
        "friday_leave_count":friday,
        "monday_leave_count":monday,
        "bridge_leave_count":bridge,
        "continuous_leave_blocks":continuous,
        "misuse_score":score,
        "risk_level":risk,
        "generated_at":datetime.utcnow()
    }
    await db.leave_analytics.insert_one(result)
    return result
    
