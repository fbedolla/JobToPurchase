namespace JobToPurchase.JobToPurchase;

using Microsoft.Manufacturing.Document;

pageextension 67262 JobToPurchFirmProdHdr extends "Firm Planned Prod. Order"
{
    layout
    {
        addlast(General)
        {
            field("Created from Project"; Rec."Created from Project")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Project No"; Rec."Project No")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Project Task No"; Rec."Project Task No")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Project Plan Line No"; Rec."Project Plan Line No")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
