# response-check

## Use

```
https://github.com/yoshiokaCB/sf-map-sample.git
cd sf-map-sample
```

### Preparation

create bucket

```
aws s3 mb s3://[bucket_name]
```

Modify the bucket name you created earlier.

```
CheckResponseStateMachine:
    Type: AWS::Serverless::StateMachine
    Properties:
      DefinitionUri: s3://[bucket_name]/statemachine/check_response.json
```


### deploy

```
aws s3 cp statemachine/check_response.json s3://[bucket_name]/statemachine/check_response.json
sam package -t template.yaml --output-template-file packaged.yaml --s3-bucket [bucket_name]
sam deploy --t packaged.yaml --stack-name response-check --capabilities CAPABILITY_IAM
```
