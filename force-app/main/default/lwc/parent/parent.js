import { LightningElement } from 'lwc';

export default class Parent extends LightningElement {

     parent;

     changehandler(event)
     {
        this.parent = event.target.value;
     }
     handleClick()
     {  


     }

     connectedCallback()
    {
        console.log('connectedCallback - Parent : ', this.parent);
    }

    renderedCallback()
    {
        console.log('renderedCallback - Parent : ', this.parent);
    }
}