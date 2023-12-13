@page subPage_configGeneral General configuration [general.config]

The general.config defines general options for the default email notification settings.

The config file uses the JSON format and can contain following entries:

## email
General e-mail notifications settings. This entry is optional.

|Key  | Description | Variable type| Default value |
|-----|-------------|--------------|---------------|
| enabled | Enable or disable notifications |bool | false (disabled). |
| senderAddress | Sender address which is used to send the notifications, e.g. notification@yourCompany.com. Using an empty string also disables the notifications.| string | "" (empty)
| smtpHost      | Host name of the SMTP server used for the notification emails. Using an empty string also disables the notifications.| string | "" (empty)
| smtpPassword  | Login password SMTP server. |string | "" (empty)
| smtpUser      | User name for the SMTP server. |string | "" (empty)
| useTLS        | Defines if TLS encryption is used. |bool | false (disabled).


## fileVersion
  Contains the version of this file (format). Reserved for future usage.
  This entry is optional. The default value is "1.1".

## Example
```
{
  "email": { 
    "enabled": true,
    "senderAddress": "etmtst@etm.at",
    "smtpHost": "eis2k212"
  },
  "fileVersion": "1.1"
}
```