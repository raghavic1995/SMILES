@isTest
/**
*@author Geerusting Govind Kumar
*@Date Creation 10/13/2017
*@Date modification 
*@description to test owner update on status 'Registration' and read/write access on SalesMan
*/
private class AP01_CaseTrigger_TEST{
/**
*@author Geerusting Govind Kumar
*@Date Creation 10/13/2017
*@Date modification 10/26/2017
*@param 
*@ExcptionName
*@return 
*/
     @isTest static void testCreateCaseGatekeeper() {
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
        
        user bypassValidation = [SELECT Id, BackupComplaint__c, Email, ByPassValidationRule__c, MultiPicklistDivision__c, Division FROM 
                                 User WHERE Id=:users[4].Id LIMIT 1];
        
        if(bypassValidation.Division == null){
            bypassValidation.Division = 'None';
        }
        bypassValidation.MultiPicklistDivision__c = 'Calderys';
        bypassValidation.BackupComplaint__c = user1Id;
        
        update bypassValidation; 
        
        OutOfOffice outOf = new OutOfOffice();
        outOf.EndDate = date1;
        outOf.StartDate = date1;
        outOf.Message = 'Out of Office: May 22';
        outOf.UserId = users[1].Id;
        outOf.IsEnabled = true;
        insert outOf;
        
        users[0].ByPassValidationRule__c = true;
        users[0].ByPassProcessBuilders__c = true;
        users[0].CountryforGatekeeper__c='India';
        update users[0];
        
        system.runas(users[0]){ 
            
           
            
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
            p2.ManufacturingImerysPlant__c = 'CA - Suzorite';
            p2.IsActive = true;
            p2.BusinessArea__c='HTS';
            p2.New_Product_Type_1__c='Bricks';
            p2.New_Product_Type_2__c='Calderys';
            p2.Division__c = 'Aluminates';
            
            Database.insert(p, true);
            Database.insert(p2, true);
            
            //RecordType recordName = [SELECT Id, DeveloperName 
            //FROM RecordType 
            //WHERE SObjectType = 'Case'
            // AND DeveloperName = 'CSE_Complaint'];  // record type samplewithoutopp
            
            //recordTypeName = recordName.Id;
            
            GatekeeperAssignment__c gat = New GatekeeperAssignment__c();
            gat.Division__c = 'Calderys';
            gat.Gatekeeper__c = user2Id;
            gat.AllPlants__c = True;
            gat.BusinessArea__c = 'HTS';
            gat.CountryforGateKeeper__c='India';
            gat.Object__c = 'Complaint';   
            
            Database.insert(gat, true);
            
            GatekeeperAssignment__c gat2 = New GatekeeperAssignment__c();
            gat2.Division__c = 'Aluminates';
            gat2.Gatekeeper__c = user1Id;
            gat2.ManufacturingImerysPlant__c = 'AT - Villach';
            gat2.Object__c = 'Complaint';
            gat2.CountryforGateKeeper__c='India';
            gat2.BusinessArea__c = 'RAC';
            Database.insert(gat2, true);  
            
            
            GatekeeperAssignment__c gat3 = New GatekeeperAssignment__c();
            gat3.Division__c = 'Ceramics';
            gat3.Gatekeeper__c = users[1].Id;
            gat3.AllPlants__c = True;
            gat3.BusinessArea__c ='PM APAC';
            gat3.CountryforGateKeeper__c='India';
            gat3.Object__c = 'Complaint';   
            
            Database.insert(gat3, true);            
            
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
            
            Test.startTest();
            Case cas2 = New Case();
            cas2.AccountId= acc1.Id;
            //cas2.RecordTypeId = recordTypeName;
            cas2.ContactId = con.Id;
            cas2.divisions__c = 'Aluminates';
            cas2.Status = 'Draft Creation';
            cas2.Type = 'Contamination';
            cas2.csAccountManager__c = users[5].id;
            cas2.Receiver__c = users[4].id;
            cas2.ProductName__c = p2.Id;
            cas2.GateKeeper__c = User3Id;
            cas2.DateRaisedCustomer__c = myDate; 
            cas2.OwnerId = user3Id;  
            cas2.BusinessArea__c = 'PM APAC';           
            cas2.Description = 'Test';
            cas2.Subject = 'Case'; 
            Database.Insert(cas2, true);
            
            Test.stopTest();
            //System.AssertEquals(caseRecord[0].GateKeeper__c, users[1].Id);
            
        }
    }
/**
*@author Geerusting Govind Kumar
*@Date Creation 29/08/2018
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/
     
/**
*@author Geerusting Govind Kumar
*@Date Creation 29/08/2018
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/
   
/**
*@author Geerusting Govind Kumar
*@Date Creation 10/13/2017
*@Date modification 10/26/2017
*@param 
*@ExcptionName
*@return 
*/
     @isTest static void testUpdateGatekeeper() {
         String recordTypeName;
        Integer countOwner;
        date myDate = date.parse('05/11/2017');
        date mydate2 = date.parse('08/12/2018');
        DateTime date1 = Date.today();      
        DateTime date2 = date.parse('08/12/2050'); 
        
        Profile p8 = [select id from profile where name='System Administrator' LIMIT 1];
        
        List<User> users = [SELECT Id FROM User WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false
                            AND profile.Id =:p8.Id LIMIT 100];
        
        Id user1Id = users[3].Id;
        Id user2Id = users[4].Id; 
        Id user3Id = users[0].Id;
        
        List<Case> updateCase = new List<Case>(); 
        List<Case> updateCase2 = new List<Case>(); 
        Map<Id, Case> caseMapUpdate = new Map<Id,case>();
        List<outOfOffice> outOfList = new List<outOfOffice>();
        
        user bypassValidation = [SELECT Id, Email, ByPassValidationRule__c, MultiPicklistDivision__c, Division FROM 
                                 User WHERE Id=:users[4].Id LIMIT 1];
        
        if(bypassValidation.Division == null){
            bypassValidation.Division = 'None';
        }
        if(bypassValidation.MultiPicklistDivision__c == null){
            bypassValidation.MultiPicklistDivision__c = 'Calderys';
        }       
        
        bypassValidation.ByPassValidationRule__c = true;
        bypassValidation.ByPassTriggerRule__c = true;
        bypassValidation.CountryforGatekeeper__c = 'Albania';
        bypassValidation.BackupComplaint__c = users[2].Id;
        
        OutOfOffice outOf = new OutOfOffice();
        outOf.EndDate = date2;
        outOf.StartDate = date1;
        outOf.Message = 'Out of Office: May 22';
        outOf.UserId = users[4].Id;
        outOf.IsEnabled = true;
        outOfList.add(outOf);
        insert outOf;
        
        OutOfOffice outOf2 = new OutOfOffice();
        outOf2.EndDate = date2;
        outOf2.StartDate = date1;
        outOf2.Message = 'Out of Office: May 22';
        outOf2.UserId = users[2].Id;
        outOf2.IsEnabled = true;
        
        insert outOf2;
        update bypassValidation;
        
        users[0].ByPassValidationRule__c =true;
        update users[0];        
        
        system.runas(users[0]){ 
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
            
            // RecordType recordName = [SELECT Id, DeveloperName 
            // FROM RecordType 
            // WHERE SObjectType = 'Case'
            // AND DeveloperName = 'CSE_Complaint'];  // record type samplewithoutopp
            
            // recordTypeName = recordName.Id;
            
            Product2 p2 = new product2();
            p2.Name = 'zzzz';
            p2.IsActive = true;
            p2.ManufacturingImerysPlant__c = '';
            p2.Division__c = 'Ceramics';
            p2.BusinessArea__c='HTS';
            p2.New_Product_Type_1__c='Bricks';
            p2.New_Product_Type_2__c='Calderys';
            Database.insert(p2, true);
            
            Product2 p3 = new product2();
            p3.Name = 'zzzz';
            p3.IsActive = true;
            p3.ManufacturingImerysPlant__c = 'AT - Villach';
            p3.Division__c = 'Aluminates';
            Database.insert(p3, true);
            
            GatekeeperAssignment__c gat = New GatekeeperAssignment__c();
            gat.Division__c = 'Calderys';
            gat.Gatekeeper__c = User2Id;
            gat.AllPlants__c = true;
            gat.Object__c = 'Complaint';
            gat.BusinessArea__c = 'HTS';
            gat.Gatekeeper2__c=users[11].id;
            gat.Gatekeeper3__c=users[12].id;
            gat.Gatekeeper4__c=users[13].id;
            Database.insert(gat, true);
            
            GatekeeperAssignment__c gat2 = New GatekeeperAssignment__c();
            gat2.Division__c = 'Ceramics';
            gat2.Gatekeeper__c = Users[2].Id;
            gat2.AllPlants__c = true;
            gat2.Object__c = 'Complaint';
            gat2.BusinessArea__c = 'RAC';
            gat2.Gatekeeper2__c=users[11].id;
            gat2.Gatekeeper3__c=users[12].id;
            gat2.Gatekeeper4__c=users[13].id;
            Database.insert(gat2, true);
            
            GatekeeperAssignment__c gat3 = New GatekeeperAssignment__c();
            gat3.Division__c = 'Aluminates';
            gat3.Gatekeeper__c = User1Id;
            gat3.ManufacturingImerysPlant__c = 'AT - Villach';
            gat3.Object__c = 'Sample';
            gat3.BusinessArea__c = 'PM APAC';
            gat3.Gatekeeper2__c=users[11].id;
            gat3.Gatekeeper3__c=users[12].id;
            gat3.Gatekeeper4__c=users[13].id;
            Database.insert(gat3, true);
            
            Product2 p4 = new product2();
            p4.Name = 'zzzz';
            p4.IsActive = true;
            p4.ManufacturingImerysPlant__c = '';
            p4.Division__c = 'Carbonates';
            Database.insert(p4, true);
            
            Case cas = New Case();
            cas.AccountId= acc1.Id;
            //cas.RecordTypeId = recordTypeName;
            cas.Divisions__c = 'Aluminates';
            cas.ContactId = con.Id;
            cas.Status = 'Draft Creation';
            cas.Type = 'Contamination';
            cas.csAccountManager__c = users[10].id;
            cas.Receiver__c = users[4].id;
            cas.ProductName__c = p3.Id;
            cas.GateKeeper__c = User1Id;  
            cas.BusinessArea__c = 'PM APAC';
            cas.OutOfOffice__c = true;         
            cas.DateRaisedCustomer__c = myDate; 
            cas.OwnerId = user3Id;   
            cas.Description = 'Test';
            cas.Subject = 'Case'; 
            Test.StartTest();
            Database.Insert(cas, true);
            Test.StopTest();
            
            List<Case> caseList = [SELECT GateKeeper__c, productName__c FROM Case WHERE Id =:cas.Id]; 
            
            If(caseList[0].productName__c <> p2.Id){
                for(Case casUpd: caseList){
                    casUpd.ProductName__c = p4.Id;
                    casUpd.Volume__c = 1233;
                    casUpd.BusinessArea__c = 'HTS';
                    casUpd.OwnerId = User2Id;
                    casUpd.GateKeeper__c = User2Id;
                    casUpd.csAccountManager__c = users[5].id;
                    casUpd.OutOfOffice__c = true;
                    updateCase.add(casUpd);
                }
                caseMapUpdate.putall(updateCase);
                
                Database.update(caseMapUpdate.values(),true);
                
            }           
          /*  If (caseList[0].productName__c <> p3.Id){
                for(Case casUpd2: CaseList){
                    casUpd2.ProductName__c = p4.Id;
                    casUpd2.Volume__c = 1233;
                    casUpd2.OwnerId = User3Id;
                    casUpd2.GateKeeper__c = User1Id;
                    casUpd2.csAccountManager__c = users[9].id;
                    casUpd2.outOfOffice__c = true;
                    updateCase2.add(casUpd2);
                }               
                caseMapUpdate.putall(updateCase2);
                Database.update(caseMapUpdate.values(),true);
                
            } */           
            
            outofList = [SELECT Message, UserId FROM OutOfOffice
                         WHERE UserId =: User2Id];
            
            if(outOfList.size() == 0){
                //system.assertEquals(samp[0].Gatekeeper__c, user2Id);
                system.assertEquals(caseList[0].OutOfOffice__c, true);
            }   
            else{
                //system.assertEquals(samp[0].Gatekeeper__c, users[3].Id);
                system.assertEquals(caseList[0].OutOfOffice__c, true);
            } 
        }
        /*user bypassValidation2 = [SELECT Id, Email, MultiPicklistDivision__c, ByPassValidationRule__c, Division FROM 
                                  User WHERE Id=:users[4].Id LIMIT 1];
        
        if(bypassValidation2.Division == null){
            bypassValidation2.Division = 'None';
        }
        
        if(bypassValidation2.MultiPicklistDivision__c == null){
            bypassValidation2.MultiPicklistDivision__c = 'Calderys';
        }                                 
        
        
        bypassValidation2.ByPassValidationRule__c = false;
        update bypassValidation2;*/
    } 
/**
*@author Geerusting Govind Kumar
*@Date Creation 10/13/2017
*@Date modification 10/26/2017
*@param 
*@ExcptionName
*@return 
*/
    
/**
*@author Geerusting Govind Kumar
*@Date Creation 10/13/2017
*@Date modification 10/26/2017
*@param 
*@ExcptionName
*@return 
*/
     
/**
*@author Geerusting Govind Kumar
*@Date Creation 10/13/2017
*@Date modification 10/26/2017
*@param 
*@ExcptionName
*@return 
*/
    
