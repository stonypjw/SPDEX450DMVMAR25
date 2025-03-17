public with sharing class invoicecontroller {

    private Id oId;
    private Opportunity opp;
    public Decimal oppValue {get;set;}
    private Map<Id,Id> associatedBillingContacts;

    public InvoiceController(ApexPages.StandardSetController ssc) {
        oId = ApexPages.currentPage().getParameters().get('Id');
        loadOpportunity();
    }

    private void loadOpportunity(){
        opp = [SELECT Amount,AccountId FROM Opportunity WHERE ID = :oId];
        oppValue = opp.Amount;
        Set<Id> accountIds = new Set<Id>();
            accountIds.add(opp.AccountId);
        associatedBillingContacts = oppHandler.defaultBillingContacts(accountIds);
    }

    public List<Invoice__c> newInvoices {
        get{
            if(newInvoices == null){
                newInvoices = new List<Invoice__c>();
                for (Integer i=0; i < 12; i++){
                    Invoice__c inv = new Invoice__c();
                        inv.Opportunity__c = oId;
                        inv.Account__c = opp.AccountId;
                        inv.Amount_Paid__c = 0;
                        inv.Billing_Contact__c = associatedBillingContacts.get(opp.AccountId);
                        newInvoices.add(inv);
                }
            }
            return newinvoices;
        }
        set{}
    }

    public PageReference cancel(){
        Pagereference pr = new PageReference('/'+oid);
        return pr;
    }

    public PageReference save(){
        List<Invoice__c> invoicesToCreate = new List<Invoice__c>();

        for (Invoice__c inv : newInvoices){
            if(inv.Amount__c > 0){
                invoicesToCreate.add(inv);
            }
        }
        insert invoicesToCreate;


        Pagereference pr = new PageReference('/'+oid);
        return pr;
    }
}