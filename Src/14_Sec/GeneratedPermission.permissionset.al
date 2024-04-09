namespace fbedolla.JobToPurchase;
using JobToPurchase.JobToPurchase;
permissionset 67250 GenPermJotPurch
{
    Permissions = tabledata "JobToPurch Setup" = RIMD,
        tabledata JobToPurchVendors = RIMD,
        table "JobToPurch Setup" = X,
        table JobToPurchVendors = X,
        codeunit "JobToPurchase Mgmt" = X,
        page "JobToPurch Setup" = X,
        page JobToPurchItemData = X,
        page JobToPurchProjPurchLines = X,
        page JobToPurchPurchLineFB = X;
}