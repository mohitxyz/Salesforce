import { LightningElement , api, track } from 'lwc';

export default class B extends LightningElement {

@track val1;


set childName(value)
{   
   
    this.val1 = value.toUpperCase();
    //confirm('1.2 = ' + this.val1);
}
@api
get childName()
{
    
    return this.val1;
}



}