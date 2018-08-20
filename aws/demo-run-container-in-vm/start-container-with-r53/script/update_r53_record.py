from __future__ import print_function
import os
import re
import botocore
import boto3
import json


# main
def handler(event, context):
    # receive
    project_name = os.environ.get('project_name')
    dns_zone_name = os.environ.get('dns_zone_name')
    dns_zone_id = os.environ.get('dns_zone_id')
    # event
    message = 'Receive Event {}'.format(json.dumps(event, indent=2))
    print("Receive Variable {} {} {}, Receive Event {}".format(
        project_name, dns_zone_name, dns_zone_id, message))

    ec2 = boto3.resource('ec2')
    route53 = boto3.client('route53')

    instance_id = event['detail']['instance-id']
    instance = ec2.Instance(instance_id)
    instance_ip = instance.private_ip_address
    instance_name = search(instance.tags, 'Name')

    print("Processing: {0}".format(instance_id))

    if not is_valid_hostname("{0}.atomic.aws.".format(instance_name)):
        print("Invalid hostname! No changes made.")
        return {'status': "Invalid hostname"}

    dns_changes = {
        'Changes': [
            {
                'Action': 'UPSERT',
                'ResourceRecordSet': {
                    'Name': "{0}.atomic.aws.".format(instance_name),
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


def search(dicts, search_for):
    for item in dicts:
        if search_for == item['Key']:
            return item['Value']
    return None


def is_valid_hostname(hostname):
    if len(hostname) > 255:
        return False
    if hostname[-1] == ".":
        hostname = hostname[:-1]
    allowed = re.compile("(?!-)[A-Z\d-]{1,63}(?<!-)$", re.IGNORECASE)
    return all(allowed.match(x) for x in hostname.split("."))
