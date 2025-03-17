trigger CreateInvoiceFromOpportunity on Opportunity (before insert, before update, before delete,
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
        oppHandler.CreateInvoiceFromOpportunity(trigger.new, trigger.oldMap, trigger.isInsert);
        
}
    if(trigger.isUpdate){
        oppHandler.CreateInvoiceFromOpportunity(trigger.new, trigger.oldMap, trigger.isInsert);

    }
    if(trigger.isDelete){

    }
    if(trigger.isUndelete){

    }
}
}