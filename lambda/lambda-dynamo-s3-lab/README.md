# README

## Requirements

Terraform is required to be installed locally.

## Setup SES

 - Go to Simple Email Service (SES) in the us-east-1 region.
 - Go to Email Addresses, and verify your email.
 - Click the link you get by email to complete the verification process.
 - Go to EC2 so you can change back to your original region.

## Setup Terraform

 - Copy terraform.tfvars.sample as terraform.tfvars
 - Update terraform.tfvars with your access and secret key and your own email address. Also update the region if you're using a different than us-east-1.
 - Run make init, then make plan. Validate that everything looks good. When ready, run make apply.

## Setup Dynamo
 
Copy the JSON in `example-dynamo-record.json` and insert it into your new DynamoDB table.

## Test

You should get an email with the meme. If you didn't, check the output of the Lambda function to see if it had an error.
