#!/bin/env pwsh
[CmdletBinding()]
param (
    [string]$VpcId,
    [string]$Region = 'us-east-2'
)


# Make sure the VPC exists
$Vpc = aws ec2 describe-vpcs --vpc-ids $VpcId --region $Region --query "Vpcs[0]" --output json | ConvertFrom-Json
if (-not $Vpc) {
    throw "VPC $VpcId does not exist"
}

# Clean up loadbalancers create for Istio Gateways
$things = aws elb describe-load-balancers --query "LoadBalancerDescriptions[?VPCId=='$VpcId']|[].LoadBalancerName" --output json | ConvertFrom-Json
if ($things) {
    Write-Host "Cleaning up Load Balancers for $VpcId"
    $things | ForEach-Object { 
        Write-Host "Deleting load balancer $_"
        aws elb delete-load-balancer --load-balancer-name $_
    }
}

$things = aws ec2 describe-nat-gateways --filter "Name=vpc-id,Values='$VpcId'" --query "NatGateways[]" --output json | ConvertFrom-Json | Where-Object { $_.State -ne 'deleted ' }
if ($things) {
    Write-Host "Cleaning up NAT Gateways for $VpcId"
    $things | ForEach-Object { 
        Write-Host "Deleting NAT gateway $($_.NatGatewayId)"
        aws ec2 delete-nat-gateway --nat-gateway-id $_.NatGatewayId
    }
}

$things = aws ec2 describe-network-interfaces --filter "Name=vpc-id,Values='$VpcId'" --query "NetworkInterfaces[].NetworkInterfaceId" --output json | ConvertFrom-Json
if ($things) {
    Write-Host "Cleaning up Network Interfaces for $VpcId"
    $things | ForEach-Object { 
        Write-Host "Deleting network interface $_"
        aws ec2 delete-network-interface --network-interface-id $_
    }
}

$things = aws ec2 describe-internet-gateways --filter "Name=attachment.vpc-id,Values='$VpcId'" --query "InternetGateways[].InternetGatewayId" --output json | ConvertFrom-Json
if ($things) {
    Write-Host "Cleaning up Internet Gateways for $VpcId"
    $things | ForEach-Object { 
        Write-Host "Detaching internet gateway $_"
        aws ec2 detach-internet-gateway --internet-gateway-id $_ --vpc-id $VpcId
        aws ec2 delete-internet-gateway --internet-gateway-id $_
    }
}

$things = aws ec2 describe-subnets --filter "Name=vpc-id,Values='$VpcId'" --query "Subnets[].SubnetId" --output json | ConvertFrom-Json
if ($things) {
    Write-Host "Cleaning up Subnets for $VpcId"
    $things | ForEach-Object { 
        Write-Host "Deleting subnet $_"
        aws ec2 delete-subnet --subnet-id $_ 
    }
}


$things = aws ec2 describe-security-groups --filter "Name=vpc-id,Values='$VpcId'" --query "SecurityGroups[]" --output json | ConvertFrom-Json | Where-Object { $_.GroupName -ne 'default' }
if ($things) {
    Write-Host "Cleaning up security groups for $VpcId"
    $things | ForEach-Object { 
        Write-Host "Deleting security group $($_.GroupId)"
        aws ec2 delete-security-group --group-id $_.GroupId
    }
}

# Delete the VPC
Write-Host "Deleting VPC $VpcId"
aws ec2 delete-vpc --vpc-id $VpcId

