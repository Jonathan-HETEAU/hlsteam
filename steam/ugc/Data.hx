package steam.ugc;

/**
	The type of a Workshop item (Steamworks `EWorkshopFileType`).
**/
enum abstract EFileType(Int) from Int to Int {
	/** Normal Workshop item that can be subscribed to. **/
	var Community              =  0;
	/** Workshop item that is meant to be voted on for the purpose of selling in-game. **/
	var Microtransaction       =  1;
	/** A collection of Workshop or Greenlight items. **/
	var Collection             =  2;
	/** Artwork. **/
	var Art                    =  3;
	/** External video. **/
	var Video                  =  4;
	/** Screenshot. **/
	var Screenshot             =  5;
	/** Greenlight game entry. **/
	var Game                   =  6;
	/** Greenlight software entry. **/
	var Software               =  7;
	/** Greenlight concept. **/
	var Concept                =  8;
	/** Steam web guide. **/
	var WebGuide               =  9;
	/** Application integrated guide. **/
	var IntegratedGuide        = 10;
	/** Workshop merchandise meant to be voted on for the purpose of being sold. **/
	var Merch                  = 11;
	/** Steam Controller bindings. **/
	var ControllerBinding      = 12;
	/** Internal. **/
	var SteamWorksAccessInvite = 13;
	/** Steam video. **/
	var SteamVideo             = 14;
	/** Managed completely by the game, not the user, and not shown on the web. **/
	var GameManagedItem        = 15;
}

/**
	How the items of a Workshop query of all the items are ranked (Steamworks `EUGCQuery`).
**/
enum abstract EQueryType(Int) from Int to Int {
	/**
		By votes.
	**/
	var RankedByVote                                  = 0;
	/**
		By publication date.
	**/
	var RankedByPublicationDate                       = 1;
	/**
		The items accepted for the game, by acceptance date.
	**/
	var AcceptedForGameRankedByAcceptanceDate         = 2;
	/**
		By trend.
	**/
	var RankedByTrend                                 = 3;
	/**
		The favorites of the user's friends, by publication date.
	**/
	var FavoritedByFriendsRankedByPublicationDate     = 4;
	/**
		The items created by the user's friends, by publication date.
	**/
	var CreatedByFriendsRankedByPublicationDate       = 5;
	/**
		By number of reports.
	**/
	var RankedByNumTimesReported                      = 6;
	/**
		The items created by the users followed by the user, by publication date.
	**/
	var CreatedByFollowedUsersRankedByPublicationDate = 7;
	/**
		The items not rated yet.
	**/
	var NotYetRated                                   = 8;
	/**
		By increasing total number of votes.
	**/
	var RankedByTotalVotesAsc                         = 9;
	/**
		By number of up votes.
	**/
	var RankedByVotesUp                               = 10;
	/**
		By relevance to the search text (see `Query.setSearchText`).
	**/
	var RankedByTextSearch                            = 11;
	/**
		By number of unique subscriptions.
	**/
	var RankedByTotalUniqueSubscriptions              = 12;
	/**
		By play time trend.
	**/
	var RankedByPlaytimeTrend                         = 13;
	/**
		By total play time.
	**/
	var RankedByTotalPlaytime                         = 14;
	/**
		By average play time trend.
	**/
	var RankedByAveragePlaytimeTrend                  = 15;
	/**
		By lifetime average play time.
	**/
	var RankedByLifetimeAveragePlaytime               = 16;
	/**
		By play sessions trend.
	**/
	var RankedByPlaytimeSessionsTrend                 = 17;
	/**
		By lifetime number of play sessions.
	**/
	var RankedByLifetimePlaytimeSessions              = 18;
}

