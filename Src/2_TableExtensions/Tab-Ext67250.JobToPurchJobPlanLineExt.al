namespace fbedolla.JobToPurchase;
using Microsoft.Projects.Project.Planning;
using Microsoft.Finance.Dimension;
using Microsoft.Purchases.Vendor;
using Microsoft.Purchases.History;
using Microsoft.Purchases.Document;
using Microsoft.Manufacturing.Document;
using Microsoft.Assembly.Document;

tableextension 67250 JobToPurchJobPlanLineExt extends "Job Planning Line"
{
    fields
    {
        field(67250; PurchOrderNo; Code[20])
        {
            Caption = 'Purch. Order No.';
            DataClassification = CustomerContent;
            TableRelation = "Purchase Line"."Document No." where("Document Type" = const(Order));
        }
        field(67251; PurchOrderLineNo; Integer)
        {
            Caption = 'Purch. Order Line No.';
            DataClassification = CustomerContent;
            TableRelation = "Purchase Line"."Line No." where("Document No." = field(PurchOrderNo));
        }
        field(67252; PurchRecNo; Code[20])
        {
            Caption = 'Purch. Receipt No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Rcpt. Line"."Document No." where("Project No." = field("Job No."), "Project Task No." = field("Job Task No."), "Project Plan. Line No." = field("Line No.")));
        }
        field(67253; PurchRecLineNo; Integer)
        {
            Caption = 'Purch. Receipt Line No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Rcpt. Line"."Line No." where("Project No." = field("Job No."), "Project Task No." = field("Job Task No."), "Project Plan. Line No." = field("Line No.")));
        }
        field(67254; PurchInvNo; Code[20])
        {
            Caption = 'Purch. Inv. Line No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Inv. Line"."Document No." where("Project No." = field("Job No."), "Project Task No." = field("Job Task No."), "Project Plan. Line No." = field("Line No.")));
        }
        field(67255; PurchInvLineNo; Integer)
        {
            Caption = 'Purch. Inv. Line No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Inv. Line"."Line No." where("Project No." = field("Job No."), "Project Task No." = field("Job Task No."), "Project Plan. Line No." = field("Line No.")));
        }
        field(67256; VendorNo; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = CustomerContent;
            TableRelation = Vendor."No." where(Blocked = const(" "));
            trigger OnValidate()
            begin
                if VendorNo <> '' then
                    case Type of
                        Type::"G/L Account":
                            begin
                                CreatePurchOrd := true;
                                "Location Code" := GetVendLocCode(VendorNo);
                            end;
                        Type::Item:
                            begin
                                CreatePurchOrd := true;
                                "Location Code" := GetVendLocCode(VendorNo);
                            end;
                        Type::Text:
                            CreatePurchOrd := true;
                    end
                else
                    CreatePurchOrd := false;
            end;
        }
        field(67257; CreatePurchOrd; Boolean)
        {
            Caption = 'Create Purchase Order';
            DataClassification = CustomerContent;
        }
        field(67258; CreateAssyOrd; Boolean)
        {
            Caption = 'Create Assembly Order';
            DataClassification = CustomerContent;
        }
        field(67259; CreateProdOrd; Boolean)
        {
            Caption = 'Create Production Order';
            DataClassification = CustomerContent;
        }
        field(67260; AssyOrderNo; Code[20])
        {
            Caption = 'Asembly Order No.';
            DataClassification = CustomerContent;
            TableRelation = "Assembly Header"."No." where("Document Type" = const(Order));
        }
        field(67261; ProdOrderNo; Code[20])
        {
            Caption = 'Production Order No.';
            DataClassification = CustomerContent;
            TableRelation = "Production Order"."No.";
        }
        field(67270; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                Rec.ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(67271; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                Rec.ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(67272; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                Rec.ShowDimensions();
            end;

            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
    }

    var
        DimMgt: Codeunit DimensionManagement;

    local procedure GetVendLocCode(VendorNo: Code[20]): Code[10]
    var
        Vend: Record Vendor;
        JobPurchSetup: Record "JobToPurch Setup";
    begin
        Vend.Reset();
        Vend.SetRange("No.", VendorNo);
        if Vend.FindFirst() then
            if Vend."Location Code" <> '' then
                exit(vend."Location Code")
            else begin
                JobPurchSetup.Get();
                exit(JobPurchSetup.DefPurchLoc);
            end;
    end;

    procedure ShowDimensions() IsChanged: Boolean
    var
        OldDimSetID: Integer;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if IsHandled then
            exit;

        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2 %3', '', "Document No.", "Line No."));

        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        IsChanged := OldDimSetID <> "Dimension Set ID";

    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if IsHandled then
            exit;

        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}
