trigger SetOppName on Opportunity (before insert, before update) {
    
    //Get ingredients - need Account Names
    Set<Id> accIds = new Set<Id>();
    for (Opportunity o : trigger.new){
        accIds.add(o.AccountId);
    }
    
    Map<Id,String> accNames = new Map<Id,String>();
    for (Account a : [SELECT Id, Name FROM Account WHERE Id IN :accIds]){
        accNames.put(a.Id, a.Name);
    }
    
    //Perform my work
    for(Opportunity o : trigger.new){
        o.Name = accNames.get(o.AccountId) + ' - ' + o.Type + ' - ' + String.valueof(o.CloseDate.year()) + '/' + String.valueof(o.CloseDate.month());
    }

}