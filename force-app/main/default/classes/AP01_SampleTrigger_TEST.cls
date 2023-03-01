@isTest
/**
*@author Geerusting Govind Kumar
*@Date Creation 10/13/2017
*@Date modification 
*@description to test owner update on status 'preparation/shipment and read/write access on account manager
*/
private class AP01_SampleTrigger_TEST{
/**
*@author Geerusting Govind Kumar
*@Date Creation 10/13/2017
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/
     @isTest static void testCreateSampleGatekeeper() {
        String recordTypeName;
        Integer countOwner;
        date mydate1 = date.parse('05/11/2017');
        date mydate2 = date.parse('05/11/2030');
        DateTime date1 = Date.today();
        List<outOfOffice> outOfList = new List<outOfOffice>();
        
        Profile p6 = [select id from profile where name='System Administrator' LIMIT 1];        
        
        List<User> users = [SELECT Id, BackupSample__c FROM User WHERE IsActive = true AND ByPassTriggerRule__c = false
                            AND profile.Id =:p6.Id LIMIT 100];
        
        Id user1Id = users[3].Id;
        Id user2Id = users[4].Id; 
        Id user3Id = users[0].Id;
        
        
        
        
        user bypassValidation = [SELECT Id, Email,BackupSample__c, ByPassValidationRule__c, MultiPicklistDivision__c, Division FROM 
                                 User WHERE Id=:users[4].Id AND profile.Id =: p6.Id LIMIT 1];
        
        if(bypassValidation.Division == null){
            bypassValidation.Division = 'None';
        }
        if(bypassValidation.MultiPicklistDivision__c == null){
            bypassValidation.MultiPicklistDivision__c = 'Ceramics';
        }       
        
        
        bypassValidation.ByPassValidationRule__c = true;
        bypassValidation.ByPassTriggerRule__c = true;
        bypassValidation.BackupSample__c = users[3].Id;
        bypassValidation.CountryforGatekeeper__c = 'Albania';
        update bypassValidation;       
        
        users[0].ByPassValidationRule__c = true;
        users[0].ByPassProcessBuilders__c = true;
        update users[0];
        
        system.runas(users[0]){ 
            
            OutOfOffice outOffice = new OutOfOffice();
            outOffice.EndDate = date1;
            outOffice.StartDate = date1;
            outOffice.Message = 'Out of Office: May 22';
            outOffice.UserId = users[1].Id;
            outOffice.IsEnabled = true;
            insert outOffice;
            
            
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
            con.Email = 'test@accenture.com';
            con.AccountId = acc1.Id;
            Database.insert(con, true);
            
            Product2 p = new product2();
            p.Name = 'zzzz';
            p.IsActive = true;
            p.ManufacturingImerysPlant__c = '';
            p.Division__c = 'Calderys';
            //p.ProductType3__c = 'Calderys';
            Database.insert(p, true);
            
            Product2 p2 = new product2();
            p2.Name = 'zzzz';
            p2.IsActive = true;
            p2.ManufacturingImerysPlant__c = '';
            p2.Division__c = 'Ceramics';
            //p2.ProductType3__c = 'Calderys';
            Database.insert(p2, true);
            
            Product2 p3 = new product2();
            p3.Name = 'zzzz';
            p3.IsActive = true;
            p3.ManufacturingImerysPlant__c = '';
            p3.Division__c = 'Aluminates';
            Database.insert(p3, true);
            
            GatekeeperAssignment__c gat = New GatekeeperAssignment__c();
            gat.Division__c = 'Calderys';
            gat.Gatekeeper__c = User2Id;
            gat.BusinessArea__c ='RAC';
            gat.AllPlants__c = true;
            gat.Object__c = 'Sample';
            gat.Gatekeeper2__c=users[11].id;
            gat.Gatekeeper3__c=users[12].id;
            gat.Gatekeeper4__c=users[13].id;
            Database.insert(gat, true);
            
            GatekeeperAssignment__c gat2 = New GatekeeperAssignment__c();
            gat2.Division__c = 'Ceramics';
            gat2.Gatekeeper__c = User1Id;
            gat2.AllPlants__c = true;
            gat2.BusinessArea__c ='RAC';
            gat2.Object__c = 'Sample';
            gat2.Gatekeeper2__c=users[11].id;
            gat2.Gatekeeper3__c=users[12].id;
            gat2.Gatekeeper4__c=users[13].id;
            Database.insert(gat2, true);
            
            GatekeeperAssignment__c gat3 = New GatekeeperAssignment__c();
            gat3.Division__c = 'Aluminates';
            gat3.Gatekeeper__c = Users[1].Id;
            gat3.AllPlants__c=false;
            gat3.ManufacturingImerysPlant__c ='FR - Iko';
            gat3.Object__c = 'Sample';
            gat3.BusinessArea__c ='RAC';
            gat3.Gatekeeper2__c=users[11].id;
            gat3.Gatekeeper3__c=users[12].id;
            gat3.Gatekeeper4__c=users[13].id;
            Database.insert(gat3, true);
            
            Map<id,GatekeeperAssignment__c> newmap = new Map<id,GatekeeperAssignment__c>();
            newmap.put(gat.Gatekeeper__c, gat);
            
            Map<id,GatekeeperAssignment__c> newmap2 = new Map<id,GatekeeperAssignment__c>();
            newmap.put(gat2.Gatekeeper__c, gat2);
            
            Map<id,GatekeeperAssignment__c> newmap3 = new Map<id,GatekeeperAssignment__c>();
            newmap.put(gat3.Gatekeeper__c, gat3);
            
            OutOfOffice outOf = new OutOfOffice();
            outOf.EndDate = date1;
            outOf.StartDate = date1;
            outOf.Message = 'Out of Office: May 22';
            outOf.UserId = users[0].Id;
            outOf.IsEnabled = true;
            outOfList.add(outOf);
            
            insert outOf;
            
            OutOfOffice outOf2 = new OutOfOffice();
            outOf2.EndDate = date1;
            outOf2.StartDate = date1;
            outOf2.Message = 'Out of Office: May 22';
            outOf2.UserId = User1Id;
            outOf2.IsEnabled = true;
            
            insert outOf2;
            
            Product2 p4 = new product2();
            p4.Name = 'zzzz';
            p4.IsActive = true;
            p4.ManufacturingImerysPlant__c = '';
            p4.Division__c = 'Carbonates';
            Database.insert(p4, true);
            
            
            
            RecordType recordName = [SELECT Id, DeveloperName 
                                     FROM RecordType 
                                     WHERE SObjectType = 'Sample__c'
                                     AND DeveloperName = 'SAM_SampleWithoutOpportunity'];  // record type samplewithoutopp
            
            recordTypeName = recordName.Id;
            
            Sample__c sam = New Sample__c();
            sam.CSAccountManager__c = acc1.Id;
            sam.RecordTypeId = recordTypeName;
            sam.RecipientName__c = con.Id;
            sam.AccountName__c=acc1.Id;
            sam.Status__c = 'Draft Creation';
            sam.Divisions__c = 'Aluminates';
            sam.Type__c = 'Lab';
            sam.CSAccountManager__c = users[1].Id;
            sam.ExpectedDeliveryDate__c = mydate2;
            sam.ProductName__c = p.Id;
            sam.Volume__c = 1233;
            sam.OwnerId = User3Id;
            sam.BusinessArea__c ='RAC';
            sam.Unit__c = 'Metric tons (as sold)';
            sam.GateKeeper__c = users[1].Id;
           
            sam.OutOfOffice__c = true;
            sam.DateOfFeedback__c = mydate1;
            sam.DispatchSite__c ='FR - Iko';
            Test.startTest();
            Database.Insert(sam, true);// insert new record with status Draft Creation
            Test.stopTest();
            
            Imerys_Site__c	is= New Imerys_Site__c	();
            is.name='FR - Iko';
            is.DispatchSite__c=true;
            is.ImerysManufacturingPlant__c=true;
            is.ImerysSellingEntity__c=true;
            
            
            Imerys_Site__c	is2= New Imerys_Site__c	();
            is2.name='FR - Test';
            is2.DispatchSite__c=true;
            is2.ImerysManufacturingPlant__c=true;
            is2.ImerysSellingEntity__c=true;
            
            

            Database.Insert(is, true);
            Database.Insert(is2, true);
            

            
            
Sample__c sam2 = New Sample__c();
sam2.CSAccountManager__c = acc1.Id;
sam2.RecordTypeId = recordTypeName;
sam2.RecipientName__c = con.Id;
sam2.AccountName__c=acc1.Id;
sam2.Divisions__c = 'Ceramics';
sam2.Status__c = 'Draft Creation';
sam2.Type__c = 'Lab';
sam2.BusinessArea__c ='RAC';
sam2.CSAccountManager__c = User3Id;
sam2.ExpectedDeliveryDate__c = mydate2;
sam2.ProductName__c = p.Id;
sam2.Volume__c = 1233;
sam2.OwnerId = User3Id;
sam2.Unit__c = 'Metric tons (as sold)';
sam2.GateKeeper__c = user3Id;
sam2.outOfOffice__c = true;
sam2.DateOfFeedback__c = mydate1;
sam2.DispatchSite__c ='FR - Iko';
sam2.DispatchSiteLookup__c=is.Id;
            

Database.insert(sam2, true);


            
            GatekeeperAssignment__c gat4 = New GatekeeperAssignment__c();
            gat4.Division__c = 'Aluminates';
            gat4.Gatekeeper__c = Users[1].Id;
            gat4.AllPlants__c=false;
            gat4.ManufacturingImerysPlant__c ='FR - Iko';
            gat4.Imerys_Site_Dispatch__c=is2.Id;
            gat4.Object__c = 'Sample';
            gat4.BusinessArea__c ='RAC';
            gat4.Gatekeeper2__c=users[11].id;
            gat4.Gatekeeper3__c=users[12].id;
            gat4.Gatekeeper4__c=users[13].id;
            Database.insert(gat4, true);
            
            
            List<Sample__c> sample = [SELECT GateKeeper__c, OutOfOffice__c FROM Sample__c WHERE Id =:sam.Id];  
            
            outofList = [SELECT Message, UserId FROM OutOfOffice
                         WHERE UserId =: User2Id];
            
            if(outOfList.size() > 0){
                system.assertEquals(sample[0].Gatekeeper__c, user2Id);
                system.assertEquals(sample[0].OutOfOffice__c, false);
            }   
            else{
                //system.assertEquals(sample[0].Gatekeeper__c, users[3].Id);
                //system.assertEquals(sample[0].OutOfOffice__c, true);
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
        bypassValidation2.ByPassTriggerRule__c = false;
        update bypassValidation2; 
    } 
   
/**
*@author Geerusting Govind Kumar
*@Date Creation 10/13/2017
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/
     @isTest static void testUpdateSampleGatekeeper() {
        String recordTypeName;
        Integer countOwner;
        date mydate3 =system.today();
        date mydate1 = date.parse('05/11/2017');
        date mydate2 = date.parse('05/11/2019');
        DateTime date1 = Date.today();
        
        List<Sample__c> updateSample = new List<Sample__c>(); 
        List<Sample__c> updateSample2 = new List<Sample__c>(); 
        Map<Id, sample__c> samMapUpdate = new Map<Id,Sample__c>();
        List<outOfOffice> outOfList = new List<outOfOffice>();
        
        Profile p6 = [select id from profile where name='System Administrator' LIMIT 1];
        
        List<User> users = [SELECT Id FROM User WHERE IsActive = true AND 
                            ByPassTriggerRule__c = false
                            AND profile.Id=:p6.Id LIMIT 100];
        
        Id user1Id = users[3].Id;
        Id user2Id = users[4].Id; 
        Id user3Id = users[0].Id;
        
        user bypassValidation = [SELECT Id, Email, ByPassValidationRule__c, MultiPicklistDivision__c,
                                 ByPassTriggerRule__c,BackupSample__c, Division, CountryforGatekeeper__c FROM 
                                 User WHERE Id=:users[4].Id LIMIT 1];
        
        if(bypassValidation.Division == null){
            bypassValidation.Division = 'None';
        }
        if(bypassValidation.MultiPicklistDivision__c == null){
            bypassValidation.MultiPicklistDivision__c = 'Ceramics';
        }       
        
        bypassValidation.ByPassTriggerRule__c = true;
        bypassValidation.ByPassValidationRule__c = true;
        bypassValidation.BackupSample__c = users[3].Id;
        bypassValidation.CountryforGatekeeper__c = 'Albania';
        update bypassValidation;  
        
        users[0].ByPassValidationRule__c = true;
        users[0].ByPassProcessBuilders__c = true;
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
            p.Name = 'zzzz';
            p.IsActive = true;
            p.ManufacturingImerysPlant__c = '';
            p.Division__c = 'Calderys';
            //p.ProductType3__c = 'Calderys';
            Database.insert(p, true);
            
            Product2 p2 = new product2();
            p2.Name = 'zzzz';
            p2.IsActive = true;
            p2.ManufacturingImerysPlant__c = '';
            p2.Division__c = 'Ceramics';
            //p2.ProductType3__c = 'Calderys';
            Database.insert(p2, true);
            
            Product2 p3 = new product2();
            p3.Name = 'zzzz';
            p3.IsActive = true;
            p3.ManufacturingImerysPlant__c = '';
            p3.Division__c = 'Carbonates';
            Database.insert(p3, true);
            
            Product2 p4 = new product2();
            p4.Name = 'zzzz';
            p4.IsActive = true;
            p4.ManufacturingImerysPlant__c = 'AT - Villach';
            p4.Division__c = 'Aluminates';
            Database.insert(p4, true);
            
            GatekeeperAssignment__c gat = New GatekeeperAssignment__c();
            gat.Division__c = 'Calderys';
            gat.Gatekeeper__c = User2Id;
            gat.AllPlants__c = true;
            gat.BusinessArea__c = 'HTS';
            gat.Object__c = 'Sample';
            gat.Gatekeeper2__c=users[11].id;
            gat.Gatekeeper3__c=users[12].id;
            gat.Gatekeeper4__c=users[13].id;
            Database.insert(gat, true);
            
            
            GatekeeperAssignment__c gat2 = New GatekeeperAssignment__c();
            gat2.Division__c = 'Ceramics';
            gat2.Gatekeeper__c = user1Id;
            gat2.AllPlants__c = true;
            gat2.Object__c = 'Sample';
            gat2.BusinessArea__c = 'HTS';
            gat2.Gatekeeper2__c=users[11].id;
            gat2.Gatekeeper3__c=users[12].id;
            gat2.Gatekeeper4__c=users[13].id;
            
            Database.insert(gat2, true);
            
            GatekeeperAssignment__c gat3 = New GatekeeperAssignment__c();
            gat3.Division__c = 'Aluminates';
            gat3.Gatekeeper__c = User1Id;
            gat3.ManufacturingImerysPlant__c = 'AT - Villach';
            gat3.Object__c = 'Sample';
            gat3.AllPlants__c=false;
            gat3.BusinessArea__c = 'RAC';
            gat3.Gatekeeper2__c=users[11].id;
            gat3.Gatekeeper3__c=users[12].id;
            gat3.Gatekeeper4__c=users[13].id;
            
            Database.insert(gat3, true);
            
            Map<id,GatekeeperAssignment__c> newmap = new Map<id,GatekeeperAssignment__c>();
            newmap.put(gat.Gatekeeper__c, gat);
            
            Map<id,GatekeeperAssignment__c> newmap2 = new Map<id,GatekeeperAssignment__c>();
            newmap.put(gat2.Gatekeeper__c, gat2);
            
            Map<id,GatekeeperAssignment__c> newmap3 = new Map<id,GatekeeperAssignment__c>();
            newmap.put(gat3.Gatekeeper__c, gat3);
            
            RecordType recordName = [SELECT Id, DeveloperName 
                                     FROM RecordType 
                                     WHERE SObjectType = 'Sample__c'
                                     AND DeveloperName = 'SAM_SampleWithoutOpportunity'];  // record type samplewithoutopp
            
            recordTypeName = recordName.Id;
            
            
            Sample__c sam = New Sample__c();
            sam.AccountName__c = acc1.Id;
            sam.RecordTypeId = recordTypeName;
            sam.RecipientName__c = con.Id;
            sam.AccountName__c=acc1.Id;
            sam.Status__c = 'Draft Creation';
            sam.Type__c = 'Lab';
            sam.CSAccountManager__c = User3Id;
            sam.ExpectedDeliveryDate__c = mydate2;
            sam.ProductName__c = p.Id;
            sam.Volume__c = 1233;
            sam.OwnerId = User3Id;
            sam.Unit__c = 'Metric tons (as sold)';
            sam.GateKeeper__c = User2Id;
            sam.OutOfOffice__c = true;
            sam.DateOfFeedback__c = mydate1;
            sam.DispatchSite__c ='FR - Iko';
            
            sam.BusinessArea__c = 'RAC';
            Test.startTest();
            Database.Insert(sam, true);// insert new record with status Draft Creation
            Test.stopTest();
            
            
            List<Sample__c> sample = [SELECT GateKeeper__c, productName__c FROM Sample__c WHERE Id =:sam.Id]; 
            
            If (sample[0].productName__c <> p2.Id){
                for(Sample__c samUpd: sample){
                    samUpd.ProductName__c = p2.Id;
                    samUpd.Volume__c = 1233;
                    samUpd.OwnerId = User3Id;
                    samUpd.Unit__c = 'Metric tons (as sold)';
                    samUpd.GateKeeper__c = User3Id;
                    samUpd.DateOfFeedback__c = mydate1;
                    updateSample.add(samUpd);
                }
                samMapUpdate.putall(updateSample);
                
                Database.update(samMapUpdate.values(),true);
                
                List<Sample__c> listsampleUpdate = [SELECT GateKeeper__c FROM Sample__c WHERE Id =:sam.Id];            
                //System.AssertEquals(listsampleUpdate[0].GateKeeper__c, User3Id);          
            }           
            If (sample[0].productName__c <> p3.Id){
                for(Sample__c samUpd2: sample){
                    samUpd2.ProductName__c = p3.Id;
                    samUpd2.Volume__c = 1233;
                    samUpd2.OwnerId = User3Id;
                    samUpd2.Unit__c = 'Metric tons (as sold)';
                    samUpd2.GateKeeper__c = User1Id;
                    samUpd2.outOfOffice__c = true;
                    samUpd2.DateOfFeedback__c = mydate1;
                    updateSample2.add(samUpd2);
                }               
                samMapUpdate.putall(updateSample);
                Database.update(samMapUpdate.values(),true);
                
                List<Sample__c> listsampleUpdate = [SELECT GateKeeper__c FROM Sample__c WHERE Id =:sam.Id];
                
                //System.AssertEquals(listsampleUpdate[0].GateKeeper__c, User2Id);          
            }
            If (sample[0].productName__c <> p4.Id){
                for(Sample__c samUpd2: sample){
                    samUpd2.ProductName__c = p4.Id;
                    samUpd2.Volume__c = 1233;
                    samUpd2.OwnerId = User3Id;
                    samUpd2.Unit__c = 'Metric tons (as sold)';
                    samUpd2.GateKeeper__c = User1Id;
                    samUpd2.outOfOffice__c = true;
                    samUpd2.DateOfFeedback__c = mydate1;
                    updateSample2.add(samUpd2);
                }               
                samMapUpdate.putall(updateSample);
                Database.update(samMapUpdate.values(),true);
                
                List<Sample__c> listsampleUpdate = [SELECT GateKeeper__c FROM Sample__c WHERE Id =:sam.Id];
                
                //System.AssertEquals(listsampleUpdate[0].GateKeeper__c, User2Id);          
            }
            
            List<Sample__c> samp = [SELECT GateKeeper__c, OutOfOffice__c FROM Sample__c WHERE Id =:sam.Id];  
            
            outofList = [SELECT Message, UserId FROM OutOfOffice
                         WHERE UserId =: User2Id];
            
            if(outOfList.size() == 0){
                //system.assertEquals(samp[0].Gatekeeper__c, user2Id);
                system.assertEquals(samp[0].OutOfOffice__c, false);
            }   
            else{
                //system.assertEquals(samp[0].Gatekeeper__c, users[3].Id);
                system.assertEquals(samp[0].OutOfOffice__c, false);
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
        bypassValidation2.ByPassTriggerRule__c = false;
        update bypassValidation2;
    }    
/**
*@author Geerusting Govind Kumar
*@Date Creation 10/18/2017
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/
     @isTest static void testCreateSampleAccess() {
         String RecordTypeName;
        date mydate1 = date.parse('05/11/2017');
        date mydate2 = date.parse('08/12/2022');
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User WHERE IsActive = true
                            AND ByPassTriggerRule__c = false
                            AND profile.Name = 'System Administrator' LIMIT 5];
        
        Id user1Id = users[0].Id;
        Id user2Id = users[1].Id;
        Id user3Id = users[2].Id;
        
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
            p.Name = 'ddddd';
            p.ManufacturingImerysPlant__c = '';
            p.IsActive = true;
            Database.insert(p, true);
            
            RecordType recordName = [SELECT Id, DeveloperName 
                                     FROM RecordType 
                                     WHERE SObjectType = 'Sample__c'
                                     AND DeveloperName = 'SAM_SampleWithoutOpportunity'];  // record type samplewithoutopp
            
            recordTypeName = recordName.Id;
            
            Sample__c sam = New Sample__c();
            sam.AccountName__c= acc1.Id;
            sam.RecordTypeId = recordTypeName;
            sam.RecipientName__c = con.Id;
            sam.AccountName__c=acc1.Id;
            sam.Status__c = 'Draft Creation';
            sam.Type__c = 'Lab';
            // sam.Division__c = 'Calderys';
            sam.CSAccountManager__c = User2Id;
            sam.ExpectedDeliveryDate__c = mydate2;
            sam.ProductName__c = p.Id;
            sam.Volume__c = 1233;
            sam.OwnerId = User3Id;
            sam.BusinessArea__c = 'HTS';
            sam.Unit__c = 'Metric tons (as sold)';
            sam.DispatchSite__c ='FR - Iko';
            sam.DateOfFeedback__c = mydate1;
            sam.Gatekeeper__c=users[4].id;
            
            Test.StartTest();
            Database.Insert(sam, true);
            Test.StopTest();// insert new record with status Draft Creation
            
            // Insert manual share for user who is not record owner. 
            // Query visit report records.
            
            GatekeeperAssignment__c gat = New GatekeeperAssignment__c();
            gat.Division__c = 'Calderys';
            gat.Gatekeeper__c = users[0].id;
            gat.BusinessArea__c ='RAC';
            gat.AllPlants__c = true;
            gat.Object__c = 'Sample';
            gat.Gatekeeper2__c=users[1].id;
            gat.Gatekeeper3__c=users[2].id;
            gat.Gatekeeper4__c=users[3].id;
            Database.insert(gat, true);
            
            
            List<Sample__Share> sampShrs = [SELECT Id, UserOrGroupId, AccessLevel, 
                                            RowCause FROM Sample__share WHERE ParentId = :sam.Id AND UserOrGroupId= :user2Id];
            
            // Test attributes of manual share.
            if(sampShrs.size() > 0) {
                System.assertEquals(sampShrs[0].AccessLevel, 'Edit');
                System.assertEquals(sampShrs[0].UserOrGroupId, user2Id);
            }                       
        }
    }
 /**
*@author Geerusting Govind Kumar
*@Date Creation 10/18/2017
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/   
    @isTest static void testUpdateSampleAccess() {
         String RecordTypeName;
        date mydate1 = date.parse('05/11/2017');
        date mydate2 = date.parse('08/12/2022');
        
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        
        List<User> users = [SELECT Id, Division, ByPassTriggerRule__c,MultiPicklistDivision__c, ByPassProcessBuilders__c FROM User WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false
                            AND ProfileId =: p2.Id
                            LIMIT 5];
        
        Id user1Id = users[0].Id;
        Id user2Id = users[1].Id;
        Id user3Id = users[2].Id;
        if(users[0].Division == null){
            users[0].Division = 'None';
        }
        if(users[0].MultiPicklistDivision__c == null){
            users[0].MultiPicklistDivision__c = 'Ceramics';
        }       
        users[0].ByPassProcessBuilders__c = true;
        users[0].ByPassTriggerRule__c = true;
        users[0].CountryforGatekeeper__c = 'Albania';
        users[0].BackupComplaint__c = users[3].Id;
        
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
            con.Email = 'test@accenture.com';
            con.AccountId = acc1.Id;
            Database.insert(con, true);
            
            Product2 p = new product2();
            p.Name = 'Test';
            p.ManufacturingImerysPlant__c = '';
            p.IsActive = true;
            Database.insert(p, true);
            
            RecordType recordName = [SELECT Id, DeveloperName 
                                     FROM RecordType 
                                     WHERE SObjectType = 'Sample__c'
                                     AND DeveloperName = 'SAM_SampleWithoutOpportunity'];  // record type samplewithoutopp
            
            recordTypeName = recordName.Id;
            
            
            
            Sample__c sam = New Sample__c();
            sam.AccountName__c = acc1.Id;
            sam.RecordTypeId = recordTypeName;
            sam.RecipientName__c = con.Id;
            sam.AccountName__c=acc1.Id;
            sam.Status__c = 'Draft Creation';
            sam.Type__c = 'Lab';
            // sam.Division__c = 'Calderys';
            sam.CSAccountManager__c = User2Id;
            sam.ExpectedDeliveryDate__c = mydate2;
            sam.ProductName__c = p.Id;
            sam.Volume__c = 1233;
            sam.OwnerId = User3Id;
            sam.BusinessArea__c = 'RAC';
            sam.Unit__c = 'Metric tons (as sold)';
            sam.DispatchSite__c ='FR - Iko';
            sam.DateOfFeedback__c = mydate1;
            
            Database.Insert(sam, true);
            
            // Insert manual share for user who is not record owner. 
            // Query visit report records.
            List<Sample__Share> sampShrs = [SELECT Id, UserOrGroupId, AccessLevel, 
                                            RowCause FROM Sample__share WHERE ParentId = :sam.Id AND UserOrGroupId= :user2Id];
            
            // Test attributes of manual share.
            if(sampShrs.size() > 0) {
                System.assertEquals(sampShrs[0].AccessLevel, 'Edit');
                System.assertEquals(sampShrs[0].UserOrGroupId, user2Id);
            }
            
            List<Sample__c> sam2 = [SELECT id FROM Sample__c WHERE Id = :sam.Id];  
            
            List<Sample__c> updateSampleList2 = New List<Sample__c>(); 
            
            for(Sample__c uv2:sam2){    
                uv2.CSAccountManager__c = users[4].Id;
                updateSampleList2.add(uv2);// update sample
            }  
            Test.startTest();
            Update updatesampleList2;
            Test.stopTest(); 
            
            List<Sample__Share> sampShrs2 = [SELECT Id, UserOrGroupId, AccessLevel, 
                                             RowCause FROM Sample__share WHERE ParentId = :sam.Id AND UserOrGroupId= :users[4].Id];  
            
            if(updateSampleList2.size() > 0){
                System.assertEquals(sampShrs2[0].AccessLevel, 'Edit');
                System.assertEquals(sampShrs2[0].UserOrGroupId, users[4].Id);
            }              
        }
    }
/**
*@author Geerusting Govind Kumar
*@Date Creation 10/18/2017
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/   
    @isTest static void testDeleteSampleAccess() {
         String RecordTypeName;
        date mydate1 = date.parse('05/11/2017');
        date mydate2 = date.parse('08/12/2022');
        
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User WHERE IsActive = true AND ByPassTriggerRule__c = false
                            AND ProfileId =: p2.Id LIMIT 5];
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
            con.Email = 'test@accenture.com';
            con.AccountId = acc1.Id;
            Database.insert(con, true);
            
            Product2 p = new product2();
            p.Name = 'tjtjhky';
            p.ManufacturingImerysPlant__c = '';
            p.IsActive = true;
            Database.insert(p, true);
            
            RecordType recordName = [SELECT Id, DeveloperName 
                                     FROM RecordType 
                                     WHERE SObjectType = 'Sample__c'
                                     AND DeveloperName = 'SAM_SampleWithoutOpportunity'];  // record type samplewithoutopp
            
            recordTypeName = recordName.Id;
            
            Sample__c sam = New Sample__c();
            sam.AccountName__c = acc1.Id;
            sam.RecordTypeId = recordTypeName;
            sam.RecipientName__c = con.Id;
            sam.AccountName__c=acc1.Id;
            sam.Status__c = 'Draft Creation';
            sam.Type__c = 'Lab';
            // sam.Division__c = 'Calderys';
            sam.CSAccountManager__c = User2Id;
            sam.ExpectedDeliveryDate__c = mydate2;
            sam.ProductName__c = p.Id;
            sam.Volume__c = 1233;
            sam.OwnerId = User3Id;
            sam.Unit__c = 'Metric tons (as sold)';
            sam.DispatchSite__c ='FR - Iko';
            sam.BusinessArea__c ='RAC';
            sam.DateOfFeedback__c = mydate1;
            
            Database.Insert(sam, true);
            
            // Insert manual share for user who is not record owner. 
            // Query visit report records.
            List<Sample__Share> sampShrs = [SELECT Id, UserOrGroupId, AccessLevel, 
                                            RowCause FROM Sample__share WHERE ParentId = :sam.Id AND UserOrGroupId= :user2Id];
            
            // Test attributes of manual share.
            if(sampShrs.size() > 0) {
                System.assertEquals(sampShrs[0].AccessLevel, 'Edit');
                System.assertEquals(sampShrs[0].UserOrGroupId, user2Id);
            }
            
            List<Sample__c> sam2 = [SELECT id FROM Sample__c WHERE Id = :sam.Id];  
            
            Test.startTest();
            delete sam2;
            Test.stopTest(); 
            
            integer countDel = [SELECT COUNT() 
                                FROM Sample__share WHERE ParentId = :sam.Id AND UserOrGroupId= :user3Id];  
            
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
    }  */    
      
/**
*@author Geerusting Govind Kumar
*@Date Creation 2/7/2018
*@Date modification
*@param 
*@ExcptionName
*@return error message in custom label 
*/   
    @isTest static void testsampleApproverShr() {
        String RecordTypeName;
        date mydate1 = date.parse('05/11/2017');
        date mydate2 = date.parse('08/12/2022');
        List<Sample__c> samList = new List<Sample__c>();
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false
                            AND profile.Name = 'System Administrator' LIMIT 5];
        Id user1Id = users[0].Id;
        Id user2Id = users[1].Id;
        Id user3Id = users[2].Id;
        
