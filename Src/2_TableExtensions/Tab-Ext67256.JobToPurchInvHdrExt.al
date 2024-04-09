namespace JobToPurchase.JobToPurchase;

using Microsoft.Purchases.History;
using Microsoft.Projects.Project.Job;

tableextension 67256 JobToPurchInvHdrExt extends "Purch. Inv. Header"
{
    fields
    {
        field(67250; "Created from Project"; Boolean)
        {
            Caption = 'Created from Project';
            DataClassification = CustomerContent;
        }
        field(67251; "Project No"; Code[20])
        {
            Caption = 'Project No';
            DataClassification = CustomerContent;
            TableRelation = Job;
        }
    }
}
