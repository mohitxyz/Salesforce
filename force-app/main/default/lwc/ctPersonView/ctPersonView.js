import { LightningElement, track } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { reduceErrors } from "c/ldsUtils";
import getPersonViewHeader from '@salesforce/apex/CTPersonViewController.getPersonViewHeader';
import getLocationViewHeader from '@salesforce/apex/CTPersonViewController.getLocationViewHeader';

import PERSON_OBJECT from "@salesforce/schema/Person__c";
import LOCATION_OBJECT from "@salesforce/schema/Location__c";

import PERSON_NAME_FIELD from "@salesforce/schema/Person__c.Name";
import PERSON_STAT_DATE_FIELD from "@salesforce/schema/Person__c.Status_Update_Date__c";
import PERSON_MOBILE_FIELD from "@salesforce/schema/Person__c.Mobile__c";
import LOCATION_NAME_FIELD from "@salesforce/schema/Location__c.Name";
import LOCATION_STATE_FIELD from "@salesforce/schema/Location__c.State__c";


export default class CtPersonView extends LightningElement  {

    cardTitle = 'Person View';
    person = false;
    location = false;
    showModal = false;
    @track inputObject = { name1: '', statusDate: '', mobile: '', name2: '', status: '' };
    @track colorObject = { Red: '', Green: '', Yellow: '', Orange:''};
    
    connectedCallback()
    {
            getPersonViewHeader()
            .then(result => {
                    this.colorObject.Red = result.Red;
                    this.colorObject.Green = result.Green;
                    this.colorObject.Yellow = result.Yellow;
                    this.colorObject.Orange = result.Orange;
            })
            .catch(error => {
                console.log('Errorured:- '+error.body.message);
            });
    }
    
    get Red()
    {
        if (this.colorObject.Red == null) {
            return 0;
        }
        else
            return this.colorObject.Red;
    }
    get Green()
    {
        if (this.colorObject.Green == null) {
            return 0;
        }
        else
            return this.colorObject.Green;
    }
    get Yellow()
    {
        if (this.colorObject.Yellow == null) {
            return 0;
        }
        else
            return this.colorObject.Yellow;
    }
    get Orange()
    {
        if (this.colorObject.Orange == null) {
            return 0;
        }
        else
            return this.colorObject.Orange;
    }

   onHideClickSalesforce(){
       this.showAccounts = false;
   }
    
    inputChangeHandler(event)
    {
        if(event.target.name == 'name1')
        {
            this.inputObject.name1 = event.target.value;
        }
        if(event.target.name == 'statusDate')
        {
            this.inputObject.statusDate = event.target.value;
        }
        if(event.target.name == 'mobile')
        {
            this.inputObject.mobile = event.target.value;
        }
        if(event.target.name == 'name2')
        {
            this.inputObject.name2 = event.target.value;
        }
        if(event.target.name == 'status')
        {
            this.inputObject.status = event.target.value;
        }

    }

    changeView(event)
    {
       // confirm('1.1');
        this.cardTitle = event.detail.viewName;

        if (this.cardTitle == 'Person View')
        {
            this.person = true;
            this.location = false;

            getPersonViewHeader()
            .then(result => {
                    this.colorObject.Red = result.Red;
                    this.colorObject.Green = result.Green;
                    this.colorObject.Yellow = result.Yellow;
                    this.colorObject.Orange = result.Orange;
            })
            .catch(error => {
                console.log('Errorured:- '+error.body.message);
            });
        }
        else if (this.cardTitle == 'Location View')
        {
            this.location = true;
            this.person = false;

             getLocationViewHeader()
            .then(result => {
                    this.colorObject.Red = result.Red;
                    this.colorObject.Green = result.Green;
                    this.colorObject.Yellow = result.Yellow;
                    this.colorObject.Orange = result.Orange;
            })
            .catch(error => {
                console.log('Errorured:- '+error.body.message);
            });
        }
    }

    closeModal()
    {
        this.showModal = false;
    }

    handleClick()
    {
        this.showModal = true;
    }

    submitDetails()
    {
        let fields = {};
        let recordInput = {};

        if (this.cardTitle == 'Person View')
        {
            fields[PERSON_NAME_FIELD.fieldApiName] = this.inputObject.name1;
            fields[PERSON_STAT_DATE_FIELD.fieldApiName] = this.inputObject.statusDate;
            fields[PERSON_MOBILE_FIELD.fieldApiName] = this.inputObject.mobile;
            
           // confirm('1.5 = ' + this.inputObject.name1 +','+ this.inputObject.statusDate );
              //4. Prepare config object with object and field API names 
              recordInput = {
                   apiName: PERSON_OBJECT.objectApiName,
                   fields: fields
             };
        }
        else if(this.cardTitle == 'Location View')
        {
            fields[LOCATION_NAME_FIELD.fieldApiName] = this.inputObject.name2;
            fields[LOCATION_STATE_FIELD.fieldApiName] = this.inputObject.status;
        
              //4. Prepare config object with object and field API names 
              recordInput = {
                   apiName: LOCATION_OBJECT.objectApiName,
                   fields: fields
             };
        }

       // confirm('1.4  ');

        createRecord(recordInput).then(response => {

            this.dispatchEvent(
                    new ShowToastEvent({
                        title: "Success",
                        message: "Record created successfully!",
                        variant: "success"
                    })
            );
            
            // confirm('Record created with Id: ' +response.id);
            // alert('Record created with Id: ' + response.id);
             
        }).catch(error => {

            this.dispatchEvent(
                    new ShowToastEvent({
                        title: "Error creating record",
                        message: reduceErrors(error).join(", "),
                        variant: "error"
                    })
                );

            //confirm('Error: ' +JSON.stringify(error));
        })
        .finally(() => {
                this.showModal = false;
            });

    }

}