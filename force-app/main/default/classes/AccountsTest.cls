@isTest
private class AccountsTest {

    @isTest 
    static void testOnApplyDefaults() {
        Account testAccount = new Account(Name='Test Account');

        Test.startTest();
        insert testAccount;
        Test.stopTest();

        Account testAccountAfterInsert = [SELECT Description FROM Account WHERE Id = :testAccount.Id];

        Assert.areEqual('Domain classes rock!', testAccountAfterInsert.Description, 'Description field was not set correctly on insert.');
    }

    @isTest 
    static void testBeforeUpdate() {
        Account testAccount = new Account(Name='Test Account', Description='Domain classes rock!');
        insert testAccount;

        testAccount.Description = 'Domain classes';

        Test.startTest();
        update testAccount;
        Test.stopTest();

        Account testAccountAfterUpdate = [SELECT AnnualRevenue FROM Account WHERE Id = :testAccount.Id];

        Assert.areEqual(6, testAccountAfterUpdate.AnnualRevenue, 'AnnualRevenue field was not set correctly on update.');
    }
}
