import os
import urllib

import boto3

sesclient = boto3.client('ses')
dynamoClient = boto3.client('dynamodb')
s3client = boto3.client('s3')
s3 = boto3.resource('s3')

table = os.environ['TABLE']
bucket = os.environ['BUCKET']
image_base_url = os.environ['IMAGE_BASE_URL']
recipient = os.environ['RECIPIENT']


def lambda_handler(event, context):
    print(event)

    for record in event['Records']:
        if record['eventName'] != 'INSERT':
            print("This is not an insert")
            return

        item = record['dynamodb']['NewImage']

        id = item['id']['N']

        dynamo_item = dynamoClient.get_item(
            TableName=table,
            Key={
                'id': {
                    'N': id
                }
            }
        )

        print(dynamo_item)

        image = dynamo_item['Item']['image']['S']
        text = dynamo_item['Item']['text']['S']

        try:
            object = s3client.get_object(Bucket=bucket, Key=image)
            print(object)
        except:
            print("The image is not in S3. Retrieving it.")
            url = dynamo_item['Item']['sourceUrl']['S']
            photoResponse = urllib.request.urlopen(url)
            imagedata = photoResponse.read()
            object = s3.Object(bucket, image)
            object.put(Body=imagedata)

        print("Image: " + image)
        print("Text: " + text)

        subject = "Your meme of the day"

        body_text = (text + "\r\n"
                            "To see the image, go here: " + image_base_url + "/" + image
                     )

        # The HTML body of the email.
        body_html = "<html><head></head><body><h1>" + text + "</h1><img src='" + image_base_url + "/" + image + "'/></body></html>"

        response = sesclient.send_email(
            Destination={
                'ToAddresses': [
                    recipient,
                ],
            },
            Message={
                'Body': {
                    'Html': {
                        'Charset': "UTF-8",
                        'Data': body_html,
                    },
                    'Text': {
                        'Charset': "UTF-8",
                        'Data': body_text,
                    },
                },
                'Subject': {
                    'Charset': "UTF-8",
                    'Data': subject,
                },
            },
            Source=recipient
        )

    return 'Successfully processed'
