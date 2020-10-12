#!/bin/bash

DIR="$(cd "$(dirname "$0")" && pwd)"

#Update Amplify CLI
# npm i -g @aws-amplify/cli

# Init project
npm init private

# Init amplify
$DIR/init_amplify.sh

# Init Cognito
$DIR/init_cognito.sh

# Init Pinpoint
$DIR/init_pinpoint.sh

# Init Storage
$DIR/init_storage.sh

# Init Api
$DIR/init_api.sh

# Init Function

# getCognitoUser
$DIR/function/getCognitoUser/init_function.sh

## manageEndUser
$DIR/function/manageEndUser/init_function.sh

## manageGuestUser
$DIR/function/manageGuestUser/init_function.sh

## postAuthentication
$DIR/function/postAuthentication/init_function.sh

## preSignup
$DIR/function/preSignup/init_function.sh

## preTokenGeneration
$DIR/function/preTokenGeneration/init_function.sh

# Update Function

# createAuthChallenge
$DIR/function/createAuthChallenge/update_function.sh

# ## getCognitoUser
$DIR/function/getCognitoUser/update_function.sh

## manageEndUser
$DIR/function/manageEndUser/update_function.sh

## manageGuestUser
$DIR/function/manageGuestUser/update_function.sh

## postAuthentication
$DIR/function/postAuthentication/update_function.sh

## preSignup
$DIR/function/preSignup/update_function.sh

## preTokenGeneration
$DIR/function/preTokenGeneration/update_function.sh

# Download Function

# createAuthChallenge
$DIR/function/createAuthChallenge/download_function.sh

## defineAuthChallenge
$DIR/function/defineAuthChallenge/download_function.sh

# ## getCognitoUser
$DIR/function/getCognitoUser/download_function.sh

## manageEndUser
$DIR/function/manageEndUser/download_function.sh

## manageGuestUser
$DIR/function/manageGuestUser/download_function.sh

## postAuthentication
$DIR/function/postAuthentication/download_function.sh

## preSignup
$DIR/function/preSignup/download_function.sh

## preTokenGeneration
$DIR/function/preTokenGeneration/download_function.sh

## verifyAuthChallengeResponse
$DIR/function/verifyAuthChallengeResponse/download_function.sh

# # Setup VSCode
mkdir .vscode
curl -o .vscode/extensions.json https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/.vscode/extensions.json
curl -o .vscode/settings.json https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/.vscode/settings.json

# Add Prettier and Editorconfig configuration
curl -o .prettierrc https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/.prettierrc
curl -o .prettierignore https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/.prettierignore
curl -o .editorconfig https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/.editorconfig

# Add the build function in package.json (https://docs.amplify.aws/cli/function/build-options)
$DIR/add_build_package.sh

# Add the app schema
curl -o "amplify/backend/api/${PROJECT_NAME}GraphQL/schema/pokemon.graphql" https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/api/graphQL/schema/pokemon.graphql


