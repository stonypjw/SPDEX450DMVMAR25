import { LightningElement, api } from 'lwc';

export default class HelloWorld extends LightningElement {

    @api greeting = 'World';

}