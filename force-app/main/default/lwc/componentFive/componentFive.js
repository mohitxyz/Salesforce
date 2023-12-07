import { LightningElement } from 'lwc';

export default class ComponentFive extends LightningElement {

/*constructor()
{
    super();
    confirm('1.1');
}

connectedCallback()
{
    confirm('1.2');
}

renderedCallback(){
    confirm('1.3');
}

disconnectedCallback()
{
    confirm('1.4');
}
*/
inputVal;
inputChange(event)
{
    this.inputVal = event.target.value;
}

buttonClick()
{
    const cust = new CustomEvent('send', {detail: this.inputVal});
    this.dispatchEvent(cust);
}

}