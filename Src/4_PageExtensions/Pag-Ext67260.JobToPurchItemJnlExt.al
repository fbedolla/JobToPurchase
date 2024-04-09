namespace JobToPurchase.JobToPurchase;

using Microsoft.Inventory.Journal;

pageextension 67260 JobToPurchItemJnlExt extends "Item Journal"
{
    layout
    {
        addlast(Control1)
        {
            field("Project No"; Rec."Project No")
            {
                ApplicationArea = All;
            }
            field("Project Task No"; Rec."Project Task No")
            {
                ApplicationArea = All;
            }
            field("Project Plan Line No"; Rec."Project Plan Line No")
            {
                ApplicationArea = All;
            }
        }
    }
}
