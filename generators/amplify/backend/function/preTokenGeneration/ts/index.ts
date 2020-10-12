import { Callback, Context, PreTokenGenerationTriggerEvent, PreTokenGenerationTriggerHandler } from 'aws-lambda';
import { DynamoDB } from 'aws-sdk';

const { REGION } = process.env;
if (!REGION) {
  throw new Error("Function requires environment variable: 'REGION'");
}

const TENANTTABLE_NAME = process.env.API_SERVERLESSNINJA_TENANTTABLE_NAME;
if (!TENANTTABLE_NAME) {
  throw new Error("Function requires environment variable: 'API_SERVERLESSNINJA_TENANTTABLE_NAME'");
}
const TENANTUSERPREFERENCETABLE_NAME = process.env.API_SERVERLESSNINJA_TENANTUSERPREFERENCETABLE_NAME;
if (!TENANTUSERPREFERENCETABLE_NAME) {
  throw new Error("Function requires environment variable: 'API_SERVERLESSNINJA_TENANTUSERPREFERENCETABLE_NAME'");
}
const GUESTUSERTABLE_NAME = process.env.API_SERVERLESSNINJA_GUESTUSERTABLE_NAME;
if (!GUESTUSERTABLE_NAME) {
  throw new Error("Function requires environment variable: 'API_SERVERLESSNINJA_GUESTUSERTABLE_NAME'");
}
const ENDUSERTABLE_NAME = process.env.API_SERVERLESSNINJA_ENDUSERTABLE_NAME;
if (!ENDUSERTABLE_NAME) {
  throw new Error("Function requires environment variable: 'API_SERVERLESSNINJA_ENDUSERTABLE_NAME'");
}

const dynamoDB = new DynamoDB({ region: REGION });

export const handler: PreTokenGenerationTriggerHandler = async (event: PreTokenGenerationTriggerEvent, _context: Context, callback: Callback<PreTokenGenerationTriggerEvent>) => {
  const userId = event.userName;
  if (!userId) {
    throw new Error("Function requires to receive in event the username: 'event.userName'");
  }

  let claimsToAddOrOverride = {};

  // if end user
  const getItemEndUserInput = {
    TableName: ENDUSERTABLE_NAME,
    Key: {
      userId: {
        S: userId,
      },
    },
  };
  const EndUser = await dynamoDB.getItem(getItemEndUserInput).promise();
  if (EndUser.Item && EndUser.Item.tenantId) {
    claimsToAddOrOverride = {
      tenantId: EndUser.Item.tenantId.S,
    };
  } else {
    // check for the owner and guest user what is their preferences
    const getItemTenantUserPreferenceInput = {
      TableName: TENANTUSERPREFERENCETABLE_NAME,
      Key: {
        userId: {
          S: userId,
        },
      },
    };

    const TenantUserPreference = await dynamoDB.getItem(getItemTenantUserPreferenceInput).promise();
    if (TenantUserPreference.Item && TenantUserPreference.Item.tenantId) {
      // we get the tenant
      const getItemTenantInput = {
        TableName: TENANTTABLE_NAME,
        Key: {
          id: {
            S: TenantUserPreference.Item.tenantId.S,
          },
        },
      };
      const Tenant = await dynamoDB.getItem(getItemTenantInput).promise();
      if (Tenant.Item) {
        // we check if the user is the owner
        if (TenantUserPreference.Item.userId && TenantUserPreference.Item.userId === userId) {
          claimsToAddOrOverride = {
            ownerTenantId: TenantUserPreference.Item.tenantId.S,
            guestTenantId: TenantUserPreference.Item.tenantId.S,
            tenantId: TenantUserPreference.Item.tenantId.S,
          };
        } else {
          // if not the owner we get the guest user
          const getItemGuestUserInput = {
            TableName: GUESTUSERTABLE_NAME,
            Key: {
              tenantId: {
                S: TenantUserPreference.Item.tenantId.S,
              },
              userId: {
                S: userId,
              },
            },
          };
          const guestUser = await dynamoDB.getItem(getItemGuestUserInput).promise();
          if (guestUser.Item) {
            claimsToAddOrOverride = {
              guestTenantId: TenantUserPreference.Item.tenantId.S,
              tenantId: TenantUserPreference.Item.tenantId.S,
            };
          }
        }
      }
    } else {
      // if no tenant id (maybe the first time the user loggin or still not choose his preference) and we return no token
      const now = new Date();
      const putItemInput = {
        TableName: TENANTUSERPREFERENCETABLE_NAME,
        Item: {
          userId: { S: userId },
          __typename: { S: 'TenantUserPreference' },
          createdAt: { S: `${now.toISOString()}` },
          updatedAt: { S: `${now.toISOString()}` },
        },
      };
      await dynamoDB.putItem(putItemInput).promise();
    }
  }

  // add the claims to override
  Object.assign(event.response, {
    claimsOverrideDetails: {
      claimsToAddOrOverride,
    },
  });

  callback(null, event);
};
