({
    doInit  : function(component, event, helper) {
        helper.haspermission(component,event);
        helper.setColumns(component,event);
        helper.getOwnershipVals(component,event);
        
        var action = component.get('c.getParentInfo');
        action.setParams({
            "accountPlanId" : component.get("v.recordId")
            
        });
        action.setCallback(this, function(response){
            if (response.getState() === "SUCCESS") {
                component.set("v.accountPlanRecord", response.getReturnValue());
                component.set("v.statusFromBcknd",component.get("v.accountPlanRecord.Account__r.Ownership"));
                component.set("v.contactName",component.get("v.accountPlanRecord.Account__r.Contact__r.Name"));
                console.log('==== v.accountPlanRecord : ' + component.get("v.accountPlanRecord"));
                console.log('==== v.statusFromBcknd : ' + component.get("v.statusFromBcknd"));
                
                var flow = component.find("flowData");
             /*   var inputVariables = [
                {
                  name : "contact",
                  type : "String",
                  value: component.get("v.contactName")
               }
            ]; 
                console.log('Contact id is: ',inputVariables);
                flow.startFlow("Contact_Lookup_for_AccountPlan",inputVariables);*/
                flow.startFlow("Contact_Lookup_for_AccountPlan");
            }
        });
        
     
	 $A.enqueueAction(action);
    },
    
   
    handleSave  : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        var businessDesc = component.find("businessDesc").get("v.value");
        var geoReach = component.find("geoReach").get("v.value");
        var impInno = component.find("impInno").get("v.value");
        var majorClients = component.find("majorClients").get("v.value");
        var keyCompetitors = component.find("keyCompetitors").get("v.value");
        var haspermission = component.get( "v.haspermission"); 
        var accFoundation = component.find("foundation").get("v.value");
        var accOwnership = component.find("ownership").get("v.value");
              
        var accountPlan = component.get("v.accountPlanRecord");
        console.log('accountPlan : ' + accountPlan);
       
        
        accountPlan.Business_Description__c = businessDesc;
        console.log('businessDesc'+businessDesc);
        accountPlan.Geographical_Reach__c = geoReach;
        accountPlan.Important_Innovations__c = impInno;
        accountPlan.Major_Clients__c = majorClients;
        accountPlan.Key_Competitors__c = keyCompetitors;
        accountPlan.Account__r.Foundation__c = accFoundation;
        accountPlan.Account__r.Ownership = accOwnership;
       
        
        console.log('haspermission',haspermission);
         if(haspermission != 'True')
        {
        var action = component.get('c.updateAccountPlanOnSave');
        action.setParams({
            accountPlan : JSON.stringify(accountPlan)  
        });
        action.setCallback(this, function(response){
            console.log('response.getState()',response.getState());
            if (response.getState() === "SUCCESS")
             
            {
                
                if('Success' === response.getReturnValue()){
                    toastEvent.setParams({
                        title : 'Success',
                        message: 'Record Saved Successfully',
                        type: 'success'
                    });
                    toastEvent.fire();
                
                }else{
                    toastEvent.setParams({
                        title : 'Error',
                        message: response.getReturnValue(),
                        type: 'error'
                    });
                    toastEvent.fire();
                }
            
            }
        else{
               toastEvent.setParams({
                        title : 'Error',
                        message: 'User Access Restricted.',
                        type: 'error'
                    });
                    toastEvent.fire(); 
            }
        });
	 $A.enqueueAction(action);
        }
         else{
              toastEvent.setParams({
                        title : 'Error',
                        message: 'User Access Restricted.',
                        type: 'error'
                    });
                    toastEvent.fire(); 
             
        }  
    }
})