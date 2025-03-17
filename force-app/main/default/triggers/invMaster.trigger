trigger invMaster on Invoice__c (before insert, before update, before delete,
after insert, after update, after delete, after undelete) {


if(trigger.isBefore){

if(trigger.isInsert){

}
if(trigger.isUpdate){

}
if(trigger.isDelete){
    invHandler.preventDelete(trigger.old);
}
}


if(trigger.isAfter){

if(trigger.isInsert){
    invHandler.shareInvoices(trigger.new);
}
if(trigger.isUpdate){
    invHandler.shareInvoices(trigger.new);
}
if(trigger.isDelete){

}
if(trigger.isUndelete){

}
}
}