#!/bin/bash

# Update the Create Auth Challenge Function
( \
    sleep 1; printf "\n"; `# Please select the Lambda Function you would want to update: CreateAuthChallenge` \
    sleep 1; echo "Y"; printf "\n"; `# Do you want to update permissions granted to this Lambda function to perform on other resources in your project? Yes` \
    sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B; printf " "; printf "\n"; `# Select the category: analytics` \
    sleep 1; echo "a"; printf "\n"; `# Select the operations you want to permit for adamaPinPoint? create, read, update, delete` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to invoke this function on a recurring schedule?: No` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to edit the local lambda function now?: No` \
) | amplify update function


echo "`npx jq '.Resources.AmplifyResourcesPolicy = {
			"DependsOn": [
				"LambdaExecutionRole"
			],
			"Type": "AWS::IAM::Policy",
			"Properties": {
				"PolicyName": "amplify-lambda-execution-policy",
				"Roles": [
					{
						"Ref": "LambdaExecutionRole"
					}
				],
				"PolicyDocument": {
					"Version": "2012-10-17",
					"Statement": [
						{
							"Effect": "Allow",
							"Action": [
								"mobiletargeting:SendMessages"
							],
							"Resource": [
								{
									"Fn::Join": [
										"",
										[
											"arn:aws:mobiletargeting:",
											{
												"Ref": "analytics'${PROJECT_NAME}'PinPointRegion"
											},
											":",
											{
												"Ref": "AWS::AccountId"
											},
											":apps/",
											{
												"Ref": "analytics'${PROJECT_NAME}'PinPointId"
											},
											"/messages"
										]
									]
								},
								{
									"Fn::Join": [
										"",
										[
											"arn:aws:ses:",
											{
												"Ref": "analytics'${PROJECT_NAME}'PinPointRegion"
											},
											":",
											{
												"Ref": "AWS::AccountId"
											},
											":identity/",
											{
												"Ref": "analytics'${PROJECT_NAME}'PinPointId"
											}
										]
									]
								}
							]
						}
					]
				}
			}
		}' ./amplify/backend/function/${PROJECT_NAME}CognitoCreateAuthChallenge/${PROJECT_NAME}CognitoCreateAuthChallenge-cloudformation-template.json`" > ./amplify/backend/function/${PROJECT_NAME}CognitoCreateAuthChallenge/${PROJECT_NAME}CognitoCreateAuthChallenge-cloudformation-template.json

