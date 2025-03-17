public with sharing class invHandler {

    public static void preventDelete(List<Invoice__c> triggerold){
        for(Invoice__c inv : triggerold){
            if(inv.Balance__c > 0){
                inv.addError('This invoice has an outstanding balance and should not be deleted');
            }
        }
    }

    public static void shareInvoices (List<Invoice__c> triggernew) {

        //STEP ONE - get ingredients
        Map<Id,Id> mapOppOwners = new Map<Id,Id>();
        Set<Id> oppIds = new Set<Id>();
        Group SVP;

        for(Invoice__c inv : triggernew){
            oppIds.add(inv.Opportunity__c);
        }

        for(Opportunity o : [SELECT Id, OwnerId FROM Opportunity WHERE Id IN :oppIds]){
            mapOppOwners.put(o.id,o.OwnerId);
        }

        SVP = [SELECT ID FROM Group WHERE DeveloperName='SVPCustomerServiceSupportA' LIMIT 1];

        //STEP TWO - Do the work
        List<Invoice__Share> shares = new List<Invoice__Share>();

        for(Invoice__c inv : triggernew){
            Invoice__Share invShare1 = new Invoice__Share();
            invShare1.ParentId = inv.Id;
            invShare1.AccessLevel = 'Read';
            invShare1.RowCause = 'Manual';
            invShare1.UserOrGroupId = mapOppOwners.get(inv.Opportunity__c);
            shares.add(invShare1);

            Invoice__Share invShare2 = new Invoice__Share();
            invShare2.ParentId = inv.Id;
            invShare2.AccessLevel = 'Edit';
            invShare2.RowCause = 'Manual';
            invShare2.UserOrGroupId = SVP.Id;
            shares.add(invShare2);
        }
        Database.insert(shares,false);
    }
}