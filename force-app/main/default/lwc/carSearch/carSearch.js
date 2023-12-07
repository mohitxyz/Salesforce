import { LightningElement, track } from 'lwc';

export default class CarSearch extends LightningElement {

    @track carId;

    cartypeHandler(event)
    {
        this.carId = event.detail;
        console.log('1.5', this.carId);
    }

    connectedCallback()
    {
        console.log('OUTPUT : connectedCallback - carSearch',);
    }

    renderedCallback()
    {
        console.log('OUTPUT : renderedCallback - carSearch',);
        console.log('1.6', this.carId);
    }

}