({
	handleInit : function(component, event, helper) {
       var actionList = component.get("c.getActionList");
         actionList.setParams({
            "recordId" : component.get('v.recordId')
        });
        actionList.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                component.set('v.ActionPlanList',response.getReturnValue());
                console.log(response.getReturnValue());
            }
            
        });
        
        $A.enqueueAction(actionList);
        
		
	},
    
    newTask : function (component, event, helper) {
        
        var recordid = component.get("v.recordId");
        var action = component.get("c.getActionList");
        action.setParams({
            "recordId"  : recordid
            });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var retuenvalue = response.getReturnValue();
                var windowHash = window.location.hash;
                var createRecordEvent = $A.get("e.force:createRecord"); 
                createRecordEvent.setParams({
                    "entityApiName":"Task",
                    "defaultFieldValues" : {
                        'WhatId' : recordid
                    }
                });
                createRecordEvent.fire();
                //$A.get('e.force:refreshView').fire();
            }
           
        });
        $A.enqueueAction(action);   
   
    },
})