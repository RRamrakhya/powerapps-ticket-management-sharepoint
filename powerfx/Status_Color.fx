// Status indicator bar Fill (single source of truth: put these in a Named Formula in App.Formulas)
Switch(ThisItem.Status.Value,
  "New",         RGBA(0, 120, 212, 1),
  "In Progress", RGBA(255, 191, 0, 1),
  "Closed",      RGBA(54, 176, 75, 1),
  "On Hold",     RGBA(209, 52, 56, 1),
  RGBA(150, 150, 150, 1))
// Accessibility: also show the status text/icon: do not rely on colour alone.
