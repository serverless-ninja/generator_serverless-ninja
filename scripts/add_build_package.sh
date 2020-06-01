#!/bin/bash

echo "`npx jq '.scripts += {"amplify:'${PROJECT_NAME}'CognitoCreateAuthChallenge": "cd amplify/backend/function/'${PROJECT_NAME}'CognitoCreateAuthChallenge/ts && npm install && npm run tsc && cd -"}' package.json`" > package.json
echo "`npx jq '.scripts += {"amplify:'${PROJECT_NAME}'CognitoDefineAuthChallenge": "cd amplify/backend/function/'${PROJECT_NAME}'CognitoDefineAuthChallenge/ts && npm install && npm run tsc && cd -"}' package.json`" > package.json
echo "`npx jq '.scripts += {"amplify:'${PROJECT_NAME}'GetCognitoUser": "cd amplify/backend/function/'${PROJECT_NAME}'GetCognitoUser/ts && npm install && npm run tsc && cd -"}' package.json`" > package.json
echo "`npx jq '.scripts += {"amplify:'${PROJECT_NAME}'ManageEndUser": "cd amplify/backend/function/'${PROJECT_NAME}'ManageEndUser/ts && npm install && npm run tsc && cd -"}' package.json`" > package.json
echo "`npx jq '.scripts += {"amplify:'${PROJECT_NAME}'ManageGuestUser": "cd amplify/backend/function/'${PROJECT_NAME}'ManageGuestUser/ts && npm install && npm run tsc && cd -"}' package.json`" > package.json
echo "`npx jq '.scripts += {"amplify:'${PROJECT_NAME}'CognitoPostAuthentication": "cd amplify/backend/function/'${PROJECT_NAME}'CognitoPostAuthentication/ts && npm install && npm run tsc && cd -"}' package.json`" > package.json
echo "`npx jq '.scripts += {"amplify:'${PROJECT_NAME}'CognitoPreSignup": "cd amplify/backend/function/'${PROJECT_NAME}'CognitoPreSignup/ts && npm install && npm run tsc && cd -"}' package.json`" > package.json
echo "`npx jq '.scripts += {"amplify:'${PROJECT_NAME}'PreTokenGeneration": "cd amplify/backend/function/'${PROJECT_NAME}'PreTokenGeneration/ts && npm install && npm run tsc && cd -"}' package.json`" > package.json
echo "`npx jq '.scripts += {"amplify:'${PROJECT_NAME}'CognitoVerifyAuthChallengeResponse": "cd amplify/backend/function/'${PROJECT_NAME}'CognitoVerifyAuthChallengeResponse/ts && npm install && npm run tsc && cd -"}' package.json`" > package.json
