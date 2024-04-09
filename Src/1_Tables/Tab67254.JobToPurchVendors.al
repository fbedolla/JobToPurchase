namespace fbedolla.JobToPurchase;

table 67254 JobToPurchVendors
{
    Caption = 'JobToPurchVendors';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Vendor No"; Code[20])
        {
            Caption = 'Vendor No';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Vendor No")
        {
            Clustered = true;
        }
    }
}
