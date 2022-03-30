//This is a dispatcher class for all Contact Trigger helper methods
public without sharing class ContactTriggerHandler implements TriggerHandler  {
    
    private boolean triggerIsExecuting;
    private integer triggerSize;
    public ContactTriggerHelper helper;

    public ContactTriggerHandler(boolean triggerIsExecuting, integer triggerSize) {
        this.triggerIsExecuting = triggerIsExecuting;
        this.triggerSize = triggerSize;
        this.helper = new ContactTriggerHelper();
    }

    public void beforeInsert(List<Contact> newContacts) {
        helper.DefaultsFromAccount(newContacts);
    }
    public void beforeUpdate(List<Contact> oldContacts, List<Contact> newContacts, Map<ID, SObject> oldContactMap, Map<ID, SObject> newContactMap) {
        helper.DefaultsFromAccount(newContacts);
    }
    public void beforeDelete(List<Contact> oldContacts, Map<ID, SObject> oldContactMap) {

    }
    public void afterInsert(List<Contact> newContacts, Map<ID, SObject> newContactMap) {

    }
    public void afterUpdate(List<Contact> oldContacts, List<Contact> newContacts, Map<ID, SObject> oldContactMap, Map<ID, SObject> newContactMap) {

    }
    public void afterDelete(List<Contact> oldContacts, Map<ID, SObject> oldContactMap) {

    }
    public void afterUndelete(List<Contact> newContacts, Map<ID, SObject> newContactMap) {

    }
}