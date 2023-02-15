@IsTest
/**
*@author Jaunbocus Muhammad Irshaad
*@Date Creation 22/12/2021
*@Date modification 
*@description 
*/
public class AP01_FreightRateRequestTriggerHanderTEST {
    @isTest static void testMapResponsibleParty() {
       String recordTypeTransloadRail;
        String recordTypeTruckIntermodal;
        String recordTypeOceanAir;
        
        Integer countOwner;
        date myDate = date.parse('05/11/2017');
        date mydate2 = date.parse('08/12/2018');
        DateTime date1 = Date.today(); 

        
        Profile p3 = [select id from profile where name='System Administrator' LIMIT 1];
        
        List<User> users = [SELECT Id, BackupComplaint__c,ByPassValidationRule__c,bypassprocessbuilders__c,bypassworkflows__c FROM User WHERE IsActive = true
                            AND ByPassTriggerRule__c = false AND
                            profile.Id =:p3.Id LIMIT 100];
        Id user1Id = users[3].Id;
        Id user2Id = users[4].Id; 
        Id user3Id = users[0].Id;
        system.debug('user 0:'+user3Id);
        
        user bypassValidation = [SELECT Id, BackupComplaint__c, Email, ByPassValidationRule__c, MultiPicklistDivision__c, Division FROM 
                                 User WHERE Id=:users[0].Id LIMIT 1];
        
        system.debug('user fetched'+bypassValidation);
        
        //if(bypassValidation.Division == null){
        //   bypassValidation.Division = 'None';
        //}
        bypassValidation.MultiPicklistDivision__c = 'Calderys';
        bypassValidation.BackupComplaint__c = user1Id;
        bypassValidation.ByPassValidationRule__c = true;
        
        update bypassValidation; 
        
        
        users[0].ByPassValidationRule__c = true;
        users[0].bypassprocessbuilders__c = true;
        users[0].bypassworkflows__c =true;
        update users[0];
        system.debug('User selected:'+users[0]);
        system.runas(users[0]){
            //Transload/Rail
            GatekeeperAssignment__c gat = New GatekeeperAssignment__c();
            gat.Division__c = 'Calderys';
            gat.Gatekeeper__c = user2Id;
            gat.BusinessArea__c = 'HTS';
            gat.Object__c = 'Freight Rate Request';
            gat.ModeOfShipment__c = 'TransloadRail';
            gat.Gatekeeper__c = user1Id;
            gat.Gatekeeper2__c= user2Id;
            gat.Gatekeeper3__c = users[0].Id;
            
            
            Database.insert(gat, true);
            
            //Ocean,Air
            GatekeeperAssignment__c gat2 = New GatekeeperAssignment__c();
            gat2.Division__c = 'Aluminates';
            gat2.Gatekeeper__c = user1Id;
            gat2.Gatekeeper2__c= user2Id;
            gat2.Gatekeeper3__c = users[0].Id;
            gat2.Object__c = 'Freight Rate Request';
            gat2.ModeOfShipment__c = 'OceanAir';
            gat2.BusinessArea__c = 'RAC';
            gat2.Product_Type_1__c = 'Fused Alumina';
            Database.insert(gat2, true);  

               //Truck/Intermodal
            GatekeeperAssignment__c gat3 = New GatekeeperAssignment__c();
            gat3.Division__c = 'Ceramics';
            gat3.Gatekeeper__c = users[1].Id;
            gat3.Gatekeeper2__c= user2Id;
            gat3.Gatekeeper3__c = users[0].Id;
            gat3.Object__c = 'Freight Rate Request';
            gat2.ModeOfShipment__c = 'TruckIntermodal';
            gat3.BusinessArea__c ='PM APAC';
            gat3.ManufacturingImerysPlant__c = 'CA - Suzorite';
   
            
            Database.insert(gat3, true);
            
            
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
            con.LastName= 'ALI';
            con.Email = 'test@accenture.com.com';
            con.AccountId = accTest.Id;
            Database.insert(con, true);
            
            
            
            Product2 pro = new Product2(Name = 'Test Product',CurrencyIsoCode = 'EUR');
            insert pro;
            
            system.debug('=======Product2==========' + [select id, CurrencyIsoCode from Product2 Where id=: pro.Id]);
            
            Id stdPb = test.getStandardPricebookId();
            
            //stdPb.CurrencyIsoCode = 'EUR';
            //stdPb.isActive = true;
            //update stdPb; 
            //PricebookEntry pbestd = new PricebookEntry(pricebook2id = stdPb.id, product2id = pro.id,unitprice=1.0, isActive=true ,CurrencyIsoCode = 'EUR');
            //insert pbestd;
            
          
            
            PricebookEntry pbe = New PricebookEntry ();
      		pbe = new PricebookEntry(Pricebook2Id = stdPb, Product2Id = pro.Id, UnitPrice = 10000, IsActive = true, UseStandardPrice = false);
            insert pbe;
            
            system.debug('========PricebookEntry=========' + [select id, CurrencyIsoCode from PricebookEntry Where product2id=: pro.Id]);
            
            
            opportunity o = new opportunity();
            o.name = 'Pizza King Oppty';
            o.AccountId = accTest.Id;
            o.CloseDate = system.today();
            o.StageName = 'Analyze needs & solution';
            o.Probability = 20;
            o.Division__c = 'Ceramics';
            o.CurrencyIsoCode ='EUR';
            o.pricebook2Id =stdPb;
            insert o;
            
            system.debug('======Opportunity===========' + [select id, CurrencyIsoCode from Opportunity Where id=: o.Id]);
            
            Quote qt = new Quote
                (Name='test quote',OpportunityId=o.id,Pricebook2Id = stdPb,ShipTo__c= accTest.Id,BillTo__c = accTest.Id,
                 ContactId=con.id, ExpirationDate=system.today());
            system.debug('status'+ qt.status);
            system.debug('prod pers:'+qt.Product_Percent_Completion__c);
            system.debug('bypass vR:'+users[0].ByPassValidationRule__c);
            system.debug('ReasonForClosing__c'+ qt.ReasonForClosing__c);
            insert qt;
            
            //OpportunityLineItem oli = new OpportunityLineItem(PricebookEntryId=pkBook.Id, Packaging__c ='Bag', opportunityid = o.id, Quantity = 2,unitprice=1.5);
            
            //insert oli;
            
            //system.debug('=======OpportunityLineItem==========' + [select id, CurrencyIsoCode from OpportunityLineItem Where id=: oli.Id]);
            QuoteLineItem qliliner = new QuoteLineItem(	Product2Id=pro.id,
                                                       	QuoteId=qt.id,
                                                       	PriceBookEntryID=pbe.id,
                                                        Packaging__c='Bag',
                                                       Unit__c='Kilogram',
                                                       ProductUnitPrice__c=100,
                                                       CustomerService__c=user1Id,
                                                        ProductForm__c='Compacted',
                                                       	Quantity=4, 
                                                       	UnitPrice =50,
                                                       	Incoterm__c = 'EXW - Ex Works');
            insert qliliner;
            
            test.startTest();
            list<FreightRateRequest__c> frrl= new list<FreightRateRequest__c>();
            RecordType recordName = [SELECT Id, DeveloperName 
                                    FROM RecordType 
                                    WHERE SObjectType = 'FreightRateRequest__c'
                                    AND DeveloperName = 'TransloadRail'];  
                                    
            recordTypeTransloadRail = recordName.Id;
            
            FreightRateRequest__c frr = new FreightRateRequest__c();
            frr.RecordTypeId = recordTypeTransloadRail;
            //frr.Quote_Line_Item__c = qliliner.id;
            frr.TypeOfOrigin__c = 'Mine';
            frr.Mineral__c = 'CaO';
            frr.VolumeRange__c = 'Month';
            frr.IsAnOrderPending__c = 'No';
            frr.Quoterating__c = 'Estimate';
            frr.IsThisRequestUrgent__c = 'Yes';
            frr.DateQuoteNeeded__c = myDate;
            frr.ReasonForQuote__c = 'Other';
            frr.OriginRailroad__c='Port Louis';
            frr.DestinationRailroad__c = 'Mahebourg';
            frr.RailCarOwnership__c = 'Rail Road Owned';
            frr.RailCarType__c='Other';
            frrl.add(frr);
            
            RecordType recordName1 = [SELECT Id, DeveloperName 
                                    FROM RecordType 
                                    WHERE SObjectType = 'FreightRateRequest__c'
                                    AND DeveloperName = 'TruckIntermodal'];  
                                    
            recordTypeTruckIntermodal = recordName1.Id;
            
            FreightRateRequest__c frr1 = new FreightRateRequest__c();
            frr1.RecordTypeId = recordTypeTruckIntermodal;
            frr1.Quote_Line_Item__c = qliliner.id;
            frr1.TypeOfOrigin__c = 'Mine';
            frr1.Mineral__c = 'CaO';
            frr1.VolumeRange__c = 'Month';
            frr1.IsAnOrderPending__c = 'No';
            frr1.Quoterating__c = 'Estimate';
            frr1.IsThisRequestUrgent__c = 'Yes';
            frr1.DateQuoteNeeded__c = myDate;
            frr1.ReasonForQuote__c = 'Other';
            frr1.OriginRailroad__c='Port Louis';
            frr1.DestinationRailroad__c = 'Mahebourg';
            frr1.RailCarOwnership__c = 'Rail Road Owned';
            frr1.RailCarType__c='Other';
            
            frrl.add(frr1);
            insert frrl;
                
            test.stopTest(); 
            
        }
    }
    @isTest static void testMapResponsibleParty2() {
        Integer countOwner;
        date myDate = date.parse('05/11/2017');
        date mydate2 = date.parse('08/12/2018');
        DateTime date1 = Date.today(); 

        
        Profile p3 = [select id from profile where name='System Administrator' LIMIT 1];
        
        List<User> users = [SELECT Id, BackupComplaint__c,ByPassValidationRule__c,bypassprocessbuilders__c,bypassworkflows__c FROM User WHERE IsActive = true
                            AND ByPassTriggerRule__c = false AND
                            profile.Id =:p3.Id LIMIT 100];
        Id user1Id = users[3].Id;
        Id user2Id = users[4].Id; 
        Id user3Id = users[0].Id;
        system.debug('user 0:'+user3Id);
        
        user bypassValidation = [SELECT Id, BackupComplaint__c, Email, ByPassValidationRule__c, MultiPicklistDivision__c, Division FROM 
                                 User WHERE Id=:users[0].Id LIMIT 1];
        
        system.debug('user fetched'+bypassValidation);
        
        //if(bypassValidation.Division == null){
        //   bypassValidation.Division = 'None';
        //}
        bypassValidation.MultiPicklistDivision__c = 'Calderys';
        bypassValidation.BackupComplaint__c = user1Id;
        bypassValidation.ByPassValidationRule__c = true;
        
        update bypassValidation; 
        
        
        users[0].ByPassValidationRule__c = true;
        users[0].bypassprocessbuilders__c = true;
        users[0].bypassworkflows__c =true;
        update users[0];
        system.debug('User selected:'+users[0]);
        system.runas(users[0]){
            //Transload/Rail
            GatekeeperAssignment__c gat = New GatekeeperAssignment__c();
            gat.Division__c = 'Calderys';
            gat.Gatekeeper__c = user2Id;
            gat.BusinessArea__c = 'HTS';
            gat.Object__c = 'Freight Rate Request';
            gat.ModeOfShipment__c = 'TransloadRail';
            gat.Gatekeeper__c = user1Id;
            gat.Gatekeeper2__c= user2Id;
            gat.Gatekeeper3__c = users[0].Id;
            
            
            Database.insert(gat, true);
            
            //Ocean,Air
            GatekeeperAssignment__c gat2 = New GatekeeperAssignment__c();
            gat2.Division__c = 'Aluminates';
            gat2.Gatekeeper__c = user1Id;
            gat2.Gatekeeper2__c= user2Id;
            gat2.Gatekeeper3__c = users[0].Id;
            gat2.Object__c = 'Freight Rate Request';
            gat2.ModeOfShipment__c = 'OceanAir';
            gat2.BusinessArea__c = 'RAC';
            gat2.Product_Type_1__c = 'Fused Alumina';
            Database.insert(gat2, true);  

               //Truck/Intermodal
            GatekeeperAssignment__c gat3 = New GatekeeperAssignment__c();
            gat3.Division__c = 'Ceramics';
            gat3.Gatekeeper__c = users[1].Id;
            gat3.Gatekeeper2__c= user2Id;
            gat3.Gatekeeper3__c = users[0].Id;
            gat3.Object__c = 'Freight Rate Request';
            gat2.ModeOfShipment__c = 'TruckIntermodal';
            gat3.BusinessArea__c ='PM APAC';
            gat3.ManufacturingImerysPlant__c = 'CA - Suzorite';
   
            
            Database.insert(gat3, true);
            
            
            Account accTest= new Account();
            accTest.Name = 'VRTEST';
            accTest.BillingCountry = 'United States';
            accTest.BillingStreet = 'Test';
            accTest.BillingCity = 'New York';
            accTest.SegmentL1__c = 'Abrasive';
            accTest.Type = 'Head Office';
            Database.insert(accTest, true);
            
            Contact con = new Contact();
             con.Salutation = 'Mr.';
            con.FirstName = 'Shia';
            con.LastName= 'ALI';
            con.Email = 'test@accenture.com.com';
            con.AccountId = accTest.Id;
            Database.insert(con, true);
            
            
            
            Product2 pro = new Product2(Name = 'Test Product',CurrencyIsoCode = 'EUR');
            insert pro;
            
            system.debug('=======Product2==========' + [select id, CurrencyIsoCode from Product2 Where id=: pro.Id]);
            
            Id stdPb = test.getStandardPricebookId();
            system.debug('<======Pricebook=========>'+stdPb);
            //stdPb.CurrencyIsoCode = 'EUR';
            //stdPb.isActive = true;
            //update stdPb; 
            //PricebookEntry pbestd = new PricebookEntry(pricebook2id = stdPb.id, product2id = pro.id,unitprice=1.0, isActive=true ,CurrencyIsoCode = 'EUR');
            //insert pbestd;
            
          
            
            PricebookEntry pbe = New PricebookEntry ();
      		pbe = new PricebookEntry(Pricebook2Id = stdPb, Product2Id = pro.Id, UnitPrice = 10000, IsActive = true, UseStandardPrice = false);
            insert pbe;
            
            system.debug('========PricebookEntry=========' + [select id,Pricebook2Id,Product2Id, CurrencyIsoCode from PricebookEntry Where product2id=: pro.Id]);
            
            
            opportunity o = new opportunity();
            o.name = 'Pizza King Oppty';
            o.AccountId = accTest.Id;
            o.CloseDate = system.today();
            o.StageName = 'Analyze needs & solution';
            o.Probability = 20;
            o.Division__c = 'Ceramics';
            o.CurrencyIsoCode ='EUR';
            o.pricebook2Id =stdPb;
            insert o;
            
            system.debug('======Opportunity===========' + [select id, CurrencyIsoCode,pricebook2Id from Opportunity Where id=: o.Id]);
            
            Quote qt = new Quote
                (Name='test quote',OpportunityId=o.id,pricebook2Id=stdPb);
            system.debug('status'+ qt.status);
            system.debug('prod pers:'+qt.Product_Percent_Completion__c);
            system.debug('bypass vR:'+users[0].ByPassValidationRule__c);
            system.debug('ReasonForClosing__c'+ qt.ReasonForClosing__c);
            insert qt;
            system.debug('<-----quote----->'+qt);
            
            //OpportunityLineItem oli = new OpportunityLineItem(PricebookEntryId=pkBook.Id, Packaging__c ='Bag', opportunityid = o.id, Quantity = 2,unitprice=1.5);
            
            //insert oli;
            
            //system.debug('=======OpportunityLineItem==========' + [select id, CurrencyIsoCode from OpportunityLineItem Where id=: oli.Id]);
            QuoteLineItem qliliner = new QuoteLineItem(	Product2Id=pro.id,
                                                       	QuoteId=qt.id,
                                                       	PriceBookEntryID=pbe.id,
                                                        Packaging__c='Bag',
                                                       Unit__c='Kilogram',
                                                       ProductUnitPrice__c=100,
                                                       CustomerService__c=user1Id,
                                                        ProductForm__c='Compacted',
                                                       	Quantity=4, 
                                                       	UnitPrice =50,
                                                       	Incoterm__c = 'EXW - Ex Works');
            insert qliliner;
            
            test.startTest();
            RecordType recordName1 = [SELECT Id, DeveloperName 
                                    FROM RecordType 
                                    WHERE SObjectType = 'FreightRateRequest__c'
                                    AND DeveloperName = 'TruckIntermodal'];  
                                    
            String recordTypeTruckIntermodal = recordName1.Id;
            FreightRateRequest__c frr1 = new FreightRateRequest__c();
            frr1.RecordTypeId = recordTypeTruckIntermodal;
            frr1.Quote_Line_Item__c = qliliner.id;
            frr1.TypeOfOrigin__c = 'Mine';
            frr1.Mineral__c = 'CaO';
            frr1.VolumeRange__c = 'Month';
            frr1.IsAnOrderPending__c = 'No';
            frr1.Quoterating__c = 'Estimate';
            frr1.IsThisRequestUrgent__c = 'Yes';
            frr1.DateQuoteNeeded__c = myDate;
            frr1.ReasonForQuote__c = 'Other';
            frr1.OriginRailroad__c='Port Louis';
            frr1.DestinationRailroad__c = 'Mahebourg';
            frr1.RailCarOwnership__c = 'Rail Road Owned';
            frr1.RailCarType__c='Other';
                        
            Database.Insert(frr1,true);
                
            test.stopTest(); 
            
        }
    }
    @isTest static void testMapResponsibleParty3() {
        Integer countOwner;
        date myDate = date.parse('05/11/2017');
        date mydate2 = date.parse('08/12/2018');
        DateTime date1 = Date.today(); 

        
        Profile p3 = [select id from profile where name='System Administrator' LIMIT 1];
        
        List<User> users = [SELECT Id, BackupComplaint__c,ByPassValidationRule__c,bypassprocessbuilders__c,bypassworkflows__c FROM User WHERE IsActive = true
                            AND ByPassTriggerRule__c = false AND
                            profile.Id =:p3.Id LIMIT 100];
        Id user1Id = users[3].Id;
        Id user2Id = users[4].Id; 
        Id user3Id = users[0].Id;
        system.debug('user 0:'+user3Id);
        
        user bypassValidation = [SELECT Id, BackupComplaint__c, Email, ByPassValidationRule__c, MultiPicklistDivision__c, Division FROM 
                                 User WHERE Id=:users[0].Id LIMIT 1];
        
        system.debug('user fetched'+bypassValidation);
        
        //if(bypassValidation.Division == null){
        //   bypassValidation.Division = 'None';
        //}
        bypassValidation.MultiPicklistDivision__c = 'Calderys';
        bypassValidation.BackupComplaint__c = user1Id;
        bypassValidation.ByPassValidationRule__c = true;
        
        update bypassValidation; 
        
        
        users[0].ByPassValidationRule__c = true;
        users[0].bypassprocessbuilders__c = true;
        users[0].bypassworkflows__c =true;
        update users[0];
        system.debug('User selected:'+users[0]);
        system.runas(users[0]){
            //Transload/Rail
            GatekeeperAssignment__c gat = New GatekeeperAssignment__c();
            gat.Division__c = 'Calderys';
            gat.Gatekeeper__c = user2Id;
            gat.BusinessArea__c = 'HTS';
            gat.Object__c = 'Freight Rate Request';
            gat.ModeOfShipment__c = 'TransloadRail';
            gat.Gatekeeper__c = user1Id;
            gat.Gatekeeper2__c= user2Id;
            gat.Gatekeeper3__c = users[0].Id;
            
            
            Database.insert(gat, true);
            
            //Ocean,Air
            GatekeeperAssignment__c gat2 = New GatekeeperAssignment__c();
            gat2.Division__c = 'Aluminates';
            gat2.Gatekeeper__c = user1Id;
            gat2.Gatekeeper2__c= user2Id;
            gat2.Gatekeeper3__c = users[0].Id;
            gat2.Object__c = 'Freight Rate Request';
            gat2.ModeOfShipment__c = 'OceanAir';
            gat2.BusinessArea__c = 'RAC';
            gat2.Product_Type_1__c = 'Fused Alumina';
            Database.insert(gat2, true);  

               //Truck/Intermodal
            GatekeeperAssignment__c gat3 = New GatekeeperAssignment__c();
            gat3.Division__c = 'Ceramics';
            gat3.Gatekeeper__c = users[1].Id;
            gat3.Gatekeeper2__c= user2Id;
            gat3.Gatekeeper3__c = users[0].Id;
            gat3.Object__c = 'Freight Rate Request';
            gat3.ModeOfShipment__c = 'TruckIntermodal';
            gat3.BusinessArea__c ='PM APAC';
            gat3.ManufacturingImerysPlant__c = 'CA - Suzorite';
   
            
            Database.insert(gat3, true);
            
            
            Account accTest= new Account();
            accTest.Name = 'VRTEST';
            accTest.BillingCountry = 'United States';
            accTest.BillingCity = 'New York';
            accTest.SegmentL1__c = 'Abrasive';
            accTest.BillingStreet = 'Test';
            accTest.Type = 'Head Office';
            Database.insert(accTest, true);
            
            Contact con = new Contact();
             con.Salutation = 'Mr.';
            con.FirstName = 'Shia';
            con.LastName= 'ALI';
            con.Email = 'test@accenture.com.com';
            con.AccountId = accTest.Id;
            Database.insert(con, true);
            
            
            
            Product2 pro = new Product2(Name = 'Test Product',CurrencyIsoCode = 'EUR');
            insert pro;
            
            system.debug('=======Product2==========' + [select id, CurrencyIsoCode from Product2 Where id=: pro.Id]);
            
            Id stdPb = test.getStandardPricebookId();
            system.debug('<======Pricebook=========>'+stdPb);
            //stdPb.CurrencyIsoCode = 'EUR';
            //stdPb.isActive = true;
            //update stdPb; 
            //PricebookEntry pbestd = new PricebookEntry(pricebook2id = stdPb.id, product2id = pro.id,unitprice=1.0, isActive=true ,CurrencyIsoCode = 'EUR');
            //insert pbestd;
            
          
            
            PricebookEntry pbe = New PricebookEntry ();
      		pbe = new PricebookEntry(Pricebook2Id = stdPb, Product2Id = pro.Id, UnitPrice = 10000, IsActive = true, UseStandardPrice = false);
            insert pbe;
            
            system.debug('========PricebookEntry=========' + [select id,Pricebook2Id,Product2Id, CurrencyIsoCode from PricebookEntry Where product2id=: pro.Id]);
            
            
            opportunity o = new opportunity();
            o.name = 'Pizza King Oppty';
            o.AccountId = accTest.Id;
            o.CloseDate = system.today();
            o.StageName = 'Analyze needs & solution';
            o.Probability = 20;
            o.Division__c = 'Ceramics';
            o.CurrencyIsoCode ='EUR';
            o.pricebook2Id =stdPb;
            insert o;
            
            system.debug('======Opportunity===========' + [select id, CurrencyIsoCode,pricebook2Id from Opportunity Where id=: o.Id]);
            
            Quote qt = new Quote
                (Name='test quote',OpportunityId=o.id,pricebook2Id=stdPb);
            system.debug('status'+ qt.status);
            system.debug('prod pers:'+qt.Product_Percent_Completion__c);
            system.debug('bypass vR:'+users[0].ByPassValidationRule__c);
            system.debug('ReasonForClosing__c'+ qt.ReasonForClosing__c);
            insert qt;
            system.debug('<-----quote----->'+qt);
            
            //OpportunityLineItem oli = new OpportunityLineItem(PricebookEntryId=pkBook.Id, Packaging__c ='Bag', opportunityid = o.id, Quantity = 2,unitprice=1.5);
            
            //insert oli;
            
            //system.debug('=======OpportunityLineItem==========' + [select id, CurrencyIsoCode from OpportunityLineItem Where id=: oli.Id]);
            QuoteLineItem qliliner = new QuoteLineItem(	Product2Id=pro.id,
                                                       	QuoteId=qt.id,
                                                       	PriceBookEntryID=pbe.id,
                                                       	Quantity=4, 
                                                        Packaging__c='Bag',
                                                       Unit__c='Kilogram',
                                                       ProductUnitPrice__c=100,
                                                       CustomerService__c=user1Id,
                                                        ProductForm__c='Compacted',
                                                       	UnitPrice =50,
                                                       	Incoterm__c = 'EXW - Ex Works');
            insert qliliner;
            
            test.startTest();
            RecordType recordName1 = [SELECT Id, DeveloperName 
                                    FROM RecordType 
                                    WHERE SObjectType = 'FreightRateRequest__c'
                                    AND DeveloperName = 'OceanAir'];  
                                    
            String recordTypeOceanAir = recordName1.Id;
            FreightRateRequest__c frr2 = new FreightRateRequest__c();
            frr2.RecordTypeId = recordTypeOceanAir;
            frr2.Quote_Line_Item__c = qliliner.id;
            frr2.TypeOfOrigin__c = 'Mine';
            frr2.Mineral__c = 'CaO';
            frr2.VolumeRange__c = 'Month';
            frr2.IsAnOrderPending__c = 'No';
            frr2.Quoterating__c = 'Estimate';
            frr2.IsThisRequestUrgent__c = 'Yes';
            frr2.DateQuoteNeeded__c = myDate;
            frr2.ReasonForQuote__c = 'Other';
            frr2.OriginRailroad__c='Port Louis';
            frr2.DestinationRailroad__c = 'Mahebourg';
            frr2.RailCarOwnership__c = 'Rail Road Owned';
            frr2.RailCarType__c='Other';
                        
            Database.Insert(frr2,true);
                
            test.stopTest(); 
            
        }
    }

}