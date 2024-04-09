namespace JobToPurchase.JobToPurchase;

using Microsoft.Assembly.Document;

pageextension 67261 JobToPurchAssyHdr extends "Assembly Order"
{
    layout
    {
        addlast(Control2)
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
