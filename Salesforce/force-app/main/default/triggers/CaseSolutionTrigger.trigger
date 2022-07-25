trigger CaseSolutionTrigger on Case_Solution__c (after update) {

    if(Trigger.isAfter&&Trigger.isUpdate){
        CaseSolutionTriggerHandler.afterUpdateCaseSolutionHandler(Trigger.new, Trigger.oldMap);
    }
}
