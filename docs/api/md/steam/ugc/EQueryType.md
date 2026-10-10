# steam.ugc.EQueryType

**enum abstract** · package [`steam.ugc`](README.md) · module `steam.ugc.Data` · source [`steam/ugc/Data.hx`](../../../../../steam/ugc/Data.hx)

How the items of a Workshop query of all the items are ranked (Steamworks `EUGCQuery`).

Underlying type: `Int`

Implicit casts from: `Int`

Implicit casts to: `Int`

## Values

| Name | Value | Description |
|---|---|---|
| `RankedByVote` | `0` | By votes. |
| `RankedByPublicationDate` | `1` | By publication date. |
| `AcceptedForGameRankedByAcceptanceDate` | `2` | The items accepted for the game, by acceptance date. |
| `RankedByTrend` | `3` | By trend. |
| `FavoritedByFriendsRankedByPublicationDate` | `4` | The favorites of the user's friends, by publication date. |
| `CreatedByFriendsRankedByPublicationDate` | `5` | The items created by the user's friends, by publication date. |
| `RankedByNumTimesReported` | `6` | By number of reports. |
| `CreatedByFollowedUsersRankedByPublicationDate` | `7` | The items created by the users followed by the user, by publication date. |
| `NotYetRated` | `8` | The items not rated yet. |
| `RankedByTotalVotesAsc` | `9` | By increasing total number of votes. |
| `RankedByVotesUp` | `10` | By number of up votes. |
| `RankedByTextSearch` | `11` | By relevance to the search text (see `Query.setSearchText`). |
| `RankedByTotalUniqueSubscriptions` | `12` | By number of unique subscriptions. |
| `RankedByPlaytimeTrend` | `13` | By play time trend. |
| `RankedByTotalPlaytime` | `14` | By total play time. |
| `RankedByAveragePlaytimeTrend` | `15` | By average play time trend. |
| `RankedByLifetimeAveragePlaytime` | `16` | By lifetime average play time. |
| `RankedByPlaytimeSessionsTrend` | `17` | By play sessions trend. |
| `RankedByLifetimePlaytimeSessions` | `18` | By lifetime number of play sessions. |
