import { LightningElement, wire } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { reduceErrors } from "c/ldsUtils";
import getPersonViewHeader from '@salesforce/apex/CTPersonViewController.getPersonViewHeader';
import getLocationViewHeader from '@salesforce/apex/CTPersonViewController.getLocationViewHeader';
import { registerListener, unregisterAllListeners } from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';

import PERSON_OBJECT from "@salesforce/schema/Person__c";
import LOCATION_OBJECT from "@salesforce/schema/Location__c";

import PERSON_NAME_FIELD from "@salesforce/schema/Person__c.Name";
import PERSON_STAT_DATE_FIELD from "@salesforce/schema/Person__c.Status_Update_Date__c";
import PERSON_MOBILE_FIELD from "@salesforce/schema/Person__c.Mobile__c";
import PERSON_HEALTH_STATUS from "@salesforce/schema/Person__c.Health_Status__c";

import LOCATION_NAME_FIELD from "@salesforce/schema/Location__c.Name";
import LOCATION_STATE_FIELD from "@salesforce/schema/Location__c.State__c";

export default class CtUpdateToRed extends LightningElement {

    fields = [PERSON_NAME_FIELD, PERSON_STAT_DATE_FIELD, PERSON_MOBILE_FIELD, PERSON_HEALTH_STATUS];    
    recordId;
    objectApiName = 'Person__c';
    @wire(CurrentPageReference) pageRef;

    connectedCallback()
    {
        registerListener('viewRecord', this.handleCallBack, this);
    }

    handleCallBack(payload)
    {
        console.log('1.2 = ' + JSON.stringify(payload));
        this.recordId = payload.tableRecord.Id;
    }


}