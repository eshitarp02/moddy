import json
import boto3
import os
from botocore.exceptions import ClientError

s3 = boto3.client('s3')
BUCKET_NAME = os.environ.get('S3_BUCKET', 'hobbymark-activity-logs')

CORS_HEADERS = {
    "Access-Control-Allow-Origin": "*"
}

def lambda_handler(event, context):
    try:
        user_id = event.get('queryStringParameters', {}).get('user_id')

        if not user_id:
            return {
                "statusCode": 400,
                "headers": CORS_HEADERS,
                "body": json.dumps({"error": "Missing 'user_id' in query parameters."})
            }

        # Clean user_id
        safe_user_id = "".join(c for c in user_id if c.isalnum() or c in ('-', '_'))
        prefix = f"activities/{safe_user_id}/"

        # List all objects under user's folder
        response = s3.list_objects_v2(Bucket=BUCKET_NAME, Prefix=prefix)

        if 'Contents' not in response:
            return {
                "statusCode": 404,
                "headers": CORS_HEADERS,
                "body": json.dumps({"message": "No activity logs found for user."})
            }

        activities = []

        for obj in response['Contents']:
            key = obj['Key']
            if key.endswith('.json'):
                file_obj = s3.get_object(Bucket=BUCKET_NAME, Key=key)
                content = file_obj['Body'].read().decode('utf-8')
                activities.append(json.loads(content))

        return {
            "statusCode": 200,
            "headers": CORS_HEADERS,
            "body": json.dumps({"activities": activities})
        }

    except ClientError as e:
        return {
            "statusCode": 500,
            "headers": CORS_HEADERS,
            "body": json.dumps({"error": "S3 access error.", "details": str(e)})
        }

    except Exception as e:
        return {
            "statusCode": 500,
            "headers": CORS_HEADERS,
            "body": json.dumps({"error": "Internal server error.", "details": str(e)})
        }