 /**
*@author Geerusting Govind Kumar
*@Date Creation 10/13/2017
*@Date modification 10/26/2017
*@param 
*@ExcptionName
*@return 
*/
     @isTest static void testDeleteCaseShare() {
         String RecordTypeName;
        date mydate = date.parse('05/11/2015');
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false
                            AND profile.Name = 'System Administrator' LIMIT 100];
        Id user1Id = users[0].Id;
        Id user2Id = users[1].Id;
        Id user3Id = users[2].Id;
        
        users[0].ByPassValidationRule__c = true;
        update users[0];
        
        system.runas(users[0]){
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
            con.LastName= 'ALISHA';
            con.Email = 'test@accenture.com.com';
            con.AccountId = acc1.Id;
            Database.insert(con, true);
            
            Product2 p = new product2();
            p.Name = 'ddfdf';
            p.ManufacturingImerysPlant__c = '';
            p.IsActive = true;
            p.Division__c = 'Calderys';
            
            Database.insert(p, true);
            
            RecordType recordName = [SELECT Id, DeveloperName 
                                     FROM RecordType 
                                     WHERE SObjectType = 'Case'
                                     AND DeveloperName = 'CSE_Complaint'];  // record type samplewithoutopp
            
            recordTypeName = recordName.Id;
            
            Case cas = New Case();
            cas.AccountId= acc1.Id;
            cas.RecordTypeId = recordTypeName;
            cas.ContactId = con.Id;
            cas.Status = 'Draft Creation';
            cas.Type = 'Contamination';
            cas.CSAccountManager__c = users[6].id;
            cas.Receiver__c = users[4].id;
            cas.ProductName__c = p.Id;
            cas.DateRaisedCustomer__c = myDate; 
            cas.OwnerId = user1Id;
            cas.Description = 'Test';
            cas.Subject = 'Case'; 
            Database.Insert(cas, true);// insert new record with status Draft Creation
            
            // Insert manual share for user who is not record owner. 
            // Query visit report records.
            List<CaseShare> caseShrs = [SELECT Id, UserOrGroupId, CaseAccessLevel, 
                                        RowCause FROM Caseshare WHERE CaseId = :cas.Id AND UserOrGroupId= :users[6].Id];
            
            // Test attributes of manual share.
            if(caseShrs.size() > 0) {
                System.assertEquals(caseShrs[0].CaseAccessLevel, 'Edit');
                System.assertEquals(caseShrs[0].UserOrGroupId, users[6].id);
            }           
            List<Case> caseDel  = [SELECT id FROM Case WHERE Id = :cas.Id];  
            
            Test.startTest();
            delete caseDel;
            Test.stopTest(); 
            
            integer countDel = [SELECT COUNT() 
                                FROM CaseShare WHERE 
                                CaseId = :cas.Id 
                                AND UserOrGroupId= :users[6].Id];  
            
            System.assertEquals(countDel, 0);
            
        }
    } 
