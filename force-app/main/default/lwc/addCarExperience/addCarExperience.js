import { LightningElement, api,track } from 'lwc';
    import { createRecord } from 'lightning/uiRecordApi';
    import { ShowToastEvent } from 'lightning/platformShowToastEvent';

    import NAME_FIELD from '@salesforce/schema/Car_Experience__c.Name';
    import EXPERIENCE_FIELD from '@salesforce/schema/Car_Experience__c.Experience__c';
    import CAR_FIELD from '@salesforce/schema/Car_Experience__c.Car__c';

    import EXPERIENCE_OBJECT from '@salesforce/schema/Car_Experience__c'
    export default class AddCarExperience extends LightningElement {

        @api carId;
         @track expText= {expOne:'', expTwo: ''};
    
        onChangeExp(event)
        {   
            //debugger;
             this.expText[event.target.name] = event.target.value;
        }
    
        handleClick()
        {
            const fields = {};
            fields[NAME_FIELD.fieldApiName] = this.expText.expOne;
            fields[EXPERIENCE_FIELD.fieldApiName] = this.expText.expTwo;
            fields[CAR_FIELD.fieldApiName] = this.carId;
    
            const recordInput = {apiName : EXPERIENCE_OBJECT.objectApiName,
                                fields};
    
            createRecord(recordInput).then(result => {
                this.showToast('Success', 'Experience Record Updated', 'success');
            })
            .catch(error => {
                this.showToast('Error', error, 'error');
            })
    
        }
    
        showToast(title, message, variant) {
            const evt = new ShowToastEvent({
                title: title,
                message: message,
                variant: variant,
            });
            this.dispatchEvent(evt);
        } 


    }