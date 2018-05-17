# IAM Role Code Challenge Solution

0. Execute the `bin/create-ec2.sh` to create an ec2 instance, noting the instance id.

    # Find out a VPC id
    aws ec2 describe-vpcs

    # Then use the VPC id to find a subnet id
    aws ec2 describe-subnets --filters "Name=vpc-id,Values=vpc-c02c08b9"

    # Create a key if you don't have one already, saving the contents locally
    aws ec2 create-key-pair --key-name ryan-blunden-key

    # Now create an ec2 instance
    ./bin/create-ec2.sh

1. Create an instance of the AWS CLI container and authenticate:

    cd awscli
    make run
    
    # Then once the Docker container starts
    aws configure

2. Create a bucket that we will use for our tests:

    aws s3 mb s3://ryan-blunden-bucket
    aws s3 ls | grep ryan-blunden-bucket

3. Add two top level folders:

    aws s3api put-object --bucket ryan-blunden-bucket --key my-app/ # Can read/write
    aws s3api put-object --bucket ryan-blunden-bucket --key other-app/ # Can not Can read/write
