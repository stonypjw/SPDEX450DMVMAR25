trigger invMaster on Invoice__c(
  before insert,
  before update,
  before delete,
  after insert,
  after update,
  after delete,
  after undelete
) {
  if (Trigger.isBefore) {
    if (Trigger.isInsert) {
    }
    if (Trigger.isUpdate) {
    }
    if (Trigger.isDelete) {
      invHandler.preventDelete(Trigger.old);
    }
  }

  if (Trigger.isAfter) {
    if (Trigger.isInsert) {
      invHandler.shareInvoices(Trigger.new);
    }
    if (Trigger.isUpdate) {
      invHandler.shareInvoices(Trigger.new);
    }
    if (Trigger.isDelete) {
    }
    if (Trigger.isUndelete) {
    }
  }
}
