namespace JobToPurchase.JobToPurchase;

using Microsoft.Projects.RoleCenters;
using Microsoft.Purchases.Document;
using Microsoft.Purchases.History;
using Microsoft.Assembly.Document;
using Microsoft.Assembly.History;
using Microsoft.Manufacturing.Document;

pageextension 67257 JobToPurchCueExt extends "Project Manager Activities"
{
    layout
    {
        addafter(Invoicing)
        {
            cuegroup(Purchases)
            {
                Caption = 'Purchases';
                field("PurchOrd Open"; Rec."PurchOrd Open")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Purchase Orders - Open';
                    DrillDownPageID = "Purchase Order List";
                    Editable = false;
                    ToolTip = 'Specifies the number of Job related Purchase Orders.';
                }
                field("PurchOrd Released"; rec."PurchOrd Released")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Purchase Orders - Released';
                    DrillDownPageID = "Purchase Order List";
                    Editable = false;
                    ToolTip = 'Specifies the number of Job related Released Purchase Orders.';
                }
                field("PurchOrd PartRec"; rec."PurchOrd PartRec")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Purchase Orders - Part. Rcvd.';
                    DrillDownPageID = "Purchase Order List";
                    Editable = false;
                    ToolTip = 'Specifies the number of Job related Partially Received Purchase Orders.';
                }
                field(PurcRec; Rec.PurcRec)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Purchase Receipts';
                    DrillDownPageID = "Posted Purchase Receipts";
                    Editable = false;
                    ToolTip = 'Specifies the number of Job related Purchase Receptions.';
                }
                field(PurchInv; Rec.PurchInv)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Posted Purchase Invoices';
                    DrillDownPageID = "Purchase Invoices";
                    Editable = false;
                    ToolTip = 'Specifies the number of Job related Posted Purchase Invoices.';
                }
            }
            cuegroup(Assembly)
            {
                field(AssyOrd; Rec.AssyOrd)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Assembly Orders';
                    DrillDownPageID = "Assembly Orders";
                    Editable = false;
                    ToolTip = 'Specifies the number of Job related Assembly Orders.';
                }
                field(PostAssyOrd; Rec.PostAssyOrd)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Posted Assembly Orders';
                    DrillDownPageID = "Posted Assembly Orders";
                    Editable = false;
                    ToolTip = 'Specifies the number of Job related Posted Assembly Orders.';
                }
            }
            cuegroup(Production)
            {
                field(FPlanProdOrd; Rec.FPlanProdOrd)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Firm Planned Production Orders';
                    DrillDownPageID = "Firm Planned Prod. Orders";
                    Editable = false;
                    ToolTip = 'Specifies the number of Job related Firm Planned Production Orders.';
                }
                field(RelProdOrd; Rec.RelProdOrd)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Released Production Orders';
                    DrillDownPageID = "Released Production Orders";
                    Editable = false;
                    ToolTip = 'Specifies the number of Job related Released Production Orders.';
                }
                field(FinProdOrd; Rec.FinProdOrd)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Finished Production Orders';
                    DrillDownPageID = "Finished Production Orders";
                    Editable = false;
                    ToolTip = 'Specifies the number of Job related Finished Production Orders.';
                }
            }
        }
    }
}
