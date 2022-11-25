/**
 * Created by aketa on 10/23/2021.
 */

({
    addFirstAction:function(component){
         var action=component.get("c.getPicklistStatusValue")
             console.log(JSON.stringify(action));
            action.setCallback(this,function(response){
               component.set('{!v.statuses}',response.getReturnValue());
            });
             $A.enqueueAction(action);
    },
    addSecondAction:function(component){
           var action=component.get("c.getPicklistTypeValue")
                     console.log(JSON.stringify(action));
                    action.setCallback(this,function(response){
                       component.set('{!v.options}',response.getReturnValue());
                    });
                     $A.enqueueAction(action);
    },
    getAllWebinar:function(component){

        var action=component.get("c.getAllWebinar");
        action.setCallback(this,function(response){
            component.set('{!v.data}',response.getReturnValue());
        });
        $A.enqueueAction(action);
    },
    getAllWebinars:function(component,labels, attributes){

            var action=component.get("c.getAllWebinars");
         action.setParams({labels:labels, attributes:attributes});
            action.setCallback(this,function(response){
                console.log(response.getReturnValue());
                component.set('{!v.data}',response.getReturnValue());
            });
            $A.enqueueAction(action);
        }
});