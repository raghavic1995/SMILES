@isTest
public class SOWTest {

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
        
        Product2 p = new product2();
        p.Name = 'zzzz';
        p.IsActive = true;
        p.ManufacturingImerysPlant__c = '';
        p.Division__c = 'Calderys';
        Database.insert(p, true);
        
    }
    
    @isTest static void fetchAccountstest(){
        Test.startTest();
    {
       Id AccountPlanId = [select id,CurrencyIsoCode from Account_Plan__c].id;
        SOW.haspermission(AccountPlanId);
 
        SOW.fetchAccounts(AccountPlanId);
        
        SOW.fetchCurrencyOfAccPlan(AccountPlanId);
    }
      Test.stopTest(); 
    }
    
    @isTest static void fetchProddetailstest(){
        Test.startTest();
    {  
       String Productstr = 'zzzz';
       List<Product2> ProductId = [select id,Name from Product2 WHERE Name LIKE :Productstr];
       SOW.fetchProddetails(Productstr);
        
        
       Id AccountId = [select id,Account__c from Account_Plan__c].Account__c;
       Id ProdID = [select id,Name from Product2].id;
       List<Product2> ProductList = [select Id,Name,Annual_Revenue__c,Total_customer_revenue__c,Units1__c,Imerys_Share_of_Wallet_Revenue__c,Target_Share_of_Wallet_Revenue__c, Imerys_margin__c,Total_consumption_in_Volume__c,Units__c,Imerys_share_of_wallet__c,Target_share_of_wallet__c, 
                           Imerys_potential__c,Annual_Volume__c  from product2 WHERE Account__r.id =: AccountId];
        
       SOW.fetchProdlistfortable(AccountId);
        
       list<Product2> ProdListforUpdate = [select id from Product2 ];
        string json = JSON.serialize(ProdListforUpdate);
        try{
            SOW.updateproduct(ProdListforUpdate);
        }catch(Exception EX){
            EX.getMessage();
        }
        
        SOW.updateproduct(ProdListforUpdate);
        
       
        Decimal dx = 12.0;
        String Units = 'test';
        String UnitPicklist = 'Bags';
        SOW.productInsertion(AccountId,ProdID,dx,UnitPicklist,dx,dx,Units,Units,dx,dx,dx,dx,Units,Units);

    }
      Test.stopTest(); 
}
    
    @isTest static void getPicklistValuestest(){
        Test.startTest();
        {
             Product2 Prod = new Product2( Name = 'Prod1',IsActive = true,Division__c = 'Calderys',Units1__c = 'Bags');  
             insert Prod; 

             SOW.getPicklistValues();
            
        }
      
        
    }
    
}