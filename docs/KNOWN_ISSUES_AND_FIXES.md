# Common pitfalls in Power Apps + SharePoint solutions, and how this design avoids them

| # | Common approach | Problem | Approach used here |
|---|---|---|---|
| 1 | `Patch(TBL_Tickets, Defaults(TBL_Tickets), …)` used for **updates** too | Inserts a new row every save (duplicates) | Patch `LookUp(TBL_Tickets, ID = varSelected.ID)` for updates; `Defaults()` only for create |
| 2 | `ClearCollect(COL_Tickets, TBL_Tickets)` on every update | Non-delegable full copy: capped at the data-row limit (default 500, max 2000), slow, stale for other users | Filter/sort against the data source with delegable formulas; collections only for small lookups |
| 3 | `Filter(COL_Tickets, Absolute(DateDiff(Now(), 'Date Created')) >= 3)` | `DateDiff` isn't delegable to SharePoint; also counts closed tickets | `Created <= DateAdd(Today(), -3, TimeUnit.Days) And Status <> "Closed"` |
| 4 | Custom `First(Sort(…IndexID…)).IndexID + 1` | Race condition: two simultaneous creates get the same ID | Use SharePoint's `ID` (display as `TKT-` & ID) or assign in a Power Automate flow; keep IndexID only if the business mandates it |
| 5 | Manual `Date Created = Now()` | Client clock and user-editable | Use the system `Created` column |
| 6 | `Office365Outlook.SendEmailV2` from the app | Runs as the user, fails silently offline, ties logic to the client | Power Automate flow on item created/modified (service identity, retries, run history) |
| 7 | Mandatory `Title` placeholder ("New Record") | Meaningless titles | Flow sets Title = `TKT-` & ID after create |
| 8 | Hardcoded colours in several controls | Inconsistent | Named formulas for colours; text/icon alongside colour (accessibility) |
| 9 | No role model | Everyone sees/edits everything | Entra groups: requester (own tickets), agent (department), manager (all); filter + SharePoint item-level permissions as needed |
| 10 | No ALM | Edits in prod | Solution + environments (Dev/Test/Prod), environment variables for site URL/list name, source-controlled with `pac solution unpack` |
