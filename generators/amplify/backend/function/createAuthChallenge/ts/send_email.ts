import { Pinpoint } from 'aws-sdk';
import { __ as t } from 'i18n';

const logoUrl = 'https://www.your-service.com/icons/icon-48x48.png';
const emailSupport = 'contact@your-service.com';
const webSiteUrl = 'https://www.your-service.com';

const emailTemplate = (otpCode: string) => {
  return `
  <html>
  <body>
      <center>
          <table>
              <tbody>
                  <tr>
                      <td style="vertical-align:top; padding:0px">
                          <table
                              style="border:0px; border-collapse:collapse; margin:0px auto 16px; background:white ;border-radius:8px">
                              <tbody>
                                  <tr>
                                      <td style="width:546px; vertical-align:top; padding-top:32px">
                                          <div style="max-width:600px; margin:0px auto">
                                              <img style="width:38px; height:38px; margin:0px 0px 15px; padding-right:30px; padding-left:30px;" src="${logoUrl}" width="38" height="38">
                                              <h1 style="font-size:30px; padding-right:30px; padding-left:30px">
                                                  ${t('email.title')}
                                              </h1>
                                              <p style="font-size:17px;padding-right:30px;padding-left:30px">
                                                  ${t('email.subTitle1')}
                                              </p>
                                              <p style="font-size:17px;padding-right:30px;padding-left:30px">
                                                  ${t('email.subTitle2')}
                                              </p>
                                              <div style="padding-right:30px; padding-left:30px; margin:32px 0px 40px">
                                                  <center>
                                                      <table style="border-collapse:collapse; border:0px; background-color:rgb(244,244,244); height:70px; table-layout:fixed; border-radius:6px">
                                                          <tbody>
                                                              <tr>
                                                                  <td style="text-align:center; vertical-align:middle; font-size:30px; letter-spacing: 0.5rem; padding-left:0.7rem;">
                                                                      ${otpCode}
                                                                  </td>
                                                              </tr>
                                                          </tbody>
                                                      </table>
                                                  </center>
                                              </div>
                                              <p style="font-size:17px; padding-right:30px; padding-left:30px">
                                                  ${t('email.disclaimer')} <a style="color:rgb(5,118,185)" href="mailto:${emailSupport}" target="_blank">${emailSupport}</a>
                                              </p>
                                          </div>
                                      </td>
                                  </tr>
                              </tbody>
                          </table>
                          <center>
                              <table style="width:100%;">
                                  <tbody>
                                      <tr>
                                          <td style="font-size:15px; color:rgb(113,114,116); text-align:center; width:100%; border-top:1px solid rgb(225,225,228)">
                                              <center>
                                                  <table style="margin-top:20px; background-color:white; border:0px; text-align:center ;border-collapse:collapse">
                                                      <tbody>
                                                          <tr>
                                                              <td>
                                                                  <span style="display:block; color:rgb(67,66,69); font-size:15px">
                                                                      ${t('email.footerCreatedBy')}
                                                                      <a href="${webSiteUrl}" style="text-decoration:none; color:rgb(67,66,69)" target="_blank">
                                                                          ${t('email.footerCreatedByCompany')}
                                                                      </a>
                                                                  </span>
                                                              </td>
                                                          </tr>
                                                      </tbody>
                                                  </table>
                                              </center>
                                          </td>
                                      </tr>
                                  </tbody>
                              </table>
                          </center>
                      </td>
                  </tr>
              </tbody>
          </table>
      </center>
  </body>
  </html>
  `;
};

const emailTemplateText = (otpCode: string) => {
  return `
    ${t('email.title')}\n\n
    ${t('email.subTitle1')}\n
    ${t('email.subTitle2')}\n\n\n
    ${otpCode}\n\n\n
    ${t('email.disclaimer')} ${emailSupport}\n
  `;
};

export const sendEmail = async (emailAddress: string, secretLoginCode: string, poinpointProjectID: string, region: string): Promise<void> => {
  const pinpoint = new Pinpoint({ region });
  const sendMessagesRequest: Pinpoint.SendMessagesRequest = {
    ApplicationId: poinpointProjectID,
    MessageRequest: {
      Addresses: {
        [emailAddress]: {
          ChannelType: 'EMAIL',
        },
      },
      MessageConfiguration: {
        EmailMessage: {
          SimpleEmail: {
            Subject: {
              Charset: 'UTF-8',
              Data: `${t('email.subject')} ${secretLoginCode}`,
            },
            HtmlPart: {
              Charset: 'UTF-8',
              Data: emailTemplate(secretLoginCode),
            },
            TextPart: {
              Charset: 'UTF-8',
              Data: emailTemplateText(secretLoginCode),
            },
          },
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
    console.error(err, err.stack);
  }
};
