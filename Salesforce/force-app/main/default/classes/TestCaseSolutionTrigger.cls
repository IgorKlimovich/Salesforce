@isTest
public class TestCaseSolutionTrigger {

    @isTest
    public static void testCaseSolutionNoAnswer(){
        List<Case_Solution__c> caseSolutions = 
        TestDataFactoryCaseSolution.createCasesWithCaseSolutions(1, 5,CaseSolutionConstants.NEW_STATUS, 
            CaseSolutionConstants.CALL, CaseSolutionConstants.CONSULTATION);
        Case_Solution__c caseSolutionForUpdate = caseSolutions[0];
        caseSolutionForUpdate.Solution_Results__c = CaseSolutionConstants.NO_ANSWER;
        Test.startTest(); 
        Database.SaveResult result =  Database.update(caseSolutionForUpdate);
        Test.stopTest();
        System.assert(result.isSuccess());
        List<Case_Solution__c> listAfterUpdate = TestDataFactoryCaseSolution.getCaseSolutions(caseSolutionForUpdate.id);
        Case casse = TestDataFactoryCaseSolution.getCase(caseSolutionForUpdate.Case__c);
        System.assertEquals(CaseSolutionConstants.NEW_STATUS, casse.Status);
        for(Case_Solution__c caseSolution: listAfterUpdate){
            System.assertEquals(CaseSolutionConstants.CONSULTATION, caseSolution.Solution_Results__c);
        }
    }

    @isTest
    public static void testCaseSolutionResolvedViaCall(){
        List<Case_Solution__c> caseSolutions =
        TestDataFactoryCaseSolution.createCasesWithCaseSolutions(1, 5, CaseSolutionConstants.NEW_STATUS,
            CaseSolutionConstants.CALL, CaseSolutionConstants.CONSULTATION); 
        Case_Solution__c caseSolutionForUpdate = caseSolutions[0];
        caseSolutionForUpdate.Solution_Results__c = CaseSolutionConstants.RESOLVED_VIA_CALL;
        Test.startTest();
        Database.SaveResult result = Database.update(caseSolutionForUpdate);
        Test.stopTest();
        System.assert(result.isSuccess());
        List<Case_Solution__c> listAfterUpdate = TestDataFactoryCaseSolution.getCaseSolutions(caseSolutionForUpdate.id);
        Case casse = TestDataFactoryCaseSolution.getCase(caseSolutionForUpdate.Case__c);
        System.assertEquals(CaseSolutionConstants.RESOLVED, casse.Status);
        for(Case_Solution__c caseSolution: listAfterUpdate){
            System.assertEquals(CaseSolutionConstants.CANCELLED, caseSolution.Solution_Results__c);
        }
    }

    @isTest
    public static void testCaseSolutionResolvedInAdvance(){
        List<Case_Solution__c> caseSolutions =
        TestDataFactoryCaseSolution.createCasesWithCaseSolutions(1, 5, CaseSolutionConstants.NEW_STATUS,
            CaseSolutionConstants.EMAIL, CaseSolutionConstants.NEED_A_CHECK); 
        Case_Solution__c caseSolutionForUpdate = caseSolutions[0];
        caseSolutionForUpdate.Solution_Results__c = CaseSolutionConstants.RESOLVED_IN_ADVANCE;
        Test.startTest();
        Database.SaveResult result = Database.update(caseSolutionForUpdate);
        Test.stopTest();
        System.assert(result.isSuccess());
        List<Case_Solution__c> listAfterUpdate = TestDataFactoryCaseSolution.getCaseSolutions(caseSolutionForUpdate.id);
        Case casse = TestDataFactoryCaseSolution.getCase(caseSolutionForUpdate.Case__c);
        System.assertEquals(CaseSolutionConstants.RESOLVED, casse.Status);
        for(Case_Solution__c caseSolution: listAfterUpdate){
            System.assertEquals(CaseSolutionConstants.CANCELLED, caseSolution.Solution_Results__c);
        }
    }
}
