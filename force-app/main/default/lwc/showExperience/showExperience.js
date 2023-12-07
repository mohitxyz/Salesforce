import { LightningElement,api,wire,track  } from 'lwc';
import { getRecord,getFieldValue } from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Car_Experience__c.Name';
import EXPERIENCE_FIELD from '@salesforce/schema/Car_Experience__c.Experience__c';
import CAR_FIELD from '@salesforce/schema/Car_Experience__c.Car__c';
import EXPERIENCE_OBJECT from '@salesforce/schema/Car_Experience__c'



export default class ShowExperience extends LightningElement {

    @api experienceId;
    @track wiredCar = [] ; 


    @wire(getRecord, {
        recordId: '$experienceId',
        fields: [NAME_FIELD, EXPERIENCE_FIELD]
    }) 
    wiredRecords({data,error})
    {
        console.log('wiredRecords : ',);
        if(data)
        {
            //this.wiredCar = [{heading:'', description : ''}];
            this.wiredCar = [];
            console.log('success : ' , data);
            this.wiredCar.heading     = getFieldValue(data, NAME_FIELD);
            this.wiredCar.description = getFieldValue(data, EXPERIENCE_FIELD);
            
        }
        else if(error)
        {   console.log('error : ', error);

            console.log('error : ', error.body.message);

        }

    };

    renderedCallback()
    {
        console.log('renderedCallback : ',);
        console.log('renderedCallback : ', JSON.stringify(this.wiredCar), this.experienceId );
    }

    connectedCallback()
    {
        console.log('connectedCallback : ',  this.experienceId );
    }

    

}