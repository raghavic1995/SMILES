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
     @isTest static void testCreateCountryforGatekeeper() {
        String recordTypeName;
        Integer countOwner;
        date myDate = date.parse('05/11/2017');
        date mydate2 = date.parse('08/12/2018');
        DateTime date1 = Date.today();  
        
        Profile p3 = [select id from profile where name='System Administrator' LIMIT 1];
        
        List<User> users = [SELECT Id FROM User WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false
                            AND profile.Id =:p3.Id LIMIT 100];
        
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
        
        bypassValidation.CountryforGatekeeper__c = 'Angola';
        bypassValidation.ByPassTriggerRule__c = true;
        bypassValidation.ByPassValidationRule__c = true;
        bypassValidation.BackupComplaint__c = users[2].Id;
        
        /*OutOfOffice outOf = new OutOfOffice();
        outOf.EndDate = date1;
        outOf.StartDate = date1;
        outOf.Message = 'Out of Office: May 22';
        outOf.UserId = users[3].Id;
        outOf.IsEnabled = true;
        //insert outOf;*/
        
        update bypassValidation;              
        
        users[4].ByPassValidationRule__c = true;
        update users[4];
        
        system.runas(bypassValidation){ 
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
            P.ProductType3__c = 'Calderys';
            
            
            Database.insert(p, true);
            
            RecordType recordName = [SELECT Id, DeveloperName 
                                     FROM RecordType 
                                     WHERE SObjectType = 'Case'
                                     AND DeveloperName = 'CSE_Complaint'];  // record type samplewithoutopp
            
            recordTypeName = recordName.Id;
            
            GatekeeperAssignment__c gat = New GatekeeperAssignment__c();
            gat.Division__c = 'Calderys';
            gat.Gatekeeper__c = user2Id;
            gat.BusinessArea__c = 'RAC';
            gat.CountryforGateKeeper__c = 'Angola';
            gat.ManufacturingImerysPlant__c = 'Unknown';
            gat.Object__c = 'Complaint'; 
            Database.insert(gat, true);         
            
            Case cas = New Case();
            cas.AccountId= acc1.Id;
            cas.RecordTypeId = recordTypeName;
            cas.ContactId = con.Id;
            cas.divisions__c = 'Calderys';
            cas.Status = 'Draft Creation';
            cas.Type = 'Contamination';
            cas.BusinessArea__c = 'RAC';
            cas.csAccountManager__c = users[4].id;
            cas.Receiver__c = users[4].id;
            cas.ProductName__c = p.Id;
            cas.GateKeeper__c = User2Id;
            cas.DateRaisedCustomer__c = myDate; 
            cas.OwnerId = user3Id;   
            cas.Description = 'Test';
            cas.Subject = 'Case'; 
            //Database.Insert(cas, true);
            
            Case cas2 = New Case();
            cas2.AccountId= acc1.Id;
            cas2.RecordTypeId = recordTypeName;
            cas2.ContactId = con.Id;
            cas2.divisions__c = 'Calderys';
            cas2.Status = 'Draft Creation';
            cas2.Type = 'Contamination';
            cas2.BusinessArea__c = 'RAC'; 
            cas2.csAccountManager__c = users[5].id;
            cas2.Receiver__c = users[4].id;
            cas2.ProductName__c = p.Id;
            cas2.GateKeeper__c = users[3].Id;
            cas2.DateRaisedCustomer__c = myDate; 
            cas2.OwnerId = user3Id;   
            cas2.Description = 'Test';
            cas2.Subject = 'Case'; 
            //Database.Insert(cas2, true);// insert new record with status Draft Creation
            
            // insert new record with status Draft Creation
            
            //List<Case> caseRecord = [SELECT GateKeeper__c FROM Case WHERE Id =:cas.Id];  
            
            //System.AssertEquals(caseRecord[0].GateKeeper__c, users[2].Id);
            
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
     @isTest static void testUpdateCountryGatekeeper() {
        String recordTypeName;
        Integer countOwner;
        date myDate = date.parse('05/11/2017');
        date mydate2 = date.parse('08/12/2018');
        DateTime date1 = Date.today();  
        List<Case> updateCase = new List<Case>();  
        Map<Id, Case> caseMapUpdate = new Map<Id,case>();
        
        Profile p3 = [select id from profile where name='System Administrator' LIMIT 1];
        
        List<User> users = [SELECT Id,ByPassValidationRule__c FROM User WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false
                            AND profile.Id =:p3.Id LIMIT 100];
        
        Id user1Id = users[3].Id;
        Id user2Id = users[4].Id; 
        Id user3Id = users[0].Id;
        
       /* user bypassValidation = [SELECT Id, CountryforGatekeeper__c,Email, ByPassValidationRule__c, MultiPicklistDivision__c, Division FROM 
                                 User WHERE Id=:users[4].Id LIMIT 1];
        
        if(bypassValidation.Division == null){
            bypassValidation.Division = 'None';
        }
        bypassValidation.MultiPicklistDivision__c = 'Calderys';
        
        
        bypassValidation.CountryforGatekeeper__c = 'Angola';
        bypassValidation.ByPassTriggerRule__c = true;
        bypassValidation.ByPassValidationRule__c = true;
        bypassValidation.BackupComplaint__c = users[1].Id;*/
        
        //update bypassValidation;              
        
        users[4].ByPassValidationRule__c =true;
        update users[4];
        
        system.runas(users[4]){ 
            Account acc1 = new Account();
            acc1.Name = 'sdsdasassd1dsdsdd';
            acc1.BillingCountry = 'United States';
            acc1.BillingCity = 'New York';
            acc1.BillingStreet = 'Test';
            acc1.SegmentL1__c = 'Abrasive';
            acc1.Type = 'Head Office';
            Database.insert(acc1, true);   
            
            OutOfOffice outOf = new OutOfOffice();
            outOf.EndDate = date1;
            outOf.StartDate = date1;
            outOf.Message = 'Out of Office: May 22';
            outOf.UserId = users[4].Id;
            outOf.IsEnabled = true;
            insert outOf;
            
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
            p.ProductType3__c = 'Calderys';
            
            Database.insert(p, true);
            
            RecordType recordName = [SELECT Id, DeveloperName 
                                     FROM RecordType 
                                     WHERE SObjectType = 'Case'
                                     AND DeveloperName = 'CSE_Complaint'];  // record type samplewithoutopp
            
            recordTypeName = recordName.Id;
            
            GatekeeperAssignment__c gat = New GatekeeperAssignment__c();
            gat.Division__c = 'Calderys';
            gat.Gatekeeper__c = user2Id;
            gat.CountryforGateKeeper__c = 'Angola';
            gat.ManufacturingImerysPlant__c = 'Unknown';
            gat.Object__c = 'Complaint'; 
            gat.BusinessArea__c = 'HTS';
            //Database.insert(gat, true);         
            
            Case cas = New Case();
            cas.AccountId= acc1.Id;
            cas.RecordTypeId = recordTypeName;
            cas.ContactId = con.Id;
            cas.Divisions__c = 'Ceramics';
            cas.Status = 'Draft Creation';
            cas.Type = 'Contamination';
            cas.csAccountManager__c = users[4].id;
            cas.Receiver__c = users[4].id;
            cas.ProductName__c = p.Id;
            cas.GateKeeper__c = User2Id;
            cas.DateRaisedCustomer__c = myDate; 
            cas.OwnerId = user3Id;   
            cas.Description = 'Test';
            cas.Subject = 'Case'; 
            cas.BusinessArea__c = 'HTS';
            
            /* Database.Insert(cas, true);// insert new record with status Draft Creation

List<Case> caseList = [SELECT Divisions__c, GateKeeper__c, BusinessArea__c
FROM Case WHERE Id =:cas.Id];  

If(caseList[0].BusinessArea__c <> 'RAC'){
for(Case casUpd: caseList){
casUpd.BusinessArea__c = 'HTS';
casUpd.GateKeeper__c = User2Id;
casUpd.OutOfOffice__c = false;
updateCase.add(casUpd);
}
caseMapUpdate.putall(updateCase);

Database.update(caseMapUpdate.values(),true);

for(Case casUpd2: caseList){
casUpd2.Divisions__c = 'Ceramics';
casUpd2.BusinessArea__c = 'HTS';
casUpd2.GateKeeper__c = users[1].Id;
casUpd2.OutOfOffice__c = true;
updateCase.add(casUpd2);
}
caseMapUpdate.putall(updateCase);

Database.update(caseMapUpdate.values(),true);               
}     */      
            
        }
    }   
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
            If (caseList[0].productName__c <> p3.Id){
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
                
            }            
            
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
        user bypassValidation2 = [SELECT Id, Email, MultiPicklistDivision__c, ByPassValidationRule__c, Division FROM 
                                  User WHERE Id=:users[4].Id LIMIT 1];
        
        if(bypassValidation2.Division == null){
            bypassValidation2.Division = 'None';
        }
        
        if(bypassValidation2.MultiPicklistDivision__c == null){
            bypassValidation2.MultiPicklistDivision__c = 'Calderys';
        }                                 
        
        
        bypassValidation2.ByPassValidationRule__c = false;
        update bypassValidation2;
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
     @isTest static void testCreateBulkGatekeeper() {
        String recordTypeName;
        Integer countOwner;
        date myDate = date.parse('05/11/2012');
        List<Case> listCase = new list<Case>();
        
        List<User> users = [SELECT Id FROM User WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false
                            AND profile.Name ='System Administrator' LIMIT 10];
        Id user1Id = users[3].Id;
        Id user2Id = users[4].Id; 
        Id user3Id = users[0].Id;
        
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
            con.LastName= 'ALISHA';
            con.Email = 'test@accenture.com.com';
            con.AccountId = acc1.Id;
            Database.insert(con, true);
            
            Product2 p = new product2();
            p.Name = 'kjskd';
            p.ManufacturingImerysPlant__c = '';
            p.IsActive = true;
            p.Division__c = 'Calderys';
            
            Database.insert(p, true);
            
            RecordType recordName = [SELECT Id, DeveloperName 
                                     FROM RecordType 
                                     WHERE SObjectType = 'Case'
                                     AND DeveloperName = 'CSE_Complaint'];  // record type samplewithoutopp
            
            recordTypeName = recordName.Id;
            
            GatekeeperAssignment__c gat = New GatekeeperAssignment__c();
            gat.Division__c = 'Calderys';
            gat.Gatekeeper__c = user2Id;
            gat.AllPlants__c = True;
            gat.BusinessArea__c = 'HTS';
            gat.Object__c = 'Case';             
            
            for(Integer i = 0 ; i<=1 ;i++)
            {       
                Case cas = New Case();
                cas.AccountId= acc1.Id;
                cas.RecordTypeId = recordTypeName;
                cas.ContactId = con.Id;
                cas.Status = 'Draft Creation';
                cas.Type = 'Contamination';
                cas.CSAccountManager__c = users[5].id;
                cas.Receiver__c = users[4].id;
                cas.ProductName__c = p.Id;
                cas.GateKeeper__c = User2Id;
                cas.DateRaisedCustomer__c = myDate; 
                cas.OwnerId = user3Id;   
                cas.Description = 'Test' + i;
                cas.Subject = 'Case' + i; 
                listCase.add(cas);
            }
            Test.startTest();
            Database.Insert(listCase, true);// insert new record with status Draft Creation
            Test.StopTest();
            
            List<Case> caseRecord = [SELECT GateKeeper__c
                                     FROM Case WHERE Id =:listCase[0].Id];  
            
            System.AssertEquals(caseRecord[0].GateKeeper__c, User2Id);         
        }
    }    
/**
*@author Geerusting Govind Kumar
*@Date Creation 10/13/2017
*@Date modification 10/26/2017
*@param 
*@ExcptionName
*@return 
*/
     @isTest static void testUpdateCaseShare() {
         String RecordTypeName;
        String RecordTypeRemark;
        date mydate = date.parse('05/11/2015');
        
        Profile p6 = [select id from profile where name='System Administrator' LIMIT 1];    
        
        List<User> users = [SELECT Id,ByPassProcessBuilders__c,Division,MultiPicklistDivision__c,Email,
                            FederationIdentifier,ByPassTriggerRule__c,CountryforGatekeeper__c 
                            FROM User WHERE IsActive = true AND ByPassTriggerRule__c = false
                            AND profile.Id =:p6.Id LIMIT 100];
        Id user1Id = users[0].Id;
        Id user2Id = users[1].Id;
        Id user3Id = users[2].Id;
        
        if(users[0].Division == null){
            users[0].Division = 'None';
        }
        if(users[0].MultiPicklistDivision__c == null){
            users[0].MultiPicklistDivision__c = 'Ceramics';
        }
        string email = users[0].Email;
        //users[0].FederationIdentifier = email;      
        users[0].ByPassProcessBuilders__c = true;
        users[0].ByPassTriggerRule__c = true;
        users[0].CountryforGatekeeper__c = 'Albania';
        users[0].ByPassValidationRule__c = true;
        users[0].BackupComplaint__c = users[3].Id;
        
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
            con.FirstName = 'SHIA';
            con.Email = 'test@accenture.com.com';
            con.LastName= 'ALISHA';
            con.AccountId = acc1.Id;
            Database.insert(con, true);
            
            Product2 p = new product2();
            p.Name = 'Test';
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
            cas.OwnerId = user3Id;
            cas.Description = 'Test';
            cas.Subject = 'Case'; 
            Database.Insert(cas, true);// insert new record with status Draft Creation
            
            RecordType recordName2 = [SELECT Id, DeveloperName 
                                      FROM RecordType 
                                      WHERE SObjectType = 'Case'
                                      AND DeveloperName = 'CSE_Remark'];  // record type samplewithoutopp
            
            recordTypeRemark = recordName2.Id;
            
            Case cas2 = New Case();
            cas2.AccountId= acc1.Id;
            cas2.RecordTypeId = recordTypeRemark;
            cas2.ContactId = con.Id;
            cas2.Status = 'Creation';
            cas2.Type = 'Contamination';
            cas2.GateKeeper__c = users[6].id;
            cas2.CSAccountManager__c = users[5].id;
            cas2.Receiver__c = users[4].id;
            //cas2.ProductName__c = p.Id;
            cas2.DateRaisedCustomer__c = myDate; 
            cas2.OwnerId = user3Id;
            cas2.Description = 'Test';
            cas2.Subject = 'Case'; 
            
            Database.Insert(cas2, true);
            
            List<CaseShare> caseShrs = [SELECT Id, UserOrGroupId, CaseAccessLevel, 
                                        RowCause 
                                        FROM CaseShare 
                                        WHERE CaseId = :cas.Id
                                        AND UserOrGroupId= :users[6].Id
                                        AND UserOrGroupId= :users[4].Id];
            
            // Test attributes of manual share.
            if(caseShrs.size() > 0) {
                System.assertEquals(caseShrs[0].CaseAccessLevel, 'Edit');
                System.assertEquals(caseShrs[0].UserOrGroupId, users[6].id);
            }
            
            List<Case> caseUpd= [SELECT id FROM Case WHERE Id = :cas.Id];  
            
            List<Case> caseUpd2= [SELECT id FROM Case WHERE Id = :cas2.Id];  
            
            List<Case> updateCaseList2 = New List<Case>(); 
            List<Case> updateCaseList3 = New List<Case>(); 
            
            for(Case cas3:caseUpd){    
                cas3.CSAccountManager__c = users[8].Id;
                updateCaseList2.add(cas3);// update sample
            }  
            Test.startTest();
            Update updateCaseList2;
            Test.stopTest();
            
            /*for(Case cas4:caseUpd2){    
                cas4.GateKeeper__c = users[3].Id;
                updateCaseList3.add(cas4);// update sample
            }  
            Update updateCaseList3;*/
            
            
            List<CaseShare> caseShrs2 = [SELECT Id, UserOrGroupId, CaseAccessLevel, 
                                         RowCause 
                                         FROM Caseshare 
                                         WHERE CaseId = :cas.Id 
                                         AND CaseAccessLevel =: 'Edit'
                                         AND UserorGroupId =: users[8].Id];  
            
            if(updateCaseList2.size() > 0){
                System.assertEquals(caseShrs2[0].CaseAccessLevel, 'Edit');
                System.assertEquals(caseShrs2[0].UserOrGroupId, users[8].Id);
            }              
        }
    }
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
    @isTest static void testupdateOwnerIdonCreation() {
         String recordTypeName;
        Integer countOwner;
        date myDate = date.parse('05/11/2017');
        date mydate2 = date.parse('08/12/2018');
        DateTime date1 = Date.today();  
        
        Profile p3 = [select id from profile where name='System Administrator' LIMIT 1];
        
        List<User> users = [SELECT Id, BackupComplaint__c,ByPassValidationRule__c FROM User WHERE IsActive = true
                                                AND ByPassTriggerRule__c = false AND
                                                profile.Id =:p3.Id LIMIT 100];
        Id user1Id = users[3].Id;
        Id user2Id = users[4].Id; 
        Id user3Id = users[0].Id;
        
        user bypassValidation = [SELECT Id, BackupComplaint__c, Email, ByPassValidationRule__c, MultiPicklistDivision__c, Division FROM 
                                 User WHERE Id=:users[0].Id LIMIT 1];
                                 
        //if(bypassValidation.Division == null){
        //   bypassValidation.Division = 'None';
        //}
        bypassValidation.MultiPicklistDivision__c = 'Calderys';
        bypassValidation.BackupComplaint__c = user1Id;
        bypassValidation.ByPassValidationRule__c = true;
               
        update bypassValidation; 
        
     
        users[0].ByPassValidationRule__c = true;
        update users[0];
        
        system.runas(users[0]){ 
            
            Test.StartTest();
            
            /*//Creating Group
        	Group testGroup = new Group(Name='QUEUE NAME', Type='Queue');
        	insert testGroup;*/
            
            //Create Parent Group ( Queue)
            Group grp = new Group();
            grp.name = 'BahrainQueue';
            grp.Type = 'Queue'; 
            Insert grp; 
            
            //Note : Apex doesnot allow DML operation on setup objects (like Group, Profile, Role,....) inside testmethod.
            //Solution: There  is an object named "QueueSobject". It Represents the mapping between a queue Group and the sObject types associated with the queue, including custom objects.
            
            QueueSobject mappingObject = new QueueSobject (QueueId = grp.Id, SobjectType = 'Case');
            insert mappingObject;
     
            //Create Group Member ( Queue Members)
            GroupMember grpMem1 = new GroupMember();
            grpMem1.UserOrGroupId = user1Id;
            grpMem1.GroupId = grp.Id;
            Insert grpMem1;
            
            GroupMember grpMem2 = new GroupMember();
            grpMem2.UserOrGroupId = user2Id;
            grpMem2.GroupId = grp.Id;
            Insert grpMem2;
            
            
            Account acc1 = new Account();
            acc1.Name = 'sdsdasassd1dsdsdd';
            acc1.BillingCountry = 'Kenya';
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
            p2.Division__c = 'Aluminates';
            
            Database.insert(p, true);
            Database.insert(p2, true);
            
            RecordType recordName = [SELECT Id, DeveloperName 
                                    FROM RecordType 
                                    WHERE SObjectType = 'Case'
                                    AND DeveloperName = 'Request'];  
                                    
            recordTypeName = recordName.Id;
            
            GatekeeperAssignment__c gat = New GatekeeperAssignment__c();
            gat.Division__c = 'Calderys';
            gat.Gatekeeper__c = user2Id;
            //gat.AllPlants__c = True;
            gat.ManufacturingImerysPlant__c = 'AR - Tucuman';
            gat.BusinessArea__c = 'HTS';
            gat.Request_Queue__c = 'ReqGlomelBackOfficeQueue';
            gat.CSTeamInCharge__c = 'Bahrain';
            gat.Object__c = 'Request';   
            
            Database.insert(gat, true);
            
            GatekeeperAssignment__c gat2 = New GatekeeperAssignment__c();
            gat2.Division__c = 'Aluminates';
            gat2.Gatekeeper__c = user1Id;
            gat2.ManufacturingImerysPlant__c = 'AT - Villach';
            gat2.Object__c = 'Request';
            gat2.Request_Queue__c = 'ReqBahrainQueue';
            gat2.CSTeamInCharge__c = 'Bahrain';
            gat2.BusinessArea__c = 'RAC';
            Database.insert(gat2, true);  

               
            /*GatekeeperAssignment__c gat3 = New GatekeeperAssignment__c();
            gat3.Division__c = 'Ceramics';
            gat3.Gatekeeper__c = users[1].Id;
           // gat3.AllPlants__c = True;
            gat3.BusinessArea__c ='PM APAC';
            gat3.ManufacturingImerysPlant__c = 'AR - Ledesma';
            gat3.Request_Queue__c = 'Bahrain';
            gat3.CSTeamInCharge__c = 'Bahrain';
            gat3.Object__c = 'Request';   
            
            Database.insert(gat3, true);*/           
            
            
            
            
            /*Case cas = New Case();
            cas.AccountId= acc1.Id;
            cas.RecordTypeId = recordTypeName;
            cas.ContactId = con.Id;
            cas.divisions__c = 'Ceramics';
            cas.Status = 'Draft Creation';
            cas.Type = 'Complaint';
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
            
            Case cas2 = New Case();
            cas2.AccountId= acc1.Id;
            cas2.RecordTypeId = recordTypeName;
            cas2.ContactId = con.Id;
            cas2.divisions__c = 'Aluminates';
            cas2.Status = 'Draft Creation';
            cas2.Type = 'Order';
            cas2.csAccountManager__c = users[5].id;
            cas2.Receiver__c = users[4].id;
            cas2.ProductName__c = p2.Id;
            cas2.GateKeeper__c = User3Id;
            cas2.DateRaisedCustomer__c = myDate; 
            cas2.Customer_Service_Department__c = 'AR - Ledesma';
            cas2.OwnerId = grp.id;  
            cas2.BusinessArea__c = 'PM APAC';           
            cas2.Description = 'Test';
            cas2.Subject = 'Case'; 
            Database.Insert(cas2, true);*/
                         
            Case cas3 = New Case();
            cas3.AccountId= acc1.Id;
            cas3.RecordTypeId = recordTypeName;
            cas3.ContactId = con.Id;
            cas3.divisions__c = 'Aluminates';
            cas3.Status = 'Draft Creation';
            cas3.Type = 'Complaint';
            cas3.BusinessArea__c = 'RAC';
            cas3.csAccountManager__c = users[5].id;
            cas3.Receiver__c = users[4].id;
            cas3.ProductName__c = p2.Id;
            cas3.GateKeeper__c = users[1].Id;
            cas3.Customer_Service_Department__c = 'AT - Villach';
            cas3.DateRaisedCustomer__c = myDate; 
            cas3.OwnerId = user3Id;
            cas3.CSTeamInCharge__c = 'Bahrain';
            cas3.Description = 'Test';
            cas3.Subject = 'Case'; 
            Database.Insert(cas3, true);
            
            Test.StopTest();
            
            //List<Case> caseRecord = [SELECT GateKeeper__c
            //                       FROM Case WHERE Id =:cas.Id];  
            
            //System.AssertEquals(caseRecord[0].GateKeeper__c, users[1].Id);
           
        }
    }    
}