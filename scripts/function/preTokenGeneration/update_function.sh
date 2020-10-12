#!/usr/local/bin/expect -f

spawn amplify update function

# Select which capability you want to add: Lambda function (serverless function)
expect "Lambda function (serverless function)"
send -- "\r"

# Please select the Lambda Function you would want to update: PretokenGeneration
expect "Select the Lambda function you want to update"
send -- "\[B"
send -- "\[B"
send -- "\[B"
send -- "\[B"
send -- "\[B"
send -- "\[B"
send -- "\[B"
send -- "\[B"
send -- "\r"

# Do you want to update permissions granted to this Lambda function to perform on other resources in your project? Yes
expect "Do you want to update the Lambda function permissions to access other resources in this project"
send -- "Y"
send -- "\r"

# Select the category: storage
expect "Select the category"
send -- "\[B"
send -- "\[B"
send -- "\[B"
send -- " "
send -- "\r"

# Storage has 5 resources in this project: Tenant:@model(appsync), TenantUserPreference:@model(appsync), GuestUser:@model(appsync), EndUser:@model(appsync)
expect "Storage has"
send -- "\[B"
send -- " "
send -- "\[B"
send -- " "
send -- "\[B"
send -- " "
send -- "\[B"
send -- " "
send -- "\r"

# Select the operations you want to permit for Tenant:@model? create, read, update, delete
expect "Select the operations you want to permit for Tenant"
send -- "a"
send -- "\r"

# Select the operations you want to permit for TenantUserPreference:@model? create, read, update, delete
expect "Select the operations you want to permit for TenantUserPreference"
send -- "a"
send -- "\r"

# Select the operations you want to permit for GuestUser:@model? create, read, update, delete
expect "Select the operations you want to permit for GuestUser"
send -- "a"
send -- "\r"

# Select the operations you want to permit for EndUser:@model? create, read, update, delete
expect "Select the operations you want to permit for EndUser"
send -- "a"
send -- "\r"

# Do you want to invoke this function on a recurring schedule?: No
expect "Do you want to invoke this function on a recurring schedule"
send -- "N"
send -- "\r"

# Do you want to configure Lambda layers for this function?: no
expect "Do you want to configure Lambda layers for this function"
send -- "n"
send -- "\r"

# Do you want to edit the local lambda function now?: No
expect "Do you want to edit the local lambda function now"
send -- "N"
send -- "\r"

expect eof
