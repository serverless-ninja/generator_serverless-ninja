# #!/bin/bash

# Create the Manage Guest User function
( \
    sleep 1; printf "\n"; `# Select which capability you want to add: Lambda function (serverless function)` \
    sleep 1; echo "${PROJECT_NAME}ManageGuestUser"; `# Provide a friendly name for your resource to be used as a label for this category in the project: manageGuestUser` \
    sleep 1; echo "${PROJECT_NAME}ManageGuestUser"; `# rovide the AWS Lambda function name:` \
    sleep 1; printf "\n"; `# Choose the function runtime that you want to use: NodeJS` \
    sleep 1; printf "\n"; `# Choose the function template that you want to use: Hello World` \
    sleep 1; echo "n"; printf "\n"; `# Do you want to access other resources created in this project from your Lambda function? No` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to invoke this function on a recurring schedule?: No` \
    sleep 1; echo "N"; printf "\n"; `# Do you want to configure Lambda layers for this function?: No` \
    sleep 1; echo "n"; printf "\n"; `# Do you want to edit the local lambda function now?: No` \
) | amplify add function

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

# ManageGuestUser
cd "amplify/backend/function/${PROJECT_NAME}ManageGuestUser/src"
rm *.js *.json
curl -o event.json https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/manageGuestUser/src/event.json
cd ..
mkdir ts
cd ts
../../../../../setup_function_typescript.sh
curl -o index.ts https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/manageGuestUser/ts/index.ts
PROJECT_NAME_UPPERCASE=$(echo ${PROJECT_NAME} | tr 'a-z' 'A-Z')
npx replace-in-file /AUTH_SERVERLESSNINJA_USERPOOLID/g "AUTH_${PROJECT_NAME_UPPERCASE}COGNITO_USERPOOLID" index.ts --isRegex
npx replace-in-file /API_SERVERLESSNINJA_USERTABLE_NAME/g "API_${PROJECT_NAME_UPPERCASE}GRAPHQL_GUESTUSERTABLE_NAME" index.ts --isRegex
npm run tsc
cd ../../../../../