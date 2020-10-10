# #!/bin/bash

# Verify Auth Challenge Response
cd "amplify/backend/function/${PROJECT_NAME}CognitoVerifyAuthChallengeResponse/src"
rm *.js *.json
curl -o event.json https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/verifyAuthChallengeResponse/src/event.json
cd ..
mkdir ts
cd ts
../../../../../setup_function_typescript.sh
curl -o index.ts https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/verifyAuthChallengeResponse/ts/index.ts
npm run tsc
cd ../../../../../