/**
	The kind of Workshop items returned by a query (Steamworks `EUGCMatchingUGCType`).
**/
enum abstract EMatchingType(Int) from Int to Int {
	/**both mtx items and ready-to-use items**/
	var Items:Int			= 0;
	/**
		Microtransaction items.
	**/
	var Items_Mtx:Int		= 1;
	/**
		Ready-to-use items.
	**/
	var Items_ReadyToUse	= 2;
	/**
		Collections.
	**/
	var Collections:Int		= 3;
	/**
		Artwork.
	**/
	var Artwork:Int			= 4;
	/**
		Videos.
	**/
	var Videos:Int			= 5;
	/**
		Screenshots.
	**/
	var Screenshots:Int		= 6;
	/**both web quides and integrated guides**/
	var AllGuides:Int		= 7;
	/**
		Web guides.
	**/
	var WebGuides:Int		= 8;
	/**
		Guides integrated in the game.
	**/
	var IntegratedGuides	= 9;
	/**ready-to-use items and integrated guides**/
	var UsableInGame:Int	= 10;
	/**
		Steam Input controller bindings.
	**/
	var ControllerBindings	= 11;
	/**game managed items (not managed by users)**/
	var GameManagedItems	= 12;
	/**return everything**/
	var All:Int				= ~0;
}