/**
*@author Geerusting Govind Kumar
*@Date Creation 2/7/2018
*@Date modification
*@param 
*@ExcptionName
*@return error message in custom label 
*/  
    /*
    @isTest static void testFillRelationship() {
        TestDataFactory.testFillRelationship();
    }*/
 
/**
*@author Jaunbocus Muhammad Irshaad
*@Date Creation 4/8/2021
*@Date modification
*@param 
*@ExcptionName
*@return error message in custom label 
*/ 
    
    @isTest static void testFillMarketSegmentAndAccMgr(){
      date mydate = date.parse('05/11/2012');
        /*date mydate1 = date.parse('05/11/2017');
        date mydate2 = date.parse('08/12/2022');
        String recordName;*/
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false AND profileID =: p2.Id LIMIT 5];
        
        /*
        Map<Id, TechnicalAssistanceRequest__c> techMap = New Map<Id, TechnicalAssistanceRequest__c>();
        Map<Id, Offer__c> offerMap = New Map<Id, Offer__c>();
        Map<Id, Project__c> projectMap = New Map<Id, Project__c>();
        List<Offer__c> offerList = new List <Offer__c>();
        List<Project__c> projectList = new List <Project__c>();
        List<TechnicalAssistanceRequest__c> techList = new List <TechnicalAssistanceRequest__c>();*/
        List<Case> caseList = new List<Case>();
        
        users[0].ByPassValidationRule__c = true;
        users[0].ByPassProcessBuilders__c = true;
        users[0].Job_Department__c = 'Customer Service & Sales Administration';
        update users[0];
        
        
        system.runas(users[0]){ 
            
            //Create Account
            Account accTest= new Account();
            accTest.Name = 'VRTEST';
            accTest.BillingCountry = 'United States';
            accTest.BillingCity = 'New York';
            accTest.BillingStreet = 'Test';
            accTest.SegmentL1__c = 'Abrasive';
            accTest.Type = 'Head Office';
            Database.insert(accTest, true);
            
            Contact con = new Contact();
            con.Salutation = 'Mr.';
            con.FirstName = 'Shia';
            con.LastName= 'ALISHA';
            con.Email = 'test@accenture.com.com';
            con.AccountId = accTest.Id;
            Database.insert(con, true);
            
            Market_Segmentation__c markSeg =  new Market_Segmentation__c();
            markSeg.Name = 'test';
            markSeg.Segmentation_Level_2__c =true;
            markSeg.Record_Level_1__c =true;
            markSeg.Record_Level_2__c =true;
            markSeg.Record_Level_3__c =true;
            markSeg.Record_Level_4__c =true;
            markSeg.Segmentation_Level_3__c = true;
            markSeg.Market_Segmentation_Code__c = '12352df02';
            markSeg.Market_Segmentation_Global_Code__c='12-34-56-78';
            insert markSeg;

            
            List<Relationship__c> relat = new List<Relationship__c>();

            Relationship__c relation = new Relationship__c();
            relation.AccountName__c = accTest.Id;
            relation.Divisions__c = 'Ceramics';
            relation.DivisionTier__c = 'B';
            relation.BusinessArea__c = 'HTS';
            relation.AccountManager__c = users[0].Id;
            relation.MarketSegmentation__c = markSeg.id;
            //relation.NewMarketL1__c = '';
            //relation.NewMarketL2__c = '';
            relation.SubType__c = 'Consultant';
            relat.add(relation);
            
            Relationship__c relation2 = new Relationship__c();
            relation2.AccountName__c = accTest.Id;
            relation2.Divisions__c = 'Carbonates';
            relation2.DivisionTier__c = 'B';
            relation2.BusinessArea__c = 'RAC';
            relation2.AccountManager__c = users[1].Id;
            relation2.MarketSegmentation__c = markSeg.id;
            relation2.SubType__c = 'Consultant';
            relat.add(relation2);
            
            Relationship__c relation3 = new Relationship__c();
            relation3.AccountName__c = accTest.Id;
            relation3.Divisions__c = 'Calderys';
            relation3.DivisionTier__c = 'B';
            relation3.BusinessArea__c = 'PM EMEA';
            relation2.AccountManager__c = users[3].Id;
            relation3.MarketSegmentation__c = markSeg.id;
            relation3.SubType__c = 'Consultant';
            relat.add(relation3);
            
            Database.insert(relat,true);
            
            Product2 p = new product2();
            p.Name = 'Test Prod';
            p.ManufacturingImerysPlant__c = '';
            p.IsActive = true;
            p.Division__c = 'Ceramics';
            
            Database.insert(p, true);
            
            Test.StartTest();
            
              for(Relationship__c relList: relat){       
                Case cas = New Case();
                cas.AccountId= accTest.Id;
                cas.ContactId = con.Id;
                cas.Status = 'Draft Creation';
                cas.Type = 'Contamination';
                cas.Receiver__c = users[4].id;
                cas.ProductName__c = p.Id;
                cas.DateRaisedCustomer__c = myDate; 
                cas.Description = 'Test';
                cas.BusinessArea__c = 'RAC';
                cas.Subject = 'Case'; 

                caseList.add(cas);
            }
            insert caseList;
        }
    }

/**
*@author Jaunbocus Muhammad Irshaad
*@Date Creation 4/8/2021
*@Date modification
*@param 
*@ExcptionName
*@return error message in custom label 
*/   
       
}