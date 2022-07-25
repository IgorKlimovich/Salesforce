@isTest
public class TestDataFactoryCaseDuplicateController {

    public static List<Case> createCases(Integer numCases, String statusName, String subjectName,
    String reasonName, String suppliedEmailName){
        List<Case> testCases = new List<Case>();
        for(Integer i=0; i<numCases; i++) {
            Case casse = new Case(Status=statusName, Subject=subjectName,Reason=reasonName, SuppliedEmail=suppliedEmailName);
            testCases.add(casse);
        }
        insert testCases;
        return testCases;
    }
}