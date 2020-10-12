# #!/bin/bash

DIR="$(cd "$(dirname "$0")" && pwd)"
PARENT_DIR="$(dirname $(dirname $(dirname "$DIR")))"

# ManageEndUser
cd "$PARENT_DIR/amplify/backend/function/${PROJECT_NAME}ManageEndUser/src"
rm *.js *.json
curl -o event.json https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/manageEndUser/src/event.json
cd ..
mkdir ts
cd ts
$PARENT_DIR/scripts/setup_function_typescript.sh
curl -o index.ts https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/manageEndUser/ts/index.ts
PROJECT_NAME_UPPERCASE=$(echo ${PROJECT_NAME} | tr 'a-z' 'A-Z')
npx replace-in-file /AUTH_SERVERLESSNINJA_USERPOOLID/g "AUTH_${PROJECT_NAME_UPPERCASE}COGNITO_USERPOOLID" index.ts --isRegex
npx replace-in-file /API_SERVERLESSNINJA_USERTABLE_NAME/g "API_${PROJECT_NAME_UPPERCASE}GRAPHQL_ENDUSERTABLE_NAME" index.ts --isRegex
npm run tsc
cd $PARENT_DIR

