# #!/bin/bash

# Create The PreSignup function
( \
    sleep 1; printf "\n"; `# Select which capability you want to add: Lambda function (serverless function)` \
    sleep 1; echo "${PROJECT_NAME}CognitoPreSignup"; `# Provide a friendly name for your resource to be used as a label for this category in the project: CognitoPreSignup` \
    sleep 1; echo "${PROJECT_NAME}CognitoPreSignup"; `# rovide the AWS Lambda function name:` \
    sleep 1; printf "\n"; `# Choose the function runtime that you want to use: NodeJS` \
    sleep 1; printf "\n"; `# Choose the function template that you want to use: Hello World` \
    sleep 1; echo "n"; printf "\n"; `# Do you want to access other resources created in this project from your Lambda function? No` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to invoke this function on a recurring schedule?: No` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to configure Lambda layers for this function?: No` \
    sleep 1; echo "n"; printf "\n"; `# Do you want to edit the local lambda function now?: No` \
) | amplify add function
