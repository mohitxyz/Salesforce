import { LightningElement } from 'lwc';
import main from '@salesforce/apex/ImperaClass.main';
//var d;
export default class One extends LightningElement {

obj = {
    'color': 'Orange',
    'size': 4,
    'text': 'hello',
    'arra': [1,2,3,4]
};

strObj = JSON.stringify(this.obj);

obj1 = JSON.parse(this.strObj);

arr = [1,2,3,4,5];

s = 'color';
s = 'size';

buttonhandler(event)
{
    //confirm('1.1 = ' );
    //this.imperaCall();

}

res;
err;

/*imperaCall()
{
    confirm('1.2 = ' );
    main()
    .then(result => {
        confirm('1.4 = ' );
        this.res = result})
    .catch(error => {
        confirm('1.5 = ' );
        this.err = error})

    confirm('1.3 = ' + this.res + ',' + this.err);

}*/

connectedCallback()
{
    confirm('1.2 = ' );
    main()
    .then(result => {
        
        this.res = result;
    
        confirm('1.3 = ' + this.res );})
    .catch(error => {
       
        this.err = error;
    })

    //confirm('1.3 = ' + this.res + ',' + this.err);
}
//confirm('1.3 = ' + this.res + ',' + this.err);






}