# Update The PostAuthentication function
( \
    sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; printf "\n"; `# Please select the Lambda Function you would want to update: CreateAuthChallenge` \
    sleep 1; echo "Y"; printf "\n"; `# Do you want to update permissions granted to this Lambda function to perform on other resources in your project? Yes` \
    sleep 1; echo -n $'\e'\[B; printf " "; printf "\n"; `# Select the category: auth` \
	  sleep 1; echo -n $'\e'\[B; printf " "; printf "\n"; `# Auth has 2 resources in this project. Select the one you would like your Lambda to access: cognito` \
    sleep 1; echo "a"; printf "\n"; `# Select the operations you want to permit for Cognito? create, read, update, delete` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to invoke this function on a recurring schedule?: No` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to edit the local lambda function now?: No` \
) | amplify update function

# Update The PreSignup function
( \
    sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; printf "\n"; `# Please select the Lambda Function you would want to update: CognitoPreSignup` \
    sleep 1; echo "Y"; printf "\n"; `# Do you want to update permissions granted to this Lambda function to perform on other resources in your project? Yes` \
    sleep 1; echo -n $'\e'\[B; printf " "; printf "\n"; `# Select the category: auth` \
    sleep 1; echo -n $'\e'\[B; printf " "; printf "\n"; `# Auth has 2 resources in this project. Select the one you would like your Lambda to access: cognito` \
    sleep 1; echo "a"; printf "\n"; `# Select the operations you want to permit for Cognito? create, read, update, delete` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to invoke this function on a recurring schedule?: No` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to edit the local lambda function now?: No` \
) | amplify update function

# Update The PretokenGeneration function
( \
    sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; printf "\n"; `# Please select the Lambda Function you would want to update: PretokenGeneration` \
    sleep 1; echo "Y"; printf "\n"; `# Do you want to update permissions granted to this Lambda function to perform on other resources in your project? Yes` \
    sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; printf " "; printf "\n"; `# Select the category: storage` \
    sleep 1; echo -n $'\e'\[B; printf " "; echo -n $'\e'\[B; printf " "; echo -n $'\e'\[B; printf " "; echo -n $'\e'\[B; printf " "; printf "\n"; `# Storage has 5 resources in this project: Tenant:@model(appsync), TenantUserPreference:@model(appsync), GuestUser:@model(appsync), EndUser:@model(appsync)` \
    sleep 1; echo "a"; printf "\n"; `# Select the operations you want to permit for Tenant:@model? create, read, update, delete` \
    sleep 1; echo "a"; printf "\n"; `# Select the operations you want to permit for TenantUserPreferences:@model? create, read, update, delete` \
    sleep 1; echo "a"; printf "\n"; `# Select the operations you want to permit for GuestUser:@model? create, read, update, delete` \
    sleep 1; echo "a"; printf "\n"; `# Select the operations you want to permit for EndUser:@model? create, read, update, delete` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to invoke this function on a recurring schedule?: No` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to edit the local lambda function now?: No` \
) | amplify update function

# Update The GetCognitoUser function
( \
    sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; printf "\n"; `# Please select the Lambda Function you would want to update: GetCognitoUser` \
    sleep 1; echo "Y"; printf "\n"; `# Do you want to update permissions granted to this Lambda function to perform on other resources in your project? Yes` \
    sleep 1; echo -n $'\e'\[B; printf " "; printf "\n"; `# Select the category: auth` \
    sleep 1; echo -n $'\e'\[B; printf " "; printf "\n"; `# Auth has 2 resources in this project. Select the one you would like your Lambda to access: cognito` \
    sleep 1; echo "a"; printf "\n"; `# Select the operations you want to permit for Cognito? create, read, update, delete` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to invoke this function on a recurring schedule?: No` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to edit the local lambda function now?: No` \
) | amplify update function

# Update The ManageGuestUser function
( \
    sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; printf "\n"; `# Please select the Lambda Function you would want to update: ManageGuestUser` \
    sleep 1; echo "Y"; printf "\n"; `# Do you want to update permissions granted to this Lambda function to perform on other resources in your project? Yes` \
    sleep 1; echo -n $'\e'\[B; printf " ";  echo -n $'\e'\[B; echo -n $'\e'\[B; printf " "; printf "\n"; `# Select the category: auth, storage` \
    sleep 1; echo -n $'\e'\[B; printf " "; printf "\n"; `# Auth has 2 resources in this project. Select the one you would like your Lambda to access: cognito` \
    sleep 1; echo "a"; printf "\n"; `# Select the operations you want to permit for Cognito? create, read, update, delete` \
    sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; printf " "; printf "\n"; `# Storage has 6 resources in this project: GuestUser:@model` \
    sleep 1; echo "a"; printf "\n"; `# Select the operations you want to permit for GuestUser:@model? create, read, update, delete` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to invoke this function on a recurring schedule?: No` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to edit the local lambda function now?: No` \
) | amplify update function

# Update The ManageGuestUser function
( \
    sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; printf "\n"; `# Please select the Lambda Function you would want to update: ManageGuestUser` \
    sleep 1; echo "Y"; printf "\n"; `# Do you want to update permissions granted to this Lambda function to perform on other resources in your project? Yes` \
    sleep 1; echo -n $'\e'\[B; printf " ";  echo -n $'\e'\[B; echo -n $'\e'\[B; printf " "; printf "\n"; `# Select the category: auth, storage` \
    sleep 1; echo -n $'\e'\[B; printf " "; printf "\n"; `# Auth has 2 resources in this project. Select the one you would like your Lambda to access: cognito` \
    sleep 1; echo "a"; printf "\n"; `# Select the operations you want to permit for Cognito? create, read, update, delete` \
    sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; printf " "; printf "\n"; `# Storage has 6 resources in this project: EndUser:@model` \
    sleep 1; echo "a"; printf "\n"; `# Select the operations you want to permit for EndUser:@model? create, read, update, delete` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to invoke this function on a recurring schedule?: No` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to edit the local lambda function now?: No` \
) | amplify update function