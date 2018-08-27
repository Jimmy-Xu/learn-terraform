#!/usr/bin/python
# -*- coding: utf-8 -*-

from __future__ import print_function
import json
import boto3
from datetime import datetime


def handler(event, context):

    print('Loading function.')
    now = datetime.utcnow()
    ec2Client = boto3.client('ec2')
    cwClient = boto3.client('cloudwatch')

    response = ec2Client.describe_spot_instance_requests(Filters=[{
        'Name': 'state',
        'Values': ['active'],
        'Name': 'status-code',
        'Values': ['fulfilled'],
        }])

    instances = response['SpotInstanceRequests']
    for i in instances:
        response = ec2Client.describe_spot_price_history(
            StartTime=now,
            EndTime=now, 
            InstanceTypes=[i['LaunchSpecification']['InstanceType']],
            AvailabilityZone=i['LaunchedAvailabilityZone'],
            ProductDescriptions=[i['ProductDescription']]
        )
        pricehistory = response['SpotPriceHistory']
        if pricehistory == []:
            response = ec2Client.describe_spot_price_history(
                StartTime=now,
                EndTime=now, 
                InstanceTypes=[i['LaunchSpecification']['InstanceType']],
                AvailabilityZone=i['LaunchedAvailabilityZone'],
                ProductDescriptions=[i['ProductDescription'] + ' (Amazon VPC)']
            )
            pricehistory = response['SpotPriceHistory']

        try:
            response = ec2Client.create_tags(
                Resources=[i['InstanceId']],
                Tags=[{
                    'Key': 'EC2 Spot Market Price',
                    'Value': pricehistory[0]['SpotPrice']
                }]
            )
        except:
            print('Unable to create tag for InstanceId:', i['InstanceId'])

        try:
            response = ec2Client.create_tags(
                Resources=[i['InstanceId']], 
                Tags=[{
                    'Key': 'EC2 Spot Bid Price',
                    'Value': i['SpotPrice']
                }]
            )
        except:
            print('Unable to create tag for InstanceId:', i['InstanceId'])

        for t in i['Tags']:
            if t['Key'] == 'aws:ec2spot:fleet-request-id':
                try:
                    cwClient.put_metric_data(
                        Namespace='EC2 Spot Instance Pricing', 
                        MetricData=[{
                            'MetricName': 'Hourly Price',
                            'Dimensions': [{
                                'Name': 'FleetRequestId',
                                'Value': t['Value']
                            }],
                            'Timestamp': now,
                            'Value': float(pricehistory[0]['SpotPrice']),
                        }]
                    )

                    cwClient.put_metric_data(
                        Namespace='EC2 Spot Instance Pricing', 
                        MetricData=[{
                            'MetricName': 'Hourly Price',
                            'Dimensions': [
                                {
                                    'Name': 'FleetRequestId',
                                    'Value': t['Value']
                                },
                                {
                                    'Name': 'InstanceId',
                                    'Value': i['InstanceId']
                                }
                            ],
                            'Timestamp': now,
                            'Value': float(pricehistory[0]['SpotPrice']),
                        }]
                    )
                except:
                    print('Unable to put custom metric for FleetRequestId:', t['Value'])
            else:
                try:
                    cwClient.put_metric_data(
                        Namespace='EC2 Spot Instance Pricing', 
                        MetricData=[{
                            'MetricName': 'Hourly Price',
                            'Dimensions': [{
                                'Name:': 'InstanceId',
                                'Value': i['InstanceId']
                            }],
                            'Timestamp': now,
                            'Value': float(pricehistory[0]['SpotPrice']),
                        }]
                    )
                except:
                    print('Unable to put custom metrick for InstanceId:', i['InstanceId'])

    print('Function complete.')
    return 'complete'
