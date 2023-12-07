import { LightningElement,track} from 'lwc';
import { createRecord, getRecord } from 'lightning/uiRecordApi';
//import { NavigationMixin } from 'lightning/navigation';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class AccountLds extends NavigationMixin(LightningElement) {

    @track accountRec={accountName: '', accountPhone: '', website: ''};

    changeHandler(event)
    {
        this.accountRec[event.target.name] = event.target.value;
    }

    createAccount()
    {
        debugger;
        const fields = {'Name' : this.accountRec.accountName,
                        'Phone' : this.accountRec.accountPhone,
                        'Website': this.accountRec.website };

        const recordInput = {apiName: 'Account' , fields};
        console.log('1.1');
        createRecord(recordInput)
                     .then(data => {
                        console.log('account rec inserted ' + data.id);
                       /* const toastSuccess = new ShowToastEvent({
                            title : 'Account Added',
                            message : data.id + ' has been added',
                            variant : 'Success'
                        }); */

                        //this.dispatchEvent(toastSuccess);

                        this[NavigationMixin.Navigate] ({
                            type: 'standard__recordPage',
                            attributes: {
                                actionName : 'view',
                                recordId : data.id
                            }
                        });

                     })
                     .catch(error=> {
                        console.log('account insert failed ' + error.body.message);
                     });

                     console.log('1.2');
    }
}