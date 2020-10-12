import { Pinpoint } from 'aws-sdk';
import { __ as t } from 'i18n';

export const sendSms = async (phoneNumber: string, secretLoginCode: string, poinpointProjectID: string, region: string): Promise<void> => {
  const pinpoint = new Pinpoint({ region });
  const sendMessagesRequest: Pinpoint.SendMessagesRequest = {
    ApplicationId: poinpointProjectID,
    MessageRequest: {
      Addresses: {
        [phoneNumber]: {
          ChannelType: 'SMS',
        },
      },
      MessageConfiguration: {
        SMSMessage: {
          Body: `${t('sms.subject')} ${secretLoginCode}`,
          MessageType: 'TRANSACTIONAL',
        },
      },
    },
  };
  const messagePromise = pinpoint.sendMessages(sendMessagesRequest);
  try {
    const response = await messagePromise.promise();
    if (response.$response.error) {
      console.error(JSON.stringify(response.$response.error));
    }
  } catch (err) {
    console.error(err);
  }
};
