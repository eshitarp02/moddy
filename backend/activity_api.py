
import os
import json
import uuid
from pymongo import MongoClient
from datetime import datetime

def get_db():
    uri = os.environ.get('DOCDB_URI')  # e.g., ...:27017/?retryWrites=false
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
        serverSelectionTimeoutMS=5000,
    )
    return client['moodmark']

def _resp(status, body_dict):
    return {
        "statusCode": status,
        "headers": {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
        },
        "body": json.dumps(body_dict),
    }

def lambda_handler(event, context):
    db = get_db()
    activities = db['activities']
    users = db['users']

    method = (event.get('httpMethod') or '').upper()
    path = event.get('path') or ''
    qs = event.get('queryStringParameters') or {}

    # Safely parse body
    body = event.get('body')
    if isinstance(body, str):
        try:
            data = json.loads(body)
        except Exception:
            data = {}
    else:
        data = body or {}

    # Helper to read/convert query params
    def get_param(name, default=None, cast=None):
        val = qs.get(name, default)
        if val is None or val == '':
            return default
        if cast:
            try:
                return cast(val)
            except Exception:
                return default
        return val

    # -----------------------------
    # POST /activity-log  (create)
    # -----------------------------
    if method == 'POST' and path.endswith('/activity-log'):
        userId = data.get('userId')
        activityType = data.get('activityType')
        description = data.get('description')

        if not userId or not users.find_one({'userId': userId}):
            return _resp(400, {"error": "Invalid or missing userId"})
        if not activityType or not description:
            return _resp(400, {"error": "Missing mandatory field: activityType or description"})

        # Store timestamps as ISO-8601 strings (consistent with your current code)
        now_iso = datetime.utcnow().isoformat()
        activity = {
            "activityId": str(uuid.uuid4()),
            "userId": userId,
            "activityType": activityType,
            "description": description,
            "bookmark": data.get('bookmark'),
            "mood": data.get('mood'),
            "timestamp": data.get('timestamp', now_iso),
            "lastUpdated": now_iso,
        }
        activities.insert_one(activity)
        return _resp(201, {"message": "Activity logged", "activityId": activity["activityId"]})

    # -----------------------------
    # PUT /activity-log  (update)
    # -----------------------------
    if method == 'PUT' and path.endswith('/activity-log'):
        activityId = data.get('activityId')
        if not activityId:
            return _resp(400, {"error": "Missing activityId"})

        # Allow updating the same fields you create (description, not 'details')
        allowed = ["activityType", "description", "mood", "timestamp", "bookmark"]
        update_fields = {k: v for k, v in data.items() if k in allowed}
        update_fields['lastUpdated'] = datetime.utcnow().isoformat()

        result = activities.update_one({"activityId": activityId}, {"$set": update_fields})
        if result.matched_count:
            return _resp(200, {"message": "Activity updated"})
        else:
            return _resp(404, {"error": "Activity not found"})

    # --------------------------------------------------------
    # GET /activity-log  (filters + pagination via querystring)
    # --------------------------------------------------------
    if method == 'GET' and path.endswith('/activity-log'):
        user_id = get_param('userId')
        activity_type = get_param('activityType')
        page = get_param('page', 1, int)
        page_size = get_param('pageSize', 10, int)
        start_date = get_param('startDate')  # ISO-8601 string expected
        end_date = get_param('endDate')
        sort_order = int(get_param('sortOrder', 1))  # 1=asc, 0=desc
        sort_dir = 1 if sort_order == 1 else -1

        # Build Mongo query
        query = {}
        if user_id:
            query['userId'] = user_id
        if activity_type:
            query['activityType'] = activity_type
        if start_date or end_date:
            query['timestamp'] = {}
            if start_date:
                query['timestamp']['$gte'] = start_date
            if end_date:
                query['timestamp']['$lte'] = end_date

        total = activities.count_documents(query)
        cursor = (
            activities.find(query)
            .sort("timestamp", sort_dir)
            .skip(max(0, (page - 1) * page_size))
            .limit(page_size)
        )

        items = [{k: v for k, v in doc.items() if k != '_id'} for doc in cursor]
        count = len(items)
        total_pages = (total + page_size - 1) // page_size if page_size > 0 else 1

        return _resp(200, {
            "items": items,
            "page": page,
            "pageSize": page_size,
            "count": count,
            "total": total,
            "totalPages": total_pages,
            "hasNextPage": (page * page_size) < total,
            "hasPrevPage": page > 1,
            "appliedFilters": {
                "userId": user_id,
                "activityType": activity_type,
                "startDate": start_date,
                "endDate": end_date,
                "page": page,
                "pageSize": page_size
            }
        })

    # ---------------------------------------
    # GET /user-logs/{userId} (legacy endpoint)
    # ---------------------------------------
    if method == 'GET' and '/user-logs/' in path:
        userId = path.split('/user-logs/')[-1]
        if not userId:
            return _resp(400, {"error": "Missing userId"})
        startDate = get_param('startDate')
        endDate = get_param('endDate')
        query = {"userId": userId}
        if startDate or endDate:
            query['timestamp'] = {}
            if startDate:
                query['timestamp']['$gte'] = startDate
            if endDate:
                query['timestamp']['$lte'] = endDate
        page = get_param('page', 1, int)
        page_size = get_param('pageSize', 10, int)
        cursor = activities.find(query).sort("timestamp", -1).skip(max(0, (page - 1) * page_size)).limit(page_size)
        logs = [{k: v for k, v in doc.items() if k != '_id'} for doc in cursor]
        return _resp(200, {"logs": logs, "page": page, "pageSize": page_size})

    return _resp(400, {"error": "Invalid request"})
