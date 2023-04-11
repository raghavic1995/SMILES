@isTest
public class Case_AddErrorOnOwnerChangeTest {
    @isTest static void testError(){
   
        String recordTypeName;
        Integer countOwner;
        date myDate = date.parse('05/11/2017');
        date mydate2 = date.parse('08/12/2018');
        DateTime date1 = Date.today();  
        
        Profile p3 = [select id from profile where name='System Administrator' LIMIT 1];
        
        List<User> users = [SELECT Id,CountryforGatekeeper__c, BackupComplaint__c FROM User WHERE IsActive = true
                            AND ByPassTriggerRule__c = false AND
                            profile.Id =:p3.Id LIMIT 100];
        Id user1Id = users[3].Id;
        Id user2Id = users[4].Id; 
        Id user3Id = users[0].Id;
       
        users[0].ByPassValidationRule__c = true;
        users[0].ByPassProcessBuilders__c = true;
        users[0].CountryforGatekeeper__c='India';
        update users[0];
        
        system.runas(users[0]){ 
            
            Test.startTest();
            
            Account acc1 = new Account();
            acc1.Name = 'sdsdasassd1dsdsdd';
            acc1.BillingCountry = 'United States';
            acc1.BillingCity = 'New York';
            acc1.BillingStreet = 'Test';
            acc1.SegmentL1__c = 'Abrasive';
            acc1.Type = 'Head Office';
            Database.insert(acc1, true);    
            
            Contact con = new Contact();
            con.Salutation = 'Mr.';
            con.FirstName = 'Shia';
            con.Email = 'test@accenture.com';
            con.LastName= 'ALISHA';
            con.AccountId = acc1.Id;
            Database.insert(con, true);
            
            Product2 p = new product2();
            p.Name = 'kjskd';
            p.ManufacturingImerysPlant__c = '';
            p.IsActive = true;
            p.Division__c = 'Calderys';
            
            Product2 p2 = new product2();
            p2.Name = 'kjskd';
            p2.ManufacturingImerysPlant__c = 'AT - Villach';
            p2.IsActive = true;
            p2.BusinessArea__c='HTS';
            p2.New_Product_Type_1__c='Bricks';
            p2.New_Product_Type_2__c='Calderys';
            p2.Division__c = 'Aluminates';
            
            Database.insert(p, true);
            Database.insert(p2, true);
                      
            
            Case cas = New Case();
            cas.AccountId= acc1.Id;
            //cas.RecordTypeId = recordTypeName;
            cas.ContactId = con.Id;
            cas.divisions__c = 'Ceramics';
            cas.Status = 'Draft Creation';
            cas.Type = 'Contamination';
            cas.csAccountManager__c = users[5].id;
            cas.Receiver__c = users[4].id;
            cas.ProductName__c = p.Id;
            cas.BusinessArea__c = 'PM APAC';
            cas.GateKeeper__c = User2Id;
            cas.DateRaisedCustomer__c = myDate; 
            cas.OwnerId = user3Id;   
            cas.Description = 'Test';
            cas.Subject = 'Case'; 
            Database.Insert(cas, true);// insert new record with status Draft Creation
            
            /*cas.OwnerId=user2Id;
            Database.update(cas, true);*/
           
            Test.stopTest();
            //System.AssertEquals(caseRecord[0].GateKeeper__c, users[1].Id);
            
        }
    }
    
}