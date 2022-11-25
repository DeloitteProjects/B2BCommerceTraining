/**
 * Created by aketa on 10/20/2021.
 */

import { LightningElement,api } from 'lwc';

export default class AccountNameChange extends LightningElement {
@api recordId;
handleSuccess(event){
    console.log('on success event recordEditForm');
}
}