public with sharing class CaseService {

    public static final String CLOSED_STATUS = 'Closed';

    public static void closeCases(Set<Id> caseIds, String closeReason) {
        List<Case> casesToUpdate = queryCases(caseIds);
        updateCaseStatusAndReason(casesToUpdate, closeReason);
    }

    private static List<Case> queryCases(Set<Id> caseIds) {
        return [SELECT Id, Status, Reason FROM Case WHERE Id IN :caseIds];
    }

    private static void updateCaseStatusAndReason(List<Case> casesToUpdate, String closeReason) {
        for(Case caseToUpdate : casesToUpdate) {
            caseToUpdate.Reason = closeReason;
            caseToUpdate.Status = CLOSED_STATUS;
        }

        try {
            update casesToUpdate;
        } catch(DmlException error) {
            System.debug('Error updating cases: ' + error.getMessage());
            throw error;
        }
    }
}
