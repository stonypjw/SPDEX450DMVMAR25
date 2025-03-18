import { LightningElement, api } from 'lwc';

export default class HelloWorldWrapper extends LightningElement {
    @api appBuilderGreeting = 'World';
}