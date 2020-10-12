import { Callback, Context, PreSignUpTriggerEvent, PreSignUpTriggerHandler } from 'aws-lambda';

export const handler: PreSignUpTriggerHandler = (event: PreSignUpTriggerEvent, context: Context, callback: Callback<PreSignUpTriggerEvent>) => {
  Object.assign(event.response, { autoConfirmUser: true });
  callback(null, event);
};
