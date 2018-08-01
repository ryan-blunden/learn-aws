1. Go to Simple Email Service in the us-east-1 region
2. Go to Email Addresses, and verify your's. You'll need to click the link you get by email
3. Copy terraform.tfvars.sample as terraform.tfvars
4. Update terraform.tfvars with your access and secret key and your own email address. Also update the region if you're using a different than us-east-1.
5. Run make init, then make plan. Validate that everything looks good. When ready, run make apply.
6. Copy the JSON in example-dynamo-record.json and insert it into your new DynamoDB table.
7. You should get an email with the meme. If you didn't, check the output of the Lambda function to see if it had an error.