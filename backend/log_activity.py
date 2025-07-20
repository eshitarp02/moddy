import os
import json
import boto3
import logging
from botocore.exceptions import ClientError

def validate_activity(data):
    required_fields = ['user_id', 'timestamp', 'activity_type', 'title']
    for field in required_fields:
        if field not in data or not data[field]:
            return False, f"Missing or empty field: {field}"
    return True, ""

def lambda_handler(event, context):
    logger = logging.getLogger()
    logger.setLevel(logging.INFO)
    s3 = boto3.client('s3')
    BUCKET_NAME = os.environ.get('S3_BUCKET', 'moodmark-user-logs')
    try:
        body = event.get('body')
        if isinstance(body, str):
            data = json.loads(body)
        else:
            data = body
        valid, msg = validate_activity(data)
        if not valid:
            logger.warning(f"Validation failed: {msg}")
            return {
                "statusCode": 400,
                "body": json.dumps({"error": msg})
            }
        user_id = str(data['user_id'])
        timestamp = str(data['timestamp'])
        activity_type = str(data['activity_type'])
        title = str(data['title'])
        description = str(data.get('description', ''))
        bookmark = data.get('bookmark')
        safe_user_id = "".join(c for c in user_id if c.isalnum() or c in ('-', '_'))
        safe_timestamp = "".join(c for c in timestamp if c.isdigit())
        s3_key = f"{safe_user_id}/activity_{safe_timestamp}.json"
        activity_log = {
            "user_id": safe_user_id,
            "timestamp": safe_timestamp,
            "activity_type": activity_type,
            "title": title,
            "description": description,
            "bookmark": bookmark
        }
        s3.put_object(
            Bucket=BUCKET_NAME,
            Key=s3_key,
            Body=json.dumps(activity_log),
            ContentType='application/json'
        )
        logger.info(f"Activity log saved: {s3_key}")
        return {
            "statusCode": 200,
            "body": json.dumps({"message": "Activity logged successfully."})
        }
    except (ValueError, json.JSONDecodeError):
        logger.exception("Invalid JSON input.")
        return {
            "statusCode": 400,
            "body": json.dumps({"error": "Invalid JSON input."})
        }
    except ClientError as e:
        logger.exception("S3 error.")
        return {
            "statusCode": 500,
            "body": json.dumps({"error": "Failed to save activity log."})
        }
    except Exception as e:
        logger.exception("Unexpected error.")
        return {
            "statusCode": 500,
            "body": json.dumps({"error": "Internal server error."})
        }
