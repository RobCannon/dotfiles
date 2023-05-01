#!/bin/env pwsh

@("us-east-1", "us-east-2", "us-west-2") | % {
    $region = $_
    aws ec2 describe-vpcs --region $region --output json | ConvertFrom-Json | ForEach-Object { $_.Vpcs } | ForEach-Object {
        [PSCustomObject]@{
            VpcId      = $_.VpcId
            Name       = $_.Tags | Where-Object { $_.Key -eq 'Name' } | Select-Object -ExpandProperty Value
            CidrBlock  = $_.CidrBlock    
            DefaultVpc = $_.IsDefault
            Region     = $region
        }
    }
} | format-table -AutoSize