/**
	The result of a Steam operation (Steamworks `EResult`).
**/
enum abstract EResult(Int) from Int to Int {
	/** Success. **/
	var OK = 1;
	/** Generic failure. **/
	var Fail = 2;
	/** No/failed network connection. **/
	var NoConnection = 3;
	//var NoConnectionRetry = 4;            // OBSOLETE - removed
	/** Password/ticket is invalid. **/
	var InvalidPassword = 5;
	/** Same user logged in elsewhere. **/
	var LoggedInElsewhere = 6;
	/** Protocol version is incorrect. **/
	var InvalidProtocolVer = 7;
	/** A parameter is incorrect. **/
	var InvalidParam = 8;
	/** File was not found. **/
	var FileNotFound = 9;
	/** Called method busy - action not taken. **/
	var Busy = 10;
	/** Called object was in an invalid state. **/
	var InvalidState = 11;
	/** Name is invalid. **/
	var InvalidName = 12;
	/** Email is invalid. **/
	var InvalidEmail = 13;
	/** Name is not unique. **/
	var DuplicateName = 14;
	/** Access is denied. **/
	var AccessDenied = 15;
	/** Operation timed out. **/
	var Timeout = 16;
	/** VAC2 banned. **/
	var Banned = 17;
	/** Account not found. **/
	var AccountNotFound = 18;
	/** SteamID is invalid. **/
	var InvalidSteamID = 19;
	/** The requested service is currently unavailable. **/
	var ServiceUnavailable = 20;
	/** The user is not logged on. **/
	var NotLoggedOn = 21;
	/** Request is pending (may be in process; or waiting on third party) **/
	var Pending = 22;
	/** Encryption or Decryption failed. **/
	var EncryptionFailure = 23;
	/** Insufficient privilege. **/
	var InsufficientPrivilege = 24;
	/** Too much of a good thing. **/
	var LimitExceeded = 25;
	/** Access has been revoked (used for revoked guest passes) **/
	var Revoked = 26;
	/** License/Guest pass the user is trying to access is expired. **/
	var Expired = 27;
	/** Guest pass has already been redeemed by account; cannot be acked again. **/
	var AlreadyRedeemed = 28;
	/** The request is a duplicate and the action has already occurred in the past; ignored this time. **/
	var DuplicateRequest = 29;
	/** All the games in this guest pass redemption request are already owned by the user. **/
	var AlreadyOwned = 30;
	/** IP address not found. **/
	var IPNotFound = 31;
	/** Failed to write change to the data store. **/
	var PersistFailed = 32;
	/** Failed to acquire access lock for this operation. **/
	var LockingFailed = 33;
	/**
		The logon session was replaced.
	**/
	var LogonSessionReplaced = 34;
	/**
		The connection failed.
	**/
	var ConnectFailed = 35;
	/**
		The connection handshake failed.
	**/
	var HandshakeFailed = 36;
	/**
		A generic IO failure.
	**/
	var IOFailure = 37;
	/**
		The remote server disconnected.
	**/
	var RemoteDisconnect = 38;
	/** Failed to find the shopping cart requested. **/
	var ShoppingCartNotFound = 39;
	/** A user didn't allow it. **/
	var Blocked = 40;
	/** Target is ignoring sender. **/
	var Ignored = 41;
	/** Nothing matching the request found. **/
	var NoMatch = 42;
	/**
		The account is disabled.
	**/
	var AccountDisabled = 43;
	/** This service is not accepting content changes right now. **/
	var ServiceReadOnly = 44;
	/** Account doesn't have value; so this feature isn't available. **/
	var AccountNotFeatured = 45;
	/** Allowed to take this action; but only because requester is admin. **/
	var AdministratorOK = 46;
	/** A Version mismatch in content transmitted within the Steam protocol. **/
	var ContentVersion = 47;
	/** The current CM can't service the user making a request; user should try another. **/
	var TryAnotherCM = 48;
	/** You are already logged in elsewhere; this cached credential login has failed. **/
	var PasswordRequiredToKickSession = 49;
	/** You are already logged in elsewhere; you must wait. **/
	var AlreadyLoggedInElsewhere = 50;
	/** Long running operation (content download) suspended/paused. **/
	var Suspended = 51;
	/** Operation canceled (typically by user: content download) **/
	var Cancelled = 52;
	/** Operation canceled because data is ill formed or unrecoverable. **/
	var DataCorruption = 53;
	/** Operation canceled - not enough disk space. **/
	var DiskFull = 54;
	/** An remote call or IPC call failed. **/
	var RemoteCallFailed = 55;
	/** Password could not be verified as it's unset server side. **/
	var PasswordUnset = 56;
	/** External account (PSN; Facebook...) is not linked to a Steam account. **/
	var ExternalAccountUnlinked = 57;
	/** PSN ticket was invalid. **/
	var PSNTicketInvalid = 58;
	/** External account (PSN; Facebook...) is already linked to some other account; must explicitly request to replace/delete the link first. **/
	var ExternalAccountAlreadyLinked = 59;
	/** The sync cannot resume due to a conflict between the local and remote files. **/
	var RemoteFileConflict = 60;
	/** The requested new password is not legal. **/
	var IllegalPassword = 61;
	/** New value is the same as the old one ( secret question and answer ) **/
	var SameAsPreviousValue = 62;
	/** Account login denied due to 2nd factor authentication failure. **/
	var AccountLogonDenied = 63;
	/** The requested new password is not legal. **/
	var CannotUseOldPassword = 64;
	/** Account login denied due to auth code invalid. **/
	var InvalidLoginAuthCode = 65;
	/** Account login denied due to 2nd factor auth failure - and no mail has been sent. **/
	var AccountLogonDeniedNoMail = 66;
	/**
		The hardware is not capable of Intel Identity Protection Technology.
	**/
	var HardwareNotCapableOfIPT = 67;
	/**
		Intel Identity Protection Technology failed to initialize.
	**/
	var IPTInitError = 68;
	/** Operation failed due to parental control restrictions for current user. **/
	var ParentalControlRestricted = 69;
	/** Facebook query returned an error. **/
	var FacebookQueryError = 70;
	/** Account login denied due to auth code expired. **/
	var ExpiredLoginAuthCode = 71;
	/**
		The login was denied by the IP restrictions.
	**/
	var IPLoginRestrictionFailed = 72;
	/**
		The account is locked down.
	**/
	var AccountLockedDown = 73;
	/**
		A verified email is required to log on.
	**/
	var AccountLogonDeniedVerifiedEmailRequired = 74;
	/**
		There is no URL matching the provided values.
	**/
	var NoMatchingURL = 75;
	/** Parse failure; missing field; etc. **/
	var BadResponse = 76;
	/** The user cannot complete the action until they re-enter their password. **/
	var RequirePasswordReEntry = 77;
	/** The value entered is outside the acceptable range. **/
	var ValueOutOfRange = 78;
	/** Something happened that we didn't expect to ever happen. **/
	var UnexpectedError = 79;
	/** The requested service has been configured to be unavailable. **/
	var Disabled = 80;
	/** The set of files submitted to the CEG server are not valid ! **/
	var InvalidCEGSubmission = 81;
	/** The device being used is not allowed to perform this action. **/
	var RestrictedDevice = 82;
	/** The action could not be complete because it is region restricted. **/
	var RegionLocked = 83;
	/** Temporary rate limit exceeded; try again later; different from `LimitExceeded`, which may be permanent. **/
	var RateLimitExceeded = 84;
	/** Need two-factor code to login. **/
	var AccountLoginDeniedNeedTwoFactor = 85;
	/** The thing we're trying to access has been deleted. **/
	var ItemDeleted = 86;
	/** Login attempt failed; try to throttle response to possible attacker. **/
	var AccountLoginDeniedThrottle = 87;
	/** Two factor code mismatch. **/
	var TwoFactorCodeMismatch = 88;
	/** Activation code for two-factor didn't match. **/
	var TwoFactorActivationCodeMismatch = 89;
	/** Account has been associated with multiple partners. **/
	var AccountAssociatedToMultiplePartners = 90;
	/** Data not modified. **/
	var NotModified = 91;
	/** The account does not have a mobile device associated with it. **/
	var NoMobileDevice = 92;
	/** The time presented is out of range or tolerance. **/
	var TimeNotSynced = 93;
	/** SMS code failure (no match; none pending; etc.) **/
	var SmsCodeFailed = 94;
	/** Too many accounts access this resource. **/
	var AccountLimitExceeded = 95;
	/** Too many changes to this account. **/
	var AccountActivityLimitExceeded = 96;
	/** Too many changes to this phone. **/
	var PhoneActivityLimitExceeded = 97;
	/** Cannot refund to payment method; must use wallet. **/
	var RefundToWallet = 98;
	/** Cannot send an email. **/
	var EmailSendFailure = 99;
	/** Can't perform operation till payment has settled. **/
	var NotSettled = 100;
	/** Needs to provide a valid captcha. **/
	var NeedCaptcha = 101;
	/** A game server login token owned by this token's owner has been banned. **/
	var GSLTDenied = 102;
	/** Game server owner is denied for other reason (account lock; community ban; vac ban; missing phone) **/
	var GSOwnerDenied = 103;
	/** The type of thing we were requested to act on is invalid. **/
	var InvalidItemType = 104;
	/** The ip address has been banned from taking this action. **/
	var IPBanned = 105;
	/** This token has expired from disuse; can be reset for use. **/
	var GSLTExpired = 106;

}

