import { LightningElement, api } from 'lwc';

export default class ChildA extends LightningElement {

    @api parentId;

    connectedCallback()
    {
        console.log('connectedCallback - childA : ', this.parentId);
    }

    renderedCallback()
    {
        console.log('renderedCallback - childA : ', this.parentId);
    }
}