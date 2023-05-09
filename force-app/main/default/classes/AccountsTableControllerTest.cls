@isTest
public class AccountsTableControllerTest {
    
    @testSetup static void testSetup() {
        
        user useridwithATM = [select id from user where isactive = true limit 1];
        
        Id userid = UserInfo.getUserId(); 
        user useridwithOutATM = [select id from user where id =:userid limit 1];
        
        Account acc1 = new Account();
        acc1.Name = 'sdsdasassd1dsdsdd';
        acc1.BillingCountry = 'Kenya';
        acc1.BillingCity = 'New York';
        acc1.BillingStreet = 'Test';
        acc1.SegmentL1__c = 'Abrasive';
        acc1.Business_Areas__c = 'RAC';
        acc1.Type = 'Head Office';
        insert acc1;
        
        Contact con = new Contact();
        con.Salutation = 'Mr.';
        con.FirstName = 'Shia';
        con.Email = 'invalid.test@imerys.com';
        con.LastName= 'ALISHA';
        con.AccountId = acc1.Id;
        con.Attitude__c='Supportive';
        con.Influence__c='2';
        insert con;
        
        
        list<AccountTeamMember> atmlist = new list<AccountTeamMember>();
        
        AccountTeamMember ATM = new AccountTeamMember();
        ATM.AccountId = acc1.id;
        ATM.Business_Area__c='HTS';
        ATM.TeamMemberRole = 'Agent';
        ATM.UserId = useridwithOutATM.id;
        insert ATM;

        Account_Plan__c accplan = new Account_Plan__c();
        accplan.Account__c =acc1.id;
        accplan.Year__c = '2021';
        insert accplan;

    } 
    
    @isTest static void getStakeholderMapValuesTest(){ 
        Test.startTest();
        
        Id AccountPlanId = [select id from Account_Plan__c where Year__c = '2021'].id;
        Id ContactId=[select id from Contact].id;
        String ConString='Test';
        String Attitude='Supportive';
        String Influence='1';
        AccountsTableController.haspermission(AccountPlanId);
        
        AccountsTableController.getRecords(AccountPlanId);
        
        AccountsTableController.updateContact(ContactId,ConString,ConString,Attitude,ConString,Influence,ConString);
        
        
        Test.stopTest();
        
    }
    
     @isTest static void getPicklistValuestest(){
        Test.startTest();
        {	
             Id ContactId=[select id, AccountId from Contact].id;
             Contact Con = new Contact( id=ContactId, Influence__c = '3',Attitude__c='Supportive');  
             
             AccountsTableController.getPicklistValuesForInfluence();
             AccountsTableController.getPicklistValuesForAttitue();
            
        }
      
        
    }
}