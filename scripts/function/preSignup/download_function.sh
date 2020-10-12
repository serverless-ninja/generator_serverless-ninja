# #!/bin/bash

DIR="$(cd "$(dirname "$0")" && pwd)"
PARENT_DIR="$(dirname $(dirname $(dirname "$DIR")))"

# Pre Sign-up
cd "$PARENT_DIR/amplify/backend/function/${PROJECT_NAME}CognitoPreSignup/src"
rm *.js *.json
curl -o event.json https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/preSignup/src/event.json
cd ..
mkdir ts
cd ts
$PARENT_DIR/scripts/setup_function_typescript.sh
curl -o index.ts https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/preSignup/ts/index.ts
npm run tsc
cd $PARENT_DIR