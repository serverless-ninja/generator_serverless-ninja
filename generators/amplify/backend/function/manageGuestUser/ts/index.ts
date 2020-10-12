import { Handler } from 'aws-lambda';
import { AWSError, CognitoIdentityServiceProvider, DynamoDB } from 'aws-sdk';
import { DeleteItemInput, UpdateItemInput } from 'aws-sdk/clients/dynamodb';
import { PromiseResult } from 'aws-sdk/lib/request';

const { REGION } = process.env;
if (!REGION) {
  throw new Error("Function requires environment variable: 'REGION'");
}

const USERPOOL_ID = process.env.AUTH_POURBOIRCOGNITO_USERPOOLID;
if (!USERPOOL_ID) {
  throw new Error("Function requires environment variable: 'AUTH_POURBOIRCOGNITO_USERPOOLID'");
}
const USERTABLE_NAME = process.env.API_POURBOIRGRAPHQL_GUESTUSERTABLE_NAME;
if (!USERTABLE_NAME) {
  throw new Error("Function requires environment variable: 'API_POURBOIRGRAPHQL_GUESTUSERTABLE_NAME'");
}

interface GraphqlEvent {
  typeName: string /* Filled dynamically based on @function usage location */;
  fieldName: string /* Filled dynamically based on @function usage location */;
  arguments: {
    /* GraphQL field arguments via $ctx.arguments */
    input: {
      userId?: string;
      emailOrPhone?: string;
      tenantId?: string;
      enabled?: boolean;
    };
  };
  identity: {
    /*
    AppSync identity object via $ctx.identity
    https://docs.aws.amazon.com/appsync/latest/devguide/resolver-context-reference.html#aws-appsync-resolver-context-reference-identity
    */
  };
  source: {
    /* The object returned by the parent resolver. E.G. if resolving field 'Post.comments', the source is the Post object. */
  };
  request: {
    /* AppSync request object. Contains things like headers. */
  };
  prev: {
    /* If using the built-in pipeline resolver support, this contains the object returned by the previous function. */
  };
}
interface User {
  userId: string;
  tenantId: string;
  updatedAt: Date;
}

const cognitoIdentityServiceProvider = new CognitoIdentityServiceProvider({ region: REGION });
const dynamoDB = new DynamoDB({ region: REGION });

export const createUser = async (emailOrPhone: string, tenantId: string): Promise<User> => {
  try {
    const params: CognitoIdentityServiceProvider.Types.AdminCreateUserRequest = {
      UserPoolId: USERPOOL_ID,
      Username: emailOrPhone,
    };

    const request: PromiseResult<CognitoIdentityServiceProvider.AdminCreateUserResponse, AWSError> = await cognitoIdentityServiceProvider.adminCreateUser(params).promise();
    const response = request.$response.data as CognitoIdentityServiceProvider.AdminCreateUserResponse;

    if (!response.User || !response.User.Username) {
      throw new Error('UserNotCreated');
    }

    const now = new Date();
    const putItemInput = {
      TableName: USERTABLE_NAME,
      Item: {
        userId: { S: response.User.Username },
        tenantId: { S: tenantId },
        __typename: { S: 'User' },
        createdAt: { S: `${now.toISOString()}` },
        updatedAt: { S: `${now.toISOString()}` },
      },
    };
    try {
      await dynamoDB.putItem(putItemInput).promise();
    } catch (errorDynamoDB) {
      // if cannot saved the user, we delete it
      await cognitoIdentityServiceProvider
        .adminDeleteUser({
          UserPoolId: USERPOOL_ID,
          Username: response.User.Username,
        })
        .promise();
      throw errorDynamoDB;
    }
    return {
      userId: response.User.Username,
      tenantId,
      updatedAt: now,
    };
  } catch (error) {
    // see possible errors here: https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_AdminCreateUser.html
    if (error instanceof AWSError) {
      if (error.code === 'UsernameExistsException') {
        // can send back the error code you want
        throw new Error('UsernameExistsException');
      }
    }
    throw error;
  }
};

export const updateUser = async (userId: string, enabled: boolean): Promise<User> => {
  const getItemInput = {
    TableName: USERTABLE_NAME,
    Key: {
      id: {
        S: userId,
      },
    },
  };

  const User = await dynamoDB.getItem(getItemInput).promise();
  if (!User.Item) {
    throw new Error('UserNotFoundException');
  }

  // enabled or disabled the user
  const params = {
    UserPoolId: USERPOOL_ID,
    Username: userId,
  };

  if (enabled === true) {
    await cognitoIdentityServiceProvider.adminEnableUser(params).promise();
  }
  if (enabled === false) {
    await cognitoIdentityServiceProvider.adminDisableUser(params).promise();
  }
  const now = new Date();
  const updateItemInput: UpdateItemInput = {
    TableName: USERTABLE_NAME,
    Key: {
      id: {
        S: userId,
      },
    },
    ExpressionAttributeNames: {
      '#updatedAt': 'updatedAt',
    },
    UpdateExpression: '#updatedAt = :updatedAt',
    ExpressionAttributeValues: {
      ':updatedAt': { S: `${now.toISOString()}` },
    },
  };
  await dynamoDB.updateItem(updateItemInput).promise();

  const tenantId = User.Item?.tenantId.S;
  if (!tenantId) {
    throw new Error('TenantNotFoundException');
  }

  return {
    userId,
    tenantId,
    updatedAt: now,
  };
};

export const deleteUser = async (userId: string): Promise<User> => {
  const getItemInput = {
    TableName: USERTABLE_NAME,
    Key: {
      id: {
        S: userId,
      },
    },
  };

  const User = await dynamoDB.getItem(getItemInput).promise();
  if (!User.Item) {
    throw new Error('UserNotFoundException');
  }

  const params: CognitoIdentityServiceProvider.Types.AdminCreateUserRequest = {
    UserPoolId: USERPOOL_ID,
    Username: userId,
  };

  await cognitoIdentityServiceProvider.adminDeleteUser(params).promise();

  const deleteItemInput: DeleteItemInput = {
    TableName: USERTABLE_NAME,
    Key: {
      id: {
        S: userId,
      },
    },
  };
  const now = new Date();
  await dynamoDB.deleteItem(deleteItemInput).promise();

  const tenantId = User.Item?.tenantId.S;
  if (!tenantId) {
    throw new Error('TenantNotFoundException');
  }

  return {
    userId,
    tenantId,
    updatedAt: now,
  };
};

export const handler: Handler<GraphqlEvent, User | void> = async (event: GraphqlEvent): Promise<User> => {
  // check if it's mutation
  if (event.typeName !== 'Mutation') {
    throw new Error('NotMutationException');
  }

  switch (event.fieldName) {
    case 'createGuestUser': {
      const { emailOrPhone, tenantId } = event.arguments.input;
      if (!emailOrPhone) {
        throw new Error('NoEmailOrPhoneException');
      }
      if (!tenantId) {
        throw new Error('NoTenantIdException');
      }
      return createUser(emailOrPhone, tenantId);
    }
    case 'updateGuestUser': {
      const { userId, enabled } = event.arguments.input;
      if (!userId) {
        throw new Error('NoUserIdException');
      }
      if (!enabled) {
        throw new Error('NoEnabledException');
      }
      return updateUser(userId, enabled);
    }
    case 'deleteGuestUser': {
      const { userId } = event.arguments.input;
      if (!userId) {
        throw new Error('NoUserIdException');
      }
      return deleteUser(userId);
    }
    default:
      throw new Error('FieldNameNotExistsException');
  }
};
