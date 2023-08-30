@isTest
private class CaseCloseResourceTest {

    @isTest
    static void testCloseCase() {
        Case testCase = new Case();
        insert testCase;

        Test.startTest();
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        req.requestURI = '/services/apexrest/case/' + testCase.Id + '/close';
        req.httpMethod = 'POST';
        req.addParameter('reason', 'Test close reason');

        RestContext.request = req;
        RestContext.response = res;

        CaseCloseResource.closeCase('Test close reason');
        Test.stopTest();

        Case updatedCase = [SELECT Status, Reason FROM Case WHERE Id = :testCase.Id];

        Assert.areEqual(CaseService.CLOSED_STATUS, updatedCase.Status, 'Case status should be Closed');
        Assert.areEqual('Test close reason', updatedCase.Reason, 'Close reason should match');
    }
}
