# Wait For It

Uses the handy [https://github.com/vishnubob/wait-for-it](wait-for-it.sh) script inside a container to let you know once a host on a specific port becomes available.

## Usage

    make wait for={HOST}:{PORT}

Make sure the image is built:

    cd utils/wait-for-it
    make build
    
Then to use the container:

    make wait for=ec2-18-236-123-138.us-west-2.compute.amazonaws.com:8080
