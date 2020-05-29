#!/bin/bash

( \
    sleep 1; printf "\n"; `# Please select from one of the below mentioned services: Amazon GraphQL` \
    sleep 1; echo "${PROJECT_NAME}GraphQL"; `# Provide API name:` \
    sleep 1; echo -n $'\e'\[B; printf "\n"; `# Choose the default authorization type for the API: Amazon Cognito User Pool` \
    sleep 1; printf "\n"; `# Do you want to configure advanced settings for the GraphQL API: No` \
    sleep 1; printf "\n"; `# Do you have an annotated GraphQL schema? No` \
    sleep 1; printf "\n"; `# Do you want a guided schema creation? Yes` \
    sleep 1; printf "\n"; `# What best describes your project: Single object with fields` \
    sleep 1; echo "n"; printf "\n"; `# Do you want to edit the schema now? No` \
) | amplify add api


curl -o "amplify/backend/api/${PROJECT_NAME}GraphQL/schema.graphql" https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/api/graphQL/schema.graphql
npx replace-in-file /SERVERLESSNINJA_/g "${PROJECT_NAME}" "amplify/backend/api/${PROJECT_NAME}GraphQL/schema.graphql" --isRegex
