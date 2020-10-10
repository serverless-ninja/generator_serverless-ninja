# #!/bin/bash

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

# Create Auth Challenge
cd "amplify/backend/function/${PROJECT_NAME}CognitoCreateAuthChallenge/src"
rm *.js *.json
curl -o event.json https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/createAuthChallenge/src/event.json
npm init private
npm install crypto-secure-random-digit i18n
cd ..
mkdir ts
cd ts
../../../../../setup_function_typescript.sh
npm install crypto-secure-random-digit i18n
npm install --save-dev @types/i18n copyfiles
curl -o index.ts https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/createAuthChallenge/ts/index.ts
curl -o send_email.ts https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/createAuthChallenge/ts/send_email.ts
curl -o send_sms.ts https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/createAuthChallenge/ts/send_sms.ts
PROJECT_NAME_UPPERCASE=$(echo ${PROJECT_NAME} | tr 'a-z' 'A-Z')
npx replace-in-file /ANALYTICS_SERVERLESSNINJA_ID/g "ANALYTICS_${PROJECT_NAME_UPPERCASE}PINPOINT_ID" index.ts --isRegex
mkdir locales
cd locales
curl -o en.json https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/createAuthChallenge/ts/locales/en.json
curl -o fr.json https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/createAuthChallenge/ts/locales/fr.json
cd ..
echo "`npx jq '.scripts += {copyfiles: "copyfiles ./locales/* ../src"}' package.json`" > package.json
echo "`npx jq '.scripts += {tsc: "npm run lint && tsc && npm run copyfiles"}' package.json`" > package.json
npm run tsc
cd ../../../../../