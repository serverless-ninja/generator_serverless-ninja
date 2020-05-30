#!/bin/bash

# Update the Create Auth Challenge Function
( \
    sleep 1; printf "\n"; `# Please select the Lambda Function you would want to update: first one` \
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

cd "amplify/backend/function/${PROJECT_NAME}GetCognitoUser/src"
rm *.js *.json
curl -o event.json https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/getCognitoUser/src/event.json
cd ..
mkdir ts
cd ts
../../../../../init_function_typescript.sh
curl -o index.ts https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/getCognitoUser/ts/index.ts
PROJECT_NAME_UPPERCASE=$(echo ${PROJECT_NAME} | tr 'a-z' 'A-Z')
npx replace-in-file /AUTH_SERVERLESSNINJA_USERPOOLID/g "AUTH_${PROJECT_NAME_UPPERCASE}COGNITO_USERPOOLID" index.ts --isRegex
npm run tsc
cd ../../../../../

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

cd "amplify/backend/function/${PROJECT_NAME}ManageGuestUser/src"
rm *.js *.json
curl -o event.json https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/manageGuestUser/src/event.json
cd ..
mkdir ts
cd ts
../../../../../init_function_typescript.sh
curl -o index.ts https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/manageGuestUser/ts/index.ts
PROJECT_NAME_UPPERCASE=$(echo ${PROJECT_NAME} | tr 'a-z' 'A-Z')
npx replace-in-file /AUTH_SERVERLESSNINJA_USERPOOLID/g "AUTH_${PROJECT_NAME_UPPERCASE}COGNITO_USERPOOLID" index.ts --isRegex
npx replace-in-file /API_SERVERLESSNINJA_USERTABLE_NAME/g "API_${PROJECT_NAME_UPPERCASE}GRAPHQL_GUESTUSERTABLE_NAME" index.ts --isRegex
npm run tsc
cd ../../../../../


# Create the Manage End User function
( \
    sleep 1; echo "${PROJECT_NAME}ManageEndUser"; `# Provide a friendly name for your resource to be used as a label for this category in the project: manageEndUser` \
    sleep 1; echo "${PROJECT_NAME}ManageEndUser"; `# rovide the AWS Lambda function name:` \
    sleep 1; printf "\n"; `# Choose the function runtime that you want to use: NodeJS` \
    sleep 1; echo -n $'\e'\[B; printf "\n"; `# Choose the function template that you want to use: Hello World` \
    sleep 1; printf "\n"; `# Do you want to access other resources created in this project from your Lambda function? Yes` \
    sleep 1; echo -n $'\e'\[B; printf " "; echo -n $'\e'\[B; echo -n $'\e'\[B; printf " "; printf "\n"; `# Select the category: auth, storage` \
    sleep 1; echo -n $'\e'\[B; printf " "; printf "\n"; `# Auth has 2 resources in this project. Select the one you would like your Lambda to access: cognito` \
    sleep 1; echo "a"; printf "\n"; `# Select the operations you want to permit for PinPoint? create, read, update, delete` \
    sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; printf " "; printf "\n"; `# Storage has 6 resources in this project: EndUser:@model` \
    sleep 1; echo "a"; printf "\n"; `# Select the operations you want to permit for EndUser:@model? create, read, update, delete` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to invoke this function on a recurring schedule?: No` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to edit the local lambda function now?: No` \
) | amplify add function

cd "amplify/backend/function/${PROJECT_NAME}ManageEndUser/src"
rm *.js *.json
curl -o event.json https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/manageEndUser/src/event.json
cd ..
mkdir ts
cd ts
../../../../../init_function_typescript.sh
curl -o index.ts https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/manageEndUser/ts/index.ts
PROJECT_NAME_UPPERCASE=$(echo ${PROJECT_NAME} | tr 'a-z' 'A-Z')
npx replace-in-file /AUTH_SERVERLESSNINJA_USERPOOLID/g "AUTH_${PROJECT_NAME_UPPERCASE}COGNITO_USERPOOLID" index.ts --isRegex
npx replace-in-file /API_SERVERLESSNINJA_USERTABLE_NAME/g "API_${PROJECT_NAME_UPPERCASE}GRAPHQL_ENDUSERTABLE_NAME" index.ts --isRegex
npm run tsc
cd ../../../../../


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

cd "amplify/backend/function/${PROJECT_NAME}PreTokenGeneration/src"
rm *.js *.json
curl -o event.json https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/preTokenGeneration/src/event.json
cd ..
mkdir ts
cd ts
../../../../../init_function_typescript.sh
curl -o index.ts https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/preTokenGeneration/ts/index.ts
PROJECT_NAME_UPPERCASE=$(echo ${PROJECT_NAME} | tr 'a-z' 'A-Z')
npx replace-in-file /API_SERVERLESSNINJA_TENANTTABLE_NAME/g "API_${PROJECT_NAME_UPPERCASE}GRAPHQL_TENANTTABLE_NAME" index.ts --isRegex
npx replace-in-file /API_SERVERLESSNINJA_TENANTUSERPREFERENCETABLE_NAME/g "API_${PROJECT_NAME_UPPERCASE}GRAPHQL_TENANTUSERPREFERENCETABLE_NAME" index.ts --isRegex
npx replace-in-file /API_SERVERLESSNINJA_GUESTUSERTABLE_NAME/g "API_${PROJECT_NAME_UPPERCASE}GRAPHQL_GUESTUSERTABLE_NAME" index.ts --isRegex
npx replace-in-file /API_SERVERLESSNINJA_ENDUSERTABLE_NAME/g "API_${PROJECT_NAME_UPPERCASE}GRAPHQL_ENDUSERTABLE_NAME" index.ts --isRegex
npm run tsc
cd ../../../../../
