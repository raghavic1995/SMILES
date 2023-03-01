({
    
    fetchAccHelper : function(component, event, helper) {
        var haspermission = component.get("c.haspermission");
        var recid = component.get("v.recordId");
        haspermission.setParams({
            "AccountplanId" : recid
        });
        
        haspermission.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var  returnvalue = response.getReturnValue();
               // console.log('sfcasf',returnvalue);
                component.set("v.hideCheckbox",returnvalue);
                component.set('v.mycolumns', [
                    {label: 'Account Name', fieldName: 'Name', type: 'text'},
                    {label: 'Location', fieldName: 'ShippingCity', type: 'text'},
                    {label: 'Imerys sales person', fieldName: 'AccountManager', type: 'text',wrapText: true},
                    {label: 'Business area', fieldName: 'Business_Areas__c', type: 'text'},
                    
                    {type: 'button', typeAttributes: {
                        label: 'Show Products',
                        name: 'ShowProducts',
                        title: 'Show Products',
                        disabled: {fieldName: 'typeButton_disabled'},
                        value: 'Show Products',
                        iconPosition: 'right'
                    }}    ]);
                var action = component.get("c.fetchAccounts");
                var AccountPlanID = component.get("v.recordId");
                action.setParams({
                    "AccountPlanID": AccountPlanID 
                });
                action.setCallback(this, function(response){
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        var rows = response.getReturnValue();
                        if( rows !=null ){
                            component.set("v.Recordcontains", true);
                            for (var i = 0; i < rows.length; i++) {
                                var row = rows[i];
                                if (row.Owner) {
                                    row.AccountManager = row.Account_Manager_Rel_BA__c;
                                }
                                row.typeButton_disabled = returnvalue ;
                                component.set("v.acctList", rows);
                            }   
                        }
                        else{
                            component.set("v.Recorddoesnotcontains", true);
                        }
                        
                    }
                });
                $A.enqueueAction(action);
            }
        });
        $A.enqueueAction(haspermission); 
    },
    
    
    getPicklistValues: function(component, event) {
        var action = component.get("c.getPicklistValues");
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                
                var fieldMap = [];
                for(var key in result){
                   // console.log("Action Values"+key);
                    fieldMap.push({key: key, value: result[key]});
                }
                component.set("v.fieldMapforunit", fieldMap);
                
            }
        });
        $A.enqueueAction(action);
    }, 
    
    fetchproductlist : function(component, event, helper) {
        
        var AccountID = component.get("v.accountid");
        
        
        component.set('v.myProductlistcolumns', [
            {label: 'Product Name', fieldName: 'Name', type: 'text'},
            {label: 'Annual Volume', fieldName: 'Annual_Volume__c', type: 'text'  },
            //{label: 'Unit', fieldName: 'Unit__c', type: 'text' ,editable: true  },
            {label: 'Units', fieldName: 'Units1__c'},
            {label: 'Annual Revenue', fieldName: 'Annual_Revenue__c', type: 'text' },      //pranay - US1331
            {label: 'Total Customer Volume', fieldName: 'Total_consumption_in_Volume__c', type: 'text' },
            {label: 'Total Customer Revenue', fieldName: 'Total_customer_revenue__c', type: 'text'},
            {label: 'Imerys Share of Wallet Volume (%)', fieldName: 'Imerys_share_of_wallet__c', type: 'text'},
            {label: 'Imerys Share of Wallet Revenue (%)', fieldName: 'Imerys_Share_of_Wallet_Revenue__c', type: 'text'},
            {label: 'Target Share of Wallet Volume (%)', fieldName: 'Target_share_of_wallet__c', type: 'Text'},
            {label: 'Target Share of Wallet revenue (%)', fieldName: 'Target_Share_of_Wallet_Revenue__c', type: 'Text' },
            //{label: 'Imerys margin(%)', fieldName: 'Imerys_margin__c', type: 'number' ,editable: true},
            {label: 'Imerys Potential', fieldName: 'Imerys_potential__c', type: 'text'  }
            ]);
        
        var action = component.get("c.fetchProdlistfortable");
        
        action.setParams({
            "AccountId": AccountID
            
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var rows = response.getReturnValue();
                if(rows != null){
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        if(row.Annual_Revenue__c != null)
                        {
                            row.Annual_Revenue__c  =  row.Annual_Revenue__c+' '+ component.get("v.currencyValue");
                        }
                        
                        if(row.Total_customer_revenue__c != null)
                        {
                            row.Total_customer_revenue__c  =  row.Total_customer_revenue__c+' '+ component.get("v.currencyValue");
                        }
                        
                        if(row.Imerys_margin__c != null)
                        {
                            row.Imerys_margin__c  =  row.Imerys_margin__c+'%';
                        }
                        
                        if(row.Target_share_of_wallet__c  != null)
                        {
                            row.Target_share_of_wallet__c  =  row.Target_share_of_wallet__c+'%'; 
                        }
                        if(row.Target_share_of_wallet__c  == '0%')
                        {
                            row.Target_share_of_wallet__c  =  ''; 
                        }
                        
                        if(row.Imerys_share_of_wallet__c  != null)
                        {
                            row.Imerys_share_of_wallet__c  =  row.Imerys_share_of_wallet__c+'%';  
                        }
                        if(row.Imerys_share_of_wallet__c  == '0%')
                        {
                            row.Imerys_share_of_wallet__c  =  ''; 
                        }
                        
                        if(row.Imerys_Share_of_Wallet_Revenue__c  != null)
                        {
                            row.Imerys_Share_of_Wallet_Revenue__c  =  row.Imerys_Share_of_Wallet_Revenue__c+'%';  
                        }
                        if(row.Imerys_Share_of_Wallet_Revenue__c  =='0%')
                        {
                            row.Imerys_Share_of_Wallet_Revenue__c  =  '';  
                        }
                        
                        if(row.Target_Share_of_Wallet_Revenue__c  != null)
                        {
                            row.Target_Share_of_Wallet_Revenue__c  =  row.Target_Share_of_Wallet_Revenue__c+'%';  
                        }
                        if(row.Target_Share_of_Wallet_Revenue__c  == '0%')
                        {
                            row.Target_Share_of_Wallet_Revenue__c  =  ''; 
                        }
                        if(row.Annual_Revenue__c  == '0'+' '+ component.get("v.currencyValue"))
                        {
                            row.Annual_Revenue__c  =  ''; 
                        }
                        if(row.Total_customer_revenue__c  == '0'+' '+ component.get("v.currencyValue"))
                        {
                            row.Total_customer_revenue__c  =  ''; 
                        }
                        
                    }
                }
                component.set("v.Productshowlist", rows);
            }
        });
        $A.enqueueAction(action);
    },
    
  
    fetchproductHelper : function(component, event, helper) {
        
        component.set('v.productlistcolumns', [ {label: 'Product Name', fieldName: 'Name', type: 'text' }  ]);
        var serachvalue = component.find("textfieldid").get("v.value");
        var action = component.get("c.fetchProddetails");
        action.setParams({ 
            "searchstr" : serachvalue
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                
                var rows = response.getReturnValue();
                if(rows.length > 0){
                    component.set("v.productList", rows);
                    component.set("v.truthyproduct", true);
                }
            }
        });
        $A.enqueueAction(action);    
    },
    
    fetchproductdetails : function(component, event, helper) {
        
        var productrecordid = component.get("v.SelectedProductRecordID" );
        var AccountRecordId = component.get("v.SelectedRecordID" );
        
        var OurAnnualRevenueValue = component.find("OurAnnualRevenueAuraID").get("v.value");
        if(OurAnnualRevenueValue){
            OurAnnualRevenueValue=parseFloat(OurAnnualRevenueValue);
        }
        //console.log(OurAnnualRevenueValue);
        if(!OurAnnualRevenueValue){
            OurAnnualRevenueValue=0;
        }
        var TotalCustomerRevenueValue = component.find("TotalCustomerRevenueID").get("v.value");
        if(!TotalCustomerRevenueValue){
            TotalCustomerRevenueValue=0;
        }
        if(TotalCustomerRevenueValue){
            TotalCustomerRevenueValue=parseFloat(TotalCustomerRevenueValue);
        }
        //var ImerysMarginValue = component.find("ImerysMarginAuraID").get("v.value"); 
        var TotalConsumptioninVolumeValue = component.find("TotalConsumptioninVolumeAuraID").get("v.value"); 
        var UnitsValue = component.find("Unit").get("v.value"); 
        var ImerysshareofwalletValue = component.find("ImerysshareofwalletAuraID").get("v.value");
        if((ImerysshareofwalletValue) && ImerysshareofwalletValue.includes('%')){
            var ImerysshareofwalletValue=ImerysshareofwalletValue.replace(/%/g,"");
        }
        if(!ImerysshareofwalletValue){
            ImerysshareofwalletValue=0;
        }
        
        var ImerysshareofwalletRevenueValue = component.find("ImerysshareofwalletRevenueID").get("v.value");
        if((ImerysshareofwalletRevenueValue) && ImerysshareofwalletRevenueValue.includes('%')){
            var ImerysshareofwalletRevenueValue=ImerysshareofwalletRevenueValue.replace(/%/g,"");
        }
        if(!ImerysshareofwalletRevenueValue){
            ImerysshareofwalletRevenueValue=0;
        }
        var TargetshareofwalletValue = component.find("TargetshareofwalletAuraID").get("v.value");
        if((TargetshareofwalletValue) && TargetshareofwalletValue.includes('%')){
            var TargetshareofwalletValue=TargetshareofwalletValue.replace(/%/g,"");
        }
        if(!TargetshareofwalletValue){
            TargetshareofwalletValue=0;
        }
        var TargetshareofwalletRevenueValue = component.find("TargetshareofwalletRevenueID").get("v.value"); 
        if((TargetshareofwalletRevenueValue) && TargetshareofwalletRevenueValue.includes('%')){
            var TargetshareofwalletRevenueValue=TargetshareofwalletRevenueValue.replace(/%/g,"");
        }
        if(!TargetshareofwalletRevenueValue){
            TargetshareofwalletRevenueValue=0;
        }
        
        var ImeryspotentialValue = component.find("ImeryspotentialAuraID").get("v.value"); 
        var AnnualVolumeValue = component.find("AnnualVolumeAuraID").get("v.value");
        
        //var UnitValue = component.find("Unit").get("v.value"); 
        
        var action = component.get("c.productInsertion");
        if(productrecordid != null){
            
            action.setParams({ 
                "AccountRecordID" : AccountRecordId,
                "productrecordID" : productrecordid,
                "OurAnnualRevenue" : OurAnnualRevenueValue,
                "TotalCustomerRevenue" : TotalCustomerRevenueValue,
                //"ImerysMargin": ImerysMarginValue,
                "TotalConsumptioninVolume" : TotalConsumptioninVolumeValue,
                "Unit" : UnitsValue,
                "Imerysshareofwallet" : ImerysshareofwalletValue,
                "ImerysshareofwalletRevenue" : ImerysshareofwalletRevenueValue,
                "TargetshareofwalletRevenue" : TargetshareofwalletRevenueValue,
                "Targetshareofwallet" : TargetshareofwalletValue,
                "Imeryspotential" : ImeryspotentialValue,
                "AnnualVolume": AnnualVolumeValue,
                
                //"Unit": UnitValue,
            });
            action.setCallback(this, function(response){
                var state = response.getState();
                //console.log('State'+state);
                if (state === "SUCCESS") {
                    var rows = response.getReturnValue();
                    if(rows.length > 0){
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            title : 'Success',
                            message: 'Product is Updated',
                            key: 'info_alt',
                            type: 'success',
                            mode: 'pester'
                        });
                        toastEvent.fire();
                        
                        component.set("v.SelectedRecordName" , '' );
                        component.set("v.OurAnnualRevenue" , '');
                        component.set("v.TotalCustomerRevenue" , '');
                        //component.set("v.ImerysMargin" , '' );
                        component.set("v.Unit" , '');
                        component.set("v.TotalConsumptioninVolume" , '');
                        component.set("v.Imerysshareofwallet" , '' );
                        component.set("v.ImerysshareofwalletRevenue" , '' );
                        component.set("v.TargetshareofwalletRevenue" , '' );
                        component.set("v.Targetshareofwallet" , '' );
                        component.set("v.Imeryspotential" , '' );
                        component.set("v.AnnualVolume" , '' );
                        
                        //component.set("v.Unit" , '');
                        component.set("v.productfieldsenabled" , false );
                        
                        
                        
                        
                    }
                    else{
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            title : 'Error',
                            message:'This is an error message',
                            type: 'error',
                            mode: 'pester'
                        });
                        toastEvent.fire();
                        
                        component.set("v.SelectedRecordName" , '' );
                        component.set("v.OurAnnualRevenue" , '');
                        component.set("v.TotalCustomerRevenue" , '');
                        //component.set("v.ImerysMargin" , '' );
                        component.set("v.Unit" , '');
                        component.set("v.TotalConsumptioninVolume" , '');
                        component.set("v.Imerysshareofwallet" , '' );
                        component.set("v.ImerysshareofwalletRevenue" , '' );
                        component.set("v.TargetshareofwalletRevenue" , '' );
                        component.set("v.Targetshareofwallet" , '' );
                        component.set("v.Imeryspotential" , '' );
                        component.set("v.AnnualVolume" , '' );
                        
                        //component.set("v.Unit" , '');
                        component.set("v.productfieldsenabled" , false );
                        
                       
                    }
                }
                
            });
            
        }
        $A.enqueueAction(action);
    },
    
    saveProductfromtable : function(component, event, helper) {
        var editedRecords =  component.find("productDataTable").get("v.draftValues");
       // console.log(editedRecords)
        var totalRecordEdited = editedRecords.length;
        var action = component.get("c.updateproduct");
        action.setParams({
            'editedProductList' : editedRecords
        });
        action.setCallback(this,function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                if(response.getReturnValue() === true){
                    
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Success",
                        "type": "success",
                        "message": totalRecordEdited+" Product Records Updated"
                    });
                    toastEvent.fire();
                    $A.get("e.force:refreshView").fire();
                    
                } else{ 
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Error!!",
                        "type": "error",
                        "message": "Error in update"
                    });
                    toastEvent.fire();
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    //Pranay - US1331
    fetchCurrencyValue : function(component, event, helper) {
         var AccountPlanId = component.get("v.recID"); //pranay
        //console.log('Printing acc plan rec id helper ' ,component.get("v.recID")); //pranay
        var currrency;
        var action4 = component.get("c.fetchCurrencyOfAccPlan");
        
        action4.setParams({
            "AccountPlanId": AccountPlanId //pranay
        });
        
        action4.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
               component.set("v.currencyValue",response.getReturnValue());
            currrency = component.get("v.currencyValue");  
              //  console.log('Currency is:',currrency);
            }
        });
         $A.enqueueAction(action4);  
    },
    
    deleterow : function(component, event, helper) {
        var ProdId = component.get("v.ProdId");
        var AccountRecordId = component.get("v.SelectedRecordID" );
        var action = component.get("c.deleteProduct"); 
        action.setParams({
            "AccountId": AccountRecordId,
            "ProdId": ProdId
        });
        
            action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "The record has been delete successfully."
                    
                });
                toastEvent.fire();
                window.location.reload();
                console.log('Deleted');
            }
        });
         $A.enqueueAction(action);
        
    }
    
})