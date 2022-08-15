public class CaseSolutionTriggerHandler {

    public static void afterUpdateCaseSolutionHandler(List<Case_Solution__c> caseSolutionsNew,
    Map<Id,Case_Solution__c> caseSolutionOldMap){
        
        List<Case_Solution__c> caseSolutionListForUpdate = new List<Case_Solution__c>();
        List<Case> caseListForUpdate  = new List<Case>();
        Set<Id> caseIds = CaseSolutionManager.getSetId(caseSolutionsNew);
        Map<Id,Case> caseWithCaseSolutions = CaseSolutionManager.getCaseWithCaseSolutions(caseIds);
        for(Case_Solution__c caseSolution : caseSolutionsNew){
            if(caseSolutionOldMap.get(caseSolution.id).Solution_Results__c != caseSolution.Solution_Results__c ) {
                if(caseSolution.Solution_Results__c==CaseSolutionConstants.RESOLVED_VIA_CALL||
                caseSolution.Solution_Results__c==CaseSolutionConstants.RESOLVED_IN_ADVANCE){
                    Case caseForUpdate = caseWithCaseSolutions.get(caseSolution.Case__c);
                    CaseSolutionManager.getCaseForUpdate(caseForUpdate, caseListForUpdate);
                    CaseSolutionManager.getCaseSolutionListForUpdate(caseForUpdate.Case_Solutions__r,
                        caseSolution, caseSolutionListForUpdate);
                }
            }
        }
        if (caseSolutionListForUpdate.size() > 0) {
            update caseSolutionListForUpdate;
        }
        if (caseListForUpdate.size() > 0) {
            update caseListForUpdate;
        }
    }
}