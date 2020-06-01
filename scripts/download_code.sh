#!/bin/bash

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

# GetCognitoUser
cd "amplify/backend/function/${PROJECT_NAME}GetCognitoUser/src"
rm *.js *.json
curl -o event.json https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/getCognitoUser/src/event.json
cd ..
mkdir ts
cd ts
../../../../../setup_function_typescript.sh
curl -o index.ts https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/getCognitoUser/ts/index.ts
PROJECT_NAME_UPPERCASE=$(echo ${PROJECT_NAME} | tr 'a-z' 'A-Z')
npx replace-in-file /AUTH_SERVERLESSNINJA_USERPOOLID/g "AUTH_${PROJECT_NAME_UPPERCASE}COGNITO_USERPOOLID" index.ts --isRegex
npm run tsc
cd ../../../../../

# ManageEndUser
cd "amplify/backend/function/${PROJECT_NAME}ManageEndUser/src"
rm *.js *.json
curl -o event.json https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/manageEndUser/src/event.json
cd ..
mkdir ts
cd ts
../../../../../setup_function_typescript.sh
curl -o index.ts https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/manageEndUser/ts/index.ts
PROJECT_NAME_UPPERCASE=$(echo ${PROJECT_NAME} | tr 'a-z' 'A-Z')
npx replace-in-file /AUTH_SERVERLESSNINJA_USERPOOLID/g "AUTH_${PROJECT_NAME_UPPERCASE}COGNITO_USERPOOLID" index.ts --isRegex
npx replace-in-file /API_SERVERLESSNINJA_USERTABLE_NAME/g "API_${PROJECT_NAME_UPPERCASE}GRAPHQL_ENDUSERTABLE_NAME" index.ts --isRegex
npm run tsc
cd ../../../../../

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

# PostAuthentication
cd "amplify/backend/function/${PROJECT_NAME}CognitoPostAuthentication/src"
rm *.js *.json
curl -o event.json https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/postAuthentication/src/event.json
cd ..
mkdir ts
cd ts
../../../../../setup_function_typescript.sh
curl -o index.ts https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/postAuthentication/ts/index.ts
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

# PreTokenGeneration
cd "amplify/backend/function/${PROJECT_NAME}PreTokenGeneration/src"
rm *.js *.json
curl -o event.json https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/preTokenGeneration/src/event.json
cd ..
mkdir ts
cd ts
../../../../../setup_function_typescript.sh
curl -o index.ts https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/preTokenGeneration/ts/index.ts
PROJECT_NAME_UPPERCASE=$(echo ${PROJECT_NAME} | tr 'a-z' 'A-Z')
npx replace-in-file /API_SERVERLESSNINJA_TENANTTABLE_NAME/g "API_${PROJECT_NAME_UPPERCASE}GRAPHQL_TENANTTABLE_NAME" index.ts --isRegex
npx replace-in-file /API_SERVERLESSNINJA_TENANTUSERPREFERENCETABLE_NAME/g "API_${PROJECT_NAME_UPPERCASE}GRAPHQL_TENANTUSERPREFERENCETABLE_NAME" index.ts --isRegex
npx replace-in-file /API_SERVERLESSNINJA_GUESTUSERTABLE_NAME/g "API_${PROJECT_NAME_UPPERCASE}GRAPHQL_GUESTUSERTABLE_NAME" index.ts --isRegex
npx replace-in-file /API_SERVERLESSNINJA_ENDUSERTABLE_NAME/g "API_${PROJECT_NAME_UPPERCASE}GRAPHQL_ENDUSERTABLE_NAME" index.ts --isRegex
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


