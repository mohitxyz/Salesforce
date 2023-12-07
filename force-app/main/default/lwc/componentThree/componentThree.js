import { LightningElement } from 'lwc';

export default class ComponentThree extends LightningElement {

    input;

    inputColorValue(event)
    {
        this.input = event.target.value;
    }

    changeButton()
    {
        const qlocator = this.template.querySelector('c-component-four');
        let a = qlocator.changeColors(this.input);
    }

    sendHandler(event)
    {
        confirm('3.1 = ' + event.detail);
    }
}