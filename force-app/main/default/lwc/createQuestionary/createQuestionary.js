/**
 * Created by aketa on 10/20/2021.
 */

import { LightningElement,api,wire } from 'lwc';
import {getRecord} from "lightning/uiRecordApi";
import {NavigationMixin} from "lightning/navigation";
import {ShowToastEvent} from "lightning/platformShowToastEvent";
export default class CreateQuestionary extends LightningElement {
@api recordId;

statusChange=false;
statusUpdate=false
onChangeRecommended(event){
let string=event.target.value;
if(string=='No'){
    this.statusChange=true;
}
}
@wire (getRecord,{recordId: '$recordId', fields: 'Webinar__c.Status__c'})
userInfoWired({error, data}){
    if(error){console.log(error);}
    else if(data){
        console.log(data);
        if(data.fields.Status__c.value=="Completed"){
            this.statusUpdate=true;
            }
        else{
        this.statusUpdate=false;
        }
    }}
onHandleSuccess(event){
    console.log("I Am Here");
    const evt=new ShowToastEvent(
        {
            title: 'Success',
            message:'Questionare has been completed',
            variant:'Success'

        }
    );
 this.dispatchEvent(evt);
this[NavigationMixin.Navigate](
    {
        type: "standard__recordPage",
        attributes:{
            recordId: 'a0B09000001fNP3',
            action:'view'

        }
    }
);
}
websiteTravel(){
    console.log("I Am Here");
    let word=document.getElementById("wordToSearch").value;
    console.log(word);
    window.open("http://google.com");

}
}