import { LightningElement,wire,track, api} from 'lwc';
import { getRecord, createRecord, updateRecord, deleteRecord, getRecordUi, getFieldValue, getFieldDisplayValue, getRecordCreateDefaults, createRecordInputFilteredByEditedFields, generateRecordInputForCreate, generateRecordInputForUpdate } from 'lightning/uiRecordApi';
/* https://developer.salesforce.com/docs/component-library/documentation/en/lwc/lwc.reference_lightning_ui_api_record */
import CAR_ID from '@salesforce/schema/Car__c.Id';
import CAR_NAME from '@salesforce/schema/Car__c.Name';
import CAR_MILEAGE from '@salesforce/schema/Car__c.Mileage__c';
import CAR_PER_DAY_RENT from '@salesforce/schema/Car__c.Per_Day_Rent__c';
import CAR_BUILD_YEAR from '@salesforce/schema/Car__c.Build_Year__c';
import CAR_PICTURE from '@salesforce/schema/Car__c.Picture__c';
import CAR_CONTACT_NAME from '@salesforce/schema/Car__c.Contact__r.Name';
import CAR_CONTACT_EMAIL from '@salesforce/schema/Car__c.Contact__r.Email';
import CAR_CONTACT_PHONE from '@salesforce/schema/Car__c.Contact__r.HomePhone';
import CAR_CARTYPE_NAME from '@salesforce/schema/Car__c.Car_Type__r.Name';
import getExpId from '@salesforce/apex/CarSearchFormController.getExpId';

import {registerListener, unregisterAllListeners} from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';

const fields=[ CAR_ID,
    CAR_NAME,
    CAR_PER_DAY_RENT,
    CAR_BUILD_YEAR,
    CAR_PICTURE,
    CAR_CONTACT_NAME,
    CAR_CONTACT_EMAIL,
    CAR_CONTACT_PHONE,
    CAR_MILEAGE,
    CAR_CARTYPE_NAME];

export default class CarDetails extends LightningElement {

    carId;
    selectedTab;
    @wire(CurrentPageReference)
    pageRef;
    @track expCar ='';


    @wire(getRecord, {recordId: '$carId',
                      fields : fields })
    wiredUi;

    tabChangeHandler(event)
    {
        this.selectedTab = event.target.value;

        console.log('OUTPUT : carId ', this.carId);
    }

    connectedCallback()
    {
        console.log('connectedCallback : ',);
        try{
            console.log('try  : ', this.expCar);

            registerListener('carSelect', this.callBack, this);
        }
        catch(error)
        {
            console.log('Error  : ', error.body.message);
        }  
       
    }
 
    callBack(payload)
    {
        this.carId = payload;
        console.log('callBack ' + payload);
    }

    disconnectedCallback()
    {
        unregisterAllListeners(this);
    }

     
    get carFound()
    {
        if(this.wiredUi.data)
        return true;
        else return false;
    }
    
    renderedCallback()
    {
       /*getExpId({carId : this.carId})
        .then(data => {
            console.log('OUTPUT : expId ', data);
            this.expCar = data;
        })
        .catch(error => {
            console.log('OUTPUT : error ', error);
            this.expCar = '**';
        })  */
        console.log('renderedCallback');
    }

    get expId()
    {
       // debugger;                                          // getter is fired reactively as the property refereneced changes 
        console.log('OUTPUT  Getter : ',this.carId);
        getExpId({carId : this.carId})
        .then(data => {
            console.log('OUTPUT : expId ', data);
            this.expCar = data;
            
        })
        .catch(error => {
            console.log('OUTPUT : error ', error);
            this.expCar = '**';
        })    
        
        return this.expCar;
    }

    
}