namespace JobToPurchase.JobToPurchase;

using Microsoft.Assembly.Document;

pageextension 67263 JobToPurchAssyhdrlist extends "Assembly Orders"
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
