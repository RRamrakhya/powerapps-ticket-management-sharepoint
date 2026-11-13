# Power Automate flow: "Ticket updated notification"
Trigger: SharePoint *When an item is created or modified* (trigger condition to avoid loops: `@not(equals(triggerOutputs()?['body/Editor/Email'], 'flow-service-account@contoso.com'))`).
1. If created: Update item → `Title = concat('TKT-', ID)`.
2. If Status changed (compare with *Get changes for an item*): Send email (V2) to Owner/AssignedTo: subject `Ticket [TKT-<ID>] has been updated`, HTML body with `<b>` priority/status.
3. Configure run-after for failure → notify the app owner. Use a shared mailbox as sender.
