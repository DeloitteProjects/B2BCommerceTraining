/**
 * Created by aketa on 10/20/2021.
 */

import { LightningElement } from 'lwc';

export default class HelloWorld extends LightningElement {
greeting='World';
changeHandler(event){
    this.greeting=event.target.value;
}
}