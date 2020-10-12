import { Context, VerifyAuthChallengeResponseTriggerEvent, VerifyAuthChallengeResponseTriggerHandler } from 'aws-lambda';

export const handler: VerifyAuthChallengeResponseTriggerHandler = (event: VerifyAuthChallengeResponseTriggerEvent, context: Context) => {
  Object.assign(event.response, { answerCorrect: false });
  if (event.request.privateChallengeParameters) {
    const expectedAnswer = event.request.privateChallengeParameters.secretLoginCode;
    if (event.request.challengeAnswer === expectedAnswer) {
      Object.assign(event.response, { answerCorrect: true });
    }
  }
  context.done(undefined, event);
};
