import { LightningElement,api, wire } from 'lwc';
import  {fireEvent}  from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';

export default class CarTile extends LightningElement {

    @wire(CurrentPageReference)
    pageRef;

    @api car;

    connectedCallback()
    {
        console.log('connectedCallback : carTile', this.car.Id);
    }
    renderedCallback()
    {
        console.log('renderedCallback : carTile', this.car.Id);
    }

    handleCarSelect(event)
    {
        console.log('OUTPUT 1.1 handleCarSelect : ', this.car.Id);
        event.preventDefault();  //

        const carId = this.car.id;

        const carSelect = new CustomEvent('carSelect', {
            detail: carId
        });
        console.log('OUTPUT 1.2 handleCarSelect : ', this.car.Id);
        this.dispatchEvent(carSelect);
        console.log('OUTPUT 1.3 handleCarSelect : ', this.car.Id);
       // debugger;

        try{
            fireEvent(this.pageRef, 'carSelect', this.car.Id );
        }
        catch(error)
        {
            console.log('OUTPUT : ', error) ;
            console.log('OUTPUT : ', error.body.message) ;
            
        }

        console.log('OUTPUT fireEvent : ', carId);
    }

}