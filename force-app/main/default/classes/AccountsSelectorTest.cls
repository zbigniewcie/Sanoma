@isTest
private class AccountsSelectorTest {

    @isTest 
    static void testSelectById() {
        List<Account> testAccounts = new List<Account>();
        for(Integer i = 1; i <= 3; i++) {
            testAccounts.add(new Account(
                Name = 'Test Account ' + i,
                AnnualRevenue = 1000 * i
            ));
        }
        insert testAccounts;

        AccountsSelector selector = new AccountsSelector();
        List<Account> selectedAccounts = selector.selectById(new Set<Id>{testAccounts[0].Id, testAccounts[1].Id});

        Assert.areEqual(2, selectedAccounts.size(), 'Expected 2 accounts to be returned.');

        Account firstAccount = selectedAccounts[0];
        Assert.areEqual('Test Account 1', firstAccount.Name);
        Assert.areEqual('Domain classes rock!', firstAccount.Description); // Description is set in Accounts.onApplyDefaults
        Assert.areEqual(1000, firstAccount.AnnualRevenue);

        Account secondAccount = selectedAccounts[1];
        Assert.areEqual('Test Account 2', secondAccount.Name);
        Assert.areEqual('Domain classes rock!', secondAccount.Description);
        Assert.areEqual(2000, secondAccount.AnnualRevenue);
    }
}
