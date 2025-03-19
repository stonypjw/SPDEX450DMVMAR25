import { LightningElement, api } from 'lwc';

export default class FormToggle extends LightningElement {

    @api editMode = false;
    @api recordId;

    handleChange(event) {
        this.editMode = !this.editMode;
    }

    handleButtonClick(event) {
        this.editMode = false;
    }
}