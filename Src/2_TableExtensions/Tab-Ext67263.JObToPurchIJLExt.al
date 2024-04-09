namespace JobToPurchase.JobToPurchase;

using Microsoft.Inventory.Journal;
using Microsoft.Projects.Project.Job;
using Microsoft.Projects.Project.Planning;

tableextension 67263 JObToPurchIJLExt extends "Item Journal Line"
{
    fields
    {
        field(67251; "Project No"; Code[20])
        {
            Caption = 'Project No';
            DataClassification = CustomerContent;
            TableRelation = Job;
        }
        field(67252; "Project Task No"; Code[20])
        {
            Caption = 'Project Task No';
            DataClassification = CustomerContent;
            TableRelation = "Job Task" where("Job No." = field("Project No"));
        }
        field(67253; "Project Plan Line No"; Integer)
        {
            Caption = 'Project Plan Line No';
            DataClassification = CustomerContent;
            TableRelation = "Job Planning Line" where("Job No." = field("Project No"), "Job Task No." = field("Project Task No"));
        }
    }
}
