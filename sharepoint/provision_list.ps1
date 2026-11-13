# PnP.PowerShell. Run in a Developer tenant first. Not executed by the author.  Install-Module PnP.PowerShell
param([Parameter(Mandatory)] [string]$SiteUrl)
Connect-PnPOnline -Url $SiteUrl -Interactive
New-PnPList -Title "TBL_Tickets" -Template GenericList -EnableVersioning     # version history = audit trail
Add-PnPField -List "TBL_Tickets" -DisplayName "IndexID" -InternalName "IndexID" -Type Number -AddToDefaultView
Add-PnPField -List "TBL_Tickets" -DisplayName "Department" -InternalName "Department" -Type Choice -Choices "IT","HR","Facilities","Management" -AddToDefaultView
Add-PnPField -List "TBL_Tickets" -DisplayName "AssignedTo" -InternalName "AssignedTo" -Type Text
Add-PnPField -List "TBL_Tickets" -DisplayName "Subject" -InternalName "Subject" -Type Note
Add-PnPField -List "TBL_Tickets" -DisplayName "Description" -InternalName "Description" -Type Note
Add-PnPField -List "TBL_Tickets" -DisplayName "Comment" -InternalName "Comment" -Type Note
Add-PnPField -List "TBL_Tickets" -DisplayName "Status" -InternalName "Status" -Type Choice -Choices "New","In Progress","On Hold","Closed" -AddToDefaultView
Add-PnPField -List "TBL_Tickets" -DisplayName "Priority" -InternalName "Priority" -Type Choice -Choices "Low","Medium","High"
Add-PnPField -List "TBL_Tickets" -DisplayName "Owner" -InternalName "Owner" -Type Text
Add-PnPField -List "TBL_Tickets" -DisplayName "DateClosed" -InternalName "DateClosed" -Type DateTime
# Index columns that the app filters on (avoids list-view threshold problems at scale):
Set-PnPField -List "TBL_Tickets" -Identity "Status" -Values @{Indexed=$true}
Set-PnPField -List "TBL_Tickets" -Identity "Department" -Values @{Indexed=$true}
# Use the built-in Created column for creation time (system-set, tamper-proof) instead of a manual DateCreated field.
