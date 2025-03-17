public with sharing class oppHandler {

    public static void CreateInvoiceFromOpportunity (List<Opportunity> triggernew, Map<Id,Opportunity> triggeroldMap,
                                                Boolean isInsert){
        //If the opportunity is already set to won then create the invoice record
        //If the opportunity has just be switched to Closed Won then create the invoice record
        //First check trigger.new to see which opportunities in the batch have just change to Won. Check oldMap.

        //STAGE ONE - Collect ingredients
        Set<Id> associatedAccIds = new Set<Id>();
        for (Opportunity o : triggernew){
            if (o.isWon && (!triggerOldMap.get(o.Id).isWon || isInsert)){
                associatedAccIds.add(o.AccountId);
            }
        }
        System.Debug('Associated Accounts:'+associatedAccIds);
        Map<Id, Id> associatedBillingContact = new Map<Id, Id>();
        for (Account a : [SELECT Id, Default_Billing_Contact__c FROM Account WHERE ID IN :associatedAccIds]){
            associatedBillingContact.put(a.Id,a.Default_Billing_Contact__c);
        }
        System.Debug('Map for Billing Contact:'+associatedBillingContact);
        //Get Custom MetaData for Net
        List<InvoiceConfig__mdt> invConfig = InvoiceConfig__mdt.getAll().values();
        System.Debug(invConfig);    

        //STAGE TWO: Do the work
        List<Invoice__c> newInvoices = new List<Invoice__c>();
        for (Opportunity o : triggernew){
            if (o.isWon && (!triggerOldMap.get(o.Id).isWon || isInsert)){
                  //If yes, create new invoice record and connect it to the Opportunity and its associated Account
                  //In order to populate Billing Contact I will need to query associated Account to get the default
                Invoice__c newInv = new Invoice__c();
                    newInv.Account__c = o.AccountId;
                    newInv.Opportunity__c = o.Id;
                    newInv.Amount__c = o.Amount;
                    newInv.Due_Date__c = o.CloseDate + Integer.valueof(invConfig[0].DefautNetBilling__c);
                    newinv.Billing_Contact__c = associatedBillingContact.get(o.AccountId);
                newInvoices.add(newInv);
            }
        }

        //STAGE THREE: Database operations
        if (!newInvoices.isEmpty()){
            Database.SaveResult[] srList = Database.insert(newInvoices,false);
 
        // Iterate through each returned result
            Set<Id> oIds = new Set<Id>();
            for (Database.SaveResult sr : srList) {
             if (!sr.isSuccess()) {
               // Operation failed, so get all errors                
              for(Database.Error err : sr.getErrors()) {
                 System.debug('The following error has occurred.');                    
                     System.debug(err.getStatusCode() + ': ' + err.getMessage());
                  System.debug('Fields that affected this error: ' + err.getFields());
        
                
                  }
               }
            }           
        
        for (Invoice__c inv : newInvoices){
            if(inv.Id == null){
                oIds.add(inv.Opportunity__c);
            }
        }
        for (Opportunity o : triggernew){
            if(oIds.contains(o.Id)){
                o.addError('An invoice record failed to be created because there is no default billing contact on the Account');
            }
        }

    }
    }
}