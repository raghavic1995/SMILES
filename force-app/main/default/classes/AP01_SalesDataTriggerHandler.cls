/**
*@author Geerutsing Govind Kumar
*@Date Creation 
*@Date modification 
*@description prefill account and product
*/
public class AP01_SalesDataTriggerHandler extends TriggerHandler{
/**
*@author Geerutsing Govind Kumar
*@Date Creation 
*@Date modification 
*@param  
*@ExcptionName                    
*@return 
*/   
    public static void createNewSalesData(List<Sales_Data__c> aNewSet){
    //Define set 
        Set<String>accountDNBSet = new Set<String>();
        Set<String>productNameSet = new Set<String>();
        Set<String>imerysPlantSet = new Set<String>();
        Set<String>ownerNameSet = new Set<String>();
        Set<String>dnBSet = new Set<String>();
        Boolean byPassTrigger;
        
        for(Sales_Data__c sal : aNewSet){
            if(sal.Tech_AccountDNB__c != null){            
                accountDnbSet.add(sal.Tech_AccountDNB__c.toLowerCase());
            }
            if(sal.Tech_ProductName__c!=null){              
                productNameSet.add(sal.Tech_ProductName__c.toLowerCase());
            }
            if(sal.Tech_ProductPlant__c!=null){         
                imerysPlantSet.add(sal.Tech_ProductPlant__c.toLowerCase());
            }
            if(sal.Tech_OwnerEmail__c!=null){
                ownerNameSet.add(sal.Tech_OwnerEmail__c.toLowerCase());
            }
        }         
        Map<String, Account> accMap = new Map<String, Account>();
        Map<String, Product2> prodMap = new Map<String, Product2>();
        Map<String, User> userNameMap = new Map<String, User>();
        Map<String, User> userEmailMap = new Map<String, User>();
        
        List<User> userList = [SELECT Id, ByPassTriggerRule__c FROM User WHERE Id=:userinfo.getUserId() LIMIT 1];
        byPassTrigger = userList[0].ByPassTriggerRule__c;   
        Matcher MyMatcher;
        
        if(!ownerNameSet.IsEmpty()){            
            for(User ur:[Select Id, Name from User WHERE Name IN: ownerNameSet]){
                userNameMap.put(ur.Name.toLowerCase(), ur);
            }                   
        }
        if(!ownerNameSet.IsEmpty()){            
            for(User ur2:[Select Id, Email from User WHERE Email IN: ownerNameSet]){
                userEmailMap.put(ur2.Email.toLowerCase(), ur2);
            }                   
        }       
        if(!accountDnbSet.isEmpty()){   // verify if set is not null           
            for(Account acct: [Select Id, DnBNumber__c from Account WHERE DnBNumber__c IN: accountDnbSet]){
                accMap.put(acct.DnBNumber__c.toLowerCase(), acct);
            }
        }                        
        if(!imerysPlantSet.isEmpty()){
            for(Product2 prod:[Select Id, Name from Product2 WHERE Name IN: productNameSet AND ImerysManufacturingPlant__r.name IN: imerysPlantSet]){
                prodMap.put(prod.Name.toLowerCase(), prod);
            }
        }           
       
        for(Sales_Data__c salInsert: aNewSet){                                                          
            if(accMap.size() > 0){                        
                salInsert.Account__c = accMap.get(salInsert.Tech_AccountDNB__c.toLowerCase()).Id;               
            }else if(salInsert.Account__c!=null){                        
            }           
            else{
                salInsert.addError(Label.CL00062);
            }
            if(prodMap.size() > 0){
                salInsert.Imerys_Product__c = prodMap.get(salInsert.Tech_ProductName__c.toLowerCase()).Id;              
            }else if(salInsert.Imerys_Product__c!=null || salInsert.Imerys_Product__c== null){                        
            }
            else{
                salInsert.addError(Label.CL00063);
            }
            if(userNameMap.size() > 0){             
                salInsert.OwnerId = userNameMap.get(salInsert.Tech_OwnerEmail__c.toLowerCase()).Id;               
            }else if(userEmailMap.size() > 0){
                salInsert.OwnerId = userEmailMap.get(salInsert.Tech_OwnerEmail__c.toLowerCase()).Id;
            }
            else if(salInsert.OwnerId!=null){                        
            }
            else{
                salInsert.addError(Label.CL00064);
            }               
        }
    }                   
/**
*@author Geerutsing Govind Kumar
*@Date Creation 
*@Date modification 
*@param
*@ExcptionName                  
*@return method 
*/  
    public override void beforeInsert(){
        //Override method BeforeUpdate from class Handler 
        createNewSalesData(trigger.new);      
    }
}