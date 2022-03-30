public with sharing class AccountController {
    

    @AuraEnabled(Cacheable=true)
    public static List<Account> getAccounts(){

        return [SELECT Id, Name FROM Account LIMIT 5];
    }

    @AuraEnabled(Cacheable=true)
    public static Account getAccount(Id accountId){

        return  [SELECT Id, Name, Industry, Type, Owner.Name, Owner.SmallPhotoUrl FROM Account Where Id =: accountId];
    }
}
