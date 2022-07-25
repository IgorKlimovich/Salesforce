@isTest
public class TestCaseDuplicateController {
    
    @isTest
    public static void testOneCaseWithSameId(){
        List<Case> testCases = TestDataFactoryCaseDuplicateController.createCases(1,'New','','','');
        Test.startTest();
        List<Case> casesFromController =CaseDuplicateController.getDuplicatesCases(testCases[0].id);
        Test.stopTest();
        System.assertEquals(0,casesFromController.size());
    }

    @isTest
    public static void testManyCasesNotClosed(){
        List<Case> testCases = TestDataFactoryCaseDuplicateController.createCases(200,'New','','','');
        Test.startTest();
        Case testCase = testCases[0];
        List<Case> casesFromController =CaseDuplicateController.getDuplicatesCases(testCase.id);
        Test.stopTest();
        System.assertEquals(0,casesFromController.size());
    }

    @isTest
    public static void testManyCasesClosed(){
        List<Case> testCases = TestDataFactoryCaseDuplicateController.createCases(200,'Closed','','','');
        Test.startTest();
        List<Case> casesFromController =CaseDuplicateController.getDuplicatesCases(testCases[0].id);
        Test.stopTest();
        System.assertEquals(0,casesFromController.size());
    }

    @isTest
    public static void testManyCasesNotClosedSameSubject(){
        List<Case> testCases = TestDataFactoryCaseDuplicateController.createCases(200,'New','Test','','');
        Test.startTest();
        Case testCase = testCases[0];
        List<Case> casesFromController =CaseDuplicateController.getDuplicatesCases(testCase.id);
        Test.stopTest();
        System.assertEquals(199,casesFromController.size());
    }

    @isTest
    public static void testManyCasesClosedSameSubject(){
        List<Case> testCases = TestDataFactoryCaseDuplicateController.createCases(200,'Closed','Test','','');
        Test.startTest();
        Case testCase = testCases[0];
        List<Case> casesFromController =CaseDuplicateController.getDuplicatesCases(testCase.id);
        Test.stopTest();
        System.assertEquals(0,casesFromController.size());
    }

    @isTest
    public static void testManyCasesNotClosedSameReasonName(){
        List<Case> testCases = TestDataFactoryCaseDuplicateController.createCases(200,'New','','Test','');
        Test.startTest();
        Case testCase = testCases[0];
        List<Case> casesFromController =CaseDuplicateController.getDuplicatesCases(testCase.id);
        Test.stopTest();
        System.assertEquals(199,casesFromController.size());
    }

    @isTest
    public static void testManyCasesClosedSameReasonName(){
        List<Case> testCases = TestDataFactoryCaseDuplicateController.createCases(200,'Closed','','Test','');
        Test.startTest();
        Case testCase = testCases[0];
        List<Case> casesFromController =CaseDuplicateController.getDuplicatesCases(testCase.id);
        Test.stopTest();
        System.assertEquals(0,casesFromController.size());
    }


    @isTest
    public static void testManyCasesNotClosedSameSuppliedEmail(){
        List<Case> testCases = TestDataFactoryCaseDuplicateController.createCases(200,'New','','','Test@gmail.com');
        Test.startTest();
        Case testCase = testCases[0];
        List<Case> casesFromController =CaseDuplicateController.getDuplicatesCases(testCase.id);
        Test.stopTest();
        System.assertEquals(199,casesFromController.size());
    }

    @isTest
    public static void testManyCasesClosedSameSuppliedEmail(){
        List<Case> testCases = TestDataFactoryCaseDuplicateController.createCases(200,'Closed','','','Test@gmail.com');
        Test.startTest();
        Case testCase = testCases[0];
        List<Case> casesFromController =CaseDuplicateController.getDuplicatesCases(testCase.id);
        Test.stopTest();
        System.assertEquals(0,casesFromController.size());
    }
}