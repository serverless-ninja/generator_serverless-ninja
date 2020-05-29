#!/bin/bash

( \
    sleep 1; printf "\n"; `# Select an Analytics provider? Amazon Pinpoint` \
    sleep 1; echo "${PROJECT_NAME}PinPoint"; `# Provide your pinpoint resource name:` \
    sleep 1; printf "\n"; `# Apps need authorization to send analytics events. Do you want to allow guests and unauthenticated users to send analytics events? Yes` \
) | amplify add analytics
