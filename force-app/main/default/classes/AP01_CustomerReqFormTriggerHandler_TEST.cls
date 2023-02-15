@isTest
/**
*@author Geerusting Govind Kumar
*@Date Creation 16/02/2021
*@Date modification 
*@description update currency
*/
private class AP01_CustomerReqFormTriggerHandler_TEST{
    /**
*@author Geerusting Govind Kumar
*@Date Creation 16/02/2021
*@Date modification
*@param 
*@ExcptionName
*@return error message in custom label 
*/   
    @isTest static void testCreateCustomerRequestForm() {
        
        // Select users for the test.
        Integer numRec = 1;
        Integer numTeamPerSamp = 2;
        
        date mydate1 = date.parse('05/11/2017');
        date mydate2 = date.parse('05/11/2030');
        DateTime date1 = Date.today();
        
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        List<Account> accts = new List<Account>();
        List<Contact> conts = new List<Contact>();
        List<Customer_Request_Form__c> custList = new List<Customer_Request_Form__c>();
        List<Customer_Request_Form__c> custUpdList = new List<Customer_Request_Form__c>();
        List<relationship__c> relList = new List<relationship__c>();
        List<CustomerRequestTeam__c> cusTeamList = new List<CustomerRequestTeam__c>();
        List<Product2> productList = new List<Product2>();
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User WHERE IsActive = true AND ByPassTriggerRule__c = false
                            AND ProfileId =: p2.Id LIMIT 5];
        Id user1Id = users[0].Id;
        Id user2Id = users[1].Id;
        Id user3Id = users[2].Id;
        
        users[0].ByPassValidationRule__c = true;
        users[0].ByPassDuplicateRules__c = true;
        update users[0];
        
