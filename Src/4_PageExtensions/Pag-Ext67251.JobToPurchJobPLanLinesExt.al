namespace fbedolla.JobToPurchase;
using Microsoft.Projects.Project.Planning;

pageextension 67251 JobToPurchJobPLanLinesExt extends "Job Planning Lines"
{
    layout
    {
        addbefore(Quantity)
        {
            field(VendorNo; Rec.VendorNo)
            {
                ApplicationArea = All;
            }
            field(CreatePurch; Rec.CreatePurchOrd)
            {
                ApplicationArea = All;
            }
            field(CreateAssyOrd; Rec.CreateAssyOrd)
            {
                ApplicationArea = All;
                Visible = AssyVisible;
            }
            field(CreateProdOrd; Rec.CreateProdOrd)
            {
                ApplicationArea = All;
                Visible = ProdVisible;
            }
            field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
            {
                ApplicationArea = All;
            }
        }
        addlast(Control1)
        {
            field(PurchOrderNo; Rec.PurchOrderNo)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(PurchOrderLineNo; Rec.PurchOrderLineNo)
            {
                ApplicationArea = All;
            }
            field(PurchRecNo; Rec.PurchRecNo)
            {
                ApplicationArea = All;
            }
            field(PurchRecLineNo; Rec.PurchRecLineNo)
            {
                ApplicationArea = All;
            }
            field(PurchInvNo; Rec.PurchInvNo)
            {
                ApplicationArea = All;
            }
            field(PurchInvLineNo; Rec.PurchInvLineNo)
            {
                ApplicationArea = All;
            }
        }
        addlast(factboxes)
        {
            part(JobToPurchPurchLineFB; JobToPurchPurchLineFB)
            {
                ApplicationArea = All;
                Caption = 'Related Purchase Lines';
                SubPageLink = "Document No." = field(PurchOrderNo), "No." = field("No."), "Project No." = field("Job No.");
            }
            part(ItemInfo; JobToPurchItemData)
            {
                ApplicationArea = All;
                Caption = 'Item Data';
                SubPageLink = "No." = field("No.");
            }
        }
    }
    actions
    {
        addlast("F&unctions")
        {
            action(CreatePurchOrders)
            {
                ApplicationArea = All;
                Caption = 'Create Purchase Orders';
                Image = CreateDocuments;
                trigger OnAction()
                var
                    JobPuchmgmt: Codeunit "JobToPurchase Mgmt";
                begin
                    JobPuchmgmt.CreatePurchOrdersJobPlanLine(Rec."Job No.", Rec."Job Task No.");
                end;
            }
            action(CreateAssyOrders)
            {
                ApplicationArea = All;
                Caption = 'Create Assembly Orders';
                Image = AssemblyOrder;
                Visible = AssyVisible;
                trigger OnAction()
                var
                    JobPuchmgmt: Codeunit "JobToPurchase Mgmt";
                begin
                    JobPuchmgmt.CreateAssyOrdersJobPlanLine(Rec."Job No.", Rec."Job Task No.");
                end;
            }
            action(CreateProdOrders)
            {
                ApplicationArea = All;
                Caption = 'Create Production Orders';
                Image = Production;
                Visible = ProdVisible;
                trigger OnAction()
                var
                    JobPuchmgmt: Codeunit "JobToPurchase Mgmt";
                begin
                    JobPuchmgmt.CreateProdOrdersJobPlanLine(Rec."Job No.", Rec."Job Task No.");
                end;
            }
        }
        addfirst(Category_Process)
        {
            actionref(createPurchOrder; CreatePurchOrders)
            {
            }
            actionref(createAssyOrder; CreateAssyOrders)
            {
            }
            actionref(createProdOrder; CreateProdOrders)
            {
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        EnableControls();
    end;

    protected var
        AssyVisible: Boolean;
        ProdVisible: Boolean;

    procedure EnableControls()
    var
        JobToPurchSetup: Record "JobToPurch Setup";
    begin
        JobToPurchSetup.Get();
        if JobToPurchSetup.UseAssy = true then
            AssyVisible := true
        else
            AssyVisible := false;

        if JobToPurchSetup.UseProd = true then
            ProdVisible := true
        else
            ProdVisible := false
    end;

    local procedure InitControls()
    begin
        AssyVisible := true;
        ProdVisible := true;
    end;
}
