using CatalogService as service from '../../srv/CatalogService';

annotate service.POs with @(
    //selectionFields -Adds fields for selecting data 
 UI.SelectionFields:[
    PO_ID,
    PARTNER_GUID.COMPANY_NAME,
    PARTNER_GUID.ADDRESS_GUID.COUNTRY,
    GROSS_AMOUNT,
    OVERALL_STATUS
 ],
  
  //LineItem - To add columns to the table
  UI.LineItem:[
    {
        $Type : 'UI.DataField',
        Value : PO_ID,
    },
     {
        $Type : 'UI.DataField',
        Value : PARTNER_GUID.COMPANY_NAME,
     },
     {
        $Type : 'UI.DataField',
        Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY,
     },
     {
        $Type : 'UI.DataField',
        Value : GROSS_AMOUNT,
     },
     {
        $Type : 'UI.DataFieldForAction',
        Action: 'CatalogService.boost',
        Label : 'boost',
        Inline : true,
     },
     {
        $Type : 'UI.DataField',
        Value : OVERALL_STATUS,
        Criticality : Criticality
     }

  ],
  //Header data and logo
 UI.HeaderInfo:{
   TypeName : 'Purchase Order',
   TypeNamePlural : 'Purchase Orders',
   Title : {
      $Type : 'UI.DataField',
      Value : PO_ID,
   },
   Description : {
      $Type : 'UI.DataField',
      Value : PARTNER_GUID.COMPANY_NAME,
   },


 ImageUrl : 'https://media.licdn.com/dms/image/v2/D4D0BAQGqkUrEIAuCHw/company-logo_200_200/B4DZfzh1QvGgAM-/0/1752137422357?e=2147483647&v=beta&t=eyEhpXK3lvRljwX-pB3mo3TOeu_Nsicu5WGjzunByz8',
 },
 UI.Facets:[ 
   {
    $Type: 'UI.CollectionFacet',
    Label: 'General Information',
    Facets:[
      {
         $Type : 'UI.ReferenceFacet',
         Target :'@UI.Identification',
         Label : 'Purchase order details',
      },
      {
         $Type : 'UI.ReferenceFacet',
         Label : 'Pricing',
         Target : '@UI.FieldGroup#Spiderman',
      },
      {
         $Type :'UI.ReferenceFacet',
         Label : 'Status',
         Target : '@UI.FieldGroup#Superman',
      }

    ]   
   }, 
   {
     $Type : 'UI.ReferenceFacet',
     Label : 'PO Items',
     Target : 'Items/@UI.LineItem',  
   },
 ],
 UI.Identification : [
   {
      $Type:'UI.DataField',
      Value: PO_ID,
   },
   {
      $Type:'UI.DataField',
      Value: PARTNER_GUID_NODE_KEY,
   },
   {
      $Type:'UI.DataField',
       Value: OVERALL_STATUS,
   },
   {
        $Type         : 'UI.DataFieldForAction',
        Label         : 'Set to Delivered',
        Action        : 'CatalogService.setOrderProcessing'
    }
 ],
 UI.FieldGroup #Spiderman:{
   Label : 'Pricing Data',
   Data : [
      {
        $Type : 'UI.DataField',
        Value : GROSS_AMOUNT,
      },
      {
        $Type : 'UI.DataField',
        Value : NET_AMOUNT,
      },
      {
        $Type : 'UI.DataField',
        Value : TAX_AMOUNT,
      }

   ]
 },
 UI.FieldGroup #Superman : {
   Label: 'Status',
   Data : [
      {
          $Type: 'UI.DataField',
          Value : CURRENCY_code,
      },
      {
         $Type: 'UI.DataField',
          Value : LIFECYCLE_STATUS,
      },
   ]
 }
  
);

annotate service.PurchaseOrderItems with @(
   UI.HeaderInfo:{
    TypeName :'PO Item',
    TypeNamePlural:'PO Items',
    Title : {
           $Type:'UI.DataField',
           Value: PO_ITEM_POS,
    },
        Description : {
          $Type:'UI.DataField',
          Value: PRODUCT_GUID.DESCRIPTION,
        },
   },
   UI.Facets:[
        {
         $Type:'UI.ReferenceFacet',
         Label: 'More Details',
         Target: '@UI.Identification',
        },
   ] ,
   UI.Identification:[
        {
         $Type:'UI.DataField',
         Value:PO_ITEM_POS,
        },
        {
         $Type:'UI.DataField',
         Value:PRODUCT_GUID_NODE_KEY,
        },
        {
         $Type:'UI.DataField',
         Value:GROSS_AMOUNT,
        },
        {
         $Type:'UI.DataField',
         Value:NET_AMOUNT,
        },
         {
         $Type:'UI.DataField',
         Value:TAX_AMOUNT,
        },
        {
         $Type:'UI.DataField',
         Value:CURRENCY_code,
        },
   ],
   UI.LineItem:[
      {
         $Type : 'UI.DataField',
         Value : PO_ITEM_POS,
      },
      {
         $Type : 'UI.DataField',
         Value : PRODUCT_GUID.DESCRIPTION,
      },
      {
         $Type : 'UI.DataField',
         Value : GROSS_AMOUNT,
      },
      {
         $Type : 'UI.DataField',
         Value : TAX_AMOUNT,
      },
      {
         $Type : 'UI.DataField',
         Value : CURRENCY_code,
      }
   ]
);

annotate CatalogService.POs with {
    PARTNER_GUID @(
        Common : { 
            Text : PARTNER_GUID.COMPANY_NAME,
         },
         ValueList.entity: CatalogService.BusinessPartnerSet
    )
};

annotate CatalogService.PurchaseOrderItems with {
    PRODUCT_GUID @(
        Common : { 
            Text : PRODUCT_GUID.DESCRIPTION,
         },
         ValueList.entity: CatalogService.ProductSet
    )
};


@cds.odata.valuelist
annotate CatalogService.BusinessPartnerSet with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value : COMPANY_NAME,
    }]
);

@cds.odata.valuelist
annotate CatalogService.ProductSet with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value : DESCRIPTION,
    }]
);

