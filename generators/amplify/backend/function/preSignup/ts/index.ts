import { Callback, CognitoUserPoolTriggerEvent, CognitoUserPoolTriggerHandler, Context } from 'aws-lambda';

export const handler: CognitoUserPoolTriggerHandler = (event: CognitoUserPoolTriggerEvent, context: Context, callback: Callback<CognitoUserPoolTriggerEvent>) => {
  Object.assign(event.response, { autoConfirmUser: true });
  callback(null, event);
};
