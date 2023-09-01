({
    doInit: function(component, event, helper) {
        var businessArea;
               
        //get record type Id
        helper.getParameterByName(component, event, helper);    
        
        
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
        
        
      //end of get parentId from from RelatedList
      //
        
        //console.log('parent id 2: -->'+component.get("v.parentId"));  
    
        if(recId!=undefined && recId.startsWith("001")){
           component.set("v.accId", recId);
       }
        
       //Only If recordId starts with 003 ( Meaning it is an Contact Record) then we assign it to the variable conId.
        if(recId!=undefined && recId.startsWith("003")){
           component.set("v.conId", recId);
       }
        
        
        //Only If recordId starts with 006 ( Meaning it is an Opportunity Record) then we assign it to the variable conId.
        if(recId!=undefined && recId.startsWith("006")){
           component.set("v.oppoId", recId);
       }
        
        var createRecordEvent = $A.get("e.force:createRecord");       
                
        var action = component.get("c.getUserDetails");
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log("State",state)
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                // set current user information on userInfo attribute
                component.set("v.BusinessArea", storeResponse);
                businessArea = component.get("v.BusinessArea");
                console.log("User Business Area: ",businessArea);
                console.log('In Success Record ID : '+component.get("v.selectedRecordId"));
                
                createRecordEvent.setParams({
                    "entityApiName":"Consumption__c",
                    "recordTypeId" : component.get("v.selectedRecordId"),
                    "defaultFieldValues" : {
                        'BusinessArea__c' : businessArea,
                        
                        
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