        users[0].ByPassValidationRule__c =true;
        users[0].ByPassProcessBuilders__c = true;
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
            con.LastName= 'ASHNA';
            con.AccountId = acc1.Id;
            Database.insert(con, true);
            
            Product2 p = new product2();
            p.Name = 'tjtjhky';
            p.ManufacturingImerysPlant__c = '';
            p.IsActive = true;
            Database.insert(p, true);
            
            Imerys_Site__c	is= New Imerys_Site__c	();
            is.name='FR - Iko';
            is.DispatchSite__c=true;
            is.ImerysManufacturingPlant__c=true;
            is.ImerysSellingEntity__c=true;
            
            RecordType recordName = [SELECT Id, DeveloperName 
                                     FROM RecordType 
                                     WHERE SObjectType = 'Sample__c'
                                     AND DeveloperName = 'SampleAfterCreation'];  // record type samplewithoutopp
            
            recordTypeName = recordName.Id;
            
            Schema.DescribeFieldResult fieldResult = Sample__c.Incoterm__c.getDescribe(); 
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
            Sample__c sam = New Sample__c();
            sam.AccountName__c = acc1.Id;
            sam.RecordTypeId = recordTypeName;
            sam.RecipientName__c = con.Id;
            sam.AccountName__c=acc1.Id;
            sam.Status__c = 'Draft Creation';
            sam.Type__c = 'Lab';
            // sam.Division__c = 'Calderys';
            sam.CSAccountManager__c = User2Id;
            sam.ExpectedDeliveryDate__c = mydate2;
            sam.ProductName__c = p.Id;
            sam.Volume__c = 1233;
            sam.OwnerId = users[0].id;
            sam.Tech_ApprovalAccess__c=true;
            sam.CostChargedToCustomer__c = 'Free of Charge';
            sam.Incoterm__c ='Collected';
            sam.RequiredDocumentation__c = 'COA';
            sam.Packaging__c = 'Bag';
            sam.Gatekeeper__c = User1Id;
            sam.ApprovalRequirement__c='Required';
            sam.BusinessArea__c = 'RAC';
            sam.Unit__c = 'Metric tons (as sold)';
            sam.DispatchSite__c ='FR - Iko';
            sam.DateOfFeedback__c = mydate1;
            sam.DispatchSiteLookup__c=is.Id;
            sam.AutomaticAcknowledgmentMailtoContact__c='No';
            Database.Insert(sam, true);
            
