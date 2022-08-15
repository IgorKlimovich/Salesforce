trigger CaseSolutionTrigger on Case_Solution__c (after update) {

    if(Trigger.isAfter&&Trigger.isUpdate){
        if(!CaseSolutionManager.firstcall){
            CaseSolutionManager.firstcall=true;
            CaseSolutionTriggerHandler.afterUpdateCaseSolutionHandler(Trigger.new, Trigger.oldMap);
        }
    }
}