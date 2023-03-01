({
    doInit  : function(component, event, helper) {
        helper.haspermission(component,event);
        helper.setColumns(component,event);
        var action = component.get('c.getParentInfo');
        action.setParams({
            "accountPlanId" : component.get("v.recordId")
            
        });
        action.setCallback(this, function(response){
            if (response.getState() === "SUCCESS") {
                component.set("v.accountPlanRecord", response.getReturnValue());
                console.log('==== v.accountPlanRecord : ' + component.get("v.accountPlanRecord"));
               
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
              
        var accountPlan = component.get("v.accountPlanRecord");
        console.log('accountPlan : ' + accountPlan);
       
        
        accountPlan.Business_Description__c = businessDesc;
        console.log('businessDesc'+businessDesc);
        accountPlan.Geographical_Reach__c = geoReach;
        accountPlan.Important_Innovations__c = impInno;
        accountPlan.Major_Clients__c = majorClients;
        accountPlan.Key_Competitors__c = keyCompetitors;
       
        
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
    },
    
        handleFilesChange : function (component, event, helper) {
      var files = event.getSource().get("v.files");
        console.log('my file: '+ files);
      if(files){
          var file = files[0]
          //console.log('my file: '+ file);
          var reader = new FileReader();
          reader.readAsDataURL(file);
          reader.onload = function () {
              var template = component.get("v.accountPlanRecord.Comments__c");
              if(template===undefined) template = '';
              template += '<img src="'+reader.result+'"/>';
              component.set("v.accountPlanRecord.Comments__c",template);
          };
          reader.onerror = function (error) {
              console.log('Error: ', error);
          };
      }
  }

})