({
    doInit: function(component, event, helper) {
        var businessArea;
        
        /** Taken from Ideads : Get parentId when overriding standard actions with a lightning components
         */
        var pageRef = component.get("v.pageReference");
        var state = pageRef.state; // state holds any query params
        var base64Context = state.inContextOfRef;
        var url;
        
        if (base64Context.startsWith("1\.")) {
            base64Context = base64Context.substring(2);
        }
        var addressableContext = JSON.parse(window.atob(base64Context));
        var recId = addressableContext.attributes.recordId;
        
        console.log('Parent Record Id --> '+ recId);
        
        var createRecordEvent = $A.get("e.force:createRecord");       
        
        var action = component.get("c.getUserDetails");
        action.setParams({ usrId : recId });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log("State",state)
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                component.set("v.BusinessArea", storeResponse);
                businessArea = component.get("v.BusinessArea");
                
                console.log('In Success Record ID : '+storeResponse);
                
                createRecordEvent.setParams({
                    "entityApiName":"Account_Plan__c",
                    "recordTypeId" : component.get("v.selectedRecordId"),
                    "defaultFieldValues" : {
                        'Business_Area__c' : businessArea,
                        'Account__c':recId
                    }
                });
                
                createRecordEvent.fire();
            }
        });
        $A.enqueueAction(action);
        
        
    },
    reInit : function(component, event, helper) {
        $A.get('e.force:refreshView').fire();
    }
    
    
})