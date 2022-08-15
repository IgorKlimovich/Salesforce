public class CaseSolutionManager {
    
    public static Boolean firstCall=false;

    public static Map<Id, Case> getCaseWithCaseSolutions(Set<Id> caseIds){
        return new Map<Id,Case>([SELECT id,(SELECT id FROM Case_Solutions__r) FROM Case WHERE id IN: caseIds]);
    }

    public static Set<Id> getSetId(List<Case_Solution__c>  caseSolutionsNew){
        Set<Id> caseIds = new Set<Id>();
        for (Case_Solution__c cs: caseSolutionsNew) {
            caseIds.add(cs.Case__c);
        }
        return caseIds;
    }

    public static List<Case> getCaseForUpdate(Case caseForUpdate, List<Case> cases){
        caseForUpdate.Status = CaseSolutionConstants.RESOLVED;
        if(!cases.contains(caseForUpdate)){
            cases.add(caseForUpdate);
        }
        return cases;
    }

    public static List<Case_Solution__c> getCaseSolutionListForUpdate(List<Case_Solution__c> caseSolutions, 
            Case_Solution__c caseSolution, List<Case_Solution__c> caseSolutionListForUpdate){

        for(Case_Solution__c casSol: caseSolutions){
            if (casSol.id != caseSolution.id) {
                casSol.Solution_Results__c = CaseSolutionConstants.CANCELLED;
                if(!caseSolutionListForUpdate.contains(casSol)){
                caseSolutionListForUpdate.add(casSol);
                }
            }
        }
        return caseSolutionListForUpdate;
    }
}