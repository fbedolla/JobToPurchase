namespace JobToPurchase.JobToPurchase;

using Microsoft.Projects.RoleCenters;
using fbedolla.JobToPurchase;

pageextension 67256 ProjectsRCExt extends "Job Project Manager RC"
{
    actions
    {
        addlast("Sales & Purchases")
        {
            action(ProjectPurchLines)
            {
                ApplicationArea = Jobs;
                Caption = 'Project Purchase Lines';
                Image = Purchase;
                RunObject = page JobToPurchProjPurchLines;
            }
        }
        addafter("Posted Documents")
        {
            group(JobToPurch)
            {
                Caption = 'Job To Purchase';
                action(JobToPurchSetup)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Job To Purchase Setup';
                    Image = Purchase;
                    RunObject = page "JobToPurch Setup";
                }
            }
        }
    }
}
