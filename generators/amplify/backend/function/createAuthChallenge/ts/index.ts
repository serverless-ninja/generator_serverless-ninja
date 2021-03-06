import { Context, CreateAuthChallengeTriggerEvent, CreateAuthChallengeTriggerHandler } from 'aws-lambda';
import { randomDigits } from 'crypto-secure-random-digit';
import { configure, setLocale } from 'i18n';
import { sendEmail } from './send_email';
import { sendSms } from './send_sms';

// Get REGION
const { REGION } = process.env;
if (!REGION) {
  throw new Error("Function requires environment variable: 'REGION'");
}

// Get Pinpoint Project ID from environment variable
const PINPOINT_PROJECT_ID = process.env.ANALYTICS_PROJECTNAMEPINPOINT_ID;
if (!PINPOINT_PROJECT_ID) {
  throw new Error("Function requires environment variable: 'ANALYTICS_PROJECTNAMEPINPOINT_ID'");
}

export const handler: CreateAuthChallengeTriggerHandler = async (event: CreateAuthChallengeTriggerEvent, context: Context) => {
  configure({
    defaultLocale: 'en',
    directory: `${__dirname}/locales`,
  });
  // set the locale with user attributes
  if (Object.prototype.hasOwnProperty.call(event.request.userAttributes, 'locale')) {
    setLocale(event.request.userAttributes.locale);
  }

  // only for CUSTOM_CHALLENGE
  if (event.request.challengeName === 'CUSTOM_CHALLENGE') {
    // if we are in the custom challenge, and no session exists
    if (event.request.session === undefined || event.request.session.length === 0) {
      // we create a 6 digits code
      const secretLoginCode = randomDigits(6).join('');
      // if account created with phone number
      if ('phone_number' in event.request.userAttributes) {
        const phoneNumber = event.request.userAttributes.phone_number;
        // send SMS with the code
        await sendSms(phoneNumber, secretLoginCode, PINPOINT_PROJECT_ID, REGION);
        // This is sent back to the client app, so they know if it's email or phone challenge
        Object.assign(event.response, { publicChallengeParameters: { phone: phoneNumber } });
        // Add the secret login code to the private challenge parameters so it can be verified by the "Verify Auth Challenge Response" trigger
        Object.assign(event.response, { privateChallengeParameters: { secretLoginCode } });
        // Add the secret login code to the session so it is available in the next
        Object.assign(event.response, { challengeMetadata: `CODE-${secretLoginCode}` });
      }
      // if account created with email
      if ('email' in event.request.userAttributes) {
        // if identities (means we have merge with social oauth account and we can use email)
        const emailAddress = event.request.userAttributes.email;
        // send email with the code
        await sendEmail(emailAddress, secretLoginCode, PINPOINT_PROJECT_ID, REGION);
        // This is sent back to the client app, so they know if it's email or phone challenge
        Object.assign(event.response, { publicChallengeParameters: { email: emailAddress } });
        // Add the secret login code to the private challenge parameters so it can be verified by the "Verify Auth Challenge Response" trigger
        Object.assign(event.response, { privateChallengeParameters: { secretLoginCode } });
        // Add the secret login code to the session so it is available in the next
        Object.assign(event.response, { challengeMetadata: `CODE-${secretLoginCode}` });
      }
    } else {
      // we already have session. So we don't generate digits again but re-use the code from the current session.
      // This allows the user to make a mistake when keying in the code and to then retry, rather the needing to resend email or sms with new code
      const previousChallenge = event.request.session.slice(-1)[0];
      if (previousChallenge.challengeMetadata !== undefined) {
        // we do regex on the previous Challenge Medadata
        const regex = RegExp(/CODE-(\d*)/);
        const previousSecretLoginCodeRegexExecArray = regex.exec(previousChallenge.challengeMetadata);
        if (previousSecretLoginCodeRegexExecArray !== null && previousSecretLoginCodeRegexExecArray.length === 2) {
          // we get the previous secret code and resend it
          const previousSecretLoginCode = previousSecretLoginCodeRegexExecArray[1];
          Object.assign(event.response, { privateChallengeParameters: { secretLoginCode: previousSecretLoginCode } });
          Object.assign(event.response, { challengeMetadata: `CODE-${previousSecretLoginCode}` });
          // we send back the phone or email to client
          if ('phone_number' in event.request.userAttributes) {
            const phoneNumber = event.request.userAttributes.phone_number;
            Object.assign(event.response, { publicChallengeParameters: { phone: phoneNumber } });
          }
          if ('email' in event.request.userAttributes) {
            const emailAddress = event.request.userAttributes.email;
            Object.assign(event.response, { publicChallengeParameters: { email: emailAddress } });
          }
        }
      }
    }
  }
  context.done(undefined, event);
};
