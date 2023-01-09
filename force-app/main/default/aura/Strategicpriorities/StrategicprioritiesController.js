({
    doInit : function(component, event, helper) {
        
        
        var haspermission = component.get("c.haspermission");
        var recid = component.get("v.recordId");
        var arr = [];
        
        
        haspermission.setParams({
            "AccountplanId" : recid
        });
        haspermission.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var  returnvalue = response.getReturnValue();
                component.set("v.ReadOnlyPermission",returnvalue);
                var action = component.get("c.getAccountpriorites");
                action.setParams({
                    "AccountplanID" : recid
                });
                action.setCallback(this, function(response){
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        var  returnvalue = response.getReturnValue();
                        
                        if(returnvalue != null){
                            for(var record of returnvalue) {   
                                arr.push(record);
                            } 
                        }
                        
                        
                        component.set("v.Recordlist1",arr[0]);
                        component.set("v.Recordlist2",arr[1]);
                        component.set("v.Recordlist3",arr[2]); 
                        component.set("v.Recordlist4",arr[3]);
                        component.set("v.Recordlist5",arr[4]);
                        
                        
                        
                        
                        if(returnvalue.length > 0){
                            try { 
                                component.set("v.KAS1",returnvalue[0].List_Priorities_of_the_Key_Account__c);
                                component.set("v.KAS2",returnvalue[1].List_Priorities_of_the_Key_Account__c);
                                component.set("v.KAS3",returnvalue[2].List_Priorities_of_the_Key_Account__c);
                                component.set("v.KAS4",returnvalue[3].List_Priorities_of_the_Key_Account__c);
                                component.set("v.KAS5",returnvalue[4].List_Priorities_of_the_Key_Account__c); 
                            }catch(err) {
                                
                            }
                        }
                        
                        if(returnvalue.length > 0){
                            try{
                                component.set("v.IS1",returnvalue[0].Imerys_Strategic__c);
                                component.set("v.IS2",returnvalue[1].Imerys_Strategic__c);
                                component.set("v.IS3",returnvalue[2].Imerys_Strategic__c);
                                component.set("v.IS4",returnvalue[3].Imerys_Strategic__c);
                                component.set("v.IS5",returnvalue[4].Imerys_Strategic__c);
                            }catch(err) {
                                
                            }
                            
                        }
                        
                        if(returnvalue.length > 0){
                            try{
                                component.set("v.ww1",returnvalue[0].Win_Win_Partnership__c );
                                component.set("v.ww2",returnvalue[1].Win_Win_Partnership__c );
                                component.set("v.ww3",returnvalue[2].Win_Win_Partnership__c );
                                component.set("v.ww4",returnvalue[3].Win_Win_Partnership__c );
                                component.set("v.ww5",returnvalue[4].Win_Win_Partnership__c );
                            }catch(err) {
                                
                            }
                        }
                    }
                    
                });  
                $A.enqueueAction(action); 
            }
        });
        $A.enqueueAction(haspermission); 
    },
    
    
    
    
    
    SubmithandleClick : function(component, event, helper) {
        
        var IS1 = component.find("IS1").get("v.value");
        var IS2 = component.find("IS2").get("v.value");
        var IS3 = component.find("IS3").get("v.value");
        var IS4 = component.find("IS4").get("v.value");
        var IS5 = component.find("IS5").get("v.value");
        
        var ww1 = component.find("ww1").get("v.value");
        var ww2 = component.find("ww2").get("v.value");
        var ww3 = component.find("ww3").get("v.value");
        var ww4 = component.find("ww4").get("v.value");
        var ww5 = component.find("ww5").get("v.value");
        
        
        var Recordlist1 = component.get("v.Recordlist1");
        var Recordlist2 = component.get("v.Recordlist2");
        var Recordlist3 = component.get("v.Recordlist3");
        var Recordlist4 = component.get("v.Recordlist4");
        var Recordlist5= component.get("v.Recordlist5");
        
        if(Recordlist1){
            for(var record of Recordlist1) {   
                record.Win_Win_Partnership__c =ww1;
                record.Imerys_Strategic__c = IS1;
            } 
        }
        
        if(Recordlist2){
            
            for(var record of Recordlist2) {   
                record.Win_Win_Partnership__c =ww2;
                record.Imerys_Strategic__c = IS2;
            } 
        }
        
        
        if(Recordlist3){
            
            for(var record of Recordlist3) {   
                record.Win_Win_Partnership__c =ww3;
                record.Imerys_Strategic__c = IS3;
            } 
        }
        
        
        
        if(Recordlist4){
            for(var record of Recordlist4) {   
                record.Win_Win_Partnership__c =ww4;
                record.Imerys_Strategic__c = IS4;
            } 
            
        } 
        
        
        
        
        
        
        if(Recordlist5) {
            for(var record of Recordlist5) {
                record.Win_Win_Partnership__c =ww5;
                record.Imerys_Strategic__c = IS5;
            }
        } 
        
        
        
        
        
        var action = component.get("c.sumbitAccountPriorites");
        var AccountplanID = component.get("v.recordId");
        action.setParams({
            "AccountplanID" : AccountplanID,
            "row1" : Recordlist1,
            "row2" : Recordlist2,
            "row3" : Recordlist3,
            "row4" : Recordlist4,
            "row5" : Recordlist5
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({  
                    "title": "Success!",
                    "message": "The record has been updated successfully.",
                    type: 'success'
                });
                toastEvent.fire();
            }
        });
        
        $A.enqueueAction(action); 
        
    },
})