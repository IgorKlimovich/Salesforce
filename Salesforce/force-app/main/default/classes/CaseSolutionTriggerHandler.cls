public class CaseSolutionTriggerHandler {

    public static void afterUpdateCaseSolutionHandler(List<Case_Solution__c> caseSolutionsNew,
    Map<Id,Case_Solution__c> caseSolutionOldMap){
        
        Set<Case_Solution__c> caseSolutionSetForUpdate = new Set<Case_Solution__c>();
        Set<Case> caseSetForUpdate  = new Set<Case>();
        Set<Id> caseIds= new Set<Id>();
        for (Case_Solution__c cs: caseSolutionsNew) {
            caseIds.add(cs.Case__c);
        }
        Map<Id,Case> caseWithCaseSolutions =
        new Map<Id,Case>([SELECT id,(SELECT id FROM Case_Solutions__r) FROM Case WHERE id IN: caseIds]);
        
        for(Case_Solution__c caseSolution : caseSolutionsNew){
            if(caseSolutionOldMap.get(caseSolution.id).Solution_Results__c!='Resolved via call' &&
            caseSolutionOldMap.get(caseSolution.id).Solution_Results__c!='Resolved in advance'  ) {
                if(caseSolution.Solution_Results__c=='Resolved via call'||caseSolution.Solution_Results__c=='Resolved in advance'){
                    Case caseForUpdate = caseWithCaseSolutions.get(caseSolution.Case__c);
                    caseForUpdate.Status='Resolved';
                    caseSetForUpdate.add(caseForUpdate);
                    List<Case_Solution__c> caseSolutions =caseForUpdate.Case_Solutions__r;
                    for(Case_Solution__c casSol: caseSolutions){
                        if (casSol.id!=caseSolution.id) {
                            casSol.Solution_Results__c='Cancelled';
                            caseSolutionSetForUpdate.add(casSol);   
                        }
                    }
                }
            }
        }
        if (caseSolutionSetForUpdate.size()>0) {
            update new List<Case_Solution__c>(caseSolutionSetForUpdate);
        }
        if (caseSetForUpdate.size()>0) {
            update new List<Case>(caseSetForUpdate);
        }
    }
}