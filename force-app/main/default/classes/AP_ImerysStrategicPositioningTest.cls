@isTest
public class AP_ImerysStrategicPositioningTest {
    @testSetup static void testSetup() {
        Account_Plan__c accplan = new Account_Plan__c();
        accplan.Production_and_Solution_Development_Stra__c ='Test Strategy';
        accplan.Pricing_Strategy__c='Test Pricing';
        accplan.Contract_Strategy__c = 'Test Contract';
        accplan.Service_Strategy__c = 'Test Service';
        accplan.Strategy__c = 'Test Service';
        insert accplan;
        
        Id userid = UserInfo.getUserId();
    }
    
    
    @isTest static void UpdateAccPlanTest(){
        Test.startTest();
        List <Account_Plan__c> AccPlanList= new List <Account_Plan__c>();
        AccPlanList= [select id,Production_and_Solution_Development_Stra__c,Pricing_Strategy__c,Strategy__c, Contract_Strategy__c,Service_Strategy__c from Account_Plan__c];    
        Id AccountPlanId = [select id from Account_Plan__c].id;
        AP_ImerysStrategicPositioning.newAccPlan(AccountPlanId);
        AP_ImerysStrategicPositioning.haspermission(AccountPlanId);
        
        try{
        AP_ImerysStrategicPositioning.KeyAccountOverviewRecordUpdate(AccountPlanId,AccPlanList[0].Production_and_Solution_Development_Stra__c,AccPlanList[0].Pricing_Strategy__c,AccPlanList[0].Contract_Strategy__c,AccPlanList[0].Service_Strategy__c,AccPlanList[0].Strategy__c);
        }
        catch(Exception EX){
            EX.getMessage();
        }
        
        
        Test.stopTest();
    }
    
   
    

}