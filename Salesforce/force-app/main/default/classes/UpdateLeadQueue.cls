public with sharing class UpdateLeadQueue implements Schedulable{
    public void execute(SchedulableContext context) {

        UpdateLeadQueueBatch ulqb =new UpdateLeadQueueBatch();
        Database.executeBatch(ulqb);
    }
}