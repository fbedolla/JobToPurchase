namespace JobToPurchase.JobToPurchase;

using Microsoft.Inventory.Ledger;

pageextension 67258 JobToPurchILEExt extends "Item Ledger Entries"
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
