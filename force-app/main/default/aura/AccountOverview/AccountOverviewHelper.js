({
	setColumns : function(Component,event) {
        Component.set('v.columns', [
            {label: 'Account name', fieldName: 'Name', type: 'text'},
            {label: 'City', fieldName: 'BillingCity', type: 'text'},
            {label: 'Country', fieldName : 'BillingCountry', type: 'text'},
            {label: 'Business Area', fieldName: 'Business_Areas__c', type: 'text'}
            
            
        ]);
	},
    
     haspermission : function(component, event) {
		
        var haspermission = component.get("c.haspermission");
        var recid = component.get("v.recordId");
        
        haspermission.setParams({
            "accountPlanId" : recid
        });
        haspermission.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var  returnvalue = response.getReturnValue();
                 component.set("v.haspermission",returnvalue);  
            }
        });
        $A.enqueueAction(haspermission); 
     },
    
     
})