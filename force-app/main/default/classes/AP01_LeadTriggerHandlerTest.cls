@isTest
public class AP01_LeadTriggerHandlerTest {
 /**
*@author Sipra Sahoo
*@Date Creation 09-02-2022
*@param 
*@ExcptionName
*@return 
*/
     @testSetup  static void testSetup() {
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        List<User> users = [SELECT Id, ByPassTriggerRule__c,ByPassValidationRule__c FROM User WHERE IsActive = true AND
                            ByPassTriggerRule__c = false 
                            AND profile.Id =: p2.Id LIMIT 100];
        
        users[0].ByPassValidationRule__c = true;
        update users[0];
        
        system.runas(users[0]){
            
            Id user1Id = users[0].Id;
            GatekeeperAssignment__c gat = New GatekeeperAssignment__c();
            gat.Division__c = 'Aluminates';
            gat.Gatekeeper__c = User1Id;
            gat.Gatekeeper2__c = User1Id;
            gat.Gatekeeper3__c = User1Id;
            gat.Gatekeeper4__c = User1Id;
            gat.Gatekeeper5__c = User1Id;
            gat.Object__c = 'Lead';
            gat.BusinessArea__c = 'RAC';
            gat.MarketSegmentL1__c = 'ACS';
            gat.Area__c ='EMEA';
            Test.startTest(); 
            insert gat;
            
            
            Lead lead = new Lead();
            lead.MarketL1__c =gat.MarketSegmentL1__c;
            lead.Area__c =gat.Area__c;
            lead.Country ='United States';
            lead.Email = 'gktest123@gmail.com';
            lead.Company ='account';
            lead.LastName =  'Client';
            insert lead;
            
            Lead_Team__c leadTeam2 = new Lead_Team__c();
            leadTeam2.Lead__c = lead.Id;
            leadTeam2.Role__c = 'Backup';
            leadTeam2.Member__c = User1Id;
            insert leadTeam2;
             
            
        }
        
    }
    
    @isTest static void populateOwnerFromGateKeeperAssignment(){   
        Test.startTest();
             list<Lead> ldList = [select id,MarketL1__c,Area__c,Country,LastName,OwnerId from Lead];
             AP01_LeadTriggerHandler.populateOwnerFromGateKeeperAssignment(ldList);
         Test.stopTest();
         }
    
     @isTest static void populateLeadTeamFromGateKeeperAssignment(){   
        Test.startTest();
             list<Lead> ldList = [select id,MarketL1__c,Area__c,Country,LastName,OwnerId,(select Id,Lead__c,Role__c,Member__c from Lead_Team__r) from Lead];
             AP01_LeadTriggerHandler.populateLeadTeamFromGateKeeperAssignment(ldList);
         Test.stopTest();
         }
 
}