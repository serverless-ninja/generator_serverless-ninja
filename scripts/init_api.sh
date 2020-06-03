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

rm "amplify/backend/api/${PROJECT_NAME}GraphQL/schema.graphql"
mkdir "amplify/backend/api/${PROJECT_NAME}GraphQL/schema"
curl -o "amplify/backend/api/${PROJECT_NAME}GraphQL/schema/tenant.graphql" https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/api/graphQL/schema/tenant.graphql
npx replace-in-file /SERVERLESSNINJA_/g "${PROJECT_NAME}" "amplify/backend/api/${PROJECT_NAME}GraphQL/schema/tenant.graphql" --isRegex

( \
    sleep 1; echo -n $'\e'\[B; printf "\n"; `# Choose the code generation language target: typescript` \
    sleep 1; printf "\n"; `# Enter the file name pattern of graphql queries, mutations and subscriptions: src/graphql/**/*.ts` \
    sleep 1; printf "\n"; `# Do you want to generate/update all possible GraphQL? Yes` \
    sleep 1; printf "\n"; `# Enter maximum statement depth? 2` \
    sleep 1; printf "\n"; `# Enter the file name for the generated code? src/API.ts` \
    sleep 1; printf "\n"; `# Do you want to generate code for your newly created GraphQL API? Yes` \
) | amplify codegen add
