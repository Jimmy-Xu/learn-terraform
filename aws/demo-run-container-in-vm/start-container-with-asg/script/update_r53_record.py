from __future__ import print_function
import os
import re
import botocore
import boto3
import json
import traceback


# main
def handler(event, context):
    # get parameters
    project_name = os.environ.get('project_name')
    dns_zone_name = os.environ.get('dns_zone_name')
    dns_zone_id = os.environ.get('dns_zone_id')

    # get event
    message = 'Receive Event {}'.format(json.dumps(event, indent=2))
    print("Receive Variable {} {} {}, Receive Event {}".format(
        project_name, dns_zone_name, dns_zone_id, message))
    instance_id = event['detail']['instance-id']
    instance_state = event['detail']['state']
    print("InstanceId: {0} InstanceState: {1}".format(instance_id, instance_state))

    try:
        ec2 = boto3.resource('ec2')
        route53 = boto3.client('route53')
        
        # get instance detail
        instance = ec2.Instance(instance_id)
        instance_ip = instance.private_ip_address
        instance_name = search(instance.tags, 'Name')
        service_name = search(instance.tags, 'ServiceName')

        print("Processing: {0} Name: {1} ServiceName: {2}".format(instance_i, instance_name, service_name))

        if not is_valid_hostname("{0}.{1}.".format(service_name,dns_zone_name)):
            print("Invalid service name! No changes made.")
            return {'status': "Invalid service name"}

        dns_changes = {
            'Changes': [
                {
                    'Action': 'UPSERT',
                    'ResourceRecordSet': {
                        'Name': "{0}.{1}.".format(service_name,dns_zone_name),
                        'Type': 'A',
                        'ResourceRecords': [
                            {
                                'Value': instance_ip
                            }
                        ],
                        'TTL': 300
                    }
                }
            ]
        }

        print("Updating Route53 to create:")
        print("{0} IN A {1}".format(instance_name, instance_ip))

        response = route53.change_resource_record_sets(
            HostedZoneId=dns_zone_id,
            ChangeBatch=dns_changes
        )
        return {'status': response['ChangeInfo']['Status']}
    except Exception, err:
        print(traceback.format_exc())
        return {'status': "",'error': err}


def search(dicts, search_for):
    for item in dicts:
        if search_for == item['Key']:
            return item['Value']
    return ""


def is_valid_hostname(hostname):
    if len(hostname) > 255:
        return False
    if hostname[-1] == ".":
        hostname = hostname[:-1]
    allowed = re.compile("(?!-)[A-Z\d-]{1,63}(?<!-)$", re.IGNORECASE)
    return all(allowed.match(x) for x in hostname.split("."))
