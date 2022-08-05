public class CaseSolutionTriggerHandler {

    public static void afterUpdateCaseSolutionHandler(List<Case_Solution__c> caseSolutionsNew,
    Map<Id,Case_Solution__c> caseSolutionOldMap){
        
        Set<Case_Solution__c> caseSolutionSetForUpdate = new Set<Case_Solution__c>();
        Set<Case> caseSetForUpdate  = new Set<Case>();
        Set<Id> caseIds = new Set<Id>();
        for (Case_Solution__c cs: caseSolutionsNew) {
            caseIds.add(cs.Case__c);
        }
        Map<Id,Case> caseWithCaseSolutions = CaseDuplicateControllerManager.getCaseWithCaseSolutions(caseIds);
        
        for(Case_Solution__c caseSolution : caseSolutionsNew){
            if(caseSolutionOldMap.get(caseSolution.id).Solution_Results__c != CaseSolutionTriggerConstants.RESOLVED_VIA_CALL &&
            caseSolutionOldMap.get(caseSolution.id).Solution_Results__c != CaseSolutionTriggerConstants.RESOLVED_IN_ADVANCE) {
                    Case caseForUpdate = caseWithCaseSolutions.get(caseSolution.Case__c);
                    caseForUpdate.Status = CaseSolutionTriggerConstants.RESOLVED;
                    caseSetForUpdate.add(caseForUpdate);
                    List<Case_Solution__c > caseSolutions = caseForUpdate.Case_Solutions__r;
                    for(Case_Solution__c casSol: caseSolutions){
                        if (casSol.id != caseSolution.id) {
                            casSol.Solution_Results__c = CaseSolutionTriggerConstants.CANCELLED;
                            caseSolutionSetForUpdate.add(casSol);   
                        }
                    }
                
            }
        }
        if (caseSolutionSetForUpdate.size() > 0) {
            update new List<Case_Solution__c>(caseSolutionSetForUpdate);
        }
        if (caseSetForUpdate.size() > 0) {
            update new List<Case>(caseSetForUpdate);
        }
    }
}