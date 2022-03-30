@isTest(isParallel=true)
public class AccountControllerTest {
    
    @testSetup static void setupCommonData(){

        //setup test data factory methods but not doing it for this code
        
        List<Account> accounts = new List<Account>();
        Account account1 = new Account();
        account1.Name = 'Test1';
        account1.Industry = 'Consulting';
        accounts.Add(account1);

        Account account2 = new Account();
        account2.Name = 'Test2';
        accounts.Add(account2);

        Insert accounts;
    }

    @isTest static void GetAccountsTest(){
    	
        Test.startTest();
        
        List<Account> accounts = AccountController.getAccounts();

        System.assertEquals(accounts.size(), 2, 'Total accounts count match');

        Test.stopTest();
	}

    @isTest static void GetAccountTest(){
    	
        Test.startTest();

        Account account = [select Id, Industry From Account Where Name = 'Test1' LIMIT 1];
        
        Account queriedAccount = AccountController.getAccount(account.Id);

        System.assertEquals(queriedAccount.Industry, account.Industry, 'Industry field match');

        Test.stopTest();
	}

}
