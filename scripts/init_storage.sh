#!/usr/local/bin/expect -f

spawn amplify add storage

# Please select from one of the below mentioned services: Content (Images, audio, video, etc.)
expect "lease select from one of the below mentioned services"
send -- "\r"

# Please provide a friendly name for your resource that will be used to label this category in the project
expect "Please provide a friendly name for your resource that will be used to label this category in the project"
send -- "$env(PROJECT_NAME)S3"
send -- "\r"

# Please provide bucket name
expect "Please provide bucket name"
send -- "$env(PROJECT_NAME)-private"
send -- "\r"

# Restrict access by? Auth/Guest Users
expect "Restrict access by"
send -- "\r"

# Who should have access: Auth users only
expect "Who should have access"
send -- "\r"

# What kind of access do you want for Authenticated users? create/update, read, delete
expect "What kind of access do you want for Authenticated users"
send -- "a"
send -- "\r"

# Do you want to add a Lambda Trigger for your S3 Bucket? No
expect "Do you want to add a Lambda Trigger for your S3 Bucket"
send -- "n"
send -- "\r"

expect eof
