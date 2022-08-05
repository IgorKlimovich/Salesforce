public  class CaseSolutionTriggerManager {

    public static Map<Id, Case> getCaseWithCaseSolutions(Set<Id> caseIds){
        return new Map<Id,Case>([SELECT id,(SELECT id FROM Case_Solutions__r) FROM Case WHERE id IN: caseIds]);
    }
}

