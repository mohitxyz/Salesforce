import { LightningElement, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { registerListener, unregisterAllListeners } from 'c/pubsub';

import { subscribe, unsubscribe, MessageContext } from 'lightning/messageService';
import MyMessageChannel from '@salesforce/messageChannel/demoMessageChannel__c';

export default class ForceFellow3 extends LightningElement {

    @wire(CurrentPageReference) pageRef;

    @wire(MessageContext) messageCtxt;

    subscribedValue;
    subscription;
    subObject;

    connectedCallback()
    {
        registerListener('sendNameEvent', this.setCaptureText, this);

        var sub = subscribe(this.messageCtxt, MyMessageChannel, (message) => this.subscriptionHandler(message));

    }

    subscriptionHandler(message)
    {
        this.subscription = message.lastName; 
    }


    setCaptureText(payload)
    {
        this.subscribedValue = payload;
    }

    disconnectedCallback()
    {
        unregisterAllListeners(this);

        unsubscribe(sub);
    }
}