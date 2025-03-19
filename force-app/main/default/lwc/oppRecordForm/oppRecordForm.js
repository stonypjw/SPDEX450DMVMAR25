import { LightningElement, api } from 'lwc';

export default class OppRecordForm extends LightningElement {

    // public properties to inherit values from record page
    @api objectApiName;
    @api recordId;

    //public properties to control behavior of form
    @api layoutType = 'Compact';
    @api formMode = 'readonly';

    handleCancel(){
        const cancelEvent = new CustomEvent('modalcancel');
        this.dispatchEvent(cancelEvent);
    }
    
    handleSuccess(){
        const successEvent = new CustomEvent('modalsuccess');
        this.dispatchEvent(successEvent);
    }
}