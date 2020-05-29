#!/bin/bash

JAVASCRIPTCONFIG="{\
\"SourceDir\":\"src\",\
\"DistributionDir\":\"front\",\
\"BuildCommand\":\"npm run-script build\",\
\"StartCommand\":\"npm run-script start\"\
}"
AWSCLOUDFORMATIONCONFIG="{\
\"configLevel\":\"project\",\
\"useProfile\":true,\
\"profileName\":\"default\"\
}"
AMPLIFY="{\
\"projectName\":\"${PROJECT_NAME}\",\
\"envName\":\"develop\",\
\"defaultEditor\":\"code\"\
}"
FRONTEND="{\
\"frontend\":\"javascript\",\
\"framework\":\"none\",\
\"config\":$JAVASCRIPTCONFIG\
}"
PROVIDERS="{\
\"awscloudformation\":$AWSCLOUDFORMATIONCONFIG\
}"

amplify init \
--amplify $AMPLIFY \
--frontend $FRONTEND \
--providers $PROVIDERS \
--yes

mkdir front
curl -o front/index.html https://raw.githubusercontent.com/serverless-ninja/generator_serverless-ninja/master/generators/front/index.html
