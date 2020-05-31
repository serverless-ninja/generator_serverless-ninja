#!/bin/bash

( \
    sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B; printf "\n"; `# Do you want to use the default authentication and security configuration? Default configuration? Manual configuration` \
    sleep 1; printf "\n"; `# Select the authentication/authorization services that you want to use: User Sign-Up, Sign-In, connected with AWS IAM controls` \
    sleep 1; echo "${PROJECT_NAME}Cognito"; `# Please provide a friendly name for your resource that will be used to label this category in the project` \
    sleep 1; echo "${PROJECT_NAME}_identity_pool"; `# Please provide a friendly name for your resource that will be used to label this category in the project` \
    sleep 1; printf "\n"; `# Allow unauthenticated logins? No` \
    sleep 1; echo -n $'\e'\[B; printf "\n"; `# Do you want to enable 3rd party authentication providers in your identity pool? No` \
    sleep 1; echo "${PROJECT_NAME}_user_pool"; `# Please provide a name for your user pool` \
    sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; printf "\n"; `# How do you want users to be able to sign in? Email or Phone Number` \
    sleep 1; printf "\n"; `# Do you want to add User Pool Groups? Yes` \
    sleep 1; echo "ADMIN"; `# Do you want to add User Pool Groups? Yes` \
    sleep 1; printf "\n"; `# Do you want to add another User Pool Group? No` \
    sleep 1; printf "\n"; `# Sort the user pool groups in order of preference?` \
    sleep 1; echo -n $'\e'\[B; printf "\n"; `# Do you want to add an admin queries API? No` \
    sleep 1; printf "\n"; `# Multifactor authentication (MFA) user login options? OFF` \
    sleep 1; echo -n $'\e'\[B; printf "\n"; `# Email based user registration/forgot password? Disabled` \
    sleep 1; echo "Your verification code is {####}"; `# Please specify an SMS verification message` \
    sleep 1; printf "\n"; `# Do you want to override the default password policy for this User Pool? N` \
    sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B;  printf ' '; printf "\n"; `# What attributes are required for signing up? None` \
    sleep 1; echo "30"; `#Specify the app's refresh token expiration period (in days): (30)` \
    sleep 1; printf "\n"; `# Do you want to specify the user attributes this app can read and write? N` \
    sleep 1; printf "\n"; `# Do you want to enable any of the following capabilities?` \
    sleep 1; echo -n $'\e'\[B; printf "\n"; `# Do you want to use an OAuth flow? No` \
    sleep 1; echo "Y"; printf "\n"; `# Do you want to configure Lambda Triggers for Cognito? Yes` \
    `# Which triggers do you want to enable for Cognito: `
        sleep 1; echo -n $'\e'\[B; printf ' '; `# Create Auth Challenge` \
        sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B; printf ' '; `# Define Auth Challenge` \
        sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; printf ' '; `# Pre Sign-up` \
        sleep 1; echo -n $'\e'\[B; printf ' '; `# Verify Auth Challenge Response` \
        sleep 1; printf "\n";
    `# Create Auth Challenge, Define Auth Challenge, Post Authentication, Pre Sign-up, Verify Auth Challenge Response`
    sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; printf ' '; printf "\n"; `# What functionality do you want to use for Create Auth Challenge: Create your own module` \
    sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; printf ' '; printf "\n"; `# What functionality do you want to use for Define Auth Challenge: Create your own module` \
    sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; printf ' '; printf "\n"; `# What functionality do you want to use for Pre Sign-up: Create your own module` \
    sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; printf ' '; printf "\n"; `# What functionality do you want to use for Verify Auth Challenge Response: Create your own module` \
    sleep 1; echo "n"; printf "\n"; `# Do you want to edit your custom function now? No` \
    sleep 1; echo "n"; printf "\n"; `# Do you want to edit your custom function now? No` \
    sleep 1; echo "n"; printf "\n"; `# Do you want to edit your custom function now? No` \
    sleep 1; echo "n"; printf "\n"; `# Do you want to edit your custom function now? No` \
) | amplify add auth

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

# Define Auth Challenge
cd "amplify/backend/function/${PROJECT_NAME}CognitoDefineAuthChallenge/src"
rm *.js *.json
curl -o event.json https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/defineAuthChallenge/src/event.json
cd ..
mkdir ts
cd ts
../../../../../setup_function_typescript.sh
curl -o index.ts https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/defineAuthChallenge/ts/index.ts
npm run tsc
cd ../../../../../

# Pre Sign-up
cd "amplify/backend/function/${PROJECT_NAME}CognitoPreSignup/src"
rm *.js *.json
curl -o event.json https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/preSignup/src/event.json
cd ..
mkdir ts
cd ts
../../../../../setup_function_typescript.sh
curl -o index.ts https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/preSignup/ts/index.ts
npm run tsc
cd ../../../../../

# Verify Auth Challenge Response
cd "amplify/backend/function/${PROJECT_NAME}CognitoVerifyAuthChallengeResponse/src"
rm *.js *.json
curl -o event.json https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/verifyAuthChallengeResponse/src/event.json
cd ..
mkdir ts
cd ts
../../../../../setup_function_typescript.sh
curl -o index.ts https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/verifyAuthChallengeResponse/ts/index.ts
npm run tsc
cd ../../../../../
