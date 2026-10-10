# hlsteam — carte des dépendances

> Généré par `tools/docgen/deps.py` (analyse statique, sans compilateur Haxe). Ne pas éditer à la main.

- Modules (fichiers `.hx`) : **22** — lignes : **6494** — packages : **4**
- Dépendances module→module : **46**
- Cycles de modules (SCC > 1) : **2**

Légende des types d'arêtes : `import`, `using`, `extends`, `implements`, `use` (référence dans le code).

## Packages

| Package | Modules | Lignes | Blocs doc `/** */` | Dépend de (packages) | Utilisé par |
|---|---:|---:|---:|---|---|
| [`steam`](modules/steam.md) | 13 | 4349 | 519 | steam.helpers | 1 |
| [`steam.data`](modules/steam.data.md) | 3 | 799 | 71 | — | 0 |
| [`steam.helpers`](modules/steam.helpers.md) | 2 | 96 | 6 | — | 1 |
| [`steam.ugc`](modules/steam.ugc.md) | 4 | 1250 | 269 | steam | 0 |

## Graphe des packages (niveau 2)

```mermaid
flowchart LR
  steam[steam] -->|2| steam_helpers[steam.helpers]
  steam_ugc[steam.ugc] -->|11| steam[steam]
```

## Cycles entre packages

Aucun.

## Ordre de documentation suggéré

Ordre topologique (les dépendances d'abord). Les modules entre crochets forment un cycle et doivent être documentés ensemble.

1. [`steam.helpers.MacroHelper`](modules/steam.helpers.md#steamhelpersmacrohelper)
2. [`steam.UID`](modules/steam.md#steamuid)
3. [`steam.helpers.Util`](modules/steam.helpers.md#steamhelpersutil)
4. [[`steam.Api`](modules/steam.md#steamapi), [`steam.Controller`](modules/steam.md#steamcontroller), [`steam.GameServer`](modules/steam.md#steamgameserver), [`steam.User`](modules/steam.md#steamuser)]
5. [`steam.AsyncCall`](modules/steam.md#steamasynccall)
6. [`steam.Callback`](modules/steam.md#steamcallback)
7. [`steam.Cloud`](modules/steam.md#steamcloud)
8. [`steam.Friends`](modules/steam.md#steamfriends)
9. [[`steam.Lobby`](modules/steam.md#steamlobby), [`steam.Matchmaking`](modules/steam.md#steammatchmaking)]
10. [`steam.Networking`](modules/steam.md#steamnetworking)
11. [`steam.Timeline`](modules/steam.md#steamtimeline)
12. [`steam.data.Locale`](modules/steam.data.md#steamdatalocale)
13. [`steam.data.VDF`](modules/steam.data.md#steamdatavdf)
14. [`steam.data.ControllerConfig`](modules/steam.data.md#steamdatacontrollerconfig)
15. [`steam.ugc.Data`](modules/steam.ugc.md#steamugcdata)
16. [`steam.ugc.Item`](modules/steam.ugc.md#steamugcitem)
17. [`steam.ugc.ItemUpdate`](modules/steam.ugc.md#steamugcitemupdate)
18. [`steam.ugc.Query`](modules/steam.ugc.md#steamugcquery)

## Modules les plus centraux (les plus utilisés)

| Module | Utilisé par | Dépend de | Lignes |
|---|---:|---:|---:|
| [`steam.UID`](modules/steam.md#steamuid) | 11 | 0 | 47 |
| [`steam.Api`](modules/steam.md#steamapi) | 6 | 4 | 766 |
| [`steam.AsyncCall`](modules/steam.md#steamasynccall) | 6 | 0 | 25 |
| [`steam.Callback`](modules/steam.md#steamcallback) | 6 | 0 | 8 |
| [`steam.User`](modules/steam.md#steamuser) | 6 | 2 | 202 |
| [`steam.ugc.Data`](modules/steam.ugc.md#steamugcdata) | 2 | 0 | 511 |
| [`steam.Controller`](modules/steam.md#steamcontroller) | 1 | 2 | 1665 |
| [`steam.GameServer`](modules/steam.md#steamgameserver) | 1 | 2 | 199 |
| [`steam.Lobby`](modules/steam.md#steamlobby) | 1 | 5 | 347 |
| [`steam.Matchmaking`](modules/steam.md#steammatchmaking) | 1 | 6 | 277 |
| [`steam.helpers.MacroHelper`](modules/steam.helpers.md#steamhelpersmacrohelper) | 1 | 0 | 61 |
| [`steam.helpers.Util`](modules/steam.helpers.md#steamhelpersutil) | 1 | 0 | 35 |
| [`steam.data.Locale`](modules/steam.data.md#steamdatalocale) | 1 | 0 | 161 |
| [`steam.data.VDF`](modules/steam.data.md#steamdatavdf) | 1 | 0 | 238 |
| [`steam.ugc.Item`](modules/steam.ugc.md#steamugcitem) | 1 | 4 | 251 |
| [`steam.Cloud`](modules/steam.md#steamcloud) | 0 | 4 | 119 |
| [`steam.Friends`](modules/steam.md#steamfriends) | 0 | 2 | 213 |
| [`steam.Networking`](modules/steam.md#steamnetworking) | 0 | 3 | 339 |
| [`steam.Timeline`](modules/steam.md#steamtimeline) | 0 | 0 | 142 |
| [`steam.data.ControllerConfig`](modules/steam.data.md#steamdatacontrollerconfig) | 0 | 2 | 400 |
| [`steam.ugc.ItemUpdate`](modules/steam.ugc.md#steamugcitemupdate) | 0 | 4 | 120 |
| [`steam.ugc.Query`](modules/steam.ugc.md#steamugcquery) | 0 | 6 | 368 |
