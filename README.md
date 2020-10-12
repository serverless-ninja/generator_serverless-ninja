# Download the scripts

`curl https://codeload.github.com/serverless-ninja/generator_serverless-ninja/tar.gz/master | tar -xz --strip=1 generator_serverless-ninja-master/scripts`

# Authorize the scripts

`chmod -R +x ./scripts`

# Give the project name

`export PROJECT_NAME="projectname"`

Only number or letter and not very long and all in lower case

## Generate all backend

`./scripts/generate_serverless-ninja_backend.sh`

## Delete scripts

`rm -rf ./scripts`

# Deploy Directly

`amplify push --yes`

# Deploy Via CI/CD and for outsource your code

## Commit

`git init`

`echo 'amplify/team-provider-info.json' >> .gitignore`

`git add .`

`git commit -m "generated code"`

Push to your remote repo (github, bitbucket, gitlab, ect ...)

If you want, you can init Gitflow and create your branches

Just open `https://console.aws.amazon.com/amplify/home` and choose to add app with git and deploy your branch

In the backend, copy the command to pull the environnement

Then delete the 

`amplify env remove developninja`

# Choose to activate SMS and email channel

`amplify console analytics`

# Choose to activate the function

`amplify console auth` and chose the `post authentication`, `pre signup` and the `pre token generation` function

# If you want add the oauth google
go to `https://console.developers.google.com/apis/` => `credentials` => and get the client id and secret

`amplify update auth`

then go to `https://console.developers.google.com/apis/` => `credentials` => add the new domain name just createad in `Authorized redirect URIs`
`https://****-develop.auth.us-east-1.amazoncognito.com/oauth2/idpresponse`

# Test

Then you can try the function by doing:

`amplify mock XXXX`

# TODO:
- change all the event json with real uses cases
- add the check for the tenant (is paid or not)