({
    doInit: function(component, event, helper) {
        var recid= component.get("v.recordId");
        
   var urlEvent = $A.get("e.force:navigateToURL");
    urlEvent.setParams({
      "url": "https://imeryscrm.lightning.force.com/lightning/r/Account_Plan__c/"+recid+"/view"
    });
    urlEvent.fire();

        
    }
    
    
})