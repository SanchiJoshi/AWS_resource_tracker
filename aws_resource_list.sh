#!/bin/bash

######################################################################
#This script will list all the active resources in the AWS account
#Author: Sanchi Joshi
#Version: v0.0.1
#
#Following are the supported AWS services by the script
# 1. EC2
# 2. RDS
# 3. S3
# 4. CloudFront
# 5. VPC
# 6. IAM
# 7. Route53
# 8. CloudWatch
# 9. CloudFormation
# 10. Lambda
# 11. SNS
# 12. SQS
# 13. DynamoDB
# 14. VPC
# 15. EBS
#
# Usage: ./aws_resource_list.sh <region> <service_name>
# Example: ./aws_resource_list.sh us-east-1 S3
########################################################################

#first, we always check for validation in command line statements i.e, check if the required number of arguments are passed
if [$# -ne 2]; then                             #$# means number of arguments, -ne means not equal
    echo "Usage: $0 <region> <service_name>"    #prints this message; #0 will print name of the script
    exit 1                                      #means terminate the script 
fi

# Assign the arguments to variables and convert the service to lowercase
aws_region=$1
aws_service=$2

#now, we check if the AWS CLI in installed or not
if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installed, please install and try again!"
    exit 1
fi

#check is aws cli is configured
if [! -d ~/.aws]; then                          #means if aws directory does not exist,then we execute the following; -d is for directory
    echo "AWS CLI is not configured, please configure and try again!"
    exit 1
fi

#execute the cli command based on the service name
#reference: AWS CLI documentation
case $aws_service in
    ec2)
        echo "Listing EC2 Instances in $aws_region"
        aws ec2 describe-instances --region $aws_region
        ;;
    rds)
        echo "Listing RDS Instances in $aws_region"
        aws rds describe-db-instances --region $aws_region
        ;;
    s3)
        echo "Listing S3 Buckets in $aws_region"
        aws s3api list-buckets --region $aws_region
        ;;
    cloudfront)
        echo "Listing CloudFront Distributions in $aws_region"
        aws cloudfront list-distributions --region $aws_region
        ;;
    vpc)
        echo "Listing VPCs in $aws_region"
        aws ec2 describe-vpcs --region $aws_region
        ;;
    iam)
        echo "Listing IAM Users in $aws_region"
        aws iam list-users --region $aws_region
        ;;
    route5)
        echo "Listing Route53 Hosted Zones in $aws_region"
        aws route53 list-hosted-zones --region $aws_region
        ;;
    cloudwatch)
        echo "Listing CloudWatch Alarms in $aws_region"
        aws cloudwatch describe-alarms --region $aws_region
        ;;
    cloudformation)
        echo "Listing CloudFormation Stacks in $aws_region"
        aws cloudformation describe-stacks --region $aws_region
        ;;
    lambda)
        echo "Listing Lambda Functions in $aws_region"
        aws lambda list-functions --region $aws_region
        ;;
    sns)
        echo "Listing SNS Topics in $aws_region"
        aws sns list-topics --region $aws_region
        ;;
    sqs)
        echo "Listing SQS Queues in $aws_region"
        aws sqs list-queues --region $aws_region
        ;;
    dynamodb)
        echo "Listing DynamoDB Tables in $aws_region"
        aws dynamodb list-tables --region $aws_region
        ;;
    ebs)
        echo "Listing EBS Volumes in $aws_region"
        aws ec2 describe-volumes --region $aws_region
        ;;
    *)
        echo "Invalid service. Please enter a valid service."
        exit 1
        ;;
esac
