import { Callback, CognitoUserPoolTriggerEvent, CognitoUserPoolTriggerHandler } from 'aws-lambda';
import { CognitoIdentityServiceProvider } from 'aws-sdk';

const cognitoIdentityServiceProvider = new CognitoIdentityServiceProvider();

export const handler: CognitoUserPoolTriggerHandler = async (event: CognitoUserPoolTriggerEvent, _, callback: Callback<CognitoUserPoolTriggerEvent>) => {
  if (event.userName) {
    // if account created with phone
    if ('cognito:phone_number_alias' in event.request.userAttributes) {
      const params: CognitoIdentityServiceProvider.AdminUpdateUserAttributesRequest = {
        UserPoolId: event.userPoolId,
        UserAttributes: [
          {
            Name: 'phone_number_verified',
            Value: 'true',
          },
        ],
        Username: event.userName,
      };
      await cognitoIdentityServiceProvider.adminUpdateUserAttributes(params).promise();
    }
    // if account created with email
    if ('cognito:email_alias' in event.request.userAttributes) {
      const params: CognitoIdentityServiceProvider.AdminUpdateUserAttributesRequest = {
        UserPoolId: event.userPoolId,
        UserAttributes: [
          {
            Name: 'email_verified',
            Value: 'true',
          },
        ],
        Username: event.userName,
      };
      await cognitoIdentityServiceProvider.adminUpdateUserAttributes(params).promise();
    }
  }

  callback(null, event);
};
