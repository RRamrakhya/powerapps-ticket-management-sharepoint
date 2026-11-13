# ALM
- Create a **solution** containing the app, flow, connection references, environment variables (SiteUrl, ListName).
- Environments: Dev → Test → Prod (a Microsoft 365 Developer Program tenant provides a sandbox).
- Export/unpack for Git: `pac solution export` / `pac solution unpack`; deploy via pipelines in Power Platform or GitHub Actions.
- Test: Power Apps **Test Studio** recorded cases (create, update, close, filter) and/or **Test Engine**; add a performance test with the scaled seed data.
