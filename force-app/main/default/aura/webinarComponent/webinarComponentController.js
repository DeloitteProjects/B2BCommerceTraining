/**
 * Created by aketa on 10/22/2021.
 */

({
    onInit: function(component,event,helper){
       /* helper.addFirstAction(component);
        helper.addSecondAction(component);*/
        helper.getAllWebinar(component);
        component.set('{!v.columns}', [
                            {label: 'Name', fieldName: 'Name', type: 'text'},
                            {label: 'Cost', fieldName: 'Cost__c', type: 'decimal'},
                            {label: 'Status', fieldName: 'Status__c', type: 'picklist'},
                            {label: 'Type', fieldName: 'Type__c', type: 'picklist'},
                            {label:'Price Per Participant', fieldName: 'Price_Per_Participant__c', type:'text'}
                            ]);

},
       /* onFilter:function(component,event,helper){
         let labels=[];
         console.log("im on onfilter");
         let attributes=[];
         let types=[];
         let statuses=[];
         console.log("Im am here");
            component.find("types").forEach(
            (type)=>{
                console.log(type.get("v.label"));
                if(type.get("v.checked")==true){
                    types.push(type.get("v.label"));
                }
            }
        );
        component.find("statusLog").forEach(
                   (status)=>{
                       console.log(status.get("v.label"));
                        if(status.get("v.checked")==true){
                            console.log("I am here inside this loop");
                            statuses.push(status.get("v.label"));
                        }
                    }
                );
                console.log("im above types");
                attributes.push(types);
                console.log("i made it on types");
                attributes.push(statuses);
                labels.push('Type__c');
                labels.push('Status__c');
                console.log("im down statuses");
                console.log(statuses);
                console.log(types);
                console.log(attributes);
                console.log(labels);


         if(types.length==0 && statuses.length==0){
             helper.getAllWebinar(component);
         }else{
         helper.getAllWebinars(component,labels,attributes);
         }
        }*/

});