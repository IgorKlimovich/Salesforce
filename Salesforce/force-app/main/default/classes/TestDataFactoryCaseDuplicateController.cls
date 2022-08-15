@isTest
public class TestDataFactoryCaseDuplicateController {

    public static List<Case> createCases(Integer numCases, String statusName, String suppliedEmailName){
        List<Case> testCases = new List<Case>();
        for(Integer i=0; i<numCases; i++) {
            Case casse = new Case(Status=statusName, SuppliedEmail=suppliedEmailName);
            testCases.add(casse);
        }
        insert testCases;
        return testCases;
    }

    public static List<String> getOptionsList(){
        return new List<String>();
    }

    public static List<String> getOptionsList(String option1){
        return new List<String>{option1};
    }

    public static List<String> getOptionsList(String option1, String option2){
        return new List<String>{option1,option2};
    }

    public static List<String> getOptionsList(String option1, String option2, String option3){
        return new List<String>{option1,option2, option3};
    }
}
