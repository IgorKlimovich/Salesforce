public with sharing class CaseDuplicateController {
    
    @AuraEnabled
    public static List<Case> getDuplicatesCases(Id caseId){
        Case currentCase=  [SELECT id, Subject, SuppliedEmail, Reason FROM Case WHERE id =:caseId LIMIT 1];
        List<Case> caseDuplicatesList = [SELECT Subject, CaseNumber,  SuppliedEmail, Reason, Status, Owner.name FROM Case
        WHERE status !='Closed' AND ((Subject=:currentCase.Subject AND subject !='') OR 
        (reason=:currentCase.Reason AND reason!='') OR (SuppliedEmail=:currentCase.SuppliedEmail 
        AND SuppliedEmail!='')) AND id!=:currentCase.id];
        return  caseDuplicatesList;
    }
}
