@isTest
public class AP01_AccountControllerTest {
     @testSetup
    static void testSetup() {
        
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
        
        Product2 p = new product2();
        p.Name = 'zzzz';
        p.IsActive = true;
        p.ManufacturingImerysPlant__c = '';
        p.Division__c = 'Calderys';
        Database.insert(p, true);
        
    }
    @isTest static void AccountControllertest(){
        integer num=1;
        Id AccountPlanId = [select id,name,CurrencyIsoCode from Account_Plan__c].id;
        Id AccountId=[select id from Account].id;
        String str= 'Test';
        Test.startTest();
        {
            AP01_AccountController.accountPlanPermission(AccountId,AccountPlanId);
            AP01_AccountController.fetchAccountPlan(AccountPlanId,num,num);
            AP01_AccountController.fetchAccPlandetails(str);
            AP01_AccountController.getUserDetails();
            AP01_AccountController.getEditUserDetails(AccountPlanId);
            
            Account_Plan__c accPlan=[select id from Account_Plan__c];
            
            AP01_AccountController.deleteAccountPlan(accPlan);
        }
        Test.stopTest(); 
        
        
    }

}