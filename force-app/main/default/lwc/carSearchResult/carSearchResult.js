import { LightningElement, api, wire, track } from 'lwc';
import getCars from '@salesforce/apex/CarSearchFormController.getCars';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CarSearchResult extends LightningElement {

    @api carTypeId ;
    @track cars;
    selectedCarId;
 
    renderedCallback()
    {
        console.log('1.7 : ', this.carTypeId);
    }

    connectedCallback()
    {
        console.log('OUTPUT : connectedCallback - carSearchResult',);
        console.log('1.8 : ', this.carTypeId);
    }

    renderedCallback()
    {
        console.log('OUTPUT : renderedCallback - carSearchResult',);
        console.log('1.8 : ', this.carTypeId);
    }
   

    @wire(getCars, {carId : '$carTypeId'}) 
    wiredCars({data, error})
    { 
           
        console.log('1.4', data, error, this.carTypeId);
        //debugger;
        if(data)
        {   
             this.cars=[];  
            this.cars = data;
            console.log('1.9 ' , JSON.stringify(this.cars));
        }
        else if(error){
            const evt = new ShowToastEvent('Custom error', error.body.message, 'Error');
            this.dispatchEvent(evt);
        }
    }


    get isAvailCars()
    {
        if(this.cars)
            return true;
        else
            return false ;
    }

    carSelectHandler(event)
    {
        this.selectedCarId = event.detail;
        console.log('OUTPUT : carSelectHandler ', this.selectedCarId);
    }

}