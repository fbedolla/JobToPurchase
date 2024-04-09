namespace fbedolla.JobToPurchase;
using Microsoft.Projects.Project.Planning;
using Microsoft.Purchases.Document;
using Microsoft.Projects.Project.Job;
using Microsoft.Manufacturing.Document;
using Microsoft.Assembly.Document;
using Microsoft.Inventory.Item;

codeunit 67250 "JobToPurchase Mgmt"
{
    var
        PurchRes: Boolean;

    procedure CreatePurchOrdersJobPlanLine(JobNo: Code[20]; JobTask: Code[20])
    var
        VendFilt: Record JobToPurchVendors temporary;
        JobPlanLines: Record "Job Planning Line";
        DocNo: Code[20];
    begin
        VendFilt.Reset();
        JobPlanLines.Reset();
        JobPlanLines.SetRange("Job No.", JobNo);
        JobPlanLines.SetRange("Job Task No.", JobTask);
        JobPlanLines.SetRange(CreatePurchOrd, true);
        JobPlanLines.SetRange(PurchOrderNo, '');
        JobPlanLines.SetCurrentKey(VendorNo);
        if JobPlanLines.FindSet() then
            repeat
                VendFilt.SetRange("Vendor No", JobPlanLines.VendorNo);
                if not VendFilt.FindLast() then begin
                    VendFilt."Vendor No" := JobPlanLines.VendorNo;
                    VendFilt.Insert();
                end;
            until JobPlanLines.Next() = 0;

        VendFilt.Reset();
        if VendFilt.FindSet() then
            repeat
                DocNo := CreatePurchHeader(VendFilt."Vendor No", JobNo);
                CreatePurchLinesJobplan(VendFilt."Vendor No", JobNo, JobTask, DocNo)
            until VendFilt.Next() = 0;
    end;

    local procedure CreatePurchHeader(VendorNo: Code[20]; JobNo: Code[20]): Code[20]
    var
        PurchHdr: Record "Purchase Header";
        Jobs: Record Job;
        JobDim1: Code[20];
        JobDim2: Code[20];
    begin
        Jobs.Reset();
        Jobs.SetRange("No.", JobNo);
        if Jobs.FindFirst() then begin
            JobDim1 := Jobs."Global Dimension 1 Code";
            JobDim2 := Jobs."Global Dimension 2 Code";
        end;

        PurchHdr.Reset();
        PurchHdr."Document Type" := PurchHdr."Document Type"::Order;
        PurchHdr.Validate("Buy-from Vendor No.", VendorNo);
        PurchHdr.Validate("Order Date", WorkDate());
        PurchHdr.Validate("Shortcut Dimension 1 Code", JobDim1);
        PurchHdr.Validate("Shortcut Dimension 2 Code", JobDim2);
        PurchHdr."Created from Project" := true;
        PurchHdr."Project No" := JobNo;
        PurchHdr.Insert(true);
        exit(PurchHdr."No.");
    end;

    local procedure CreatePurchLinesJobplan(VendNo: Code[20]; JobNo: Code[20]; JobTask: Code[20]; PurchNo: Code[20])
    var
        JobPlanLines: Record "Job Planning Line";
        PurchLine: Record "Purchase Line";

    begin
        JobPlanLines.Reset();
        JobPlanLines.SetRange("Job No.", JobNo);
        JobPlanLines.SetRange("Job Task No.", JobTask);
        JobPlanLines.SetRange(VendorNo, VendNo);
        if JobPlanLines.FindSet() then
            repeat
                PurchLine.Reset();
                PurchLine.Init();
                PurchLine."Document Type" := PurchLine."Document Type"::Order;
                PurchLine."Document No." := PurchNo;
                PurchLine."Line No." += 10000;
                case
                    JobPlanLines.Type of
                    JobPlanLines.Type::"G/L Account":
                        begin
                            PurchLine.Type := PurchLine.Type::"G/L Account";
                            PurchLine.Validate("No.", JobPlanLines."No.");
                            PurchLine.Description := JobPlanLines.Description;
                            PurchLine.Validate(Quantity, JobPlanLines.Quantity);
                            PurchLine.Validate("Direct Unit Cost", JobPlanLines."Unit Cost");
                            PurchLine.Validate("Shortcut Dimension 1 Code", JobPlanLines."Shortcut Dimension 1 Code");
                            PurchLine.Validate("Shortcut Dimension 2 Code", JobPlanLines."Shortcut Dimension 2 Code");
                            PurchLine.Validate("Job No.", JobPlanLines."Job No.");
                            PurchLine.Validate("Job Task No.", JobPlanLines."Job Task No.");
                            PurchLine."Job Planning Line No." := JobPlanLines."Line No.";
                            PurchLine."Project No." := JobPlanLines."Job No.";
                            PurchLine."Project Task No." := JobPlanLines."Job Task No.";
                            PurchLine."Project Plan. Line No." := JobPlanLines."Line No.";
                            PurchLine."Created From Project" := true;
                            PurchLine.Insert(true);
                            MarkJobPlanLine(JobPlanLines."Job No.", JobPlanLines."Job Task No.", JobPlanLines."Line No.", PurchNo, PurchLine."Line No.");
                        end;
                    JobPlanLines.Type::Item:
                        begin
                            PurchLine.Type := PurchLine.Type::Item;
                            PurchLine.Validate("No.", JobPlanLines."No.");
                            PurchLine.Validate(Quantity, JobPlanLines.Quantity);
                            PurchLine.Validate("Location Code", JobPlanLines."Location Code");
                            PurchLine.Validate("Direct Unit Cost", JobPlanLines."Unit Cost");
                            PurchLine.Validate("Shortcut Dimension 1 Code", JobPlanLines."Shortcut Dimension 1 Code");
                            PurchLine.Validate("Shortcut Dimension 2 Code", JobPlanLines."Shortcut Dimension 2 Code");
                            PurchLine."Project No." := JobPlanLines."Job No.";
                            PurchLine."Project Task No." := JobPlanLines."Job Task No.";
                            PurchLine."Project Plan. Line No." := JobPlanLines."Line No.";
                            PurchLine."Created From Project" := true;
                            PurchLine.Insert(true);
                            MarkJobPlanLine(JobPlanLines."Job No.", JobPlanLines."Job Task No.", JobPlanLines."Line No.", PurchNo, PurchLine."Line No.");
                        end;
                    JobPlanLines.Type::Text:
                        begin
                            PurchLine.Type := PurchLine.Type::" ";
                            PurchLine.Description := JobPlanLines.Description;
                            PurchLine."Project No." := JobPlanLines."Job No.";
                            PurchLine."Project Task No." := JobPlanLines."Job Task No.";
                            PurchLine."Project Plan. Line No." := JobPlanLines."Line No.";
                            PurchLine."Created From Project" := true;
                            PurchLine.Insert(true);
                            MarkJobPlanLine(JobPlanLines."Job No.", JobPlanLines."Job Task No.", JobPlanLines."Line No.", PurchNo, PurchLine."Line No.");
                        end;
                end;
            until JobPlanLines.Next() = 0;
    end;

    procedure CreateAssyOrdersJobPlanLine(JobNo: Code[20];
        JobTask: Code[20])
    var
        JobPlanLines: Record "Job Planning Line";
        Itm: Record Item;
        AssyOrdHdr: Record "Assembly Header";
        Jobs: Record Job;
        JobDim1: Code[20];
        JobDim2: Code[20];
    begin
        Jobs.Reset();
        Jobs.SetRange("No.", JobNo);
        if Jobs.FindFirst() then begin
            JobDim1 := Jobs."Global Dimension 1 Code";
            JobDim2 := Jobs."Global Dimension 2 Code";
        end;

        JobPlanLines.Reset();
        JobPlanLines.SetRange("Job No.", JobNo);
        JobPlanLines.SetRange("Job Task No.", JobTask);
        JobPlanLines.SetRange(CreateAssyOrd, true);
        JobPlanLines.SetRange(AssyOrderNo, '');
        if JobPlanLines.FindSet() then
            repeat
                Itm.Reset();
                Itm.SetRange("No.", JobPlanLines."No.");
                if Itm."Assembly Policy" = Itm."Assembly Policy"::"Assemble-to-Stock" then begin
                    AssyOrdHdr.Init();
                    AssyOrdHdr."Document Type" := AssyOrdHdr."Document Type"::Order;
                    AssyOrdHdr.Validate("Item No.", JobPlanLines."No.");
                    AssyOrdHdr.Validate("Location Code", JobPlanLines."Location Code");
                    AssyOrdHdr.Validate(Quantity, JobPlanLines.Quantity);
                    AssyOrdHdr."Creation Date" := WorkDate();
                    AssyOrdHdr."Due Date" := JobPlanLines."Planning Date";
                    AssyOrdHdr.Validate("Shortcut Dimension 1 Code", JobPlanLines."Shortcut Dimension 1 Code");
                    AssyOrdHdr.Validate("Shortcut Dimension 2 Code", JobPlanLines."Shortcut Dimension 2 Code");
                    AssyOrdHdr."Created from Project" := true;
                    AssyOrdHdr."Project No" := JobPlanLines."Job No.";
                    AssyOrdHdr."Project Task No" := JobPlanLines."Job Task No.";
                    AssyOrdHdr."Project Plan Line No" := JobPlanLines."Line No.";
                    AssyOrdHdr.Insert(true);
                    MarkAssyJobPlanLine(JobPlanLines."Job No.", JobPlanLines."Job Task No.", JobPlanLines."Line No.", AssyOrdHdr."No.");
                end else
                    ;
            until JobPlanLines.Next() = 0;
    end;

    procedure CreateProdOrdersJobPlanLine(JobNo: Code[20]; JobTask: Code[20])
    var
        JobPlanLines: Record "Job Planning Line";
        Itm: Record Item;
        ProdOrd: Record "Production Order";
        Jobs: Record Job;
        JobDim1: Code[20];
        JobDim2: Code[20];
    begin
        Jobs.Reset();
        Jobs.SetRange("No.", JobNo);
        if Jobs.FindFirst() then begin
            JobDim1 := Jobs."Global Dimension 1 Code";
            JobDim2 := Jobs."Global Dimension 2 Code";
        end;

        JobPlanLines.Reset();
        JobPlanLines.SetRange("Job No.", JobNo);
        JobPlanLines.SetRange("Job Task No.", JobTask);
        JobPlanLines.SetRange(CreateProdOrd, true);
        JobPlanLines.SetRange(ProdOrderNo, '');
        if JobPlanLines.FindSet() then
            repeat
                Itm.Reset();
                Itm.SetRange("No.", JobPlanLines."No.");
                if Itm."Production BOM No." <> '' then begin
                    ProdOrd.Init();
                    ProdOrd.Status := ProdOrd.Status::"Firm Planned";
                    ProdOrd.Description := JobPlanLines."Job No." + ' ' + JobPlanLines."Job Task No.";
                    ProdOrd."Creation Date" := WorkDate();
                    ProdOrd.Validate("Source No.", JobPlanLines."No.");
                    ProdOrd.Validate("Due Date", JobPlanLines."Planning Due Date");
                    ProdOrd.Validate("Location Code", JobPlanLines."Location Code");
                    ProdOrd.Validate(Quantity, JobPlanLines.Quantity);
                    ProdOrd.Validate("Shortcut Dimension 1 Code", JobPlanLines."Shortcut Dimension 1 Code");
                    ProdOrd.Validate("Shortcut Dimension 2 Code", JobPlanLines."Shortcut Dimension 2 Code");
                    ProdOrd."Created from Project" := true;
                    ProdOrd."Project No" := JobPlanLines."Job No.";
                    ProdOrd."Project Task No" := JobPlanLines."Job Task No.";
                    ProdOrd."Project Plan Line No" := JobPlanLines."Line No.";
                    ProdOrd.Insert(true);
                    MarkProdJobPlanLine(JobPlanLines."Job No.", JobPlanLines."Job Task No.", JobPlanLines."Line No.", ProdOrd."No.");
                end;
            until JobPlanLines.Next() = 0;
    end;

    local procedure MarkJobPlanLine(JobNo: Code[20]; JobTaskNo: Code[20]; JobTaskLineNo: Integer; PurchNo: Code[20]; PurchLineNo: Integer);
    var
        JobPlanLine: Record "Job Planning Line";
    begin
        JobPlanLine.Reset();
        JobPlanLine.SetRange("Job No.", JobNo);
        JobPlanLine.SetRange("Job Task No.", JobTaskNo);
        JobPlanLine.SetRange("Line No.", JobTaskLineNo);
        if JobPlanLine.FindSet() then begin
            JobPlanLine.PurchOrderNo := PurchNo;
            JobPlanLine.PurchOrderLineNo := PurchLineNo;
            JobPlanLine.Modify();
        end;
    end;

    local procedure MarkAssyJobPlanLine(JobNo: Code[20]; JobTaskNo: Code[20]; JobTaskLineNo: Integer; AssyNo: Code[20])
    var
        JobPlanLine: Record "Job Planning Line";
    begin
        JobPlanLine.Reset();
        JobPlanLine.SetRange("Job No.", JobNo);
        JobPlanLine.SetRange("Job Task No.", JobTaskNo);
        JobPlanLine.SetRange("Line No.", JobTaskLineNo);
        if JobPlanLine.FindSet() then begin
            JobPlanLine.AssyOrderNo := AssyNo;
            JobPlanLine.Modify();
        end;
    end;

    local procedure MarkProdJobPlanLine(JobNo: Code[20]; JobTaskNo: Code[20]; JobTaskLineNo: Integer; ProdNo: Code[20])
    var
        JobPlanLine: Record "Job Planning Line";
    begin
        JobPlanLine.Reset();
        JobPlanLine.SetRange("Job No.", JobNo);
        JobPlanLine.SetRange("Job Task No.", JobTaskNo);
        JobPlanLine.SetRange("Line No.", JobTaskLineNo);
        if JobPlanLine.FindSet() then begin
            JobPlanLine.ProdOrderNo := ProdNo;
            JobPlanLine.Modify();
        end;
    end;

    local procedure GetJobDims(JobNo: Code[20]);
    var
        myInt: Integer;
    begin

    end;
}
