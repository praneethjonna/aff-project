import { LightningElement, wire, api } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';
import getAccount from '@salesforce/apex/AccountController.getAccount';


export default class AccountList extends LightningElement {  

    @api selectedAccount;
    @api selectedAccountId;
    @api loading = false;
    @api error;
    @api accounts;

    @wire(getAccounts) 
    wiredAccounts({error, data}) {
        this.loading = true;
        if (error) {
            this.loading = false;
            this.error = 'Unknown error';
            if (Array.isArray(error.body)) {
                this.error = error.body.map(e => e.message).join(', ');
            } else if (typeof error.body.message === 'string') {
                this.error = error.body.message;
            }
        } else if (data) {
            this.loading = false;
            this.accounts = data;
        }
    }

    renderedCallback() {
        
        if(this.selectedAccountId != null){
            let dataId = '[data-id="'+ this.selectedAccountId + '"]';
            if(this.template.querySelector(dataId) != null){
                this.template.querySelector(dataId).classList.add('slds-is-active');
                this.template.querySelector(dataId).classList.add('account-selected');
            }
            
        }
    }

    handleNextClick() {
   
        if(this.selectedAccountId === undefined){
            this.error = 'Please select one account before clicking on next!';
            return;
        } else {
            this.error = undefined;
        }

        this.loading = true;
        getAccount({recordId: this.selectedAccountId})
            .then(result => {
                this.selectedAccount = result;
                this.loading = false;
            })
            .catch(error => {
                console.log(error);
                this.error = error;
                this.loading = false;
            });
    }

    handleBackClick = event => {

        this.selectedAccount = null;
    }


    onItemSelected = event => {
        this.selectedAccountId = event.currentTarget.dataset.id
        let dataId = '[data-id="'+ this.selectedAccountId + '"]';

        const listItems = this.template.querySelectorAll('.slds-nav-vertical__item');
        listItems.forEach(item => {
            item.classList.remove('slds-is-active');
            item.classList.remove('account-selected');
        });
        
        console.log(this.template.querySelector(dataId));
        this.template.querySelector(dataId).classList.add('slds-is-active');
        this.template.querySelector(dataId).classList.add('account-selected');
    }

}