import { LightningElement,track } from 'lwc';

export default class EventMode extends LightningElement {

     valueone = ['readonly'];

     @track selectedVal = [];

    get options() {
        return [
            { label: 'readonly', value: 'readonly' },
            { label: 'edit', value: 'edit' },
            { label: 'view', value: 'view' }
        ];
    }

    get selectedValues() {
        //return this.value.join(',');
    }

    handleChange(e) {

        this.valueone = e.detail.value;
        this.selectedVal = this.valueone[0];

        const event = new CustomEvent('changemode', {
            detail: {mode: this.selectedVal}
                   });

        console.log('1.2: ', this.selectedVal);
        console.log('1.3: ', e.target.selectedVal);
      
        this.dispatchEvent(event);
    }


}