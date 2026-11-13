// Main gallery Items: filter at the SOURCE with delegable predicates (SharePoint delegates =, <>, <, >, StartsWith, And/Or on indexed columns).
// Nav selection stored in varNav: "All" | "New" | "In Progress" | "On Hold" | "Closed" | "Stale" | "Today"
Sort(
  Filter(
    TBL_Tickets,
    (varNav = "All" Or varNav = "Stale" Or varNav = "Today" Or Status.Value = varNav),
    // stale = open tickets created 3+ days ago. Delegable date comparison (NOT DateDiff, which is not delegable to SharePoint):
    (varNav <> "Stale" Or (Created <= DateAdd(Today(), -3, TimeUnit.Days) And Status.Value <> "Closed")),
    (varNav <> "Today" Or Created >= Today()),
    IsBlank(ddDept.Selected.Value) Or Department.Value = ddDept.Selected.Value
  ),
  Created, SortOrder.Descending
)
