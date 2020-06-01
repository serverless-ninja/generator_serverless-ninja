import { CognitoUserPoolTriggerEvent, CognitoUserPoolTriggerHandler, Context } from 'aws-lambda';

export const handler: CognitoUserPoolTriggerHandler = (event: CognitoUserPoolTriggerEvent, context: Context) => {
  // if we don't have session, it's the first time we try to login so we propose the CUSTOM_CHALLENGE
  if (event.request.session === undefined || event.request.session.length === 0) {
    Object.assign(event.response, { issueTokens: false });
    Object.assign(event.response, { failAuthentication: false });
    Object.assign(event.response, { challengeName: 'CUSTOM_CHALLENGE' });
  } else {
    // we authorize with the CUSTOM_CHALLENGE
    if (event.request.session.slice(-1)[0].challengeName === 'CUSTOM_CHALLENGE') {
      // reply that we are in CUSTOM_CHALLENGE context
      Object.assign(event.response, { challengeName: 'CUSTOM_CHALLENGE' });
      // first we check if the last answer is correct
      if (event.request.session.slice(-1)[0].challengeResult === true) {
        Object.assign(event.response, { issueTokens: true });
        Object.assign(event.response, { failAuthentication: false });
        context.done(undefined, event);
        return;
      }
      // can try to answer the custom challenge only 3 times
      if (event.request.session.length < 3) {
        // wrong answer, so we let the user answer again
        Object.assign(event.response, { issueTokens: false });
        Object.assign(event.response, { failAuthentication: false });
        context.done(undefined, event);
        return;
      }
      // if try to answer more than 3 times we reject authentication
      Object.assign(event.response, { issueTokens: false });
      Object.assign(event.response, { failAuthentication: true });
      context.done(undefined, event);
      return;
    }
    // if not CUSTOM_CHALLENGE we reject authentication
    Object.assign(event.response, { issueTokens: false });
    Object.assign(event.response, { failAuthentication: true });
    context.done(undefined, event);
    return;
  }
  context.done(undefined, event);
};
