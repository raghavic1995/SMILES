@isTest
public class AccountPlanStageTest {
    
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
        
        Account_Plan_Priorities__c APPri = new Account_Plan_Priorities__c();
        APPri.Name = 'Test';
        APPri.Imerys_Strategic__c = 'Test';
        APPri.Description_for_the_Priorities_of_the_Ke__c = 'Test';
        insert APPri;
        
        
    } 
    
    @isTest static void haspermissionTest(){ 
        Test.startTest();
        Id AccountPlanId = [select id from Account_Plan__c where Year__c = '2021'].id;
        AccountPlanStages.haspermission(AccountPlanId);
        AccountPlanStages.getAccountPlanPrioritiesList(AccountPlanId);
        
        try{
            AccountPlanStages.haspermission(null);
        }catch(Exception EX){
            EX.getMessage();
        }
        Test.stopTest();  
    }
    
    
    @isTest static void saveAccountPlanPrioritiesListTest(){  
        list<Account_Plan_Priorities__c> APPriority = [select id from Account_Plan_Priorities__c where Name = 'Test'];   
        AccountPlanStages.saveAccountPlanPrioritiesList(APPriority);   
    }
    
    @isTest static void InsertAccountPlanPrioritiesListTest(){  
        
        Id AccountPlanId = [select id from Account_Plan__c where Year__c = '2021'].id;
        AccountPlanStages.InsertAccountPlanPrioritiesList(AccountPlanId,'Test','Test','Test','Test'); 
    }
    
}