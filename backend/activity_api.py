import os
import json
import uuid
from pymongo import MongoClient
from datetime import datetime

def get_db():
    uri = os.environ.get('DOCDB_URI')
    username = os.environ.get('DOCDB_USER')
    password = os.environ.get('DOCDB_PASS')
    if not uri or not username or not password:
        raise Exception("Missing DocumentDB environment variables")
    client = MongoClient(
        uri,
        username=username,
        password=password,
        tls=True,
        tlsAllowInvalidCertificates=True,
        serverSelectionTimeoutMS=5000
    )
    return client['moodmark']

def lambda_handler(event, context):
    db = get_db()
    activities = db['activities']
    users = db['users']
    method = event.get('httpMethod', '').upper()
    path = event.get('path', '')
    params = event.get('queryStringParameters') or {}
    body = event.get('body')
    if isinstance(body, str):
        try:
            data = json.loads(body)
        except Exception:
            data = {}
    else:
        data = body or {}

    # POST /log-activity
    if method == 'POST' and path.endswith('/log-activity'):
        userId = data.get('userId')
        activityType = data.get('activityType')
        description = data.get('description')
        if not userId or not users.find_one({'userId': userId}):
            return {"statusCode": 400, "body": json.dumps({"error": "Invalid or missing userId"})}
        if not activityType or not description:
            return {"statusCode": 400, "body": json.dumps({"error": "Missing mandatory field: activityType or description"})}
        activity = {
            "activityId": str(uuid.uuid4()),
            "userId": userId,
            "activityType": activityType,
            "description": description,
            "bookmark": data.get('bookmark'),
            "mood": data.get('mood'),
            "timestamp": data.get('timestamp', datetime.utcnow().isoformat()),
            "lastUpdated": datetime.utcnow().isoformat()
        }
        activities.insert_one(activity)
        return {"statusCode": 201, "body": json.dumps({"message": "Activity logged", "activityId": activity["activityId"]})}

    # PUT /log-activity
    elif method == 'PUT' and path.endswith('/log-activity'):
        activityId = data.get('activityId')
        if not activityId:
            return {"statusCode": 400, "body": json.dumps({"error": "Missing activityId"})}
        update_fields = {k: v for k, v in data.items() if k in ["activityType", "details", "mood", "timestamp"]}
        update_fields['lastUpdated'] = datetime.utcnow().isoformat()
        result = activities.update_one({"activityId": activityId}, {"$set": update_fields})
        if result.matched_count:
            return {"statusCode": 200, "body": json.dumps({"message": "Activity updated"})}
        else:
            return {"statusCode": 404, "body": json.dumps({"error": "Activity not found"})}

    # GET /user-logs/{userId}
    elif method == 'GET' and '/user-logs/' in path:
        userId = path.split('/user-logs/')[-1]
        if not userId:
            return {"statusCode": 400, "body": json.dumps({"error": "Missing userId"})}
        startDate = params.get('startDate')
        endDate = params.get('endDate')
        query = {"userId": userId}
        if startDate or endDate:
            query['timestamp'] = {}
            if startDate:
                query['timestamp']['$gte'] = startDate
            if endDate:
                query['timestamp']['$lte'] = endDate
        # Pagination
        page = int(params.get('page', 1))
        pageSize = int(params.get('pageSize', 10))
        cursor = activities.find(query).sort("timestamp", -1).skip((page-1)*pageSize).limit(pageSize)
        logs = [
            {k: v for k, v in doc.items() if k != '_id'}
            for doc in cursor
        ]
        return {"statusCode": 200, "body": json.dumps({"logs": logs, "page": page, "pageSize": pageSize})}

    else:
        return {"statusCode": 400, "body": json.dumps({"error": "Invalid request"})}
