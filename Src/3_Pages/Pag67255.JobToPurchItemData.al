namespace fbedolla.JobToPurchase;
using Microsoft.Inventory.Item;

page 67255 JobToPurchItemData
{
    ApplicationArea = All;
    Caption = 'JobToPurchItemData';
    PageType = CardPart;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the item.';

                    trigger OnDrillDown()
                    begin
                        ShowDetails();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies what you are selling.';
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total quantity of the item that is currently in inventory at all locations.';
                }
            }
            group(Orders)
            {
                field("Qty. in Transit"; Rec."Qty. in Transit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty. in Transit field.';
                }
                field("Qty. on Assembly Order"; Rec."Qty. on Assembly Order")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how many units of the item are allocated to assembly orders, which is how many are listed on outstanding assembly order headers.';
                }
                field("Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how many units of the item are inbound on purchase orders, meaning listed on outstanding purchase order lines.';
                }
                field("Qty. on Component Lines"; Rec."Qty. on Component Lines")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how many units of the item are allocated as production order components, meaning listed under outstanding production order lines.';
                }
                field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how many units of the item are allocated to sales orders, meaning listed on outstanding sales orders lines.';
                }
                field("Qty. on Job Order"; Rec."Qty. on Job Order")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how many units of the item are allocated to jobs, meaning listed on outstanding job planning lines.';
                }
            }
            group(Reservations)
            {
                field("Res. Qty. on Assembly Order"; Rec."Res. Qty. on Assembly Order")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Res. Qty. on Assembly Order field.';
                }
                field("Res. Qty. on Inbound Transfer"; Rec."Res. Qty. on Inbound Transfer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Res. Qty. on Inbound Transfer field.';
                }
                field("Res. Qty. on Job Order"; Rec."Res. Qty. on Job Order")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Res. Qty. on Job Order field.';
                }
                field("Res. Qty. on Outbound Transfer"; Rec."Res. Qty. on Outbound Transfer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Res. Qty. on Outbound Transfer field.';
                }
                field("Res. Qty. on Req. Line"; Rec."Res. Qty. on Req. Line")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Res. Qty. on Req. Line field.';
                }
                field("Res. Qty. on Purch. Returns"; Rec."Res. Qty. on Purch. Returns")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Res. Qty. on Purch. Returns field.';
                }
                field("Res. Qty. on Sales Returns"; Rec."Res. Qty. on Sales Returns")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Res. Qty. on Sales Returns field.';
                }
                field("Reserved Qty. on Inventory"; Rec."Reserved Qty. on Inventory")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reserved Qty. on Inventory field.';
                }
                field("Reserved Qty. on Purch. Orders"; Rec."Reserved Qty. on Purch. Orders")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reserved Qty. on Purch. Orders field.';
                }
            }
        }
    }
    local procedure ShowDetails()
    begin
        PAGE.Run(PAGE::"Item Card", Rec);
    end;
}
