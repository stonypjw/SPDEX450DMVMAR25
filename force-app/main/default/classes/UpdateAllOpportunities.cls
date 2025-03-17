global class UpdateAllOpportunities implements Schedulable {

    global void execute(SchedulableContext sc){
        ID batchInstanceId = Database.executeBatch(new UpdateOpportuntiesBatch()); 
    }
}