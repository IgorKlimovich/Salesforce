public with sharing class CaseDuplicateController {

    @AuraEnabled
    public static List<Case> getDuplicatesCases(Id caseId, List<String> options){
        List<Case> caseDuplicateList = new List<Case>();
        try {
            Case currentCase = CaseManager.getCurrentCase(caseId);
            caseDuplicateList = CaseManager.getCaseDuplicatesList(currentCase, options);
        } catch (Exception e) {        
            throw new AuraHandledException(e.getMessage());
        }
        return caseDuplicateList;
    }
}