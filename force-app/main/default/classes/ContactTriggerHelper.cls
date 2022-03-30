// This method holds all the contact triggers unit of works  
public without sharing class ContactTriggerHelper {
    public ContactTriggerHelper() {

    }

    //This method is used to update fields on contact that comes from account
    public void DefaultsFromAccount(List<Contact> newContacts){

        Set<Id> accountIds = new Set<Id>();

        for (Contact contact : newContacts) {
            
            if (contact.AccountId != null) {
                accountIds.add(contact.AccountId);
            }
            
        }

        if(accountIds.size() > 0){

            Map<Id, Account> mapAccounts = new Map<Id, Account>([Select Id, Industry from Account where id in: accountIds]);
            for (Contact contactObj : newContacts) {
                if (contactObj.AccountId != null) {
                    if (mapAccounts.containsKey(contactObj.AccountId)) {
                        contactObj.Account_Industry__c = mapAccounts.get(contactObj.AccountId).Industry;
                    }
                }
                else {
                    contactObj.Account_Industry__c = null;
                }
            }
        }
        else {
            for (Contact contactObj : newContacts) {
                contactObj.Account_Industry__c = null;
            }
        }

    }
}
