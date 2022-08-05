public with sharing class CaseDuplicateController {

    @AuraEnabled
    public static List<Case> getDuplicatesCases(Id caseId){
        List<Case> caseDuplicateList = new List<Case>();
        try {
            Case currentCase = CaseDuplicateControllerManager.getCurrentCase(caseId);
            caseDuplicateList = CaseDuplicateControllerManager.getCaseDuplicatesList(currentCase);
        } catch (Exception e) {        
            throw new AuraHandledException(e.getMessage());
        }
        return caseDuplicateList;
    }
}
