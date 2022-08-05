public class CaseDuplicateControllerManager {

    public static Case getCurrentCase(Id caseId){
        return [SELECT id, Subject, SuppliedEmail, Reason FROM Case WHERE id =:caseId LIMIT 1];
    }

    public static List<Case> getCaseDuplicatesList(Case currentCase){
        return  [SELECT Subject, CaseNumber,  SuppliedEmail, Reason, Status, Owner.name FROM Case
        WHERE Status !=:CaseDuplicatesControllerConstants.CASE_STATUS_CLOSED AND (Subject=:currentCase.Subject  OR 
        Reason=:currentCase.Reason  OR SuppliedEmail=:currentCase.SuppliedEmail) AND id!=:currentCase.id];
    }
}
