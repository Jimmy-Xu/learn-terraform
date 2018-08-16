import os
import boto3
import botocore
import json

def handler_name(event, context):
    # receive
    project_name = os.environ.get('project_name')
    dns_zone_name = os.environ.get('dns_zone_name')
    # event
    message = 'Receive Event {}'.format(json.dumps(event, indent=2))
    print("Receive Variable {} {}, Receive Event {}".format(project_name, dns_zone_name, message))
    return {
        'message' : message
    }
