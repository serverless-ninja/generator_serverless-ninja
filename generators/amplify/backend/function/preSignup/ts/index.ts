import { Callback, CognitoUserPoolTriggerEvent, CognitoUserPoolTriggerHandler, Context } from 'aws-lambda';
import { CognitoIdentityServiceProvider } from 'aws-sdk';

const { REGION } = process.env;
if (!REGION) {
  throw new Error("Function requires environment variable: 'REGION'");
}

const cognitoIdentityServiceProvider = new CognitoIdentityServiceProvider({ region: REGION });

export const handler: CognitoUserPoolTriggerHandler = async (event: CognitoUserPoolTriggerEvent, context: Context, callback: Callback<CognitoUserPoolTriggerEvent>) => {
  // merge the user if user already registered with same email as use in the social provider

  if (event.triggerSource === 'PreSignUp_ExternalProvider' && event.request.userAttributes.email && event.userName) {
    // check if we have already an user with this email
    const listUsersRequest = {
      UserPoolId: event.userPoolId,
      Filter: `email = "${event.request.userAttributes.email}"`,
    };
    const listUsersResponse = await cognitoIdentityServiceProvider.listUsers(listUsersRequest).promise();
    if (listUsersResponse && listUsersResponse.Users && listUsersResponse.Users.length > 0) {
      const [providerName, providerUserId] = event.userName.split('_'); // event userName example: "Facebook_12324325436"

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
      await cognitoIdentityServiceProvider.adminLinkProviderForUser(adminLinkProviderForUserRequest);
    }
  }

  // const userRs = await getUserByEmail(event.userPoolId, event.request.userAttributes.email)

  // confirm user
  Object.assign(event.response, { autoConfirmUser: true });
  callback(null, event);
};
