namespace JobToPurchase.JobToPurchase;

using Microsoft.Purchases.History;
using Microsoft.Projects.Project.Job;
using Microsoft.Projects.Project.Planning;


tableextension 67252 JobToPurchPurchRecLineExt extends "Purch. Rcpt. Line"
{
    fields
    {
        field(67250; "Project No."; Code[20])
        {
            Caption = 'Project No.';
            DataClassification = CustomerContent;
            TableRelation = Job where(Status = const(Open));
        }
        field(67251; "Project Task No."; Code[20])
        {
            Caption = 'Project Task No.';
            DataClassification = CustomerContent;
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Project No."));
        }
        field(67252; "Project Plan. Line No."; Integer)
        {
            Caption = 'Project Plan. Line No.';
            DataClassification = CustomerContent;
            TableRelation = "Job Planning Line"."Line No." where("Job No." = field("Project No."), "Job Task No." = field("Project Task No."));
        }
        field(67253; "Created From Project"; Boolean)
        {
            Caption = 'Created From Project';
            DataClassification = CustomerContent;
        }
    }
}
