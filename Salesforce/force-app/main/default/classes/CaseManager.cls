public with sharing class CaseManager {

    public static Case getCurrentCase(Id caseId){
        return [SELECT id, Subject, SuppliedEmail, Reason FROM Case WHERE id =:caseId LIMIT 1];
    }

    public static List<Case> getCaseDuplicatesList(Case currentCase, List<String> options){
        Case casse = checkCaseOptions(currentCase, options);
        return  [SELECT Subject, CaseNumber,  SuppliedEmail, Reason, Status, Owner.name FROM Case
        WHERE Status !=:CaseConstants.CASE_STATUS_CLOSED AND ((Subject=:casse.Subject AND Subject!=null) OR 
        (Reason=:casse.Reason AND Reason!=null) OR (SuppliedEmail=:casse.SuppliedEmail and SuppliedEmail!=null)) AND id!=:casse.id]; 
    }

    public static Case checkCaseOptions(Case casse, List<String> options){
        if(!options.contains(CaseConstants.SUBJECT)){
            casse.Subject=null;
        }
        if(!options.contains(CaseConstants.REASON)){
            casse.Reason=null;
        }
        if(!options.contains(CaseConstants.SUPPLIED_EMAIL)){
            casse.SuppliedEmail=null;
        }
        return casse;
    }
}