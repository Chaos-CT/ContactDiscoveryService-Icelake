#!/bin/bash
# sudo chmod 777 ./remove_kinesis_consumers.sh
# ./remove_kinesis_consumers.sh

REGION="eu-west-2"
STREAM_ARN="arn:aws:kinesis:eu-west-2:522814704979:stream/cdsi-account-updates-stream"

echo "Fetching consumers..."
CONSUMERS=$(aws kinesis list-stream-consumers \
  --region "$REGION" \
  --stream-arn "$STREAM_ARN" \
  --query 'Consumers[*].ConsumerARN' \
  --output text)

for ARN in $CONSUMERS; do
  echo "Deregistering consumer: $ARN"
  aws kinesis deregister-stream-consumer \
    --region "$REGION" \
    --consumer-arn "$ARN"
done

echo "All consumers deregistered (initiated)."