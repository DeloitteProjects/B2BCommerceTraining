/**
 * Created by aketa on 10/21/2021.
 */

import { LightningElement,api,wire } from 'lwc';
import getQuestionnares from '@salesforce/apex/querySelector.getQuestionnares';
import getUserId from '@salesforce/apex/querySelector.getUserid';
export default class GetUser extends LightningElement {
@api recordId;


 @wire(getQuestionnares,{webId:'$recordId'})
        noQuestionnare;

        @wire(getUserId,{webId:'$recordId'})
           valueList({ error, data }) {
                console.log("UserId "+data);
                 this.userId = data;
                console.log(this.userId);

                this.error = error;
            }


}