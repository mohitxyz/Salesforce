import { LightningElement,api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class CarDetail extends NavigationMixin(LightningElement) {

    @api car;

    fullDetailsHandler()
    {
        console.log('fullDetails : ', this.car.data.fields.Id.value);

        this[NavigationMixin.Navigate]({
            type:"standard__recordPage",
            attributes :{
                recordId : this.car.data.fields.Id.value,
                objectApiName : "Car__c",
                actionName : "view"
            }
        })
    }

    get carName()
    {
        return this.car.data.fields.Name.value;
    }

    get perDayRent()
    {
        return this.car.data.fields.Per_Day_Rent__c.value;
    }

    get image()
    {
        return this.car.data.fields.Picture__c.value;
    }

}