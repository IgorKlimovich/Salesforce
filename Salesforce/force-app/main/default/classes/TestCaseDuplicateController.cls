@isTest
public class TestCaseDuplicateController {

    @isTest
    public static void testNull(){
        Boolean exceptionOccurred = false;
        try {
        Test.startTest();
        List<Case> casesFromController =CaseDuplicateController.getDuplicatesCases(null);
        Test.stopTest();   
        } catch (AuraHandledException ex) {
            exceptionOccurred = true;
        }
        System.assert(exceptionOccurred);
    }

    @isTest
    public static void testCasesClosedSameSuppliedEmail(){
        List<Case> testCases = TestDataFactoryCaseDuplicateController.createCases
        (3,CaseDuplicatesControllerConstants.CLOSED_STATUS, CaseDuplicatesControllerConstants.TEST_EMAIL);
        Test.startTest();
        Case testCase = testCases[0];
        List<Case> casesFromController =CaseDuplicateController.getDuplicatesCases(testCase.id);
        Test.stopTest();
        System.assertEquals(0,casesFromController.size());
    }

    @isTest
    public static void testCasesOpenSameSuppliedEmail(){
        List<Case> testCases = TestDataFactoryCaseDuplicateController.createCases
        (3, CaseDuplicatesControllerConstants.NEW_STATUS, CaseDuplicatesControllerConstants.TEST_EMAIL);
        Test.startTest();
        Case testCase = testCases[0];
        List<Case> casesFromController =CaseDuplicateController.getDuplicatesCases(testCase.id);
        Test.stopTest();
        System.assertEquals(2,casesFromController.size());
        for(Case casse: casesFromController){
            System.assertEquals(testCase.SuppliedEmail, casse.SuppliedEmail);
        }
    }
}
