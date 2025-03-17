public with sharing class UpdateOpportuntiesBatch implements Database.Batchable<sObject> {
 
    public Database.QueryLocator start(Database.BatchableContext BC){
        //collect the records needed to be processes
        return Database.getQueryLocator('SELECT ID, Name, Type, Account.Name, CloseDate FROM Opportunity');
   }
   
   public void execute(Database.BatchableContext BC, List<Opportunity> opps){
        // processing logic
        for (Opportunity o : opps){
            ///Calc naming convention
        }
        update opps;

   }

   public void finish(Database.BatchableContext BC){
        // post processing logic
        system.debug('all done');

         // retrieve the job information
         AsyncApexJob job = [SELECT Id, Status, CreatedBy.Email FROM AsyncApexJob
         WHERE Id = :bc.getJobId() LIMIT 1];

// create an Email message
Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();

// populate the to address(es), subject, body of the email
message.toAddresses = new String[] {job.CreatedBy.Email};
message.subject = 'Async Job Infor for: ' + job.Id;
message.plaintextbody = 'Job Status: ' + job.Status;

// create a List of singleEmailMessage to add our message to and pass to sendEmail
List<Messaging.SingleEmailMessage> messages = New List<Messaging.SingleEmailMessage>();

messages.add(message);

// send the email
List<Messaging.SendEmailResult> results = Messaging.sendEmail(messages);

// iterate over the results and check for success
if (results[0].success) {
system.debug('Email was sent successfully.');
} else {
system.debug('Email failed: ' + results[0].errors[0].message);
}
}
   }