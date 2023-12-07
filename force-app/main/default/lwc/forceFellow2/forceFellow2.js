import { LightningElement, wire, api } from 'lwc';
import showResult from '@salesforce/apex/forceFellowController.showResult';
import { fireEvent } from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';
import { publish, MessageContext } from 'lightning/messageService';
import MyMessageChannel from '@salesforce/messageChannel/demoMessageChannel__c';

export default class ForceFellow2 extends LightningElement {

    @wire(MessageContext) messageCont;




    firstName;
    firstNameChangeHandler(event)
    {
        this.firstName = event.target.value;
    }

    handleLMS()
    {
        let payload = {lastName : this.firstName };
        publish(this.messageCont, MyMessageChannel, payload );
    }


    @wire(CurrentPageReference) currentPageref;

    handlePublish()
    {
        
        fireEvent(this.currentPageref, 'sendNameEvent', 'test payload');
    }


    constructor()
    {
        super();
        console.log('forceFellow 2 - Constructor');
    }

    throwToParent()
    {
       /* const cust = new CustomEvent('childclick', { detail: { payload: 'test' }, bubbles: true });
        this.dispatchEvent(cust);*/

        const cust = new CustomEvent('childclickbubbles', { detail: { payload: 'test' }, bubbles:true });
        this.dispatchEvent(cust);
        
    }




    name;
    returnedName;
    @api paramObject;

    handleName(event)
    {
        console.log('handleName : ', event.target.value );
        this.name = event.target.value;
        console.log('handleName- : ', this.name );
        
    }

    @api
    returnData(a, b)
    {
        return a + b;
    }

    @wire(showResult, { name: '$paramObject' })
    wiredData({ error, data }) {
        console.log('@wire');
      if (data) {
          console.log('Data = ', data);
          this.returnedName = data;
      } else if (error) {
          console.log('Error:', error);
      }
    }

    connectedCallback()
    {
        console.log('forceFellow 2 - connectedCallback = '  + JSON.stringify(this.paramObject));
    }

    /*render()
    {

    }*/

    renderedCallback()
    {
        console.log('forceFellow 2 - renderedCallback = ' + this.paramObject);
        console.log('forceFellow 2 - renderedCallback= ' + + JSON.stringify(this.paramObject));
        //this.returnedName = this.paramObject;
    }

    disconnectedCallback()
    {
        console.log('forceFellow 2 - disconnectedCallback');
    }

    errorCallback(error, stack)
    {
        console.log('forceFellow 2 : ',  +  error + ',' + stack );
    }

    throwException()
    {
        console.log('OUTPUT : throwException');
        //throw new Error('custom error');
    }


}