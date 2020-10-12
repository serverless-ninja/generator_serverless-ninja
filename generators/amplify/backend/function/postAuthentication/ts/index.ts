import { Callback, Context, PostAuthenticationTriggerEvent, PostAuthenticationTriggerHandler } from 'aws-lambda';
import { CognitoIdentityServiceProvider } from 'aws-sdk';

const { REGION } = process.env;
if (!REGION) {
  throw new Error("Function requires environment variable: 'REGION'");
}

const cognitoIdentityServiceProvider = new CognitoIdentityServiceProvider({ region: REGION });

export const handler: PostAuthenticationTriggerHandler = async (event: PostAuthenticationTriggerEvent, context: Context, callback: Callback<PostAuthenticationTriggerEvent>) => {
  if (event.userName) {
    // if account created with phone
    if ('phone_number' in event.request.userAttributes) {
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
    if ('email' in event.request.userAttributes) {
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
