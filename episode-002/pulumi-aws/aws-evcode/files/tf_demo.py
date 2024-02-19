import json
import urllib.parse
import boto3


# Function based on documentation:
# https://boto3.amazonaws.com/v1/documentation/api/latest/guide/sqs-example-sending-receiving-msgs.html


def lambda_handler(event, context):
    print("Received event: " + json.dumps(event, indent=2))

    if 'body' in event:
        message = str(json.loads(str(event['body'])))
    elif 'queryStringParameters' in event:
        message = str(event['queryStringParameters'])
    else:
        message = "empty message"

    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps({
            "RequestID ": context.aws_request_id,
            "ReceivedMessage": message
        })
    }