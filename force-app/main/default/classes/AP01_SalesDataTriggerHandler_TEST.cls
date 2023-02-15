@isTest
/**
*@author Geerusting Govind Kumar
*@Date Creation 12/5/2020
*@Date modification 
*@description 
*/
private class AP01_SalesDataTriggerHandler_TEST{

/**
*@author Geerusting Govind Kumar
*@Date Creation 12/5/2020
*@Date modification
*@param 
*@ExcptionName
*@return 
*/   
    @isTest static void testInsertSalesData() {
        List<Profile> lstAdminPro = [SELECT Id From Profile 
                                     WHERE Name = 'System Administrator' limit 1];
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c, Email, Name FROM User 
                            WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false 
                            AND ProfileId =: lstAdminPro[0].Id LIMIT 1];
        
        users[0].ByPassValidationRule__c =true;
        update users[0];
        
        system.RunAs(users[0]){
            
            Account accTest= new Account();
            accTest.Name = 'VRTEST';
            accTest.BillingCountry = 'United States';
            accTest.BillingCity = 'New York';
            accTest.BillingStreet='Test';
            accTest.SegmentL1__c = 'Abrasive';
            accTest.DnBNumber__c = '01256hhj';
            accTest.Type = 'Head Office';
            Database.insert(accTest, true);
            
            String objectName = 'Product2';
            String fieldName ='ManufacturingImerysPlant__c';
            
            Schema.SObjectType s = Schema.getGlobalDescribe().get(objectName) ;
            Schema.DescribeSObjectResult r = s.getDescribe() ;
            Map<String,Schema.SObjectField> fields = r.fields.getMap() ;
            Schema.DescribeFieldResult fieldResult = fields.get(fieldName).getDescribe();
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
            
            List<Product2> prodPlant = [Select Id, ManufacturingImerysPlant__c, Name from product2 where ManufacturingImerysPlant__c <> null];
            
            Product2 pro = new Product2(Name = 'Test Product', ManufacturingImerysPlant__c ='IT - Gran Bianco', CurrencyIsoCode = 'EUR');
            insert pro;
            
            Sales_Data__c salDat = new Sales_Data__c();
            salDat.Tech_AccountDNB__c = accTest.DnBNumber__c;
            salDat.Tech_ProductName__c = pro.Name;
            salDat.Tech_ProductPlant__c = pro.ManufacturingImerysPlant__c;
            salDat.Tech_OwnerEmail__c= users[0].Name;
            Insert salDat;      
            
        }
    }     
}