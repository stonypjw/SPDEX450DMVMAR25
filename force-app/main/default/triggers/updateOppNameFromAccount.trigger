trigger updateOppNameFromAccount on Account (before insert, before update, before delete,
                                             after insert, after update, after delete, after undelete) {

      
    if(trigger.isBefore){

        if(trigger.isInsert){

        }
        if(trigger.isUpdate){

        }
        if(trigger.isDelete){

        }
    }

    if(trigger.isAfter){

        if(trigger.isInsert){

        }
        if(trigger.isUpdate){

            //Automate the update of opportunities to reflect an Account Name change
            Set<Id> changedNameAccIds = new Set<Id>();
            for(Account a : trigger.new){
                if(a.Name != trigger.oldMap.get(a.Id).Name){
                    changedNameAccIds.add(a.Id);
                }
            }
            if(!changedNameAccIds.isEmpty()){
                List<Opportunity> oppsToUpdate = [SELECT Id FROM Opportunity WHERE AccountId IN :changedNameAccIds];
                Database.update(oppsToUpdate,false);
            }

        }
        if(trigger.isDelete){

        }
        if(trigger.isUndelete){

        }
    }
}