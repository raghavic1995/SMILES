@isTest
public class AP01_AccountPlanTriggerHandlerTest {
   
       @testSetup static void testSetup() {
          
       
           Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        List<User> users = [SELECT Id, ByPassTriggerRule__c,ByPassValidationRule__c FROM User WHERE IsActive = true AND
                            ByPassTriggerRule__c = false 
                            AND profile.Id =: p2.Id LIMIT 100];
        
        users[0].ByPassValidationRule__c = true;
        update users[0];
           
           Id user1Id = users[0].Id;
           Id user2Id = users[1].Id;
           
           Id userId= UserInfo.getUserId();
        
        Account acc1 = new Account();
        acc1.Name = 'sdsdasassd1dsdsdd';
        acc1.BillingCountry = 'Kenya';
        acc1.BillingCity = 'New York';
        acc1.BillingStreet = 'Test';
        acc1.SegmentL1__c = 'Abrasive';
        acc1.Business_Areas__c = 'RAC';
        acc1.Type = 'Head Office';
        insert acc1;
           
        AccountTeamMember ATM = new AccountTeamMember();
        ATM.AccountId = acc1.id;
        ATM.Business_Area__c='HTS';
        ATM.TeamMemberRole = 'Agent';
        ATM.UserId = user1Id;
        insert ATM;
           
         Test.startTest();   
        List<Account_Plan__c> accplannewlist = new List<Account_Plan__c>();
        Account_Plan__c accplan = new Account_Plan__c();
        accplan.Account__c =acc1.id;
        accplan.Year__c = '2021';
        accplan.OwnerId = userId;
        accplannewlist.add(accplan);   
        insert accplannewlist;
           
         AccountPlanTeam__c aptm= new AccountPlanTeam__c();
           aptm.Member__c= userId;
           aptm.Access__c='Edit';
           aptm.AccountPlanNo__c=accplan.id;
           insert aptm;
        
        Account_Plan__c AccountPlanListUpdate = [select id,Year__c,OwnerId,Account__c FROM Account_Plan__c WHERE Id =:accplan.id ];
        AccountPlanListUpdate.Year__c = '2022';
        //AccountPlanListUpdate.OwnerId = user2Id;
        //AccountPlanListUpdate.add(accplan);
        Update AccountPlanListUpdate;
    
       test.stopTest(); 
       } 

    @isTest static void techUpdateTeamMemberstest(){ 
        Test.startTest();
        Set<String> AccPlanListforUpdate = new Set<String>();
        
        String AccountPlanId = [select id from Account_Plan__c where Year__c = '2022'].id;
        AccPlanListforUpdate.add(AccountPlanId);
        AP01_AccountPlanTriggerHandler.techUpdateTeamMembers(AccPlanListforUpdate);
       // AP01_AccountPlanTriggerHandler.techUpdateTeamMembersParents(AccPlanListforUpdate);
       
        
        Test.stopTest();
        
    }
    
      @isTest static void techUpdateTeamMembersParentstest(){ 
        Test.startTest();
        Set<String> AccPlanListforUpdate = new Set<String>();
        
        String AccountPlanId = [select id from Account_Plan__c where Year__c = '2022'].id;
        AccPlanListforUpdate.add(AccountPlanId);
       // AP01_AccountPlanTriggerHandler.techUpdateTeamMembers(AccPlanListforUpdate);
        //AP01_AccountPlanTriggerHandler.techUpdateTeamMembersParents(AccPlanListforUpdate);
        Test.stopTest();
        
    }
    
        
    }