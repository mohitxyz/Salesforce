import { LightningElement, track, wire } from 'lwc';
import getCarTypes from '@salesforce/apex/CarSearchFormController.getCarTypes';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import {  NavigationMixin } from 'lightning/navigation';

export default class CarSearchForm extends NavigationMixin(LightningElement) {

    @track carTypes;// = [{value:'', label:'All Types'}];          //array of object with label, value
    prop = 'dfd';


    
    @wire(getCarTypes) wiredCarType({data,error})
    {
      // debugger;
        console.log('1.1 ' , data, error);
        if(data)
        {    
            this.carTypes = [{value:'', label:'All Types'}];            // very important   
            //this.carTypes = []; 
            data.forEach((rec) => {
                const carType = {};
                carType.label = rec.Name;
                carType.value = rec.Id;
                console.log('1.3', carType.label + ',' + carType.value );

                this.carTypes.push(carType);
                
            });

            console.log('1.2 ' + ',' + JSON.stringify(this.carTypes) + ',' + this.carTypes.length);

            
        }
        else if(error)
        {
            this.showToast('Custom Error', error.body.message, 'Error');
        }
    };

    
    showToast(title, message, variant)
    { 
        const toast = new ShowToastEvent({ 
            title: title,
            message : message,
            variant : variant
         });
        this.dispatchEvent(toast);
    }

    handleComboChange(event)
    {

        console.log('OUTPUT : ', this.prop);

        const carTypeId = event.detail.value;
        console.log('1.6 : ', carTypeId);
        const carSelectionEvt = new CustomEvent('cartypeselected', {detail: carTypeId}); 
        this.dispatchEvent(carSelectionEvt);
    }

    createNewCarType()
    {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            atrributes:{
                objectApiName : 'Car_Type__c',
                actionName : 'new'
            }
        })
    }

    connectedCallback()
    {
        console.log('OUTPUT : connectedCallback - carSearchForm',);
    }

    renderedCallback()
    {
        console.log('OUTPUT : renderedCallback - carSearchForm',);
    }

}