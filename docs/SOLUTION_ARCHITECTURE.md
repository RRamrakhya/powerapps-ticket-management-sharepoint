# Solution architecture
Canvas app (container-based responsive UI) → SharePoint Online list `TBL_Tickets` → Power Automate (notification + Title/ID stamping) → Office 365 Outlook.
**Schema:** Title (required), IndexID (optional), Department (Choice), AssignedTo, Subject, Description, Comment, Status (Choice), Priority (Choice), Owner, DateClosed; system: ID, Created, Modified, Created By.
**Lifecycle:** New → In Progress ⇄ On Hold → Closed (DateClosed stamped on close; cleared on reopen).
**Views:** cards (counts by status), filter sidebar (department, status), gallery (status colour bar), details form.
**Delegation rule:** every gallery filter must be delegable; verify there is no blue-underline warning; test with > 2000 seed rows (scale the generator).
**Security:** least privilege via Entra groups; Power Platform DLP policy; connection references in the solution.
