import { Handler } from 'aws-lambda';
import { CognitoIdentityServiceProvider } from 'aws-sdk';

const { REGION } = process.env;
if (!REGION) {
  throw new Error("Function requires environment variable: 'REGION'");
}

const COGNITO_USERPOOL_ID = process.env.AUTH_SERVERLESSNINJA_USERPOOLID;
if (!COGNITO_USERPOOL_ID) {
  throw new Error("Function requires environment variable: 'AUTH_SERVERLESSNINJA_USERPOOLID'");
}

const cognitoIdentityServiceProvider = new CognitoIdentityServiceProvider({ region: REGION });

interface GraphqlEvent {
  typeName: string /* Filled dynamically based on @function usage location */;
  fieldName: string /* Filled dynamically based on @function usage location */;
  arguments: {
    /* GraphQL field arguments via $ctx.arguments */
  };
  identity: {
    /*
    AppSync identity object via $ctx.identity
    https://docs.aws.amazon.com/appsync/latest/devguide/resolver-context-reference.html#aws-appsync-resolver-context-reference-identity
    */
  };
  source: {
    /* The object returned by the parent resolver. E.G. if resolving field 'Post.comments', the source is the Post object. */
    userId: string;
  };
  request: {
    /* AppSync request object. Contains things like headers. */
  };
  prev: {
    /* If using the built-in pipeline resolver support, this contains the object returned by the previous function. */
  };
}

interface CognitoUser {
  /**
   * The user email
   */
  email?: string;
  /**
   * The user phone number
   */
  phone?: string;
  /**
   * The date the user was created.
   */
  createdDate?: Date;
  /**
   * The date the user was last modified.
   */
  lastModifiedDate?: Date;
  /**
   * Indicates that the status is enabled.
   */
  enabled?: boolean;
}

export const handler: Handler<GraphqlEvent, CognitoUser | void> = async (event: GraphqlEvent): Promise<CognitoUser> => {
  // check if it's field for User
  if (event.typeName !== 'User') {
    throw new Error('NoUserFieldException');
  }
  // check if it's cognitoUser field
  if (event.fieldName !== 'cognitoUser') {
    throw new Error('NotcognitoUserFieldException');
  }

  const params: CognitoIdentityServiceProvider.Types.AdminGetUserRequest = {
    UserPoolId: COGNITO_USERPOOL_ID,
    Username: event.source.userId,
  };
  const user = await cognitoIdentityServiceProvider.adminGetUser(params).promise();
  if (!user) {
    throw new Error('UsernameExistsException');
  }
  const email = user.UserAttributes && user.UserAttributes.find((value) => value.Name === 'email');
  const phone = user.UserAttributes && user.UserAttributes.find((value) => value.Name === 'phone_number');
  return {
    email: email?.Value,
    phone: phone?.Value,
    createdDate: user.UserCreateDate,
    lastModifiedDate: user.UserLastModifiedDate,
    enabled: user.Enabled,
  };
};
