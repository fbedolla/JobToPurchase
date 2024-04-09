namespace fbedolla.JobToPurchase;
using Microsoft.Inventory.Location;

table 67250 "JobToPurch Setup"
{
    Caption = 'Job To Purch. Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(3; "Action Type"; enum JobToPurchActionType)
        {
            Caption = 'Action Type';
            DataClassification = CustomerContent;
        }
        field(10; DefPurchLoc; Code[10])
        {
            Caption = 'Default Purchase Location';
            DataClassification = CustomerContent;
            TableRelation = Location;
            trigger OnValidate()
            var
                Loc: Record Location;
            begin
                Loc.Get(DefPurchLoc);
                DefLocName := Loc.Name;
            end;
        }
        field(11; DefLocName; Text[100])
        {
            Caption = 'Location Name';
            DataClassification = CustomerContent;
        }
        field(20; UseAssy; Boolean)
        {
            Caption = 'Use Assemblies';
            DataClassification = CustomerContent;
        }
        field(21; UseProd; Boolean)
        {
            Caption = 'Use Production Prods.';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
    var
        RecordHasBeenRead: Boolean;

    procedure GetRecordOnce()
    begin
        if RecordHasBeenRead then
            exit;
        Get();
        RecordHasBeenRead := true;
    end;
}
