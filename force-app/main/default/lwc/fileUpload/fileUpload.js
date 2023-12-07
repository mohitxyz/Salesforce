import { LightningElement , api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class FileUpload extends LightningElement {

    @api recordId;
    
    get acceptedFormats() {
        return ['.pdf', '.png'];
    }

    handleUploadFinished(event) {
        const uploadedFiles = event.detail.files.contentVersionId + ',' + event.detail.files.documentId ;
        const evt = new ShowToastEvent({
            title: 'SUCCESS',
            message: uploadedFiles + ' File(s) uploaded  successfully',
            variant: 'success',
        });
        this.dispatchEvent(evt);
    }

    get inputParam()
    {
        return [
            {
                name: 'inputParam1',
                type: 'String',
                value: 'Hello'
            }
        ];
    }

    statusHandler(event)
    {
        confirm('1.1 ' + event.detail.status);
        
        if(event.detail.status == 'FINISHED')
        {
            const outputVariables = event.detail.outputVariables;
            for(let i = 0; i < outputVariables.length; i++) {
                 const outputVar = outputVariables[i];
                 if(outputVar.name == 'outputParam1'){
                    console.log('contactName from flow >> ' + outputVar.value);
                 }
                 if(outputVar.name == 'emailID'){
                    console.log('emailID from flow >> ' + outputVar.value);
                 }
            }
        }
    }
    


}