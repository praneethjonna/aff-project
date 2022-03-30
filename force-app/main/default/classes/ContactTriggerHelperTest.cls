//Test class for ContactTriggerHelper class methods
@isTest(isParallel=true)
public  class ContactTriggerHelperTest {
    

    @testSetup static void setupCommonData(){

        //setup test data factory methods but not doing it for this code
        
        List<Account> accounts = new List<Account>();
        Account account1 = new Account();
        account1.Name = 'Test1_WithIndustry';
        account1.Industry = 'Consulting';
        accounts.Add(account1);

        Account account2 = new Account();
        account2.Name = 'Test2_WithOutIndustry';
        accounts.Add(account2);

        Insert accounts;

        List<Contact> contacts = new List<Contact>();
        Contact contact1 = new Contact();
        contact1.AccountId = account1.Id;
        contact1.LastName = 'Test1ValidIndustry';
        contacts.add(contact1);
        
        Contact contact2 = new Contact();
        contact2.AccountId = account2.Id;
        contact2.LastName = 'Test2BlankIndustry';
        contacts.Add(contact2);

        Contact contact3 = new Contact();
        contact3.LastName = 'NoAccount';
        contacts.Add(contact3);

        Insert contacts;

    }

    @isTest static void DefaultsFromAccount_ContactInsert_WithValidIndustry(){
    	
        Test.startTest();
        
        Account accountWithIndustry = [select Id, Industry From Account Where Name = 'Test1_WithIndustry' LIMIT 1];

        Contact testContact = new Contact();
        testContact.LastName = 'InsertTestContact';
        testContact.AccountId = accountWithIndustry.Id;
        insert testContact;

        Contact actualContact = [Select Id, AccountId, Account_Industry__c FROM Contact Where LastName = 'InsertTestContact' LIMIT 1];

        System.assertEquals(accountWithIndustry.Industry, actualContact.Account_Industry__c, 'Match Account Industry');

        Test.stopTest();
	}

    @isTest static void DefaultsFromAccount_ContactUpdate_WithValidIndustry(){
    	
        Test.startTest();

        Contact testContact = [Select Id, AccountId, Account_Industry__c FROM Contact Where LastName = 'Test2BlankIndustry' LIMIT 1];
        Account accountWithIndustry = [select Id, Industry From Account Where Name = 'Test1_WithIndustry' LIMIT 1];
        testContact.AccountId = accountWithIndustry.Id;
        update testContact;

        Contact actualContact = [Select Id, AccountId, Account_Industry__c FROM Contact Where LastName = 'Test2BlankIndustry' LIMIT 1];

        System.assertEquals(accountWithIndustry.Industry, actualContact.Account_Industry__c, 'Match Account Industry');

        Test.stopTest();
	}

    @isTest static void DefaultsFromAccount_ContactUpdate_WithNullIndustry(){
    	
        Test.startTest();

        Contact testContact = [Select Id, AccountId, Account_Industry__c FROM Contact Where LastName = 'Test2BlankIndustry' LIMIT 1];
        Account accountWithIndustry = [select Id, Industry From Account Where Name = 'Test2_WithOutIndustry' LIMIT 1];
        testContact.AccountId = accountWithIndustry.Id;
        update testContact;

        Contact actualContact = [Select Id, AccountId, Account_Industry__c FROM Contact Where LastName = 'Test2BlankIndustry' LIMIT 1];

        System.assertEquals(null, actualContact.Account_Industry__c, 'Match Account Industry with null');

        Test.stopTest();
	}

    @isTest static void DefaultsFromAccount_ContactUpdate_WithNoAccount(){
    	
        Test.startTest();

        Contact testContact = [Select Id, AccountId, Account_Industry__c FROM Contact Where LastName = 'Test2BlankIndustry' LIMIT 1];
        Account accountWithIndustry = [select Id, Industry From Account Where Name = 'Test2_WithOutIndustry' LIMIT 1];
        testContact.AccountId = accountWithIndustry.Id;
        update testContact;

        Contact actualContact = [Select Id, AccountId, Account_Industry__c FROM Contact Where LastName = 'Test2BlankIndustry' LIMIT 1];

        System.assertEquals(null, actualContact.Account_Industry__c, 'Match Account Industry with null');

        Test.stopTest();
	}
}
