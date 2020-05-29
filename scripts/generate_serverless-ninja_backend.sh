#!/bin/bash

# Update Amplify CLI
npm i -g @aws-amplify/cli

# Init project
npm init private

# Init amplify
./init_amplify.sh

# Setup VSCode
mkdir .vscode
curl -o .vscode/extensions.json https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/.vscode/extensions.json
curl -o .vscode/settings.json https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/.vscode/settings.json

# Add Prettier and Editorconfig configuration
curl -o .prettierrc https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/.prettierrc
curl -o .prettierignore https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/.prettierignore
curl -o .editorconfig https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/.editorconfig

# Init Cognito
./init_cognito.sh

# Init Pinpoint
./init_pinpoint.sh

# Init Storage
./init_storage.sh

# Init Api
./init_api.sh

# Init Function
./init_function.sh