        system.runas(users[0]){
            
            for(Integer i=0;i<numRec;i++) {
                
                Product2 p3 = new product2();
                p3.Name = 'kjskd' + i;
                p3.ManufacturingImerysPlant__c = '';
                p3.IsActive = true;
                productList.add(p3);
            }
            // By Anshu 16/08/2022
            Imerys_Site__c ims= new Imerys_Site__c();
            ims.Name= 'AR - Imerys Minerales Argentina';
            ims.ImerysSellingEntity__c=True;
            Database.insert(ims, true);
            
            
            GatekeeperAssignment__c gat = New GatekeeperAssignment__c();
            gat.Gatekeeper__c = User2Id;
            gat.Gatekeeper2__c = user1Id;
            gat.Gatekeeper3__c = user2Id;
            gat.Gatekeeper4__c =user2Id;
            gat.ImerysSellingEntity__c ='1';
            gat.Object__c = 'Customer Request Form';
            gat.Process__c = 'Customer Service in charge';
            gat.Imerys_Site__c=ims.Id;
            Database.insert(gat, true);
            
            GatekeeperAssignment__c gat3 = New GatekeeperAssignment__c();
            gat3.Gatekeeper__c = User2Id;
            gat3.Gatekeeper2__c = User2Id;
            gat3.Gatekeeper3__c = user1Id;
            gat3.Imerys_Site__c=ims.Id;
            gat3.Gatekeeper4__c =user1Id;
            gat3.ImerysSellingEntity__c ='1';
            gat3.Object__c = 'Customer Request Form';
            gat3.Process__c ='Credit Controller in Charge';
            
            Database.insert(gat3, true);
            
            GatekeeperAssignment__c gat2 = New GatekeeperAssignment__c();
            gat2.Gatekeeper__c = User2Id;
            gat2.Gatekeeper2__c = User2Id;
            gat2.Gatekeeper3__c = user1Id;
            gat2.Gatekeeper4__c =user1Id;
            gat2.ImerysSellingEntity__c ='100';
            gat2.Object__c = 'Customer Request Form';
            gat2.Process__c = 'ERP Creator in Charge';
            gat2.Imerys_Site__c=ims.Id;
            Database.insert(gat2, true);
            
            
            GatekeeperAssignment__c gat4 = New GatekeeperAssignment__c();
            gat4.Gatekeeper__c = User2Id;
            gat4.Gatekeeper2__c = user1Id;
            gat4.Gatekeeper3__c = user2Id;
            gat4.Gatekeeper4__c =user2Id;
            gat4.ImerysSellingEntity__c ='100';
            gat4.Object__c = 'Customer Request Form';
            gat4.Imerys_Site__c=ims.Id;
            Database.insert(gat4, true);
            
            for(Integer i=0;i<numRec;i++) {
                
                Account acc1 = new Account();
                acc1.Name = 'sdsdasassd1dsdsdd' + i;
                acc1.BillingCountry = 'United States';
                acc1.BillingCity = 'New York';
                acc1.BillingStreet = 'Street';
                acc1.SegmentL1__c = 'Abrasive';
                acc1.Type = 'Head Office';
                //acc1.Business_Areas__c='PM EMEA';
                accts.add(acc1);
            }
            Database.insert(accts, true); 
            
            for(Integer i=0;i<numRec;i++) {
                
                Account acct = accts[i];
                relationship__c relation = new Relationship__c();
                relation.AccountName__c = acct.Id;
                relation.AccountManager__c = user1Id;
                relation.SubType__c = 'Consultant';
                relation.BusinessArea__c = 'RAC';
                //relation.SegmentL2__c = 'Automotive';
                relList.add(relation);
            }   
            
            Database.insert(relList, true);
            
            for(Integer j=0;j<numRec;j++) {
                
                Account acct = accts[j];
                Contact con = new Contact();
                con.Salutation = 'Mr.';
                con.FirstName = 'Shia' + j;
                con.LastName= 'ALISHA' + j;
                con.Email = 'test@accenture.com';
                con.AccountId = acct.Id;
                conts.add(con);
                
            }
            
            Database.insert(conts, true);
            
            Market_Segmentation__c markSeg =  new Market_Segmentation__c();
            markSeg.Name = 'test';
            markSeg.Segmentation_Level_2__c =true;
            markSeg.Segmentation_Level_3__c = true;
            markSeg.Record_Level_1__c =true;
            markSeg.Record_Level_2__c =true;
            markSeg.Record_Level_3__c =true;
            markSeg.Record_Level_4__c =true;
            markSeg.Market_Segmentation_Code__c = '12352df02';
            markSeg.Market_Segmentation_Global_Code__c='12-34-56-78';
            insert markSeg;
            
            
            for(Integer j=0;j<numRec;j++) {
                
                Account acct = accts[j];
                Contact cct = conts[j];
                Product2 prod = productList[j];
                Customer_Request_Form__c cust = new Customer_Request_Form__c();
                cust.Business_Area__c ='RAC';
                cust.Imerys_Selling_Entity_Lookup__c=ims.Id;
                //cust.Customer_Service_in_Charge__c=user2Id;
                cust.ImerysSellingEntityGlobal__c ='AR - Imerys Minerales Argentina';
                cust.Account_Manager__c =user1Id;
                cust.CreditControllerinCharge__c=user3Id;
                cust.Ship_To__c = acct.Id;
                custList.add(cust);
                
                Customer_Request_Form__c cust2 = new Customer_Request_Form__c();
                cust2.Business_Area__c ='RAC';
                cust2.Imerys_Selling_Entity_Lookup__c=ims.Id;
                cust2.ImerysSellingEntityGlobal__c ='AR - Imerys Minerales Argentina';
                cust2.Account_Manager__c =user1Id;
                cust2.CreditControllerinCharge__c=user2Id;
                cust2.Customer_Service_in_Charge__c=user2Id;
                cust2.Ship_To__c = acct.Id;
                custList.add(cust2);
            }
            
            insert custList;
            
            
            for(Integer j=0;j<numRec;j++) {
                
                Customer_Request_Form__c form = custList[j];
                
                for (Integer k=0;k<numTeamPerSamp;k++) {
                    
                    CustomerRequestTeam__c team = new CustomerRequestTeam__c();
                    team.Member__c = user1Id;
                    team.Role__c = 'Account Manager';
                    team.CustomerRequestForm__c = form.Id;
                    team.Access__c = 'Edit';
                    cusTeamList.add(team);
                }
            }
            
            for(Customer_Request_Form__c custUpdate:custList){
                //custUpdate.ImerysSellingEntity__c ='100';
                //custUpdate.ImerysSellingEntityGlobal__c ='AR - Imerys Minerales Argentina';
                custUpdate.Imerys_Selling_Entity_Lookup__c=ims.Id;
                custUpdate.ImerysSellingEntityGlobal__c ='AR - Imerys Minerales Argentina';
                custUpdate.Account_Manager__c = user3Id;
                custUpdList.add(custUpdate);
            }               
            
            Test.startTest();           
            Database.Insert(cusTeamList, true);
            AP01_CustomerReqFormTriggerHandler.createCustomerServiceTeam(custList);
            Test.stopTest();
            
            Database.update(custUpdList,true);
            
            Database.delete(custUpdList,true);
            
            // Insert manual share for user who is not record owner. 
            // Query visit report records.
            List<CustomerRequestTeam__Share> sampleShrs = [SELECT Id, UserOrGroupId, AccessLevel, 
                                                           RowCause FROM CustomerRequestTeam__Share WHERE ParentId =: cusTeamList[0].Id];
            
            // Test attributes of manual share.
            if(sampleShrs.size() > 0){
                System.assertEquals(sampleShrs[0].AccessLevel, 'Edit');
            }
            
        }              
    }
    
    
    @isTest static void testupdateFields() {
        // Select users for the test.
        date mydate1 = date.parse('05/11/2017');
        date mydate2 = date.parse('05/11/2030');
        DateTime date1 = Date.today();
        
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        List<Account> accts = new List<Account>();
        List<Contact> conts = new List<Contact>();
        List<Customer_Request_Form__c> custList = new List<Customer_Request_Form__c>();
        List<Customer_Request_Form__c> custUpdList = new List<Customer_Request_Form__c>();
        List<relationship__c> relList = new List<relationship__c>();
        List<CustomerRequestTeam__c> cusTeamList = new List<CustomerRequestTeam__c>();
        List<Product2> productList = new List<Product2>();
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User WHERE IsActive = true AND ByPassTriggerRule__c = false
                            AND ProfileId =: p2.Id LIMIT 5];
        Id user1Id = users[0].Id;
        Id user2Id = users[1].Id;
        Id user3Id = users[2].Id;
        
        users[0].ByPassValidationRule__c = true;
        users[0].ByPassDuplicateRules__c = true;
        update users[0];
        
        system.runas(users[0]){
            
            Account acc1 = new Account();
            acc1.Name = 'AccountTest';
            acc1.BillingCountry = 'United States';
            acc1.BillingCity = 'New York';
            acc1.BillingStreet = 'Street';
            acc1.SegmentL1__c = 'Abrasive';
            acc1.Type = 'Head Office';
            Database.insert(acc1, true); 
            
            relationship__c relation = new Relationship__c();
            relation.AccountName__c = acc1.Id;
            relation.AccountManager__c = user1Id;
            relation.SubType__c = 'Consultant';
            relation.BusinessArea__c = 'PM EMEA';
            //relation.SegmentL2__c = 'Automotive';
            relList.add(relation);
            
            Database.insert(relList, true);
            
            
            
            
            Contact con = new Contact();
            con.Salutation = 'Mr.';
            con.FirstName = 'Shia';
            con.LastName= 'ALISHA';
            con.Email = 'test@accenture.com';
            con.AccountId = acc1.Id;
            Database.insert(con, true);
            
            Market_Segmentation__c markSeg =  new Market_Segmentation__c();
            markSeg.Name = 'test';
            markSeg.Segmentation_Level_2__c =true;
            markSeg.Segmentation_Level_3__c = true;
            markSeg.Record_Level_1__c =true;
            markSeg.Record_Level_2__c =true;
            markSeg.Record_Level_3__c =true;
            markSeg.Record_Level_4__c =true;
            markSeg.Market_Segmentation_Code__c = '12352df02';
            markSeg.Market_Segmentation_Global_Code__c='12-34-56-78';
            insert markSeg;
            
            Legal_Entity__c LegEnt1 = new Legal_Entity__c();
            LegEnt1.LegalName__c = 'test01';
            LegEnt1.Account__c = acc1.Id;
            LegEnt1.Stage__c = 'Draft';    
            Database.insert(LegEnt1,true);
            
            Legal_Entity__c LegEnt2 = new Legal_Entity__c();
            LegEnt2.LegalName__c = 'test02';
            LegEnt2.Account__c = acc1.Id;
            LegEnt2.Stage__c = 'Draft';    
            Database.insert(LegEnt2,true);
            
            Legal_Entity__c LegEnt3 = new Legal_Entity__c();
            LegEnt3.LegalName__c = 'test03';
            LegEnt3.Account__c = acc1.Id;
            LegEnt3.Stage__c = 'Draft';    
            Database.insert(LegEnt3,true);
            
            Legal_Entity__c LegEnt4 = new Legal_Entity__c();
            LegEnt4.LegalName__c = 'test04';
            LegEnt4.Account__c = acc1.Id;
            LegEnt4.Stage__c = 'Draft';    
            Database.insert(LegEnt4,true);
            
            
            //By ANSHU 16/08/2022
            
            Imerys_Site__c ims= new Imerys_Site__c();
            ims.Name= 'AR - Imerys Minerales Argentina';
            ims.ImerysSellingEntity__c=True;
            Database.insert(ims, true);
            
            Imerys_Site__c ims1= new Imerys_Site__c();
            ims1.Name= 'AR - Imerys Minerales Argentina';
            ims1.ImerysSellingEntity__c=True;
            Database.insert(ims1, true);
            
            GatekeeperAssignment__c gat = New GatekeeperAssignment__c();
            gat.Gatekeeper__c = User2Id;
            gat.Gatekeeper2__c = user1Id;
            gat.Gatekeeper3__c = user2Id;
            gat.Gatekeeper4__c =user2Id;
            gat.ImerysSellingEntity__c ='1';
            gat.Object__c = 'Customer Request Form';
            gat.Process__c = 'Customer Service in charge';
            gat.Imerys_Site__c=ims1.Id;
            Database.insert(gat, true);
            
            gat.Gatekeeper4__c =user1Id;
            Database.update(gat, true);
            
            
            GatekeeperAssignment__c gat3 = New GatekeeperAssignment__c();
            gat3.Gatekeeper__c = User2Id;
            gat3.Gatekeeper2__c = User2Id;
            gat3.Gatekeeper3__c = user1Id;
            gat3.Imerys_Site__c=ims.Id;
            gat3.Gatekeeper4__c =user1Id;
            gat3.ImerysSellingEntity__c ='1';
            gat3.Process__c = 'Credit Controller in charge';
            gat3.Object__c = 'Customer Request Form';
            Database.insert(gat3, true);
            
            GatekeeperAssignment__c gat2 = New GatekeeperAssignment__c();
            gat2.Gatekeeper__c = User2Id;
            gat2.Gatekeeper2__c = User2Id;
            gat2.Gatekeeper3__c = user1Id;
            gat2.Gatekeeper4__c =user1Id;
            gat2.ImerysSellingEntity__c ='100';
            gat2.Process__c = 'ERP Creator in Charge';
            gat2.Object__c = 'Customer Request Form';
            gat2.Imerys_Site__c=ims1.Id;
            Database.insert(gat2, true);
            
            
            GatekeeperAssignment__c gat4 = New GatekeeperAssignment__c();
            gat4.Gatekeeper__c = User2Id;
            gat4.Gatekeeper2__c = user1Id;
            gat4.Gatekeeper3__c = user2Id;
            gat4.Gatekeeper4__c =user2Id;
            gat4.ImerysSellingEntity__c ='100';
            gat4.Object__c = 'Customer Request Form';
            gat4.Process__c = 'Customer Service in charge';
            gat4.Imerys_Site__c=ims.Id;
            Database.insert(gat4, true);
            
            
            Customer_Request_Form__c cust = new Customer_Request_Form__c();
            cust.Business_Area__c ='PM EMEA';
            cust.Imerys_Selling_Entity_Lookup__c=ims.Id;
            cust.ImerysSellingEntityGlobal__c ='AR - Imerys Minerales Argentina';
            cust.Account_Manager__c =user1Id;
            cust.Ship_To__c = acc1.Id;
            cust.Customer_Service_in_Charge__c=user1Id;
            cust.Payer_Tax_Number_1__c = '1';
            cust.Payer_DnB_Number__c = '1';
            cust.Payer_VAT_Number__c = '1';
            cust.Payer_Tax_Number_2__c = '1';
            
            Database.Insert(cust, true);
            cust.Imerys_Selling_Entity_Lookup__c=ims1.Id;
            cust.ImerysSellingEntityGlobal__c ='AR - Imerys Minerales Argentina';
            cust.Customer_Service_in_Charge__c=user2Id;
            Database.Update(cust, true);
            
            
            
            //custList.add(cust);
            
            
            
            
            
        }
    } 
    
}