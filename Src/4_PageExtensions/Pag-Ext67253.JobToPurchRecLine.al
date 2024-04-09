namespace JobToPurchase.JobToPurchase;

using Microsoft.Purchases.History;

pageextension 67253 JobToPurchRecLine extends "Posted Purchase Rcpt. Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("Project No."; Rec."Project No.")
            {
                ApplicationArea = All;
            }
            field("Project Task No."; Rec."Project Task No.")
            {
                ApplicationArea = All;
            }
            field("Project Plan. Line No."; Rec."Project Plan. Line No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
