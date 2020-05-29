#!/bin/bash

( \
    sleep 1; printf "\n"; `# Please select from one of the below mentioned services: Content (Images, audio, video, etc.)` \
    sleep 1; echo "${PROJECT_NAME}S3"; `# Please provide a friendly name for your resource that will be used to label this category in the project` \
    sleep 1; echo "${PROJECT_NAME}-private"; `# Please provide bucket name:` \
    sleep 1; printf "\n"; `# Restrict access by? Auth/Guest Users` \
    sleep 1; printf "\n"; `# Who should have access: Auth users only` \
    sleep 1; echo "a"; printf "\n" `# What kind of access do you want for Authenticated users? create/update, read, delete` \
    sleep 1; printf "\n"; `# Do you want to add a Lambda Trigger for your S3 Bucket? No` \
) | amplify add storage
