import { Callback, CognitoUserPoolTriggerEvent, CognitoUserPoolTriggerHandler, Context } from 'aws-lambda';
import { CognitoIdentityServiceProvider } from 'aws-sdk';

const { REGION } = process.env;
if (!REGION) {
  throw new Error("Function requires environment variable: 'REGION'");
}

const cognitoIdentityServiceProvider = new CognitoIdentityServiceProvider({ region: REGION });

export const handler: CognitoUserPoolTriggerHandler = async (event: CognitoUserPoolTriggerEvent, context: Context, callback: Callback<CognitoUserPoolTriggerEvent>) => {
  // merge the user if user already registered with same email and then try to log with the social provider with this email
  if (event.triggerSource === 'PreSignUp_ExternalProvider' && event.request.userAttributes.email && event.userName) {
    const [providerName, providerUserId] = event.userName.split('_'); // event userName example: "Facebook_12324325436"
    // check if we have already an user with this email
    const listUsersRequest = {
      UserPoolId: event.userPoolId,
      Filter: `email = "${event.request.userAttributes.email}"`,
    };
    const listUsersResponse = await cognitoIdentityServiceProvider.listUsers(listUsersRequest).promise();
    if (listUsersResponse && listUsersResponse.Users && listUsersResponse.Users.length > 0) {
      if (listUsersResponse.Users[0].Username) {
        const adminLinkProviderForUserRequest = {
          UserPoolId: event.userPoolId,
          SourceUser: {
            ProviderAttributeName: 'Cognito_Subject',
            ProviderAttributeValue: providerUserId,
            ProviderName: providerName,
          },
          DestinationUser: {
            ProviderAttributeValue: listUsersResponse.Users[0].Username, // the first one found
            ProviderName: 'Cognito',
          },
        };
        // https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_AdminLinkProviderForUser.html
        await cognitoIdentityServiceProvider.adminLinkProviderForUser(adminLinkProviderForUserRequest).promise();
      }
    } else {
      // if no user with this email, we create it
      const adminCreateUserResponse = await cognitoIdentityServiceProvider
        .adminCreateUser({ Username: event.request.userAttributes.email, UserPoolId: event.userPoolId, MessageAction: 'SUPPRESS' })
        .promise();
      // then we merge it
      if (adminCreateUserResponse.User) {
        const adminLinkProviderForUserRequest = {
          UserPoolId: event.userPoolId,
          SourceUser: {
            ProviderAttributeName: 'Cognito_Subject',
            ProviderAttributeValue: providerUserId,
            ProviderName: providerName,
          },
          DestinationUser: {
            ProviderAttributeValue: adminCreateUserResponse.User.Username, // the first one found
            ProviderName: 'Cognito',
          },
        };
        // https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_AdminLinkProviderForUser.html
        await cognitoIdentityServiceProvider.adminLinkProviderForUser(adminLinkProviderForUserRequest).promise();
      }
    }
  }
  // confirm user
  Object.assign(event.response, { autoConfirmUser: true });
  callback(null, event);
};
