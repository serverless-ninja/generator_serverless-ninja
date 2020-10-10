#!/bin/bash

# Update Amplify CLI
npm i -g @aws-amplify/cli

# Init project
npm init private

# Init amplify
./init_amplify.sh

# Init Cognito
./init_cognito.sh

# Init Pinpoint
./init_pinpoint.sh

# Init Storage
./init_storage.sh

# Init Api
./init_api.sh

# Init Function

## createAuthChallenge
./createAuthChallenge/init_function.sh

## defineAuthChallenge
./defineAuthChallenge/init_function.sh

## getCognitoUser
./getCognitoUser/init_function.sh

## manageEndUser
./manageEndUser/init_function.sh

## manageGuestUser
./manageGuestUser/init_function.sh

## postAuthentication
./postAuthentication/init_function.sh

## preSignup
./preSignup/init_function.sh

## preTokenGeneration
./preTokenGeneration/init_function.sh

## verifyAuthChallengeResponse
./verifyAuthChallengeResponse/init_function.sh

# Setup VSCode
mkdir .vscode
curl -o .vscode/extensions.json https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/.vscode/extensions.json
curl -o .vscode/settings.json https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/.vscode/settings.json

# Add Prettier and Editorconfig configuration
curl -o .prettierrc https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/.prettierrc
curl -o .prettierignore https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/.prettierignore
curl -o .editorconfig https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/.editorconfig

# Add the build function in package.json (https://docs.amplify.aws/cli/function/build-options)
./add_build_package.sh

# Add the app schema
curl -o "amplify/backend/api/${PROJECT_NAME}GraphQL/schema/pokemon.graphql" https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/api/graphQL/schema/pokemon.graphql


