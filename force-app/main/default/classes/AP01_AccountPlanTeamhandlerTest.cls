@isTest
public class AP01_AccountPlanTeamhandlerTest {
    
    @testSetup static void testSetup() {
        
        
        Account acc1 = new Account();
        acc1.Name = 'sdsdasassd1dsdsdd';
        acc1.BillingCountry = 'Kenya';
        acc1.BillingCity = 'New York';
        acc1.BillingStreet = 'Test';
        acc1.SegmentL1__c = 'Abrasive';
        acc1.Business_Areas__c = 'RAC';
        acc1.Type = 'Head Office';
        insert acc1;
        
        Account_Plan__c accplan = new Account_Plan__c();
        accplan.Account__c =acc1.id;
        accplan.Year__c = '2021';
        insert accplan;
        
        
        
    }
    
    
    @isTest static void hasPermissionTest(){ 
        Test.startTest();
        ID userid = [select id from user where email!=Null limit 1].id;
        Id AccountId = [select id from Account_Plan__c where Year__c = '2021'].id;
        AccountPlanTeam__c apt = new AccountPlanTeam__c();
        apt.Access__c = 'Edit';
        apt.AccountPlanNo__c = AccountId;
        apt.Member__c = userid;
        apt.Role__c = 'Account Manager';
        insert apt;
        apt.Role__c= 'BA Customer Service';
        update apt;
        
        Test.stopTest();
        
    }
    
    
    
    
}