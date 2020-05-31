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
