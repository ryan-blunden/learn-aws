#!/usr/bin/env bash

mkdocs build --clean
aws s3 sync ./site s3://<BUCKET_NAME> --acl  public-read --delete
