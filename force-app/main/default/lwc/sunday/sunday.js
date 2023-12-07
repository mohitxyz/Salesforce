import { LightningElement, track} from 'lwc';
import getAccountsFromApex from '@salesforce/apex/queryAccounts.getAccountsFromApex';

export default class Sunday extends LightningElement {

    @track masterData = {firstName: '',
                          lastName: ''};
    addName;

    changeHandler(event)
    {
        this.masterData[event.target.name] = event.target.value;

        if(this.masterData.firstName && this.masterData.lastName && this.masterData.age)
        this.addName = this.masterData.firstName + ' ' + this.masterData.lastName + ' ' + this.masterData.age ;

        //if (this.data[event.target.name] == 'dob')
        //confirm(this.data.value + ',' + this.data[event.target.name]);
    }


    handleClick(event)
    {
        debugger;
       console.log('1.2: '  + event.target.name + ','+ event.target.value + ','+ event.target.label);
       window.console.log(event.target.name);
       if(event.target.name === 'queryButton')
       {
        getAccountsFromApex({cnt : this.masterData.age})
        .then((data) => {
            window.console.log('2.1', data);

                data.forEach((rows, index) =>{
                 window.console.log('2.2', rows);
                 if(index === 1)
                this.masterData.firstName = rows.Name;
                else
                this.masterData.lastName  = rows.Name;
            });

        })
        .catch((error) => {
            window.console.log(error);
        });
   
       }
    }

}