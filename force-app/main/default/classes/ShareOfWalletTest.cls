@isTest
public class ShareOfWalletTest {

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
        
        @isTest static void fetchchildAccTest(){
            
            Test.startTest();
    {
       Id AccountPlanId = [select id,CurrencyIsoCode from Account_Plan__c].id;
       
        ShareOfWallet.fetchchildAcc(AccountPlanId);
        
        ShareOfWallet.KeyAccountOverview(AccountPlanId);
        
        ShareOfWallet.haspermission(AccountPlanId);
        
        Test.stopTest();
    }
  }
    
    @isTest static void KeyAccountOverviewRecordUpdateTest(){
            
            Test.startTest();
    {
      
        Id AccountPlanId = [select id,CurrencyIsoCode from Account_Plan__c].id; 
        string AccountChallengesvalue = 'Accountchallenges';
        string AccountBenefitsvalue = 'AccountBenefitsvalue';
        string valueProposition = 'valueProposition';
        string HowdoesImerysdeliverthisvalueprop = 'HowdoesImerysdeliverthisvalue';
    
       ShareOfWallet.KeyAccountOverviewRecordUpdate(AccountPlanId,AccountChallengesvalue,AccountBenefitsvalue,valueProposition,HowdoesImerysdeliverthisvalueprop);
        
        Test.stopTest();
    }
    }
    
     @isTest static void updateChildAcctsTest(){
            
            Test.startTest();
    {
        list<Account> AccountListforUpdate = [select id from Account ];
        ShareOfWallet.updateChildAccts(AccountListforUpdate);
        
        Test.stopTest();
    }
    }
    
   @isTest static void fetchAccTest(){
            
            Test.startTest();
    {
        String User = 'Test';
        List<User> Userlist = [select id,Name from User WHERE Name LIKE :User];
        ShareOfWallet.fetchAcc(User);
        Test.stopTest();
    }
    }

    @isTest static void getChildAccountsTest(){
            
            Test.startTest();
    {
        String AccountPlanId = [select id,CurrencyIsoCode from Account_Plan__c].id;
        
        ShareOfWallet.getChildAccounts(AccountPlanId);
        
        ShareOfWallet.getParentInfo(AccountPlanId);
        
        Account_Plan__c accplanupdate =  [SELECT Id, Name FROM Account_Plan__c LIMIT 1];
        string json = JSON.serialize(accplanupdate);
        try{
            ShareOfWallet.updateAccountPlanOnSave(json);
        }catch(Exception EX){
            EX.getMessage();
        }
        
      ShareOfWallet.updateAccountPlanOnSave(json);
        
        
        Test.stopTest();
    }
    }     
}