/**
	The visibility of a Workshop item (Steamworks `ERemoteStoragePublishedFileVisibility`).
**/
enum abstract EItemVisibility(Int) from Int to Int {
	/**
		Visible to everyone.
	**/
	var Public      = 0;
	/**
		Visible to the friends of the owner.
	**/
	var FriendsOnly = 1;
	/**
		Visible to the owner only.
	**/
	var Private     = 2;
}


/**
	The list of items of a user, for a Workshop query (Steamworks `EUserUGCList`).
**/
enum abstract EUserList(Int) from Int to Int {
	/**
		The items published by the user.
	**/
	var Published:Int		= 0;
	/**
		The items the user voted on.
	**/
	var VotedOn:Int			= 1;
	/**
		The items the user voted up.
	**/
	var VotedUp:Int			= 2;
	/**
		The items the user voted down.
	**/
	var VotedDown:Int		= 3;
	/**
		Deprecated.
	**/
	var WillVoteLater:Int	= 4;
	/**
		The favorites of the user.
	**/
	var Favorited:Int		= 5;
	/**
		The items the user subscribed to.
	**/
	var Subscribed:Int		= 6;
	/**
		The items the user used or played.
	**/
	var UsedOrPlayed:Int	= 7;
	/**
		The items the user follows.
	**/
	var Followed:Int		= 8;
}

/**
	The order of the items of a user list query (Steamworks `EUserUGCListSortOrder`).
**/
enum abstract EUserListSortOrder(Int) from Int to Int {
	/**
		By decreasing creation date.
	**/
	var CreationOrderDesc:Int		= 0;
	/**
		By increasing creation date.
	**/
	var CreationOrderAsc:Int		= 1;
	/**
		By title.
	**/
	var TitleAsc:Int				= 2;
	/**
		By decreasing update date.
	**/
	var LastUpdatedDesc:Int			= 3;
	/**
		By decreasing subscription date.
	**/
	var SubscriptionDateDesc:Int	= 4;
	/**
		By decreasing vote score.
	**/
	var VoteScoreDesc:Int			= 5;
	/**
		For moderation.
	**/
	var ForModeration:Int			= 6;
}
