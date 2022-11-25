/**
 * Created by aketa on 10/20/2021.
 */

import { LightningElement ,wire,api,track } from 'lwc';
import USER_ID from '@salesforce/user/Id';
import NAME_FIELD from '@salesforce/schema/User.Name';
import {getRecord} from 'lightning/uiRecordApi';
import {createRecord} from 'lightning/uiRecordApi';
import age from '@salesforce/schema/Questionare__c.Age__c';
import comments from '@salesforce/schema/Questionare__c.Comments__c';
import score from '@salesforce/schema/Questionare__c.Score__c';
import tellUsWhy from '@salesforce/schema/Questionare__c.Tell_Us_Why__c';
import wasUserParticipant from '@salesforce/schema/Questionare__c.Was_User_Participant__c';
import webinar from '@salesforce/schema/Webinar__c.Id';
import recommend from '@salesforce/schema/Questionare__c.Would_your_recommend_this_Webinar__c';
import questionare from '@salesforce/schema/Questionare__c';
import userId from  '@salesforce/schema/User.Id';

export default class CreateQuestionare extends LightningElement {
    @api webinarId;
age='12';
comments='lkj';
score='';
tellUsWhy='';
wasUserParticipant='';

recommend='';
@track title;
@wire(getRecord, {
    recordId: USER_ID,
    fields: [NAME_FIELD]
}) wireuser({
    data
}) {
    if (data) {
        this.title ="Hi " + data.fields.Name.value + "! Share your feedback with us!";
    }
}

insertQuestionareAction(){
    console.log("i am here");
    const fields={};
    console.log(document.getElementById("age").value);
    fields["Age__c"]=document.getElementById("age").value;
    fields[wasUserParticipant.fieldApiName]=document.getElementById("participant").value;
    fields[score.fieldApiName]=this.score;
    fields[comments.fieldApiName]='comment';
    fields[tellUsWhy.fieldApiName]=this.tellUsWhy;
    fields[recommend.fieldApiName]=this.recommend;
    fields[webinar.fieldApiName]=this.webinarId;

    const recordInput={apiName: '@salesforce/schema/Questionare__c', fields};
    console.log(recordInput);
    createRecord(recordInput);
}
}