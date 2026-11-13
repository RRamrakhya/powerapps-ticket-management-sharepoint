// Save button. Fixes vs. the original design:
//  1) UPDATE patches the existing record (LookUp), CREATE patches Defaults(): never Defaults() for an update (that inserts a duplicate).
//  2) Closing stamps DateClosed; re-opening clears it.
//  3) Result is checked with IfError; the collection/notification only runs after success.
//  4) Notification is a Power Automate flow triggered by SharePoint (see alm/FLOW_NOTIFY.md), not client-side email.
With(
  { rec: If(IsBlank(varSelected), Defaults(TBL_Tickets), LookUp(TBL_Tickets, ID = varSelected.ID)) },
  IfError(
    Set(varSaved, Patch(TBL_Tickets, rec, {
      Title: If(IsBlank(varSelected), "New ticket", rec.Title),   // required SharePoint field: replaced with TKT-<ID> by the flow
      Department: ddDept.Selected,
      Status: ddStatus.Selected,
      Priority: ddPriority.Selected,
      AssignedTo: txtAssigned.Text,
      Subject: txtSubject.Text,
      Description: txtDesc.Text,
      Comment: txtComment.Text,
      Owner: If(IsBlank(varSelected), varUser, rec.Owner),
      DateClosed: If(ddStatus.Selected.Value = "Closed", Now(), Blank())
    })),
    Notify("Could not save the ticket: " & FirstError.Message, NotificationType.Error),
    Notify("Ticket saved", NotificationType.Success); Reset(frmTicket); Set(varSelected, Blank())
  )
)
