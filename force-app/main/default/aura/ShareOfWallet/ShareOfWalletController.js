({
    fetchAcc : function(component, event, helper) {
        
       
        helper.fetchAccHelper(component, event, helper);
        helper.fetchCurrencyValue(component, event, helper);
        helper.getPicklistValues(component, event,helper);
		        
        
    },
    
    
    
    updateSelectedText : function(component, event, helper) {
        var selectedRows = event.getParam('selectedRows');
        var RecordId; 
        for(var record of selectedRows) {   
            RecordId = record.Id;
        } 
        component.set("v.SelectedRecordID" , RecordId);
        if(component.get("v.SelectedRecordID" ) != null){
            component.set("v.ADDProductButtonController", false );
        } 
    },
    
    
    
    updateProductSelectedText : function(component, event, helper) {
        
        var selectedRows = event.getParam('selectedRows');
       // console.log(selectedRows);
        var RecordName; 
        var RecordId; 
        for(var record of selectedRows) {   
            RecordName = record.Name;
            RecordId = record.Id;
        } 
       // console.log(RecordName);
        //console.log(RecordId);
        component.set("v.SelectedRecordName" , RecordName);
        component.set("v.SelectedProductRecordID" , RecordId);
        
        
        
    },
    
    
    AddbuttonhandleClick : function(component, event, helper){
        component.set("v.showproducttable", false);
        component.set("v.truthy", true);
    },
    
    
    
    searchbuttonhandleClick : function(component, event, helper){
        if(component.get("v.SelectedRecordID" ) != null){
            helper.fetchproductHelper(component, event, helper);
        } 
    },
    
    
    openModel: function(component, event, helper) {
        component.set("v.truthy", true);
    },
    
    closeModel: function(component, event, helper) { 
        component.set("v.truthy", false);
    },
    
    submitDetails: function(component, event, helper) {
        component.set("v.truthy", false);  
        component.set("v.truthyproduct", false);     
        
        if(component.get("v.SelectedRecordName" ) != null){
            component.set("v.productfieldsenabled", true);
        }    
    },
    ProductonSave : function(component, event, helper) {
        helper.saveProductfromtable(component, event, helper);          
    },
    
    
    SavehandleClick: function(component, event, helper) {
        helper.fetchproductdetails(component, event, helper);          
    },
    
    CancelhandleClick: function(component, event, helper) {
        component.set("v.SelectedRecordName" , '' );
        component.set("v.OurAnnualRevenue" , '');
        component.set("v.TotalCustomerRevenue" , '');
        component.set("v.AnnualVolume" , '');
        component.set("v.ImerysMargin" , '' );
        component.set("v.Unit" , '');
        component.set("v.TotalConsumptioninVolume" , '');
        component.set("v.Imerysshareofwallet" , '' );
        component.set("v.ImerysshareofwalletRevenue" , '' );
        component.set("v.TargetshareofwalletRevenue" , '' );
        component.set("v.Targetshareofwallet" , '' );
        component.set("v.Imeryspotential" , '' );
        component.set("v.productfieldsenabled" , false );
        
       // component.set("v.Unit" , '');
    },
    
    refreshcomponent : function(component, event, helper) {
        helper.fetchproductlist(component, event, helper);  
    },
    
    viewRecord : function(component, event, helper) {
       
        // console.log('Printing acc plan rec id' ,component.get("v.recID"));
        var recId = event.getParam('row').Id;
        component.set("v.accountid", recId);
       // console.log(component.get("v.accountid"));
        var actionName = event.getParam('action').name;
        if ( actionName == 'ShowProducts' ) {
            component.set("v.SelectedRecordName" , '' );
            component.set("v.OurAnnualRevenue" , '');
            component.set("v.TotalCustomerRevenue" , '');
            
            component.set("v.AnnualVolume" , '');
            component.set("v.ImerysMargin" , '' );
            component.set("v.Unit" , '');
            component.set("v.TotalConsumptioninVolume" , '');
            component.set("v.Imerysshareofwallet" , '' );
            component.set("v.ImerysshareofwalletRevenue" , '' );
            component.set("v.TargetshareofwalletRevenue" , '' );
            component.set("v.Targetshareofwallet" , '' );
            component.set("v.Imeryspotential" , '' );
            component.set("v.productfieldsenabled" , false );
            helper.fetchproductlist(component, event, helper); 
            component.set("v.showproducttable" , true ); 
        } 
    },
    
    updateSelectedTextProduct: function (component, event, helper) {
        var selectedRows = event.getParam('selectedRows');
       // console.log('prod id'+JSON.stringify(selectedRows));
        if(selectedRows != null){
            component.set("v.checkboxchecked", true);
            
            for(var record of selectedRows) {  
                component.set("v.ProdId", record.Id);
                component.set("v.SelectedRecordName", record.Name);
                component.set("v.AnnualVolume", record.Annual_Volume__c);
                component.set("v.OurAnnualRevenue", record.Annual_Revenue__c);
                component.set("v.TotalCustomerRevenue", record.Total_customer_revenue__c);
                //component.set("v.ImerysMargin", record.Imerys_margin__c);
                component.set("v.TotalConsumptioninVolume", record.Total_consumption_in_Volume__c);
                component.set("v.Unit", record.Unit1__c);
                component.set("v.Imerysshareofwallet", record.Imerys_share_of_wallet__c );
                component.set("v.ImerysshareofwalletRevenue", record.Imerys_Share_of_Wallet_Revenue__c );
                component.set("v.Targetshareofwallet", record.Target_share_of_wallet__c );
                component.set("v.TargetshareofwalletRevenue", record.Target_Share_of_Wallet_Revenue__c );
                component.set("v.Imeryspotential", record.Imerys_potential__c );
            }  
        }
        
    },
    
    handleClick : function (component, event, helper) {  
        if(component.get("v.checkboxchecked") == true){
         component.set("v.isModalOpen",true);
         
        }
    },
    
    handleDelete : function (component, event, helper) {  
        if(component.get("v.checkboxchecked") == true){
           
            helper.deleterow(component, event, helper); 
        }
    },
    
        
    closeModelProduct: function(component, event, helper) {
        // Set isModalOpen attribute to false  
        component.set("v.isModalOpen", false);
    },
    
    submitDetailsProduct:function(component, event, helper) {
        // Set isModalOpen attribute to false  
        component.set("v.isModalOpen", false);
        var ProductName = component.find("ProductName").get("v.value");
        var AnnualVolume = component.find("AnnualVolumeAuraID").get("v.value");
       
        var OurAnnualRevenue = component.find("OurAnnualRevenueAuraID").get("v.value");
        if(OurAnnualRevenue){
            OurAnnualRevenue=parseFloat(OurAnnualRevenue);
        }
        //console.log(OurAnnualRevenue);
        if(!OurAnnualRevenue){
            OurAnnualRevenue=0;
        }
        
        var TotalCustomerRevenue = component.find("TotalCustomerRevenueID").get("v.value");
        if(!TotalCustomerRevenue){
            TotalCustomerRevenue=0;
        }
        if(TotalCustomerRevenue){
            TotalCustomerRevenue=parseFloat(TotalCustomerRevenue);
        }
        
        //var ImerysMargin = component.find("ImerysMarginAuraID").get("v.value");
        var TotalConsumptioninVolume = component.find("TotalConsumptioninVolumeAuraID").get("v.value");
        var Unit = component.find("Unit").get("v.value");
        
        var Imerysshareofwallet = component.find("ImerysshareofwalletAuraID").get("v.value");
        if((Imerysshareofwallet) && Imerysshareofwallet.includes('%')){
            var Imerysshareofwallet=Imerysshareofwallet.replace(/%/g,"");
        }
        if(!Imerysshareofwallet){
            Imerysshareofwallet=0;
        }
        
        var ImerysshareofwalletRevenue = component.find("ImerysshareofwalletRevenueID").get("v.value");
        if((ImerysshareofwalletRevenue) && ImerysshareofwalletRevenue.includes('%')){
            var ImerysshareofwalletRevenue=ImerysshareofwalletRevenue.replace(/%/g,"");
        }
        if(!ImerysshareofwalletRevenue){
            ImerysshareofwalletRevenue=0;
        }
        
        var Targetshareofwallet = component.find("TargetshareofwalletAuraID").get("v.value");
        if((Targetshareofwallet) && Targetshareofwallet.includes('%')){
            var Targetshareofwallet=Targetshareofwallet.replace(/%/g,"");
        }
        if(!Targetshareofwallet){
            Targetshareofwallet=0;
        }
        
        var TargetshareofwalletRevenue = component.find("TargetshareofwalletRevenueID").get("v.value");
        if((TargetshareofwalletRevenue) && TargetshareofwalletRevenue.includes('%')){
            var TargetshareofwalletRevenue=TargetshareofwalletRevenue.replace(/%/g,"");
        }
        if(!TargetshareofwalletRevenue){
            TargetshareofwalletRevenue=0;
        }
        
        var Imeryspotential = component.find("ImeryspotentialAuraID").get("v.value");
        
        var action = component.get("c.productInsertion");
        action.setParams({
            "productrecordID": component.get("v.ProdId"),
            "OurAnnualRevenue": OurAnnualRevenue,
            "AnnualVolume" :AnnualVolume,
            "TotalCustomerRevenue" : TotalCustomerRevenue ,
            //"ImerysMargin" : ImerysMargin ,
            "TotalConsumptioninVolume": TotalConsumptioninVolume ,
            "Unit": Unit ,
            "Imerysshareofwallet": Imerysshareofwallet ,
            "ImerysshareofwalletRevenue": ImerysshareofwalletRevenue ,
            "Targetshareofwallet": Targetshareofwallet ,
            "TargetshareofwalletRevenue": TargetshareofwalletRevenue ,
            "Imeryspotential": Imeryspotential 
            
            
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            //console.log('Return state'+state)
            //console.log('Value'+action.getReturnValue())
            if (state === "SUCCESS") {
               window.location.reload();
              
            }
        });
        $A.enqueueAction(action);
        
    },
    
})