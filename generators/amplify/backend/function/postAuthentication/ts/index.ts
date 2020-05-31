import { Callback, CognitoUserPoolTriggerEvent, CognitoUserPoolTriggerHandler, Context } from 'aws-lambda';
import { CognitoIdentityServiceProvider } from 'aws-sdk';

const { REGION } = process.env;
if (!REGION) {
  throw new Error("Function requires environment variable: 'REGION'");
}

const cognitoIdentityServiceProvider = new CognitoIdentityServiceProvider({ region: REGION });

export const handler: CognitoUserPoolTriggerHandler = async (event: CognitoUserPoolTriggerEvent, context: Context, callback: Callback<CognitoUserPoolTriggerEvent>) => {
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
