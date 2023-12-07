import { LightningElement, track, wire } from 'lwc';
import getRecentPerson from '@salesforce/apex/CTPersonLocationTabController.getRecentPerson';
import getRecentLocation from '@salesforce/apex/CTPersonLocationTabController.getRecentLocation';
import searchPerson from '@salesforce/apex/CTPersonLocationTabController.searchPerson';
import searchLocation from '@salesforce/apex/CTPersonLocationTabController.searchLocation';
import { CurrentPageReference } from 'lightning/navigation';

import { fireEvent } from 'c/pubsub';

const actions = [
    { label: 'View', name: 'view' },
    { label: 'Update', name: 'update' },
];

const PersonColumns = [
{ label: 'Name', fieldName: 'Name' },
{ label: 'Phone', fieldName: 'Mobile__c', type: 'text' },
{ label: 'Token', fieldName: 'Token__c', type: 'text' },
{ label: 'Health Status', fieldName: 'Health_Status__c', type: 'text' },
{ label: 'Status Update Date', fieldName: 'Status_Update_Date__c', type: 'date' },
{
        type: 'action',
        typeAttributes: { rowActions: actions },
    },
];

const LocationColumns = [
{ label: 'Name', fieldName: 'Name' },
{ label: 'Status', fieldName: 'Status__c', type: 'phone' },
{ label: 'Red Score', fieldName: 'Red_Score__c', type: 'text' },
{ label: 'Pin Code', fieldName: 'Pincode__c', type: 'text' },
{ label: 'Address', fieldName: 'Address__c', type: 'text' },
{ label: 'Status Update Date', fieldName: 'Status_Update_Date__c', type: 'date' },
{
        type: 'action',
        typeAttributes: { rowActions: actions },
    },
];

export default class CtPersonLocationTab extends LightningElement {

    activeTab;
    @track data = [{}];

    @track columns;
    searchKey;

    @wire(CurrentPageReference) pageRef;

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        switch (actionName) {
            case 'view':
                this.viewUpdateToRed(row);
                break;
            case 'update':
                this.doUpdateToRed(row);
                break;
            
        }
    }

    viewUpdateToRed(row)
    {
        console.log('1.1 = ' + JSON.stringify(row));
        let payload = {tableRecord: row};
        fireEvent(this.pageRef, 'viewRecord', payload);
    }

    doUpdateToRed(row)
    {

    }

    connectedCallback() { 
      // debugger;
        this.columns = PersonColumns;

        getRecentPerson()
            .then(result => {
               
                this.data = result;
                 console.log('1.1 = ' + result);
            })
            .catch(error => {
                console.log('Errorured:- '+error.body.message);
            });
    }

    searchHandler(event)
    {
        this.searchKey = event.target.value;

        if(this.searchKey != null && this.searchKey != '' )
        {
            if (this.activeTab == 'Person View')
            {
                searchPerson({searchTerm: this.searchKey})
                .then(result => {
                    this.data = result;
                })
                .catch(error => {
                    console.log('Errorured:- '+error.body.message);
                });
            }
            else if(this.activeTab == 'Location View')
            {
                searchLocation({searchTerm: this.searchKey})
                .then(result => {
                    this.data = result;
                })
                .catch(error => {
                    console.log('Errorured:- '+error.body.message);
                });
            }  
        }
        else
        {
            this.reloadDataTable(this.activeTab);
        }
    }

    handleTabChange(event)
    {
       // confirm('1.2');
        this.activeTab = event.target.value;
       // confirm('1.3');

        const evt = new CustomEvent('changeview', { detail: { viewName: this.activeTab } });
       //confirm('1.4');
        this.dispatchEvent(evt);
       // confirm('1.5');
        this.reloadDataTable(this.activeTab);
    }

    reloadDataTable(tab)
    {
        if(tab == 'Person View')
        {
            this.columns = PersonColumns;

            getRecentPerson()
            .then(result => {
                this.data = result;
            })
            .catch(error => {
                console.log('Errorured:- '+error.body.message);
            });
        }
        if(tab == 'Location View')
        {
            this.columns = LocationColumns; 

            getRecentLocation()
            .then(result => {
                this.data = result;
            })
            .catch(error => {
                console.log('Errorured:- '+error.body.message);
            });
        }
    }


}