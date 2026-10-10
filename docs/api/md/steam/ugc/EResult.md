# steam.ugc.EResult

**enum abstract** · package [`steam.ugc`](README.md) · module `steam.ugc.Data` · source [`steam/ugc/Data.hx`](../../../../../steam/ugc/Data.hx)

The result of a Steam operation (Steamworks `EResult`).

Underlying type: `Int`

Implicit casts from: `Int`

Implicit casts to: `Int`

## Values

| Name | Value | Description |
|---|---|---|
| `OK` | `1` | Success. |
| `Fail` | `2` | Generic failure. |
| `NoConnection` | `3` | No/failed network connection. |
| `InvalidPassword` | `5` | Password/ticket is invalid. |
| `LoggedInElsewhere` | `6` | Same user logged in elsewhere. |
| `InvalidProtocolVer` | `7` | Protocol version is incorrect. |
| `InvalidParam` | `8` | A parameter is incorrect. |
| `FileNotFound` | `9` | File was not found. |
| `Busy` | `10` | Called method busy - action not taken. |
| `InvalidState` | `11` | Called object was in an invalid state. |
| `InvalidName` | `12` | Name is invalid. |
| `InvalidEmail` | `13` | Email is invalid. |
| `DuplicateName` | `14` | Name is not unique. |
| `AccessDenied` | `15` | Access is denied. |
| `Timeout` | `16` | Operation timed out. |
| `Banned` | `17` | VAC2 banned. |
| `AccountNotFound` | `18` | Account not found. |
| `InvalidSteamID` | `19` | SteamID is invalid. |
| `ServiceUnavailable` | `20` | The requested service is currently unavailable. |
| `NotLoggedOn` | `21` | The user is not logged on. |
| `Pending` | `22` | Request is pending (may be in process; or waiting on third party) |
| `EncryptionFailure` | `23` | Encryption or Decryption failed. |
| `InsufficientPrivilege` | `24` | Insufficient privilege. |
| `LimitExceeded` | `25` | Too much of a good thing. |
| `Revoked` | `26` | Access has been revoked (used for revoked guest passes) |
| `Expired` | `27` | License/Guest pass the user is trying to access is expired. |
| `AlreadyRedeemed` | `28` | Guest pass has already been redeemed by account; cannot be acked again. |
| `DuplicateRequest` | `29` | The request is a duplicate and the action has already occurred in the past; ignored this time. |
| `AlreadyOwned` | `30` | All the games in this guest pass redemption request are already owned by the user. |
| `IPNotFound` | `31` | IP address not found. |
| `PersistFailed` | `32` | Failed to write change to the data store. |
| `LockingFailed` | `33` | Failed to acquire access lock for this operation. |
| `LogonSessionReplaced` | `34` | The logon session was replaced. |
| `ConnectFailed` | `35` | The connection failed. |
| `HandshakeFailed` | `36` | The connection handshake failed. |
| `IOFailure` | `37` | A generic IO failure. |
| `RemoteDisconnect` | `38` | The remote server disconnected. |
| `ShoppingCartNotFound` | `39` | Failed to find the shopping cart requested. |
| `Blocked` | `40` | A user didn't allow it. |
| `Ignored` | `41` | Target is ignoring sender. |
| `NoMatch` | `42` | Nothing matching the request found. |
| `AccountDisabled` | `43` | The account is disabled. |
| `ServiceReadOnly` | `44` | This service is not accepting content changes right now. |
| `AccountNotFeatured` | `45` | Account doesn't have value; so this feature isn't available. |
| `AdministratorOK` | `46` | Allowed to take this action; but only because requester is admin. |
| `ContentVersion` | `47` | A Version mismatch in content transmitted within the Steam protocol. |
| `TryAnotherCM` | `48` | The current CM can't service the user making a request; user should try another. |
| `PasswordRequiredToKickSession` | `49` | You are already logged in elsewhere; this cached credential login has failed. |
| `AlreadyLoggedInElsewhere` | `50` | You are already logged in elsewhere; you must wait. |
| `Suspended` | `51` | Long running operation (content download) suspended/paused. |
| `Cancelled` | `52` | Operation canceled (typically by user: content download) |
| `DataCorruption` | `53` | Operation canceled because data is ill formed or unrecoverable. |
| `DiskFull` | `54` | Operation canceled - not enough disk space. |
| `RemoteCallFailed` | `55` | An remote call or IPC call failed. |
| `PasswordUnset` | `56` | Password could not be verified as it's unset server side. |
| `ExternalAccountUnlinked` | `57` | External account (PSN; Facebook...) is not linked to a Steam account. |
| `PSNTicketInvalid` | `58` | PSN ticket was invalid. |
| `ExternalAccountAlreadyLinked` | `59` | External account (PSN; Facebook...) is already linked to some other account; must explicitly request to replace/delete the link first. |
| `RemoteFileConflict` | `60` | The sync cannot resume due to a conflict between the local and remote files. |
| `IllegalPassword` | `61` | The requested new password is not legal. |
| `SameAsPreviousValue` | `62` | New value is the same as the old one ( secret question and answer ) |
| `AccountLogonDenied` | `63` | Account login denied due to 2nd factor authentication failure. |
| `CannotUseOldPassword` | `64` | The requested new password is not legal. |
| `InvalidLoginAuthCode` | `65` | Account login denied due to auth code invalid. |
| `AccountLogonDeniedNoMail` | `66` | Account login denied due to 2nd factor auth failure - and no mail has been sent. |
| `HardwareNotCapableOfIPT` | `67` | The hardware is not capable of Intel Identity Protection Technology. |
| `IPTInitError` | `68` | Intel Identity Protection Technology failed to initialize. |
| `ParentalControlRestricted` | `69` | Operation failed due to parental control restrictions for current user. |
| `FacebookQueryError` | `70` | Facebook query returned an error. |
| `ExpiredLoginAuthCode` | `71` | Account login denied due to auth code expired. |
| `IPLoginRestrictionFailed` | `72` | The login was denied by the IP restrictions. |
| `AccountLockedDown` | `73` | The account is locked down. |
| `AccountLogonDeniedVerifiedEmailRequired` | `74` | A verified email is required to log on. |
| `NoMatchingURL` | `75` | There is no URL matching the provided values. |
| `BadResponse` | `76` | Parse failure; missing field; etc. |
| `RequirePasswordReEntry` | `77` | The user cannot complete the action until they re-enter their password. |
| `ValueOutOfRange` | `78` | The value entered is outside the acceptable range. |
| `UnexpectedError` | `79` | Something happened that we didn't expect to ever happen. |
| `Disabled` | `80` | The requested service has been configured to be unavailable. |
| `InvalidCEGSubmission` | `81` | The set of files submitted to the CEG server are not valid ! |
| `RestrictedDevice` | `82` | The device being used is not allowed to perform this action. |
| `RegionLocked` | `83` | The action could not be complete because it is region restricted. |
| `RateLimitExceeded` | `84` | Temporary rate limit exceeded; try again later; different from `LimitExceeded`, which may be permanent. |
| `AccountLoginDeniedNeedTwoFactor` | `85` | Need two-factor code to login. |
| `ItemDeleted` | `86` | The thing we're trying to access has been deleted. |
| `AccountLoginDeniedThrottle` | `87` | Login attempt failed; try to throttle response to possible attacker. |
| `TwoFactorCodeMismatch` | `88` | Two factor code mismatch. |
| `TwoFactorActivationCodeMismatch` | `89` | Activation code for two-factor didn't match. |
| `AccountAssociatedToMultiplePartners` | `90` | Account has been associated with multiple partners. |
| `NotModified` | `91` | Data not modified. |
| `NoMobileDevice` | `92` | The account does not have a mobile device associated with it. |
| `TimeNotSynced` | `93` | The time presented is out of range or tolerance. |
| `SmsCodeFailed` | `94` | SMS code failure (no match; none pending; etc.) |
| `AccountLimitExceeded` | `95` | Too many accounts access this resource. |
| `AccountActivityLimitExceeded` | `96` | Too many changes to this account. |
| `PhoneActivityLimitExceeded` | `97` | Too many changes to this phone. |
| `RefundToWallet` | `98` | Cannot refund to payment method; must use wallet. |
| `EmailSendFailure` | `99` | Cannot send an email. |
| `NotSettled` | `100` | Can't perform operation till payment has settled. |
| `NeedCaptcha` | `101` | Needs to provide a valid captcha. |
| `GSLTDenied` | `102` | A game server login token owned by this token's owner has been banned. |
| `GSOwnerDenied` | `103` | Game server owner is denied for other reason (account lock; community ban; vac ban; missing phone) |
| `InvalidItemType` | `104` | The type of thing we were requested to act on is invalid. |
| `IPBanned` | `105` | The ip address has been banned from taking this action. |
| `GSLTExpired` | `106` | This token has expired from disuse; can be reset for use. |
