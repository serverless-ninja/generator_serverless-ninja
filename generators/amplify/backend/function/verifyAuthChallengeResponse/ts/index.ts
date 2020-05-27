import { CognitoUserPoolTriggerEvent, CognitoUserPoolTriggerHandler, Context } from 'aws-lambda';

export const handler: CognitoUserPoolTriggerHandler = (event: CognitoUserPoolTriggerEvent, context: Context) => {
  Object.assign(event.response, { answerCorrect: false });
  if (event.request.privateChallengeParameters) {
    const expectedAnswer = event.request.privateChallengeParameters.secretLoginCode;
    if (event.request.challengeAnswer === expectedAnswer) {
      Object.assign(event.response, { answerCorrect: true });
    }
  }
  context.done(undefined, event);
};
