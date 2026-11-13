// App.OnStart: keep it light. Do NOT cache the whole list.
Set(varUser, User().Email);
Set(varIsManager, !IsEmpty(Filter(Office365Groups.ListGroupMembers(envManagerGroupId).value, mail = User().Email)))
// envManagerGroupId is a solution environment variable (see alm/ALM.md), so no ID is hardcoded.
// Prefer Entra security groups + a role lookup over hardcoded emails.
