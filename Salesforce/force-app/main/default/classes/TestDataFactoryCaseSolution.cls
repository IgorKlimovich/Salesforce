@isTest
public class TestDataFactoryCaseSolution {

    public static List<Case_Solution__c> createCasesWithCaseSolutions(Integer numCases, Integer numCaseSolutions, 
    String caseStatus, String solutionType, String solutionResults){
        List<Case> testCases = new List<Case>();
        for(Integer i=0;i<numCases;i++) {
            Case casse = new Case(Status=caseStatus);
            testCases.add(casse);
        }
        insert testCases;
    
    List<Case_Solution__c> caseSolutions = new List<Case_Solution__c>();   
    for(Integer j=0;j<numCases;j++){
        Case cas = testCases[j];
        for(Integer k=0; k<numCaseSolutions;k++){
            caseSolutions.add
            (new Case_Solution__c(Case__c = cas.id, Solution_Type__c = solutionType, Solution_Results__c = solutionResults));
        }
    }
    insert caseSolutions;
    return caseSolutions;
    }

    public static List<Case_Solution__c> getCaseSolutions(Id caseSolutionId){
        return [SELECT Id, Solution_Results__c FROM Case_Solution__c WHERE id !=:caseSolutionId ];
    }

    public static Case getCase(Id caseId){
        return [SELECT ID, Status FROM Case WHERE id =:caseId ];
    }
}
