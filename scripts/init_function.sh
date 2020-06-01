#!/bin/bash

# Create The PostAuthentication function
( \
    sleep 1; echo "${PROJECT_NAME}CognitoPostAuthentication"; `# Provide a friendly name for your resource to be used as a label for this category in the project: CognitoPostAuthentication` \
    sleep 1; echo "${PROJECT_NAME}CognitoPostAuthentication"; `# rovide the AWS Lambda function name:` \
    sleep 1; printf "\n"; `# Choose the function runtime that you want to use: NodeJS` \
    sleep 1; echo -n $'\e'\[B; printf "\n"; `# Choose the function template that you want to use: Hello World` \
    sleep 1; printf "\n"; `# Do you want to access other resources created in this project from your Lambda function? Yes` \
    sleep 1; echo -n $'\e'\[B; printf " "; printf "\n"; `# Select the category: auth` \
	sleep 1; echo -n $'\e'\[B; printf " "; printf "\n"; `# Auth has 2 resources in this project. Select the one you would like your Lambda to access: cognito` \
    sleep 1; echo "a"; printf "\n"; `# Select the operations you want to permit for Cognito? create, read, update, delete` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to invoke this function on a recurring schedule?: No` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to edit the local lambda function now?: No` \
) | amplify add function

# Create The PreSignup function
( \
    sleep 1; echo "${PROJECT_NAME}CognitoPreSignup"; `# Provide a friendly name for your resource to be used as a label for this category in the project: CognitoPreSignup` \
    sleep 1; echo "${PROJECT_NAME}CognitoPreSignup"; `# rovide the AWS Lambda function name:` \
    sleep 1; printf "\n"; `# Choose the function runtime that you want to use: NodeJS` \
    sleep 1; echo -n $'\e'\[B; printf "\n"; `# Choose the function template that you want to use: Hello World` \
    sleep 1; printf "\n"; `# Do you want to access other resources created in this project from your Lambda function? Yes` \
    sleep 1; echo -n $'\e'\[B; printf " "; printf "\n"; `# Select the category: auth` \
	sleep 1; echo -n $'\e'\[B; printf " "; printf "\n"; `# Auth has 2 resources in this project. Select the one you would like your Lambda to access: cognito` \
    sleep 1; echo "a"; printf "\n"; `# Select the operations you want to permit for Cognito? create, read, update, delete` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to invoke this function on a recurring schedule?: No` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to edit the local lambda function now?: No` \
) | amplify add function

# Create the PretokenGeneration function
( \
    sleep 1; echo "${PROJECT_NAME}PreTokenGeneration"; `# Provide a friendly name for your resource to be used as a label for this category in the project: preTokenGeneration` \
    sleep 1; echo "${PROJECT_NAME}PreTokenGeneration"; `# rovide the AWS Lambda function name:` \
    sleep 1; printf "\n"; `# Choose the function runtime that you want to use: NodeJS` \
    sleep 1; echo -n $'\e'\[B; printf "\n"; `# Choose the function template that you want to use: Hello World` \
    sleep 1; printf "\n"; `# Do you want to access other resources created in this project from your Lambda function? Yes` \
    sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; printf " "; printf "\n"; `# Select the category: storage` \
    sleep 1; echo -n $'\e'\[B; printf " "; echo -n $'\e'\[B; printf " "; echo -n $'\e'\[B; printf " "; echo -n $'\e'\[B; printf " "; printf "\n"; `# Storage has 6 resources in this project: EndUser:@model` \
    sleep 1; echo "a"; printf "\n"; `# Select the operations you want to permit for Tenant:@model? create, read, update, delete` \
    sleep 1; echo "a"; printf "\n"; `# Select the operations you want to permit for TenantUserPreferences:@model? create, read, update, delete` \
    sleep 1; echo "a"; printf "\n"; `# Select the operations you want to permit for GuestUser:@model? create, read, update, delete` \
    sleep 1; echo "a"; printf "\n"; `# Select the operations you want to permit for EndUser:@model? create, read, update, delete` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to invoke this function on a recurring schedule?: No` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to edit the local lambda function now?: No` \
) | amplify add function

# Create the getCognitoUser function
( \
    sleep 1; echo "${PROJECT_NAME}GetCognitoUser"; `# Provide a friendly name for your resource to be used as a label for this category in the project: getCognitoUser` \
    sleep 1; echo "${PROJECT_NAME}GetCognitoUser"; `# rovide the AWS Lambda function name:` \
    sleep 1; printf "\n"; `# Choose the function runtime that you want to use: NodeJS` \
    sleep 1; echo -n $'\e'\[B; printf "\n"; `# Choose the function template that you want to use: Hello World` \
    sleep 1; printf "\n"; `# Do you want to access other resources created in this project from your Lambda function? Yes` \
    sleep 1; echo -n $'\e'\[B; printf " "; printf "\n"; `# Select the category: auth` \
    sleep 1; echo -n $'\e'\[B; printf " "; printf "\n"; `# Auth has 2 resources in this project. Select the one you would like your Lambda to access: cognito` \
    sleep 1; echo "a"; printf "\n"; `# Select the operations you want to permit for PinPoint? create, read, update, delete` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to invoke this function on a recurring schedule?: No` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to edit the local lambda function now?: No` \
) | amplify add function

# Create the Manage Guest User function
( \
    sleep 1; echo "${PROJECT_NAME}ManageGuestUser"; `# Provide a friendly name for your resource to be used as a label for this category in the project: manageGuestUser` \
    sleep 1; echo "${PROJECT_NAME}ManageGuestUser"; `# rovide the AWS Lambda function name:` \
    sleep 1; printf "\n"; `# Choose the function runtime that you want to use: NodeJS` \
    sleep 1; echo -n $'\e'\[B; printf "\n"; `# Choose the function template that you want to use: Hello World` \
    sleep 1; printf "\n"; `# Do you want to access other resources created in this project from your Lambda function? Yes` \
    sleep 1; echo -n $'\e'\[B; printf " "; echo -n $'\e'\[B; echo -n $'\e'\[B; printf " "; printf "\n"; `# Select the category: auth, storage` \
    sleep 1; echo -n $'\e'\[B; printf " "; printf "\n"; `# Auth has 2 resources in this project. Select the one you would like your Lambda to access: cognito` \
    sleep 1; echo "a"; printf "\n"; `# Select the operations you want to permit for PinPoint? create, read, update, delete` \
    sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; printf " "; printf "\n"; `# Storage has 6 resources in this project: GuestUser:@model` \
    sleep 1; echo "a"; printf "\n"; `# Select the operations you want to permit for GuestUser:@model? create, read, update, delete` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to invoke this function on a recurring schedule?: No` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to edit the local lambda function now?: No` \
) | amplify add function

# Create the Manage End User function
( \
    sleep 1; echo "${PROJECT_NAME}ManageEndUser"; `# Provide a friendly name for your resource to be used as a label for this category in the project: manageEndUser` \
    sleep 1; echo "${PROJECT_NAME}ManageEndUser"; `# rovide the AWS Lambda function name:` \
    sleep 1; printf "\n"; `# Choose the function runtime that you want to use: NodeJS` \
    sleep 1; echo -n $'\e'\[B; printf "\n"; `# Choose the function template that you want to use: Hello World` \
    sleep 1; printf "\n"; `# Do you want to access other resources created in this project from your Lambda function? Yes` \
    sleep 1; echo -n $'\e'\[B; printf " "; echo -n $'\e'\[B; echo -n $'\e'\[B; printf " "; printf "\n"; `# Select the category: auth, storage` \
    sleep 1; echo -n $'\e'\[B; printf " "; printf "\n"; `# Auth has 2 resources in this project. Select the one you would like your Lambda to access: cognito` \
    sleep 1; echo "a"; printf "\n"; `# Select the operations you want to permit for Cognito? create, read, update, delete` \
    sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; printf " "; printf "\n"; `# Storage has 6 resources in this project: EndUser:@model` \
    sleep 1; echo "a"; printf "\n"; `# Select the operations you want to permit for EndUser:@model? create, read, update, delete` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to invoke this function on a recurring schedule?: No` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to edit the local lambda function now?: No` \
) | amplify add function
