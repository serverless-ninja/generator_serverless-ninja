#!/bin/bash

npm init private
npm install aws-lambda aws-sdk
npm install --save-dev typescript @types/node @types/aws-lambda eslint@6.8.0 eslint-plugin-flowtype@3 @typescript-eslint/eslint-plugin@2.31.0 eslint-config-airbnb-base@latest eslint-plugin-import @typescript-eslint/parser@2.31.0 eslint-config-airbnb-typescript prettier eslint-config-prettier eslint-plugin-prettier eslint-plugin-jsx-a11y eslint-plugin-react eslint-plugin-react-hooks@2.5.0
curl -o tsconfig.json https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/generic/ts/tsconfig.json
curl -o .eslintrc.json https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/generic/ts/.eslintrc.json
curl -o .eslintignore https://raw.githubusercontent.com/generator_serverless-ninja/master/generators/amplify/backend/function/generic/ts/.eslintignore
echo "`npx jq '.scripts += {tsc: "npm run lint && tsc"}' package.json`" > package.json
echo "`npx jq '.scripts += {lint: "eslint . --ext .ts"}' package.json`" > package.json