            for(Sample__c sampUpd: [Select Id FROM Sample__c
                                    WHERE Id =: sam.Id]){
                                        
                                        samList.add(sampUpd);
                                    }
            
            test.startTest();
            update samList;
            test.StopTest();
            
            /*Approval.ProcessSubmitRequest app = new Approval.ProcessSubmitRequest();
            app.setObjectId(sam.id);
            app.setNextApproverIds(new Id[] {sam.GateKeeper__c});
            Approval.ProcessResult result = Approval.process(app);*/
            
            List<Sample__Share> specAssistShrs = [SELECT Id, UserOrGroupId, AccessLevel, 
                                                  RowCause FROM Sample__share 
                                                  WHERE ParentId = :sam.Id AND UserOrGroupId= :users[1].Id];      
            // Test attributes of manual share.
            if(specAssistShrs.size() > 0) {
                System.assertEquals(specAssistShrs[0].AccessLevel, 'Edit');
                System.assertEquals(specAssistShrs[0].UserOrGroupId, users[1].Id);
            }           
            
        }
    } 
    
/**
*@author Jaunbocus Muhammad Irshaad
*@Date Creation 26/10/2021
*@Date modification
*@param 
*@ExcptionName
*@return error message in custom label 
*/   
    @isTest static void testFillMarketSegment(){
      date mydate = date.parse('05/11/2012');
        date mydate1 = date.parse('05/11/2017');
        date mydate2 = date.parse('08/12/2022');
        
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
        List<Sample__c> sampleList = new List<Sample__c>();
        
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
            accTest.Business_Areas__c='RAC';
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
            relation3.AccountManager__c = users[3].Id;
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
            
            RecordType recordName = [SELECT Id, DeveloperName 
                                     FROM RecordType 
                                     WHERE SObjectType = 'Sample__c'
                                     AND DeveloperName = 'SAM_SampleWithOpportunity'];  // record type samplewithoutopp
			
			Id recordTypeName = recordName.Id;
            
            for(Relationship__c relList: relat){
                Sample__c sam = New Sample__c();
                sam.CSAccountManager__c = accTest.Id;
                sam.RecordTypeId = recordTypeName;
                sam.RecipientName__c = con.Id;
                sam.AccountName__c=accTest.Id;
                sam.Status__c = 'Draft Creation';
                sam.Divisions__c = 'Aluminates';
                sam.Type__c = 'Lab';
                sam.Tech_RelationshipInformation__c = relation2.id;
                sam.CSAccountManager__c = Users[0].Id;
                sam.ExpectedDeliveryDate__c = mydate2;
                sam.ProductName__c = p.Id;
                sam.Volume__c = 1233;
                sam.OwnerId = Users[0].Id;
                sam.BusinessArea__c ='RAC';
                sam.Unit__c = 'Metric tons (as sold)';
                sam.GateKeeper__c = Users[0].Id;
                sam.OutOfOffice__c = true;
                sam.DateOfFeedback__c = mydate1;
                sam.DispatchSite__c ='FR - Iko';
                sam.AccountName__c=accTest.Id;
                
                sampleList.add(sam);
            }
            Test.startTest();
            	Insert sampleList;
            Test.stopTest();
        }
	}
      
           
     
}