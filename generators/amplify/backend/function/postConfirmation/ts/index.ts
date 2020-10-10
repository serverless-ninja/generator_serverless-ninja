import { CognitoUserPoolTriggerEvent, CognitoUserPoolTriggerHandler, Context } from 'aws-lambda';
import { CognitoIdentityServiceProvider } from 'aws-sdk';

const { REGION } = process.env;
if (!REGION) {
  throw new Error("Function requires environment variable: 'REGION'");
}

const cognitoIdentityServiceProvider = new CognitoIdentityServiceProvider({ region: REGION });

/**
 * Doesnt work (do not use)
 */
export const handler: CognitoUserPoolTriggerHandler = async (event: CognitoUserPoolTriggerEvent, context: Context) => {
  // check if we have already an user with this email
  const listUsersRequest = {
    UserPoolId: event.userPoolId,
    Filter: `email = "${event.request.userAttributes.email}"`,
  };
  const listUsersResponse = await cognitoIdentityServiceProvider.listUsers(listUsersRequest).promise();
  if (listUsersResponse && listUsersResponse.Users && listUsersResponse.Users.length > 0) {
    // find the user with UserStatus : 'EXTERNAL_PROVIDER'
    const socialUser = listUsersResponse.Users.find((value) => value.UserStatus === 'EXTERNAL_PROVIDER');
    const nativeUser = listUsersResponse.Users.find((value) => value.UserStatus === 'FORCE_CHANGE_PASSWORD');
    if (socialUser && socialUser.Username && nativeUser && nativeUser.Username) {
      // we delete the current user social user
      await cognitoIdentityServiceProvider.adminDeleteUser({ UserPoolId: event.userPoolId, Username: socialUser.Username }).promise();
      const [providerName, providerUserId] = socialUser.Username.split('_'); // example: "Facebook_12324325436"
      const adminLinkProviderForUserRequest = {
        UserPoolId: event.userPoolId,
        SourceUser: {
          ProviderAttributeName: 'Cognito_Subject',
          ProviderAttributeValue: providerUserId,
          ProviderName: providerName,
        },
        DestinationUser: {
          ProviderAttributeValue: nativeUser.Username,
          ProviderName: 'Cognito',
        },
      };
      // https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_AdminLinkProviderForUser.html
      await cognitoIdentityServiceProvider.adminLinkProviderForUser(adminLinkProviderForUserRequest).promise();
    }
  }
  // TODO but a problem come when login as the signup user has been deleted , maybe need to do merge im presingup
  context.done(undefined, event);
};
