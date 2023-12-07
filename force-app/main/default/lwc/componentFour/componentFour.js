import { LightningElement, track , api} from 'lwc';

export default class ComponentFour extends LightningElement {

input = 'hello';
inputVal;
check=false;
@track loop=['one', 'two', 3,4,5,6,7];
childColor;

comboValue = 'inProgress';

get colorOptions() {
    return [
        { label: 'New', value: 'new' },
        { label: 'In Progress', value: 'inProgress' },
        { label: 'Finished', value: 'finished' },
    ];
}

handleChange(event) {

}

inputOneHandler(event)
{
    this.inputVal = event.target.value;
}

buttonHandler()
{
    confirm(this.inputVal);
}


checkHandler(event)
{
    this.check = event.target.checked;
}



@api
changeColors(color)
{
    confirm('2.1 = ' + color);
    this.comboValue = color;
    confirm('2.2= ' + this.comboValue);
}

}