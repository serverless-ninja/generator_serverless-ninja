#!/bin/bash

( \
    sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B; printf "\n"; `# Do you want to use the default authentication and security configuration? Default configuration? Manual configuration` \
    sleep 1; printf "\n"; `# Select the authentication/authorization services that you want to use: User Sign-Up, Sign-In, connected with AWS IAM controls` \
    sleep 1; echo "${PROJECT_NAME}Cognito"; `# Please provide a friendly name for your resource that will be used to label this category in the project` \
    sleep 1; echo "${PROJECT_NAME}_identity_pool"; `# Please provide a friendly name for your resource that will be used to label this category in the project` \
    sleep 1; printf "\n"; `# Allow unauthenticated logins? No` \
    sleep 1; echo -n $'\e'\[B; printf "\n"; `# Do you want to enable 3rd party authentication providers in your identity pool? No` \
    sleep 1; echo "${PROJECT_NAME}_user_pool"; `# Please provide a name for your user pool` \
    sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; printf "\n"; `# How do you want users to be able to sign in? Email or Phone Number` \
    sleep 1; printf "\n"; `# Do you want to add User Pool Groups? Yes` \
    sleep 1; echo "ADMIN"; `# Do you want to add User Pool Groups? Yes` \
    sleep 1; printf "\n"; `# Do you want to add another User Pool Group? No` \
    sleep 1; printf "\n"; `# Sort the user pool groups in order of preference?` \
    sleep 1; echo -n $'\e'\[B; printf "\n"; `# Do you want to add an admin queries API? No` \
    sleep 1; printf "\n"; `# Multifactor authentication (MFA) user login options? OFF` \
    sleep 1; echo -n $'\e'\[B; printf "\n"; `# Email based user registration/forgot password? Disabled` \
    sleep 1; echo "Your verification code is {####}"; `# Please specify an SMS verification message` \
    sleep 1; printf "\n"; `# Do you want to override the default password policy for this User Pool? N` \
    sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B;  printf ' '; printf "\n"; `# What attributes are required for signing up? None` \
    sleep 1; echo "30"; `#Specify the app's refresh token expiration period (in days): (30)` \
    sleep 1; printf "\n"; `# Do you want to specify the user attributes this app can read and write? N` \
    sleep 1; printf "\n"; `# Do you want to enable any of the following capabilities?` \
    sleep 1; echo -n $'\e'\[B; printf "\n"; `# Do you want to use an OAuth flow? No` \
    sleep 1; echo "Y"; printf "\n"; `# Do you want to configure Lambda Triggers for Cognito? Yes` \
    `# Which triggers do you want to enable for Cognito: `
        sleep 1; echo -n $'\e'\[B; printf ' '; `# Create Auth Challenge` \
        sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B; printf ' '; `# Define Auth Challenge` \
        sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; printf ' '; `# Verify Auth Challenge Response` \
        sleep 1; printf "\n";
    `# Create Auth Challenge, Define Auth Challenge, Verify Auth Challenge Response`
    sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; printf ' '; printf "\n"; `# What functionality do you want to use for Create Auth Challenge: Create your own module` \
    sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; printf ' '; printf "\n"; `# What functionality do you want to use for Define Auth Challenge: Create your own module` \
    sleep 1; echo -n $'\e'\[B; echo -n $'\e'\[B; echo -n $'\e'\[B; printf ' '; printf "\n"; `# What functionality do you want to use for Verify Auth Challenge Response: Create your own module` \
    sleep 1; echo "n"; printf "\n"; `# Do you want to edit your custom function now? No` \
    sleep 1; echo "n"; printf "\n"; `# Do you want to edit your custom function now? No` \
    sleep 1; echo "n"; printf "\n"; `# Do you want to edit your custom function now? No` \
) | amplify add auth
