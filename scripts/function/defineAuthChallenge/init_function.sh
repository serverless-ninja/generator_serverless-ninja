# #!/bin/bash

# Define Auth Challenge
cd "amplify/backend/function/${PROJECT_NAME}CognitoDefineAuthChallenge/src"
rm *.js *.json
curl -o event.json https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/defineAuthChallenge/src/event.json
cd ..
mkdir ts
cd ts
../../../../../setup_function_typescript.sh
curl -o index.ts https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/amplify/backend/function/defineAuthChallenge/ts/index.ts
npm run tsc
cd ../../../../../