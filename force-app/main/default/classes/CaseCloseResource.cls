@RestResource(urlMapping='/case/*/close')
global class CaseCloseResource {
    
    @HttpPost
    global static void closeCase(String closeReason) {
        Id caseId = getCaseIdFromURI();
        
        if(caseId != null) {
            Set<Id> caseIds = new Set<Id>{caseId};
            try {
                CaseService.closeCases(caseIds, closeReason);
            } catch(Exception error) {
                RestContext.response.statusCode = 500;
                RestContext.response.responseBody = Blob.valueOf('Error closing the case: ' + error.getMessage());
            }
        } else {
            RestContext.response.statusCode = 400; // Bad Request
            RestContext.response.responseBody = Blob.valueOf('Invalid Case Id provided in the URL.');
        }
    }

    private static Id getCaseIdFromURI() {
        return RestContext.request.requestURI.substringBetween('/case/', '/close');
    }
}
