@isTest
private class UnitOfWorkTest {

    @IsTest
    static void challengeComplete() {

        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
                new Schema.SObjectType[]{
                        Account.SObjectType,
                        Contact.SObjectType,
                        Note.SObjectType
                });

        List<Account> accounts = new List<Account>();
        List<Contact> contacts = new List<Contact>();
        List<Note> notes = new List<Note>();

        for (Integer i = 0; i < 100; i++) {
            Account testAccount = new Account(Name = 'Test account ' + i);
            accounts.add(testAccount);

            for (Integer j = 0; j < 5; j++) {
                Contact testContact = new Contact(LastName = 'Contact lastname ' + i);
                contacts.add(testContact);
                uow.registerRelationship(testContact, Contact.AccountId, testAccount);

                Note testNote = new Note(Title = 'Note title ' + i + '-' + j, Body = 'Test note body');
                notes.add(testNote);
                uow.registerRelationship(testNote, Note.ParentId, testAccount);
            }
        }

        uow.registerNew(accounts);
        uow.registerNew(contacts);
        uow.registerNew(notes);

        uow.commitWork();

        System.assertEquals(100, [SELECT Id FROM Account].size());
        System.assertEquals(500, [SELECT Id FROM Contact].size());
        System.assertEquals(500, [SELECT Id FROM Note].size());
    }
}

