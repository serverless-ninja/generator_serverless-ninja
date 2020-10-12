#!/bin/bash

npm init private
npm install aws-lambda aws-sdk
npm install --save-dev typescript @types/node @types/aws-lambda eslint-config-airbnb-typescript eslint-plugin-import@^2.22.0 @typescript-eslint/eslint-plugin@^4.2.0 eslint-config-prettier eslint @typescript-eslint/parser
npx install-peerdeps --dev eslint-plugin-prettier
curl -o tsconfig.json https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/generic/ts/tsconfig.json
curl -o .eslintrc.json https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/generic/ts/.eslintrc.json
curl -o .eslintignore https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/generic/ts/.eslintignore
echo "`npx jq '.scripts += {tsc: "npm run lint && tsc"}' package.json`" > package.json
echo "`npx jq '.scripts += {lint: "eslint . --ext .ts"}' package.json`" > package.json
