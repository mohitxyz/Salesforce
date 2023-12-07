import { LightningElement, track } from 'lwc';

export default class ForceFellow extends LightningElement {

    @track paramObj = {
        name: '',
        number: ''
    };

    testVal;

    childClickHandler(event)
    {
        confirm(event.detail.payload);

    }

    nameChangeHandler(event)
    {
        this.paramObj.name = event.target.value;
        console.log('1.1 : ', this.paramObj.name);
        this.testVal = event.target.value;
    }

    handleClick()
    {
        const res = this.template.querySelector('c-force-fellow2');
        console.log('1.2  = ' + res.returnData(10, 20));

        this.template.addEventListener('childclickbubbles', this.handleCustomEvent.bind(this));

    }

    handleCustomEvent(event)
    {
        confirm('1.2 = ' + event.detail.payload);
    }

    numberChangeHandler(event)
    {
        this.paramObj.number = event.target.value;
    }

    constructor()
    {
        super();
        console.log('forceFellow - Constructor');
    }

    connectedCallback()
    {
        console.log('forceFellow - connectedCallback');
    }

    renderedCallback()
    {
        console.log('forceFellow - renderedCallback');
       // this.paramObj.number = 2;
    }

    disconnectedCallback()
    {
        console.log('forceFellow - disconnectedCallback');
    }

    errorCallback(error, stack)
    {
        console.log('OUTPUT : ',typeof(error) + ',' + JSON.stringify(error));
        console.log('forceFellow : ',  +  error + ',' + stack );
    }

}