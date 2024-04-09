namespace JobToPurchase.JobToPurchase;

using Microsoft.Purchases.Document;
using Microsoft.Projects.Project.Job;

tableextension 67254 JobToPurchHdrExt extends "Purchase Header"
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
