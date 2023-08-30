@isTest
private class CaseServiceTest {

    @isTest 
    static void testCloseCases() {
        Case testCase = new Case();
        insert testCase;

        Test.startTest();
        Set<Id> caseIds = new Set<Id>{testCase.Id};
        String closeReason = 'Test close reason';
        CaseService.closeCases(caseIds, closeReason);
        Test.stopTest();

        Case updatedCase = [SELECT Status, Reason FROM Case WHERE Id = :testCase.Id];

        Assert.areEqual(CaseService.CLOSED_STATUS, updatedCase.Status, 'Case status should be Closed');
        Assert.areEqual(closeReason, updatedCase.Reason, 'Close reason should match');
    }
}