namespace fbedolla.JobToPurchase;

page 67250 "JobToPurch Setup"
{
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Job To Purchase Setup';
    PageType = Card;
    SourceTable = "JobToPurch Setup";
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Action Type"; Rec."Action Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Action Type field.';
                }
                field(UseAssy; Rec.UseAssy)
                {
                    ApplicationArea = All;
                }
                field(UseProd; Rec.UseProd)
                {
                    ApplicationArea = All;
                }
            }
            group(defData)
            {
                Caption = 'Default Data';
                field(DefPurchLoc; Rec.DefPurchLoc)
                {
                    ApplicationArea = All;
                }
                field(DefLocName; Rec.DefLocName)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}
