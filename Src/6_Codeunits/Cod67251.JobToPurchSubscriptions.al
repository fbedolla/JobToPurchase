namespace JobToPurchase.JobToPurchase;
using Microsoft.Projects.Project.Planning;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Journal;
using Microsoft.Purchases.Document;
using Microsoft.Purchases.Posting;
using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Posting;
using Microsoft.Inventory.Item.Catalog;

codeunit 67251 JobToPurchSubscriptions
{
    [EventSubscriber(ObjectType::Table, Database::"Job Planning Line", 'OnAfterCopyFromItem', '', True, True)]
    local procedure GetVendNo(var JobPlanningLine: Record "Job Planning Line")
    var
        Item: Record Item;
        ItemVend: Record "Item Vendor";
    begin
        if JobPlanningLine.Type = JobPlanningLine.Type::Item then begin
            Item.Reset();
            Item.SetRange("No.", JobPlanningLine."No.");
            case Item."Replenishment System" of
                Item."Replenishment System"::Purchase:
                    begin
                        if Item.FindFirst() then begin
                            if item."Vendor No." <> '' then
                                JobPlanningLine.Validate(VendorNo, Item."Vendor No.")
                            else begin
                                ItemVend.Reset();
                                ItemVend.SetRange("Item No.", JobPlanningLine."No.");
                                if ItemVend.FindFirst() then
                                    JobPlanningLine.Validate(VendorNo, ItemVend."Vendor No.");
                            end;
                        end;
                    end;
                Item."Replenishment System"::Assembly:
                    begin
                        JobPlanningLine.CreatePurchOrd := false;
                        JobPlanningLine.CreateAssyOrd := true;
                        JobPlanningLine.CreateProdOrd := false;
                    end;
                Item."Replenishment System"::"Prod. Order":
                    begin
                        JobPlanningLine.CreatePurchOrd := false;
                        JobPlanningLine.CreateAssyOrd := false;
                        JobPlanningLine.CreateProdOrd := true;
                    end;
            end;

            JobPlanningLine."Shortcut Dimension 1 Code" := Item."Global Dimension 1 Code";
            JobPlanningLine."Shortcut Dimension 2 Code" := Item."Global Dimension 2 Code";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeApplyItemLedgEntry', '', true, true)]
    local procedure ProjNo(ItemJnlLine: Record "Item Journal Line"; var ItemLedgEntry: Record "Item Ledger Entry"; var ValueEntry: Record "Value Entry")
    begin
        ItemLedgEntry."Project No" := ItemJnlLine."Project No";
        ItemLedgEntry."Project Task No" := ItemJnlLine."Project Task No";
        ItemLedgEntry."Project Plan Line No" := ItemJnlLine."Project Plan Line No";
        ValueEntry."Project No" := ItemJnlLine."Project No";
        ValueEntry."Project Task No" := ItemJnlLine."Project Task No";
        ValueEntry."Project Plan Line No" := ItemJnlLine."Project Plan Line No";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnPostItemJnlLineOnBeforeInitAmount', '', true, true)]
    local procedure InsProytoILE(var ItemJnlLine: Record "Item Journal Line"; PurchLine: Record "Purchase Line")
    begin
        ItemJnlLine."Project No" := PurchLine."Project No.";
        ItemJnlLine."Project Task No" := PurchLine."Project Task No.";
        ItemJnlLine."Project Plan Line No" := PurchLine."Project Plan. Line No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnItemQtyPostingOnAfterInsertApplEntry', '', true, true)]
    local procedure MyProcedure(var ItemJnlLine: Record "Item Journal Line"; var GlobalItemLedgEntry: Record "Item Ledger Entry")
    begin
        GlobalItemLedgEntry."Project No" := ItemJnlLine."Project No";
        GlobalItemLedgEntry."Project Task No" := ItemJnlLine."Project Task No";
        GlobalItemLedgEntry."Project Plan Line No" := ItemJnlLine."Project Plan Line No";
    end;
}
