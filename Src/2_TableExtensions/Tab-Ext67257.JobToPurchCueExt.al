namespace JobToPurchase.JobToPurchase;

using Microsoft.Projects.RoleCenters;
using Microsoft.Purchases.Document;
using Microsoft.Purchases.History;
using Microsoft.Manufacturing.Document;
using Microsoft.Assembly.History;
using Microsoft.Assembly.Document;

tableextension 67257 JobToPurchCueExt extends "Job Cue"
{
    fields
    {
        field(67250; "PurchOrd Open"; Integer)
        {
            Caption = 'PurchOrd Open';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = count("Purchase Header" where("Created from Project" = const(true), Status = const(Open), "Document Type" = const(Order)));

        }
        field(67251; "PurchOrd Released"; Integer)
        {
            Caption = 'PurchOrd Released';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = count("Purchase Header" where("Created from Project" = const(true), Status = const(Released), "Document Type" = const(Order)));
        }
        field(67252; "PurchOrd PartRec"; Integer)
        {
            Caption = 'PurchOrd PartRec';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = count("Purchase Header" where("Created from Project" = const(true), Receive = const(true)));
        }
        field(67253; PurcRec; Integer)
        {
            Caption = 'PurcRec';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = count("Purch. Rcpt. Header" where("Created from Project" = const(true)));
        }
        field(67254; PurchInv; Integer)
        {
            Caption = 'PurchInv';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = count("Purch. Inv. Header" where("Created from Project" = const(true)));
        }
        field(67255; AssyOrd; Integer)
        {
            Caption = 'Assembly Orders';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = count("Assembly Header" where("Created from Project" = const(true)));
        }
        field(67256; PostAssyOrd; Integer)
        {
            Caption = 'Posted Assembly Orders';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = count("Posted Assembly Header" where("Created from Project" = const(true)));
        }
        field(67257; FPlanProdOrd; Integer)
        {
            Caption = 'Firm Planned Production Orders';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = count("Production Order" where("Created from Project" = const(true), Status = Const("Firm Planned")));
        }
        field(67258; RelProdOrd; Integer)
        {
            Caption = 'Released Production Orders';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = count("Production Order" where("Created from Project" = const(true), Status = Const(Released)));
        }
        field(67259; FinProdOrd; Integer)
        {
            Caption = 'Finished Production Orders';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = count("Production Order" where("Created from Project" = const(true), Status = Const(Finished)));
        }
    }
}
