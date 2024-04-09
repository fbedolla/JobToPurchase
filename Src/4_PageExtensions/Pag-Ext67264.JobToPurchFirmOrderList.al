namespace JobToPurchase.JobToPurchase;

using Microsoft.Manufacturing.Document;

pageextension 67264 JobToPurchFirmOrderList extends "Firm Planned Prod. Orders"
{
    layout
    {
        addlast(Control1)
        {
            field("Created from Project"; Rec."Created from Project")
            {
                ApplicationArea = All;

            }
        }
    }
}
