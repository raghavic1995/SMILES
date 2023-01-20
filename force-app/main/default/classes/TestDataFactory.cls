/**
*@author Geerusting Govind Kumar
*@Date Draft Creation 6/7/2017
*@Date modification 8/8/2017- testupdatevisitreport: run as visitreport owner to prevent validation rule from firing.
*@Date modification 14/9/2017- Allow owner to transfer visit report from VisitReportTrigger.
*@Date modification 11/27/2017- Test error message in InternalAttendeesTrigger and allow test for ByPassTriggerRule.
*@description TestDataFactory- create Account Team Member based on Draft Creation of new relationship, update and delete account team,
allow sharing rule on visit report object, display error message on update/delete of visit report if user is not an owner and internal attendees
*/
@isTest
public class TestDataFactory {
    public List<SelectOption> options = new List<SelectOption>();
    public string Divisions;
    /**
*@author Geerutsing Govind Kumar
*@Date Draft Creation 6/7/2017
*@Date modification 18/7/2017
*@param numRel Integer type
*@ExcptionName Divisions
*@return 
*/ 
    public List<SelectOption> getDivisions()
    {
        Schema.DescribeFieldResult fieldResult = Relationship__c.Divisions__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple)
        {
            Divisions = f.getlabel();
        }     
        return options;
    }
    
    // /**
    // *@author Jaunbocus Muhammad Irshaad
    // *@Date Draft Creation 28/5/2021
    // *@Date modification 
    // *@param 
    // *@ExcptionName
    // *@return 
    // */
    
    /*
    public static void testGetUserBusinessArea(){
        List<User> users = [SELECT Id, ByPassTriggerRule__c, NewBusinessArea__c,Email, Name FROM User 
                            WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false 
                           ];
        
        system.RunAs(users[0]){
            Test.startTest();
            string BusinessArea1 = AP01_OppoRelatedListProjController.getUserDetails();
            Test.StopTest();
            
            system.assertEquals(users[0].NewBusinessArea__c,BusinessArea1);
        }
        
        
    }*/
    
    // /**
    // *@author Jaunbocus Muhammad Irshaad
    // *@Date Draft Creation 16/02/2021
    // *@Date modification 
    // *@param 
    // *@ExcptionName
    // *@return 
    // */
    
    public static void testGetUserInfo(){
        List<User> users = [SELECT Id, ByPassTriggerRule__c, NewBusinessArea__c,Email, Name FROM User 
                            WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false 
                           ];
        
        List<recordtype> recType = [Select Id from recordtype where developername = 'RecurrentSales'];
        Id recId = recType[0].id;
        
        
        system.RunAs(users[0]){
            Test.startTest();
            string BusinessArea1 	= getCurrentUserInfo.getUserDetails();
            List<String> str  		= getCurrentUserInfo.getRecordIdAvailable();
            String recordTypeName	= getCurrentUserInfo.getRecordTypeName(recId);
            Test.StopTest();
            
            system.assertEquals(users[0].NewBusinessArea__c,BusinessArea1);
        }
        
        
    }
    
    
    /*
    public static void testdDeleteRelatedOppo(){
        List<User> users = [SELECT Id, ByPassTriggerRule__c,ByPassValidationRule__c, NewBusinessArea__c,Email, Name FROM User 
                            WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false 
                           ];
        
        users[0].ByPassValidationRule__c = true;
        update users[0];8
        
        system.RunAs(users[0]){
            Account accTest= new Account();
            accTest.Name = 'VRTEST';
            accTest.BillingCountry = 'United States';
            accTest.BillingCity = 'New York';
            accTest.SegmentL1__c = 'Abrasive';
            accTest.Type = 'Head Office';
            Database.insert(accTest, true);
            
           
            Market_Segmentation__c markSeg =  new Market_Segmentation__c();
            markSeg.Name = 'test';
            markSeg.Segmentation_Level_2__c =true;
            markSeg.Segmentation_Level_3__c = true;
            markSeg.Record_Level_1__c =true;
            markSeg.Record_Level_2__c =true;
            markSeg.Record_Level_3__c =true;
            markSeg.Record_Level_4__c =true;
            markSeg.Market_Segmentation_Code__c = '12352df02';
            insert markSeg;
            
            Project__c proj = new Project__c();
            proj.Project_Name__c = 'Test Proj';
            proj.ProjectStatus__c ='On Watch';
            proj.Account__c = accTest.Id;
            proj.ProjectType__c = 'Prorata';
            proj.BusinessArea__c='HTS';
            proj.MarketSegmentationNew__c = markSeg.id;
            proj.CurrencyIsoCode='EUR';
            insert proj;
            
            opportunity opp = new opportunity();
            opp.name = 'Pizza King Oppty';
            opp.type = 'New Customer';
            opp.RecordTypeId = '0121l0000009xwHAAQ';
            opp.Project__c = proj.id;
            opp.AccountId = accTest.Id;
            opp.CloseDate = system.today();
            opp.StageName = 'New';
            opp.Probability = 20;
            opp.Division__c = 'Ceramics';
            opp.BusinessArea__c = 'RAC';
            insert opp;
            
            Test.StartTest();
           		AP01_OppoRelatedListProjController.deleteRelatedOppo(opp.Id);
            Test.stopTest();
            
        }
        
    }*/
    
    // /**
    // *@author Jaunbocus Muhammad Irshaad
    // *@Date Draft Creation 20/5/2021
    // *@Date modification 
    // *@param 
    // *@ExcptionName
    // *@return 
    // */    
    // 
   
    /*
    public static void testGetOppoProj(){
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c,ByPassValidationRule__c, NewBusinessArea__c,Email, Name FROM User 
                            WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false 
                           ];
        
        users[0].ByPassValidationRule__c = true;
        update users[0];
        
        system.RunAs(users[0]){
            Account accTest= new Account();
            accTest.Name = 'VRTEST';
            accTest.BillingCountry = 'United States';
            accTest.BillingCity = 'New York';
            accTest.SegmentL1__c = 'Abrasive';
            accTest.Type = 'Head Office';
            Database.insert(accTest, true);
            
           
            Market_Segmentation__c markSeg =  new Market_Segmentation__c();
            markSeg.Name = 'test';
            markSeg.Segmentation_Level_2__c =true;
            markSeg.Segmentation_Level_3__c = true;
            markSeg.Record_Level_1__c =true;
            markSeg.Record_Level_2__c =true;
            markSeg.Record_Level_3__c =true;
            markSeg.Record_Level_4__c =true;
            markSeg.Market_Segmentation_Code__c = '12352df02';
            insert markSeg;
            
            Project__c proj = new Project__c();
            proj.Project_Name__c = 'Test Proj';
            proj.ProjectStatus__c ='On Watch';
            proj.Account__c = accTest.Id;
            proj.ProjectType__c = 'Prorata';
            proj.BusinessArea__c='HTS';
            proj.MarketSegmentationNew__c = markSeg.id;
            proj.CurrencyIsoCode='EUR';
            insert proj;
            
            opportunity opp = new opportunity();
            opp.name = 'Pizza King Oppty';
            opp.type = 'New Customer';
            opp.RecordTypeId = '0121l0000009xwHAAQ';
            opp.Project__c = proj.id;
            opp.AccountId = accTest.Id;
            opp.CloseDate = system.today();
            opp.StageName = 'New';
            opp.Probability = 20;
            opp.Division__c = 'Ceramics';
            opp.BusinessArea__c = 'RAC';
            insert opp;
            
            Test.StartTest();
            List<Opportunity> oppList = AP01_OppoRelatedListProjController.getOpp(proj.Id);
            Test.stopTest();
            
        }
        
    }*/
    
    // /**
    // *@author Jaunbocus Muhammad Irshaad
    // *@Date Draft Creation 21/5/2021
    // *@Date modification 
    // *@param 
    // *@ExcptionName
    // *@return 
    // */ 
    // 
    
    /*
    public static void testgetRecTypeIdProject(){
         List<User> users = [SELECT Id, ByPassTriggerRule__c,ByPassValidationRule__c, NewBusinessArea__c,Email, Name FROM User 
                            WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false 
                           ];
        
        users[0].ByPassValidationRule__c = true;
        update users[0];
        
        system.RunAs(users[0]){
         
            Test.StartTest();
            	id recTypeId = AP01_OppoRelatedListProjController.getRecTypeIdProject();
            Test.stopTest();
        }
        
    }*/


    
    /**
*@author Geerutsing Govind Kumar
*@Date Draft Creation 6/7/2017
*@Date modification 18/7/2017
*@param numRel Integer type
*@ExcptionName DMLException e on insert
*@return 
*/  
    public static void testcreateAccountTeam(Integer numRel) {
        Integer countInsert;
        List<User> myUser = [SELECT Id FROM User WHERE IsActive = true LIMIT: numRel];   
        //Account recordtype Id 
        Id accountRecordType = [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName = 'ACC_Account' LIMIT 1].Id;
        
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        
        List<User> users = [SELECT Id FROM User WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false
                            AND profile.Id =:p2.Id LIMIT 100];
        
        
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
        bypassValidation.BackupSample__c = users[3].Id;
        
        update bypassValidation;       
        
        system.runas(users[4]){ 
            //Create Account
            Account acc1 = new Account();
            acc1.Name = 'test1fkjf';
            acc1.BillingCountry = 'United States';
            acc1.BillingCity = 'New York';
            acc1.SegmentL1__c = 'Abrasive';
            acc1.Type = 'Head Office';
            Database.insert(acc1, true);
            
            //Insert 'Division Account Relationship'        
            List<Relationship__c> relat = new List<Relationship__c>();
            
            for(user userlist: myuser) {
                Relationship__c relation = new Relationship__c();
                relation.AccountName__c = acc1.Id;
                relation.AccountManager__c = userlist.id;
                relation.Divisions__c = 'Ceramics';
                relation.SubType__c = 'Consultant';
                relation.BusinessArea__c = 'RAC';
                //relation.SegmentL2__c = 'Automotive';
                relat.add(relation);
            }
            //insert relat;
            //Create 'AccountTeamMember'   
            test.startTest();
            Database.insert(relat,true);//insert
            test.stopTest();
            
            countInsert = [SELECT COUNT()FROM AccountTeamMember 
                           WHERE AccountId =: acc1.Id];
            //System.assertEquals(countInsert, 1);
        }           
    }   
    /**
*@author Geerutsing Govind Kumar
*@Date Draft Creation 6/7/2017
*@Date modification 18/7/2017
*@param numRel Integer type
*@ExcptionName DMLException e on insert
*@return
*/          
    public static void testupdateAccountTeam() {
        Integer count;
        Set<String> oldAccount = New Set<String>();
        Set<String> oldRole = New Set<String>();
        List<User> myUser = [SELECT Id FROM User WHERE IsActive = true LIMIT 10];
        
        List<User> users = [SELECT Id FROM User WHERE IsActive = true AND ByPassTriggerRule__c = false LIMIT 100];
        
        
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
        bypassValidation.BackupSample__c = users[6].Id;
        bypassValidation.CountryforGatekeeper__c = 'Albania';
        //update bypassValidation;       
        
        users[6].ByPassValidationRule__c =true;
        update users[6];
        
        system.runas(users[6]){ 
            //Account recordtype Id 
            Id accountRecordType = [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName = 'ACC_Account' LIMIT 1].Id;
            
            //Create Account
            
            //Create Account
            Account acc2 = new Account();
            acc2.Name = 'alishazzg';
            acc2.BillingCountry = 'United States';
            acc2.BillingCity = 'New York';
            acc2.SegmentL1__c = 'Abrasive';
            acc2.Type = 'Head Office';
            Database.insert(acc2, true);
            
            Account acc5 = new Account();
            acc5.Name = 'alishazfgfgfgzg';
            acc5.BillingCountry = 'United States';
            acc5.BillingCity = 'New York';
            acc5.SegmentL1__c = 'Abrasive';
            acc5.Type = 'Head Office';
            Database.insert(acc5, true);
            
            Contact con = new Contact();
            con.Salutation = 'Mr.';
            con.FirstName = 'Shia';
            con.LastName= 'ALISHA';
            con.Email = 'test@accenture.com';
            con.AccountId = acc2.Id;
            Database.insert(con, true);
            
            AccountContactRelation acr = new AccountContactRelation(); 
            acr.Accountid = acc5.id;
            acr.Contactid = con.id;
            upsert acr;
            
            update acr;
            
            //Create Division
            
            //Insert 'Division Account Relationship'        
            List<Relationship__c> relat = new List<Relationship__c>();
            
            //for(Division__c DivToInsert: divList) {
            Relationship__c relation = new Relationship__c();
            relation.AccountName__c = acc2.Id;
            relation.AccountManager__c = myUser[4].Id;
            relation.AccountManager2__c = myUser[2].Id;
            relation.AccountManager3__c = myUser[3].Id;
            relation.Divisions__c = 'Ceramics';
            relation.BusinessArea__c = 'RAC';
            //relation.SegmentL2__c = 'Automotive';
            relation.SubType__c = 'Consultant';
            relat.add(relation);
            
            Database.insert(relat,true);
            
            Relationship__c rel  = [SELECT Id, AccountName__c, AccountManager__c FROM Relationship__c 
                                    WHERE AccountName__c =:acc2.Id AND AccountManager__c =:myuser[4].Id];
            rel.AccountManager__c = myuser[5].Id;
            update rel;
            
            Test.StartTest();
            Database.update(rel,true);
            Test.StopTest();
            
            ContactShare a2=[SELECT Id, UserOrGroupId, ContactAccessLevel, 
                             RowCause FROM ContactShare                                   
                             WHERE UserOrGroupId =: relation.AccountManager2__c
                             AND ContactId =: con.Id LIMIT 1];
            
            System.assert(a2!=null);
            
            count = [SELECT COUNT()FROM AccountTeamMember
                     WHERE accountId =:acc2.Id AND UserId =:myuser[1].Id AND TeamMemberRole= 'Account Manager'];
            System.assertEquals(count, 0);    
        }           
    } 
    /**
*@author Geerutsing Govind Kumar
*@Date Draft Creation 6/7/2017
*@Date modification 18/7/2017
*@param 
*@ExcptionName DMLException e on insert
*@return
*/    
    public static void testdeleteAccountTeam() {
        Integer countInsert;
        Integer countDelete;
        Set<String> oldAccount = New Set<String>();
        Set<String> oldRole = New Set<String>();
        List<User> myUser = [SELECT Id FROM User WHERE IsActive = true LIMIT 10];
        List<User> users = [SELECT Id FROM User WHERE IsActive = true AND ByPassTriggerRule__c = false LIMIT 100];
        
        
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
        bypassValidation.BackupSample__c = users[3].Id;
        bypassValidation.CountryforGatekeeper__c = 'Albania';
        //update bypassValidation;       
        
        users[4].ByPassValidationRule__c = true;
        update users;
        system.runas(users[4]){ 
            //Account recordtype Id 
            Id accountRecordType = [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName = 'ACC_Account' LIMIT 1].Id;
            
            //Create Account
            
            //Create Account
            Account acc2 = new Account();
            acc2.Name = 'Gina';
            acc2.BillingCountry = 'United States';
            acc2.BillingCity = 'New York';
            acc2.SegmentL1__c = 'Abrasive';
            acc2.Type = 'Head Office';
            Database.insert(acc2, true);
            
            //Insert 'Division Account Relationship'        
            List<Relationship__c> relat = new List<Relationship__c>();
            
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
            
            //for(Division__c DivToInsert: divList) {
            Relationship__c relation = new Relationship__c();
            relation.AccountName__c = acc2.Id;
            relation.AccountManager__c = myUser[1].Id;
            relation.MarketSegmentation__c = markSeg.Id;
            relation.Divisions__c = 'Ceramics';
            relation.BusinessArea__c = 'RAC';
            //relation.SegmentL2__c = 'Automotive';
            relation.SubType__c = 'Consultant';
            relat.add(relation);
            
            Database.insert(relat,true);
            
            countInsert = [SELECT COUNT()FROM AccountTeamMember
                           WHERE accountId =:acc2.Id AND UserId =:myuser[1].Id AND TeamMemberRole= 'Account Manager'];
            //System.assertEquals(countInsert, 1);   
            
            Relationship__c delRel  = [SELECT Id, AccountName__c, AccountManager__c FROM Relationship__c 
                                       WHERE AccountName__c =:acc2.Id AND AccountManager__c =:myuser[1].Id];   
            
            Test.startTest();
            Database.delete(delRel, true);
            Test.stopTest();  
            
            countDelete = [SELECT COUNT()FROM AccountTeamMember
                           WHERE accountId =:acc2.Id AND UserId =:myuser[1].Id AND TeamMemberRole= 'Account Manager'];
            System.assertEquals(countDelete, 0);  
        }           
    } 
    
    /**
*@author Geerutsing Govind Kumar
*@Date Draft Creation 29/8/2017
*@Date modification 29/8/2017
*@param numRel Integer type
*@ExcptionName DMLException e on insert
*@return 
*/  
    public static void testcreateAccountManager(Integer numRel){
        Integer countInsert;
        List<User> myUser = [SELECT Id FROM User WHERE IsActive = true LIMIT: numRel];   
        //Account recordtype Id 
        // Id accountRecordType = [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName = 'Account' LIMIT 1].Id;
        
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        
        
        List<User> users = [SELECT Id FROM User WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false
                            AND profile.Id =:p2.Id  LIMIT 100];
        
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
        bypassValidation.BackupSample__c = users[3].Id;
        bypassValidation.CountryforGatekeeper__c = 'Albania';
        update bypassValidation;   
        
        users[4].ByPassValidationRule__c =true;
        
        
        system.runas(users[4]){ 
            //Create Account
            Account acc = new Account();
            acc.Name = 'Gina';
            acc.BillingCountry = 'United States';
            acc.BillingCity = 'New York';
            acc.SegmentL1__c = 'Abrasive';
            acc.Type = 'Head Office';
            Database.insert(acc, true);
            
            
            Contact con = new Contact();
            con.Salutation = 'Mr.';
            con.FirstName = 'Shia';
            con.LastName= 'ALISHA';
            con.Email = 'test@accenture.com';
            con.AccountId = acc.Id;
            Database.insert(con, true);
            
            
            //Insert 'Division Account Relationship'        
            List<Relationship__c> relat = new List<Relationship__c>();
            
            for(user userlist: myuser) {
                Relationship__c relation = new Relationship__c();
                relation.AccountName__c = acc.Id;
                relation.KeyAccountManager__c = userlist.id;
                relation.Divisions__c = 'Ceramics';
                relation.BusinessArea__c = 'RAC';
                //relation.SegmentL2__c = 'Automotive';
                relation.SubType__c = 'Consultant';
                relat.add(relation);
            }
            //insert relat;
            //Create 'AccountTeamMember'   
            test.startTest();
            Database.insert(relat,true);//insert
            test.stopTest();
            
            countInsert = [SELECT COUNT()FROM AccountTeamMember 
                           WHERE TeamMemberRole='Key Account Manager'];
            //System.assertEquals(countInsert, 1); 
        }   
    }   
    /**
*@author Geerutsing Govind Kumar
*@Date Draft Creation 29/8/2017
*@Date modification 29/8/2017
*@param
*@ExcptionName 
*@return
*/          
    public static void testupdateAccountManager() {
        Integer count;
        Set<String> oldAccount = New Set<String>();
        Set<String> oldRole = New Set<String>();
        List<User> myUser = [SELECT Id FROM User WHERE IsActive = true LIMIT 10];
        
        //Account recordtype Id 
        // Id accountRecordType = [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName = 'Account' LIMIT 1].Id;
        List<User> users = [SELECT Id FROM User WHERE IsActive = true AND ByPassTriggerRule__c = false and profile.Name ='System Administrator' LIMIT 100];
        
        
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
        bypassValidation.BackupSample__c = users[3].Id;
        bypassValidation.CountryforGatekeeper__c = 'Albania';
        //update bypassValidation;  
        
        
        users[4].ByPassValidationRule__c = true;
        update users[4];     
        
        system.runas(users[4]){ 
            //Create Account
            
            //Create Account
            Account acc4 = new Account();
            acc4.Name = 'Alisha';
            acc4.BillingCountry = 'United States';
            acc4.BillingCity = 'New York';
            acc4.SegmentL1__c = 'Abrasive';
            acc4.Type = 'Head Office';
            Database.insert(acc4, true);
            //Insert 'Division Account Relationship'        
            
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
            
            Contact con = new Contact();
            con.Salutation = 'Mr.';
            con.FirstName = 'Shia';
            con.LastName= 'ALISHA';
            con.Email = 'test@accenture.com';
            con.AccountId = acc4.Id;
            Database.insert(con, true);
            
            Account acc5 = new Account();
            acc5.Name = 'alishasfzzg';
            acc5.BillingCountry = 'United States';
            acc5.BillingCity = 'New York';
            acc5.SegmentL1__c = 'Abrasive';
            acc5.Type = 'Head Office';
            Database.insert(acc5, true);
            
            AccountContactRelation acr = new AccountContactRelation(); 
            acr.Accountid = acc5.id;
            acr.Contactid = con.id;
            insert acr;
            
            List<Relationship__c> relat = new List<Relationship__c>();
            
            //for(Division__c DivToInsert: divList) {
            Relationship__c relation = new Relationship__c();
            relation.AccountName__c = acc4.Id;
            relation.KeyAccountManager__c= myUser[1].Id;
            relation.Divisions__c = 'Ceramics';
            relation.MarketSegmentation__c = markSeg.Id;
            relation.BusinessArea__c = 'RAC';
            // relation.SegmentL2__c = 'Automotive';
            relation.SubType__c = 'Consultant';
            relat.add(relation);
            
            Database.insert(relat,true);
            
            Relationship__c rel  = [SELECT Id, AccountName__c, KeyAccountManager__c FROM Relationship__c 
                                    WHERE AccountName__c =:acc4.Id AND KeyAccountManager__c =:myuser[1].Id];
            rel.KeyAccountManager__c = myuser[2].Id;
            update rel;
            
            Test.StartTest();
            Database.update(rel,true);
            Test.StopTest();
            
            count = [SELECT COUNT()FROM AccountTeamMember
                     WHERE accountId =:acc4.Id AND UserId =:myuser[1].Id AND TeamMemberRole= 'Key Account Manager'];
            System.assertEquals(count, 0); 
        }           
    } 
    /**
*@author Geerutsing Govind Kumar
*@Date Draft Creation 29/8/2017
*@Date modification 29/8/2017
*@param 
*@ExcptionName 
*@return
*/    
    public static void testdeleteAccountManager() {
        Integer countInsert;
        Integer countDelete;
        Set<String> oldAccount = New Set<String>();
        Set<String> oldRole = New Set<String>();
        List<User> myUser = [SELECT Id FROM User WHERE IsActive = true LIMIT 10];
        
        List<User> users = [SELECT Id FROM User WHERE IsActive = true AND ByPassTriggerRule__c = false LIMIT 100];
        
        
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
        bypassValidation.BackupSample__c = users[3].Id;
        bypassValidation.CountryforGatekeeper__c = 'Albania';
        //update bypassValidation;
        
        users[4].ByPassValidationRule__c = true;
        update users[4];          
        
        system.runas(users[4]){ 
            //Account recordtype Id 
            // Id accountRecordType = [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName = 'Account' LIMIT 1].Id;
            
            //Create Account
            Account acc3 = new Account();
            acc3.Name = 'Watson';
            acc3.BillingCountry = 'United States';
            acc3.BillingCity = 'New York';
            acc3.SegmentL1__c = 'Abrasive';
            acc3.Type = 'Head Office';
            Database.insert(acc3, true);
            
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
            
            //Insert 'Division Account Relationship'        
            List<Relationship__c> relat = new List<Relationship__c>();
            
            //for(Division__c DivToInsert: divList) {
            Relationship__c relation = new Relationship__c();
            relation.AccountName__c = acc3.Id;
            relation.KeyAccountManager__c = myUser[1].Id;
            relation.Divisions__c = 'Ceramics';
            relation.BusinessArea__c = 'RAC';
            relation.MarketSegmentation__c = markSeg.Id;
            //relation.SegmentL2__c = 'Automotive';
            relation.SubType__c = 'Consultant';
            relat.add(relation);
            
            Database.insert(relat,true);
            
            countInsert = [SELECT COUNT()FROM AccountTeamMember
                           WHERE accountId =:acc3.Id AND UserId =:myuser[1].Id AND TeamMemberRole= 'Key Account Manager'];
            //System.assertEquals(countInsert, 1);   
            
            Relationship__c delRel  = [SELECT Id, AccountName__c, KeyAccountManager__c FROM Relationship__c 
                                       WHERE AccountName__c =:acc3.Id AND KeyAccountManager__c =:myuser[1].Id];   
            
            Test.startTest();
            Database.delete(delRel, true);
            Test.stopTest();  
            
            countDelete = [SELECT COUNT()FROM AccountTeamMember
                           WHERE accountId =:acc3.Id AND UserId =:myuser[1].Id AND TeamMemberRole= 'Key Account Manager'];
            System.assertEquals(countDelete, 0); 
        }           
    }          
    
    /**
*@author Geerutsing Govind Kumar
*@Date Draft Creation 17/7/2017
*@Date modification 15/9/2017
*@param 
*@ExcptionName
*@return 
*/          
    public static void testCreateInternalAttendees(){
        
        // Select users for the test.
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        
        List<User> users = [SELECT Id, ByPassProcessBuilders__c, Email, MultiPicklistDivision__c,Division, FederationIdentifier FROM User WHERE IsActive = true 
                            AND profile.Id=: p2.Id
                            AND ByPassTriggerRule__c = false LIMIT 5];
        
        Id User1Id = users[0].Id;
        Id User2Id = users[1].Id;
        Id User3Id = users[2].Id;
        
        if(users[0].Division == null){
            users[0].Division = 'None';
        }
        if(users[0].MultiPicklistDivision__c == null){
            users[0].MultiPicklistDivision__c = 'Ceramics';
        }
        string email = users[0].Email;
        users[0].ByPassProcessBuilders__c = true;
        users[0].ByPassValidationRule__c =true;
        
        update users[0];
        
        if(users[1].Division == null){
            users[1].Division = 'None';
        }
        if(users[1].MultiPicklistDivision__c == null){
            users[1].MultiPicklistDivision__c = 'Ceramics';
        }
        users[1].ByPassProcessBuilders__c = true; 
        users[1].ByPassValidationRule__c = true;        
        update users[1];
        
        
        system.runas(users[0]){ 
            Account acc1 = new Account();
            acc1.Name = 'TestDev1';
            acc1.BillingCountry = 'United States';
            acc1.BillingCity = 'New York';
            acc1.SegmentL1__c = 'Abrasive';
            acc1.Type = 'Head Office';
            Database.insert(acc1, true);    
            
            Contact con = new Contact();
            con.Salutation = 'Mr.';
            con.FirstName = 'TestDev1';
            con.LastName= 'SMITH';
            con.Email = 'test@accenture.com.com';
            con.AccountId = acc1.Id;
            //con.Division__c = div.Id;
            Database.insert(con, true);
            date mydate = date.parse('05/11/2012'); 
            
            // Create new visit Report.
            VisitReport__c visit = new VisitReport__c();
            visit.Account__c = acc1.Id;
            //visit.contact__c =  con.Id;
            visit.Type__c = 'Email';
            visit.BusinessArea__c = 'RAC';
            visit.Dateofvisit__c = mydate;
            visit.MainObjectivesofthemeeting__c = 'Courtesy';
            // visit.SegmentL2__c = 'Ceramics';
            visit.OwnerId = user1Id;
            Visit.Division__c = 'Ceramics';
            Database.insert(visit, true); 
            
            User_Visit_Report_Relationship__c internalList = new User_Visit_Report_Relationship__c(); 
            internalList.VisitReportName__c = visit.Id;
            internalList.InternalAttendeeName__c = user2Id; 
            Test.startTest();
            Database.insert(internalList,true);  
            Test.stopTest();
            
            // Insert manual share for user who is not record owner. 
            // Query visit report records.
            List<VisitReport__Share> visitShrs = [SELECT Id, UserOrGroupId, AccessLevel, 
                                                  RowCause FROM VisitReport__share WHERE ParentId = :visit.Id AND UserOrGroupId= :user2Id];
            
            // Test attributes of manual share.
            if(visitShrs.size() > 0) {
                System.assertEquals(visitShrs[0].AccessLevel, 'Edit');
                System.assertEquals(visitShrs[0].UserOrGroupId, user2Id);
            }  
            
        }
        system.runas(users[1]){ 
            Account acc2 = new Account();
            acc2.Name = 'test1';
            acc2.BillingCountry = 'United States';
            acc2.BillingCity = 'New york';
            acc2.SegmentL1__c = 'Abrasive';
            acc2.Type = 'Head Office';
            Database.insert(acc2, true);    
            
            Contact con2 = new Contact();
            con2.Salutation = 'Mr.';
            con2.FirstName = 'Tom';
            con2.Email = 'test@accenture.com.com';
            con2.LastName= 'SMITH';
            con2.AccountId = acc2.Id;
            //con.Division__c = div.Id;
            Database.insert(con2, true);
            date mydate = date.parse('05/11/2012'); 
            
            // Create new visit Report.
            VisitReport__c visit2 = new VisitReport__c();
            visit2.Account__c = acc2.Id;
            //visit.contact__c =  con.Id;
            visit2.Type__c = 'Email';
            visit2.BusinessArea__c = 'RAC';
            visit2.Dateofvisit__c = mydate;
            visit2.MainObjectivesofthemeeting__c = 'Courtesy';
            // visit2.SegmentL2__c = 'Ceramics';
            visit2.OwnerId = user2Id;
            visit2.Division__c = 'Ceramics';
            Database.insert(visit2, true); 
            
            User_Visit_Report_Relationship__c internalList2 = new User_Visit_Report_Relationship__c(); 
            internalList2.VisitReportName__c = visit2.Id;
            internalList2.InternalAttendeeName__c = user2Id; 
            
            try{            
                Database.insert(internalList2,true);         
            }
            catch(Exception e)
            {
                Boolean expectedExceptionThrown =  e.getMessage().contains(Label.CL00003);
                System.AssertEquals(expectedExceptionThrown, true);
            }
        }      
    }
    /**
*@author Geerutsing Govind Kumar
*@Date Draft Creation 17/7/2017
*@Date modification 15/9/2017
*@param 
*@ExcptionName
*@return 
*/          
    public static void testUpdateInternalAttendees(){
        // Select users for the test.
        String visitreportName;
        String internalAttendName;
        
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c, Email, ByPassProcessBuilders__c, MultiPicklistDivision__c,Division, FederationIdentifier
                            FROM User 
                            WHERE profile.Id=:p2.Id
                            AND ByPassTriggerRule__c = false
                            AND IsActive = true LIMIT 5];
        
        Id User1Id = users[3].Id;
        Id User2Id = users[4].Id; 
        Id User3Id = users[0].Id;
        
        if(users[1].Division == null){
            users[1].Division = 'None';
        }
        if(users[1].MultiPicklistDivision__c == null){
            users[1].MultiPicklistDivision__c = 'Ceramics';
        }
        string email = users[1].Email;
        users[1].ByPassProcessBuilders__c = true;
        users[1].ByPassValidationRule__c =true;
        
        update users[1];
        
        if(users[3].Division == null){
            users[3].Division = 'None';
        }
        if(users[3].MultiPicklistDivision__c == null){
            users[3].MultiPicklistDivision__c = 'Ceramics';
        }
        
        users[3].ByPassProcessBuilders__c = true;
        users[3].ByPassValidationRule__c = true;
        
        update users[3];
        
        system.runas(users[3]){ 
            Account acc1 = new Account();
            acc1.Name = 'TestDev1';
            acc1.BillingCountry = 'United States';
            acc1.BillingCity = 'New york';
            acc1.SegmentL1__c = 'Abrasive';
            acc1.Type = 'Head Office';
            Database.insert(acc1, true);    
            
            Contact con = new Contact();
            con.Salutation = 'Mr.';
            con.FirstName = 'TestDev1';
            con.LastName= 'SMITH';
            con.Email = 'test@accenture.com.com';
            con.AccountId = acc1.Id;
            //con.Division__c = div.Id;
            Database.insert(con, true);
            date mydate = date.parse('05/11/2012'); 
            
            // Create new visit Report.
            VisitReport__c visit = new VisitReport__c();
            visit.Account__c = acc1.Id;
            //visit.contact__c =  con.Id;
            visit.Type__c = 'Email';
            visit.Dateofvisit__c = mydate;
            visit.MainObjectivesofthemeeting__c = 'Courtesy';
            //visit.SegmentL2__c = 'Ceramics';
            visit.OwnerId = user1Id;
            visit.BusinessArea__c = 'RAC';
            visit.Division__c = 'Ceramics';
            Database.insert(visit, true); 
            
            User_Visit_Report_Relationship__c internalList = new User_Visit_Report_Relationship__c(); 
            internalList.VisitReportName__c = visit.Id;
            internalList.InternalAttendeeName__c = user2Id; 
            Test.startTest();
            Database.insert(internalList,true);  
            Test.stopTest();
            
            // Insert manual share for user who is not record owner. 
            // Query visit report records.
            List<VisitReport__Share> visitShrs = [SELECT Id, UserOrGroupId, AccessLevel, 
                                                  RowCause FROM VisitReport__share 
                                                  WHERE ParentId = :visit.Id AND UserOrGroupId= :user2Id];
            
            // Test attributes of manual share.
            if(visitShrs.size() > 0) {
                System.assertEquals(visitShrs[0].AccessLevel, 'Edit');
                System.assertEquals(visitShrs[0].UserOrGroupId, user2Id);
            }
            
            List<User_Visit_Report_Relationship__c> internalAttendList = [SELECT VisitReportName__c
                                                                          FROM User_Visit_Report_Relationship__c 
                                                                          WHERE VisitReportName__c = :visit.Id AND InternalAttendeeName__c =:user2Id];
            
            List<User_Visit_Report_Relationship__c> userVisitReport = New List<User_Visit_Report_Relationship__c>(); 
            
            for(User_Visit_Report_Relationship__c uv:internalAttendList ){    
                uv.InternalAttendeeName__c = user2Id;
                userVisitReport.add(uv);
            }           
            try{
                Database.update(userVisitReport, true);
            }
            catch(Exception e)
            {
                Boolean expectedExceptionThrown =  e.getMessage().contains(Label.CL00003);
                System.AssertEquals(expectedExceptionThrown, false);
            }
        }
        system.runas(users[1]){ 
            Account acc2 = new Account();
            acc2.Name = 'test1';
            acc2.BillingCountry = 'United States';
            acc2.BillingCity = 'New York';
            acc2.SegmentL1__c = 'Abrasive';
            acc2.Type = 'Head Office';
            Database.insert(acc2, true);    
            
            Contact con2 = new Contact();
            con2.Salutation = 'Mr.';
            con2.FirstName = 'Tom';
            con2.Email = 'test@accenture.com.com';
            con2.LastName= 'SMITH';
            con2.AccountId = acc2.Id;
            //con.Division__c = div.Id;
            Database.insert(con2, true);
            date mydate = date.parse('05/11/2012'); 
            
            // Create new visit Report.
            VisitReport__c visit2 = new VisitReport__c();
            visit2.Account__c = acc2.Id;
            //visit.contact__c =  con.Id;
            visit2.Type__c = 'Email';
            visit2.Dateofvisit__c = mydate;
            visit2.MainObjectivesofthemeeting__c = 'Courtesy';
            //visit2.SegmentL2__c = 'Ceramics';
            visit2.OwnerId = user1Id;
            visit2.BusinessArea__c = 'RAC';
            visit2.Division__c = 'Ceramics';
            Database.insert(visit2, true); 
            
            User_Visit_Report_Relationship__c internalList2 = new User_Visit_Report_Relationship__c(); 
            internalList2.VisitReportName__c = visit2.Id;
            internalList2.InternalAttendeeName__c = user2Id; 
            visitreportName = visit2.Id;
            internalAttendName = user2Id; 
            
            try{            
                Database.insert(internalList2,true);         
            }
            catch(Exception e)
            {
                Boolean expectedExceptionThrown =  e.getMessage().contains(Label.CL00003);
                System.AssertEquals(expectedExceptionThrown, false);
            }
        }
        
        system.runas(users[3]){
            List<User_Visit_Report_Relationship__c> internalAttendList = [SELECT VisitReportName__c
                                                                          FROM User_Visit_Report_Relationship__c 
                                                                          WHERE VisitReportName__c = :visitreportName AND InternalAttendeeName__c =:internalattendName];
            
            List<User_Visit_Report_Relationship__c> userVisitReport = New List<User_Visit_Report_Relationship__c>(); 
            
            for(User_Visit_Report_Relationship__c uv:internalAttendList ){    
                uv.InternalAttendeeName__c = user2Id;
                userVisitReport.add(uv);
            }
            
            try{
                Database.update(userVisitReport, true);
            }
            catch(Exception e)
            {
                Boolean expectedExceptionThrown =  e.getMessage().contains(Label.CL00003);
                System.AssertEquals(expectedExceptionThrown, true);
            }
        }       
    }
    /**
*@author Geerutsing Govind Kumar
*@Date Draft Creation 17/7/2017
*@Date modification 15/9/2017
*@param 
*@ExcptionName
*@return 
*/        
    public static void testDeleteInternalAttendees(){
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        // Select users for the test.
        Integer visitCount;
        Integer visitCount2;
        String internalAttendId;
        
        List<User> users = [SELECT Id,ByPassProcessBuilders__c,Division,MultiPicklistDivision__c,Email,
                            FederationIdentifier,ByPassTriggerRule__c,CountryforGatekeeper__c FROM User 
                            WHERE IsActive = true
                            AND ByPassTriggerRule__c = false
                            AND Profile.Id =: p2.Id
                            LIMIT 5];
        
        Id User1Id = users[0].Id;
        Id User2Id = users[1].Id;
        Id User3Id = users[2].Id;
        Id User4Id = users[3].Id;
        
        if(users[0].Division == null){
            users[0].Division = 'None';
        }
        if(users[0].MultiPicklistDivision__c == null){
            users[0].MultiPicklistDivision__c = 'Ceramics';
        }
        string email = users[0].Email;
        users[0].ByPassProcessBuilders__c = true;
        users[0].CountryforGatekeeper__c = 'France';
        users[0].ByPassValidationRule__c = true;
        
        update users[0];
        
        if(users[1].Division == null){
            users[1].Division = 'None';
        }
        if(users[1].MultiPicklistDivision__c == null){
            users[1].MultiPicklistDivision__c = 'Ceramics';
        }
        users[1].ByPassProcessBuilders__c = true;
        users[1].ByPassValidationRule__c = true;
        
        update users[1];
        
        
        system.runas(users[0]){ 
            Account acc1 = new Account();
            acc1.Name = 'testDev4';
            acc1.BillingCountry = 'United States';
            acc1.BillingCity = 'New York';
            acc1.SegmentL1__c = 'Abrasive';
            acc1.Type = 'Head Office';
            Database.insert(acc1, true);    
            
            Contact con = new Contact();
            con.Salutation = 'Mr.';
            con.FirstName = 'testDev4';
            con.Email = 'test@accenture.com.com';
            con.LastName= 'SMITH';
            con.AccountId = acc1.Id;
            //con.Division__c = div.Id;
            Database.insert(con, true);
            date mydate = date.parse('05/11/2012'); 
            
            // Create new visit Report.
            VisitReport__c visit = new VisitReport__c();
            visit.Account__c = acc1.Id;
            //visit.contact__c =  con.Id;
            visit.Type__c = 'Email';
            visit.Dateofvisit__c = mydate;
            visit.MainObjectivesofthemeeting__c = 'Courtesy';
            //visit.SegmentL2__c = 'Ceramics';
            visit.OwnerId = user1Id;
            visit.Division__c = 'Ceramics';
            visit.BusinessArea__c = 'RAC';
            
            Database.insert(visit, true); 
            
            User_Visit_Report_Relationship__c internalList = new User_Visit_Report_Relationship__c(); 
            internalList.VisitReportName__c = visit.Id;
            internalList.InternalAttendeeName__c = user2Id;     
            Database.insert(internalList,true);       
            
            // Insert manual share for user who is not record owner.
            // Query visit report records.
            List<VisitReport__Share> visitShare = [SELECT Id, UserOrGroupId, AccessLevel, 
                                                   RowCause FROM VisitReport__share WHERE ParentId = :visit.Id AND UserOrGroupId= :user2Id];
            
            // Test attributes of manual share.
            if(visitShare.size() > 0) {
                System.assertEquals(visitShare[0].AccessLevel, 'Edit');
                System.assertEquals(visitShare[0].UserOrGroupId, user2Id);
            }        
            User_Visit_Report_Relationship__c internalattend = [SELECT Id FROM  User_Visit_Report_Relationship__c  WHERE Id = :internalList.Id ALL ROWS];   
            
            Test.startTest();
            Database.delete(internalattend, true);
            Test.stopTest();      
            // Query visit report records.
            
            visitCount = [SELECT COUNT() 
                          FROM VisitReport__share WHERE ParentId = :visit.Id AND UserOrGroupId= :user2Id];
            
            //Test attributes of manual share.
            System.assertEquals(visitCount, 0);
        }
        system.runas(users[1]){ 
            Account acc2 = new Account();
            acc2.Name = 'testDev5';
            acc2.BillingCountry = 'China';
            acc2.BillingCity = 'New York';
            acc2.SegmentL1__c = 'Abrasive';
            acc2.Type = 'Head Office';
            Database.insert(acc2, true);    
            
            Contact con2 = new Contact();
            con2.Salutation = 'Mr.';
            con2.FirstName = 'TestDev5';
            con2.LastName= 'SMITH';
            con2.Email = 'test@accenture.com.com';
            con2.AccountId = acc2.Id;
            //con.Division__c = div.Id;
            Database.insert(con2, true);
            date mydate = date.parse('05/11/2012'); 
            
            // Create new visit Report.
            VisitReport__c visit2 = new VisitReport__c();
            visit2.Account__c = acc2.Id;
            //visit.contact__c =  con.Id;
            visit2.Type__c = 'Email';
            visit2.Dateofvisit__c = mydate;
            visit2.MainObjectivesofthemeeting__c = 'Courtesy';
            //visit2.SegmentL2__c = 'Ceramics';
            visit2.OwnerId = user2Id;
            visit2.BusinessArea__c = 'RAC';
            visit2.Division__c = 'Ceramics';
            Database.insert(visit2, true); 
            
            User_Visit_Report_Relationship__c internalList2 = new User_Visit_Report_Relationship__c(); 
            internalList2.VisitReportName__c = visit2.Id;
            internalList2.InternalAttendeeName__c = user1Id;   
            Database.insert(internalList2,true);   
            internalAttendId = internalList2.Id;
            
            // Insert manual share for user who is not record owner.
            // Query visit report records.
            List<VisitReport__Share> visitShare2 = [SELECT Id, UserOrGroupId, AccessLevel, 
                                                    RowCause FROM VisitReport__share WHERE ParentId = :visit2.Id AND UserOrGroupId= :user1Id];
            
            // Test attributes of manual share.
            if(visitShare2.size() > 0) {
                System.assertEquals(visitShare2[0].AccessLevel, 'Edit');
                System.assertEquals(visitShare2[0].UserOrGroupId, user1Id);
            } 
        }   
        User_Visit_Report_Relationship__c internalattend2 = [SELECT Id FROM  User_Visit_Report_Relationship__c  WHERE Id = :internalAttendId ALL ROWS];      
        
        system.runas(users[0]){ 
            try{
                Database.delete(internalattend2, true);
            }
            catch(Exception e)
            {
                Boolean expectedExceptionThrown =  e.getMessage().contains(Label.CL00002);
                System.AssertEquals(expectedExceptionThrown, true);
            } 
        }
    }  
    /**
*@author Geerutsing Govind Kumar
*@Date Draft Creation 25/7/2017
*@Date modification 14/9/2017
*@param 
*@ExcptionName
*@return 
*/          
    public static void testupdateVisitReport(){
        // Select users for the test.
        List<User> users = [SELECT Id FROM User WHERE IsActive = true AND ByPassTriggerRule__c = false LIMIT 100];
        Id User1Id = users[3].Id;
        Id User2Id = users[4].Id; 
        Id User3Id = users[0].Id; 
        
        users[3].ByPassValidationRule__c = true;
        users[0].ByPassValidationRule__c = true;
        update users[3];        
        
        system.runas(users[3]){ 
            Account acc1 = new Account();
            acc1.Name = 'sdsdasassd1';
            acc1.BillingCountry = 'United States';
            acc1.BillingCity = 'New York';
            acc1.SegmentL1__c = 'Abrasive';
            acc1.Type = 'Head Office';
            Database.insert(acc1, true);    
            
            Contact con = new Contact();
            con.Salutation = 'Mr.';
            con.FirstName = 'Tom';
            con.LastName= 'SMITH';
            con.AccountId = acc1.Id;
            con.Email = 'test@accenture.com.com';
            //con.Division__c = div.Id;
            Database.insert(con, true);
            date mydate = date.parse('05/11/2012');
            
            // Create new visit Report.
            
            VisitReport__c visit = new VisitReport__c();
            visit.Account__c = acc1.Id;
            // visit.contact__c =  con.Id;
            visit.Type__c = 'Email';
            visit.Dateofvisit__c = mydate;
            visit.MainObjectivesofthemeeting__c = 'Courtesy';
            // visit.SegmentL2__c = 'Ceramics';
            visit.OwnerId = User1Id;
            visit.BusinessArea__c = 'RAC';
            visit.Division__c = 'Ceramics';
            Database.insert(visit, true); 
            
            User_Visit_Report_Relationship__c internalList = new User_Visit_Report_Relationship__c(); 
            internalList.VisitReportName__c = visit.Id;
            internalList.InternalAttendeeName__c = user2Id;     
            Database.insert(internalList,true);       
            
            User_Visit_Report_Relationship__c internalattend = [SELECT Id, InternalAttendeeName__c FROM  User_Visit_Report_Relationship__c  
                                                                WHERE InternalAttendeeName__c = :internalList.InternalAttendeeName__c];   
            // check if internaluser is inserted                                                   
            System.assertEquals(internalattend.InternalAttendeeName__c, user2Id);
            
            VisitReport__c visit2 = [SELECT Id FROM VisitReport__c
                                     WHERE Id= :visit.Id];  
            visit2.SegmentL2__c = 'Ceramics';
            
            //Profile p = [select id from profile where name='Sales'];
            
            //UserRole ur = [select Id, ParentRoleId from UserRole WHERE Name = 'Calderys']; // check for top level role
            
            //User u = [SELECT Id FROM User WHERE UserRoleId = :ur.Id LIMIT 1];
            //User u = new User(alias = 'test123', email='test1234@noemail.com',
            // emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
            //localesidkey='en_US', profileid = p.Id, country='United States',
            //timezonesidkey='America/Los_Angeles', username='test1234@noemail.com', UserRoleId = ur.Id );
            
            system.runas(users[0]){                    
                try
                {   
                    Test.startTest();
                    Database.update(visit2,true);  // user update visit report
                    Test.stopTest(); 
                }
                catch(Exception e)
                {
                    Boolean expectedExceptionThrown =  e.getMessage().contains(Label.CL00001);
                    System.AssertEquals(expectedExceptionThrown, true);
                }
            }
        }
    }
    /**
*@author Geerutsing Govind Kumar
*@Date Draft Creation 25/7/2017
*@Date modification 14/9/2017
*@param 
*@ExcptionName
*@return 
*/      
    public static void testdeleteVisitReport(){
        // Select users for the test.
        List<User> users = [SELECT Id FROM User WHERE IsActive = true AND ByPassTriggerRule__c = false LIMIT 100];
        Id User1Id = users[3].Id;
        Id User2Id = users[4].Id; 
        Id User3Id = users[0].Id;
        String visitReport;
        
        users[3].ByPassValidationRule__c = true;
        update users[3];
        
        users[0].ByPassValidationRule__c =true;
        update users[0];
        
        system.runas(users[3]){ 
            Account acc1 = new Account();
            acc1.Name = 'sdsdasassd1dsdsdd';
            acc1.BillingCountry = 'United States';
            acc1.BillingCity = 'New York';
            acc1.SegmentL1__c = 'Abrasive';
            acc1.Type = 'Head Office';
            Database.insert(acc1, true);    
            
            Contact con = new Contact();
            con.Salutation = 'Mr.';
            con.FirstName = 'Shia';
            con.LastName= 'ALISHA';
            con.Email = 'test@accenture.com.com';
            con.AccountId = acc1.Id;
            //con.Division__c = div.Id;
            Database.insert(con, true);
            date mydate = date.parse('05/11/2012');
            
            // Create new visit Report.
            VisitReport__c visit = new VisitReport__c();
            visit.Account__c = acc1.Id;
            // visit.contact__c =  con.Id;
            visit.Type__c = 'Email';
            visit.Dateofvisit__c = mydate;
            visit.BusinessArea__c = 'RAC';
            visit.MainObjectivesofthemeeting__c = 'NPD';
            // visit.SegmentL2__c = 'Ceramics';
            visit.OwnerId = User1Id;
            visit.Division__c = 'Ceramics';
            Database.insert(visit, true); 
            
            User_Visit_Report_Relationship__c internalList = new User_Visit_Report_Relationship__c(); 
            internalList.VisitReportName__c = visit.Id;
            internalList.InternalAttendeeName__c = user2Id;     
            Database.insert(internalList,true);       
            
            User_Visit_Report_Relationship__c internalattend = [SELECT Id, InternalAttendeeName__c FROM  User_Visit_Report_Relationship__c  
                                                                WHERE InternalAttendeeName__c = :internalList.InternalAttendeeName__c];   
            // check if internaluser is inserted                                                   
            System.assertEquals(internalattend.InternalAttendeeName__c, user2Id);
            visitReport = visit.Id; 
        }
        VisitReport__c visit3 = [SELECT Id FROM VisitReport__c
                                 WHERE Id= :VisitReport];  
        //visit2.SegmentL2__c = 'value 2';
        
        // Profile p = [select id from profile where name='Sales'];
        
        //UserRole ur = [select Id, ParentRoleId from UserRole WHERE Name = 'Calderys']; // check for top level role
        
        // User u = [SELECT Id FROM User WHERE UserRoleId = :ur.Id LIMIT 1];
        //User u = new User(alias = 'test123', email='test1234@noemail.com',
        // emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
        //localesidkey='en_US', profileid = p.Id, country='United States',
        //timezonesidkey='America/Los_Angeles', username='test1234@noemail.com', UserRoleId = ur.Id );
        //If(u !=null){
        system.runas(users[0]){
            try
            {
                Test.startTest();
                Database.delete(visit3,true);  // user delete visit report
                Test.stopTest();
            }
            catch(Exception e)
            {
                Boolean expectedExceptionThrown =  e.getMessage().contains(Label.CL00002);
                System.AssertEquals(expectedExceptionThrown, true);
            }
        }   
    }
    /**
*@author Geerutsing Govind Kumar
*@Date Draft Creation 10/12/2017
*@Date modification 10/16/2017
*@param 
*@ExcptionName
*@return 
*/      
    public static void testCreateSampleGatekeeper(){
        // Select users for the test.
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
            
            
            

            /**

Sample__c sam3 = New Sample__c();
sam3.CSAccountManager__c = acc1.Id;
sam3.RecordTypeId = recordTypeName;
sam3.RecipientName__c = con.Id;
sam3.Status__c = 'Draft Creation';
sam3.Divisions__c ='Ceramics';
sam3.Type__c = 'Lab';
sam3.CSAccountManager__c = User3Id;
sam3.ExpectedDeliveryDate__c = mydate2;
sam3.ProductName__c = p2.Id;
sam3.Volume__c = 1233;
sam3.OwnerId = User1Id;
sam3.BusinessArea__c ='RAC';
sam3.Unit__c = 'Metric tons (as sold)';
sam3.GateKeeper__c = user1Id;
sam3.outOfOffice__c = true;
sam3.DateOfFeedback__c = mydate1;
sam3.DispatchSite__c ='FR - Iko';

insert sam3;

Sample__c sam4 = New Sample__c();
sam4.CSAccountManager__c = acc1.Id;
sam4.RecordTypeId = recordTypeName;
sam4.RecipientName__c = con.Id;
sam4.Status__c = 'Draft Creation';
sam4.Type__c = 'Lab';
sam4.CSAccountManager__c = User3Id;
sam4.ExpectedDeliveryDate__c = mydate2;
sam4.ProductName__c = p3.Id;
sam4.Volume__c = 1233;
sam4.OwnerId = User1Id;
sam4.Unit__c = 'Metric tons (as sold)';
sam4.BusinessArea__c ='RAC';
sam4.GateKeeper__c = null;
sam4.outOfOffice__c = true;
sam4.DateOfFeedback__c = mydate1;
sam4.DispatchSite__c ='FR - Iko';

Sample__c sam5 = New Sample__c();
sam5.CSAccountManager__c = acc1.Id;
sam5.RecordTypeId = recordTypeName;
sam5.RecipientName__c = con.Id;
sam5.Status__c = 'Draft Creation';
sam5.Type__c = 'Lab';
sam5.CSAccountManager__c = User3Id;
sam5.ExpectedDeliveryDate__c = mydate2;
sam5.ProductName__c = p3.Id;
sam5.BusinessArea__c ='RAC';
sam5.Volume__c = 1233;
sam5.OwnerId = User1Id;
sam5.Unit__c = 'Metric tons (as sold)';
sam5.GateKeeper__c = user3Id;
sam5.outOfOffice__c = true;
sam5.DateOfFeedback__c = mydate1;
sam5.DispatchSite__c ='FR - Iko';

Database.Insert(sam5, true);// insert new record with status Draft Creation
*/
            
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
*@author Geerutsing Govind Kumar
*@Date Draft Creation 10/12/2017
*@Date modification 10/16/2017
*@param 
*@ExcptionName
*@return 
*/      
    public static void testUpdateSampleGatekeeper(){
        // Select users for the test.
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
            
            OutOfOffice outOf = new OutOfOffice();
            outOf.EndDate = date1;
            outOf.StartDate = date1;
            outOf.Message = 'Out of Office: May 22';
            outOf.UserId = users[0].Id;
            outOf.IsEnabled = true;
            outOfList.add(outOf);
            
            //insert outOf;  
            //update outOf;
            
            /*OutOfOffice outOf2 = new OutOfOffice();
            outOf2.EndDate = date1;
            outOf2.StartDate = date1;
            outOf2.Message = 'Out of Office: May 22';
            outOf2.UserId = user1Id;
            outOf2.IsEnabled = true;
            
            Test.startTest();
            Database.Insert(outOf2, true);// insert new record with status Draft Creation
            Test.stopTest();*/
            
            
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
*@author Geerutsing Govind Kumar
*@Date Draft Creation 18/10/2017
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/          
    public static void testcreateSampleShare(){
        // Select users for the test.
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
            
            Test.StartTest();
            Database.Insert(sam, true);
            Test.StopTest();// insert new record with status Draft Creation
            
            // Insert manual share for user who is not record owner. 
            // Query visit report records.
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
*@author Geerutsing Govind Kumar
*@Date Draft Creation 18/10/2017
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/         
    public static void testUpdateSampleShare(){
        // Select users for the test.
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
*@author Geerutsing Govind Kumar
*@Date Draft Creation 18/10/2017
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/      
    public static void testDeleteSampleShare(){
        // Select users for the test.
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
*@author Geerutsing Govind Kumar
*@Date Draft Creation 18/10/2017
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/      
    public static void testsampleApproverShr(){
        // Select users for the test.
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
            sam.Status__c = 'Draft Creation';
            sam.Type__c = 'Lab';
            // sam.Division__c = 'Calderys';
            sam.CSAccountManager__c = User2Id;
            sam.ExpectedDeliveryDate__c = mydate2;
            sam.ProductName__c = p.Id;
            sam.Volume__c = 1233;
            sam.OwnerId = user1Id;
            sam.Tech_ApprovalAccess__c=true;
            sam.CostChargedToCustomer__c = 'Free of Charge';
            sam.Incoterm__c = ple[0].value;
            sam.RequiredDocumentation__c = 'COA';
            sam.Packaging__c = 'Bag';
            sam.Gatekeeper__c = User1Id;
            sam.ApprovalRequirement__c='Required';
            
            sam.BusinessArea__c = 'RAC';
            sam.Unit__c = 'Metric tons (as sold)';
            sam.DispatchSite__c ='FR - Iko';
            sam.DateOfFeedback__c = mydate1;
            
            Database.Insert(sam, true);
            
            for(Sample__c sampUpd: [Select Id FROM Sample__c
                                    WHERE Id =: sam.Id]){
                                        
                                        samList.add(sampUpd);
                                    }
            
            test.startTest();
            update samList;
            test.StopTest();
            
            Approval.ProcessSubmitRequest app = new Approval.ProcessSubmitRequest();
            app.setObjectId(sam.id);
            app.setNextApproverIds(new Id[] {sam.GateKeeper__c});
            Approval.ProcessResult result = Approval.process(app);
            
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
*@author Geerutsing Govind Kumar
*@Date Draft Creation 10/12/2017
*@Date modification 10/16/2017
*@param 
*@ExcptionName
*@return 
*/      
    public static void testCreateCaseGatekeeper(){
        // Select users for the test
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
*@author Geerutsing Govind Kumar
*@Date Draft Creation 8/29/2018
*@Date modification 10/16/2017
*@param 
*@ExcptionName
*@return 
*/      
    public static void testCreateCountryforGatekeeper(){
        // Select users for the test
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
*@author Geerutsing Govind Kumar
*@Date Draft Creation 8/29/2018
*@Date modification 10/16/2017
*@param 
*@ExcptionName
*@return 
*/      
    public static void testUpdateCountryforGatekeeper(){
        // Select users for the test
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
*@author Geerutsing Govind Kumar
*@Date Draft Creation 10/12/2017
*@Date modification 10/16/2017
*@param 
*@ExcptionName
*@return 
*/      
    public static void testUpdateCaseGatekeeper(){
        // Select users for the test.
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
*@author Geerutsing Govind Kumar
*@Date Draft Creation 10/12/2017
*@Date modification 10/16/2017
*@param 
*@ExcptionName
*@return 
*/      
    public static void testCreateBulkGatekeeper(integer count){
        // Select users for the test
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
            
            for(Integer i = 0 ; i<=count ;i++)
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
*@author Geerutsing Govind Kumar
*@Date Draft Creation 18/10/2017
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/          
    public static void testcreateCaseShare(){
        // Select users for the test.
        String RecordTypeName;
        String RecordTypeRemark;
        date mydate = date.parse('05/11/2017');
        
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User WHERE IsActive = true AND
                            ByPassTriggerRule__c = false 
                            AND profile.Id =: p2.Id LIMIT 100];
        
        Id user1Id = users[0].Id;
        Id user2Id = users[1].Id;
        Id user3Id = users[2].Id;
        
        user bypassValidation = [SELECT Id, Email, ByPassValidationRule__c, MultiPicklistDivision__c, Division FROM 
                                 User WHERE Id=:users[0].Id LIMIT 1];
        
        if(bypassValidation.Division == null){
            bypassValidation.Division = 'None';
        }
        if(bypassValidation.MultiPicklistDivision__c == null){
            bypassValidation.MultiPicklistDivision__c = 'Ceramics';
        }       
        bypassValidation.ByPassValidationRule__c = true;
        bypassValidation.ByPassTriggerRule__c = true;
        bypassValidation.CountryforGatekeeper__c = 'Albania';
        bypassValidation.BackupComplaint__c = users[3].Id;
        
        update bypassValidation;        
        
        users[0].ByPassValidationRule__c =true;
        update users[0];
        
        system.runas(users[0]){
            Account acc1 = new Account();
            acc1.Name = 'sdsdasassd1dsdsdd';
            acc1.BillingCountry = 'United States';
            acc1.BillingCity = 'New York';
            acc1.SegmentL1__c = 'Abrasive';
            acc1.Type = 'Head Office';
            acc1.BillingStreet = 'Test';
            Database.insert(acc1, true);    
            
            Contact con = new Contact();
            con.Salutation = 'Mr.';
            con.FirstName = 'SHIA';
            con.Email = 'test@accenture.com.com';
            con.LastName= 'Alisha';
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
            cas.CSAccountManager__c = users[5].id;
            cas.Receiver__c = users[4].id;
        //    cas.CustomerService2__c = users[7].id;
            cas.ProductName__c = p.Id;
            cas.DateRaisedCustomer__c = myDate; 
            cas.OwnerId = user3Id;
            cas.Description = 'Test';
            cas.BusinessArea__c = 'HTS';
            cas.Subject = 'Case'; 
            
            Test.StartTest();
            Database.Insert(cas, true);// insert new record with status Draft Creation
            Test.StopTest();
            
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
            cas2.BusinessArea__c = 'RAC';
            cas2.Type = 'Contamination';
            cas2.GateKeeper__c = users[6].id;
            cas2.CSAccountManager__c = users[5].id;
        //    cas2.CustomerService2__c = users[7].id;
            cas2.Receiver__c = users[4].id;
            //cas2.ProductName__c = p.Id;
            cas2.DateRaisedCustomer__c = myDate; 
            cas2.OwnerId = user3Id;
            cas2.Description = 'Test';
            cas2.Subject = 'Case'; 
            
            Database.Insert(cas2, true);
            // insert new record with status Draft Creation
            
            // Query case share records.
            CaseShare[] caseShrs = [SELECT Id, UserOrGroupId, CaseAccessLevel, 
                                    RowCause 
                                    FROM Caseshare 
                                    WHERE CaseId = :cas.Id
                                    AND UserorGroupId =: users[5].id
                                    AND UserorGroupId =: users[4].id
                                    AND UserorGroupId =: users[6].id
                                    AND CaseAccessLevel =: 'Edit'];
            
            // Test attributes of manual share.
            if(caseShrs.size() > 0) {
                System.assertEquals(caseShrs[0].CaseAccessLevel, 'Edit');
                System.assertEquals(caseShrs[0].UserOrGroupId, users[5].id);
            }                       
        }     
    }
    /**
*@author Geerutsing Govind Kumar
*@Date Draft Creation 18/10/2017
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/      
    public static void testUpdateCaseShare(){
        // Select users for the test.
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
*@author Geerutsing Govind Kumar
*@Date Draft Creation 18/10/2017
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/      
    public static void testDeleteCaseShare(){
        // Select users for the test.
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
*@author Geerutsing Govind Kumar
*@Date Draft Creation 16/5/2018
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/  
    public static void testTargetRelationship(){
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        
        List<User> usersListActive = [SELECT Id FROM User 
                                      WHERE IsActive = true 
                                      AND ByPassTriggerRule__c = false 
                                      LIMIT 10];
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false AND profileID =: p2.Id LIMIT 5];
        
        Map<Id, Target__c> tarMap = New Map<Id, Target__c>();
        
        user bypassValidation = [SELECT Id, Email, ByPassValidationRule__c,MultiPicklistDivision__c, Division FROM 
                                 User WHERE Id=:users[0].Id LIMIT 1];
        
        if(bypassValidation.Division == null){
            bypassValidation.Division = 'None';
        }
        if(bypassValidation.MultiPicklistDivision__c == null){
            bypassValidation.MultiPicklistDivision__c = 'Calderys';
        }       
        
        bypassValidation.ByPassValidationRule__c = true;
        bypassValidation.BackupComplaint__c = usersListActive[2].Id;
        bypassValidation.CountryforGatekeeper__c = 'Albania';
        
        update bypassValidation;
        
        system.runas(users[0]){ 
            Id accountRecordType = [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName = 'ACC_Account' LIMIT 1].Id;
            
            Account accTest= new Account();
            accTest.Name = 'VRTEST';
            accTest.BillingCountry = 'United States';
            accTest.BillingCity = 'New York';
            accTest.DnBNumber__c = '12E456L8P';
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
            
            List<Target__c> tarList = new List<Target__c>();
            List<Relationship__c> relat = new List<Relationship__c>();
            
            //Insert 'Division Account Relationship' 
            Relationship__c relation = new Relationship__c();
            relation.AccountName__c = accTest.Id;
            relation.Divisions__c = 'Ceramics';
            relation.BusinessArea__c = 'HTS';
            relation.DivisionTier__c = 'B';
            //relation.SegmentL2__c = 'Ceramics - OEM';
            relation.SubType__c = 'Consultant';
            relat.add(relation);
            
            Relationship__c relation2 = new Relationship__c();
            relation2.AccountName__c = accTest.Id;
            relation2.Divisions__c = 'Carbonates';
            relation2.BusinessArea__c = 'RAC';
            relation2.DivisionTier__c = 'B';
            //relation2.SegmentL2__c = 'Ceramics - OEM';
            relation2.SubType__c = 'Consultant';
            relat.add(relation2);
            
            Relationship__c relation3 = new Relationship__c();
            relation3.AccountName__c = accTest.Id;
            relation3.Divisions__c = 'Calderys';
            relation3.DivisionTier__c = 'B';
            relation3.BusinessArea__c = 'RAC';
            //relation3.SegmentL2__c = 'Ceramics - OEM';
            relation3.SubType__c = 'Consultant';
            relat.add(relation3);
            
            Database.insert(relat,true);
            
            Relationship__c[] rel = [SELECT id FROM Relationship__c 
                                     WHERE Divisions__c = 'Ceramics'
                                     AND AccountName__c =: accTest.id];
            
            for(Relationship__c relList: relat){            
                For(User u : users){
                    Target__c target1 = new Target__c();
                    target1.Account__c = accTest.Id;
                    target1.Division__c = 'Ceramics';
                    target1.Sales__c = u.Id;
                    
                    tarList.add(target1);
                }
                tarMap.putAll(tarlist);
            }
            insert tarMap.values(); 
            update tarMap.values();
            
            Target__c[] tar = [SELECT Tech_RelationshipInformation__c FROM Target__c
                               WHERE Division__c = 'Ceramics'
                               AND Account__c =: accTest.Id];
            
            //System.assertEquals(rel[0].Id, tar[0].Tech_RelationshipInformation__c);  
            
        }
        
    }
    /**
*@author Geerutsing Govind Kumar
*@Date Draft Creation 20/7/2018
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/  
    public static void testERPCodeRelationship(){
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        
        List<User> usersListActive = [SELECT Id FROM User 
                                      WHERE IsActive = true 
                                      AND ByPassTriggerRule__c = false 
                                      LIMIT 10];
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false AND profileID =: p2.Id LIMIT 5];
        
        Map<Id, ERPCode__c> ERPCodeMap = New Map<Id, ERPCode__c>();
        
        user bypassValidation = [SELECT Id, Email, ByPassValidationRule__c,MultiPicklistDivision__c, Division FROM 
                                 User WHERE Id=:users[0].Id LIMIT 1];
        
        if(bypassValidation.Division == null){
            bypassValidation.Division = 'None';
        }
        if(bypassValidation.MultiPicklistDivision__c == null){
            bypassValidation.MultiPicklistDivision__c = 'Calderys';
        }       
        
        bypassValidation.ByPassValidationRule__c = true;
        bypassValidation.BackupComplaint__c = usersListActive[2].Id;
        bypassValidation.CountryforGatekeeper__c = 'Albania';
        update bypassValidation;
        
        Id recordType;
        
        // recordType recordName = [SELECT Id, DeveloperName 
        // FROM RecordType 
        // WHERE SObjectType = 'ERPCode__c'
        // AND DeveloperName = 'ERP_Code_Request']; 
        
        // recordType = recordName.Id;
        
        system.runas(users[0]){  
            
            Id accountRecordType = [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName = 'ACC_Account' LIMIT 1].Id;
            
            Account accTest= new Account();
            accTest.Name = 'VRTEST';
            accTest.BillingCountry = 'United States';
            accTest.BillingCity = 'New York';
            accTest.DnBNumber__c = '12E456L8P';
            accTest.SegmentL1__c = 'Abrasive';
            accTest.Type = 'Head Office';
            Database.insert(accTest, true);
            
            Contact con = new Contact();
            con.Salutation = 'Mr.';
            con.FirstName = 'HAIA';
            con.Email = 'test@accenture.com.com';
            con.LastName= 'ALISHA';
            con.AccountId = accTest.Id;
            Database.insert(con, true);
            
            // ERPCodeAssignment__c erpCodeAssigmt = new ERPCodeAssignment__c();
            // erpCodeAssigmt.Division__c = 'Ceramics';
            // erpCodeAssigmt.Country__c = 'Sudan';
            // erpCodeAssigmt.ERPSource__c = 'SageX3';
            // erpCodeAssigmt.CreditManager__c = users[2].Id;
            // erpCodeAssigmt.DataAdmin__c = users[2].Id;
            // insert erpCodeAssigmt;
            
            List<ERPCode__c> ERPList = new List<ERPCode__c>();
            List<Relationship__c> relat = new List<Relationship__c>();
            
            //Insert 'Division Account Relationship' 
            Relationship__c relation = new Relationship__c();
            relation.AccountName__c = accTest.Id;
            relation.Divisions__c = 'Ceramics';
            relation.DivisionTier__c = 'B';
            relation.BusinessArea__c = 'RAC';
            //relation.SegmentL2__c = 'Ceramics - OEM';
            relation.SubType__c = 'Consultant';
            relat.add(relation);
            
            Relationship__c relation2 = new Relationship__c();
            relation2.AccountName__c = accTest.Id;
            relation2.Divisions__c = 'Carbonates';
            relation2.BusinessArea__c = 'HTS';
            relation2.DivisionTier__c = 'B';
            //relation2.SegmentL2__c = 'Ceramics - OEM';
            relation2.SubType__c = 'Consultant';
            relat.add(relation2);
            
            Relationship__c relation3 = new Relationship__c();
            relation3.AccountName__c = accTest.Id;
            relation3.Divisions__c = 'Calderys';
            relation3.BusinessArea__c = 'RAC';
            relation3.DivisionTier__c = 'B';
            //relation3.SegmentL2__c = 'Ceramics - OEM';
            relation3.SubType__c = 'Lead';
            relat.add(relation3);
            
            Database.insert(relat,true);
            
            Relationship__c[] rel = [SELECT id FROM Relationship__c 
                                     WHERE Divisions__c = 'Ceramics'
                                     AND AccountName__c =: accTest.id];
            
            for(Relationship__c relList: relat){            
                ERPCode__c erp = new ERPCode__c();
                erp.Account__c = accTest.Id;
                erp.Division__c = 'Ceramics';
                erp.BusinessArea__c = 'RAC';
                //erp.recordtypeId = recordType;
                //erp.Country__c = 'Sudan';
                //erp.ERPSource__c ='SageX3';
                ERPList.add(erp);
            }
            
            ERPCodeMap.putAll(ERPList);
            insert ERPCodeMap.values(); 
            update ERPCodeMap.values();
            
            ERPCode__c[] erp = [SELECT Tech_RelationshipInformation__c FROM ERPCode__c
                                WHERE Division__c = 'Ceramics'
                                AND BusinessArea__c = 'HTS'
                                AND Account__c =: accTest.Id];
            
            //system.assertEquals(rel[0].Id, erp[0].Tech_RelationshipInformation__c);  
            
        } 
  
    }       
    /**
*@author Geerutsing Govind Kumar
*@Date Draft Creation 5/2/2018
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/   
    public static void testFillRelationship(){
        
        date mydate = date.parse('05/11/2012');
        date mydate1 = date.parse('05/11/2017');
        date mydate2 = date.parse('08/12/2022');
        String recordName;
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c,ByPassValidationRule__c,ByPassProcessBuilders__c FROM User WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false AND profileID =: p2.Id LIMIT 5];
        
        Map<Id, TechnicalAssistanceRequest__c> techMap = New Map<Id, TechnicalAssistanceRequest__c>();
        Map<Id, Offer__c> offerMap = New Map<Id, Offer__c>();
        Map<Id, Project__c> projectMap = New Map<Id, Project__c>();
        List<Offer__c> offerList = new List <Offer__c>();
        List<Project__c> projectList = new List <Project__c>();
        List<TechnicalAssistanceRequest__c> techList = new List <TechnicalAssistanceRequest__c>();
        
        users[0].ByPassValidationRule__c = true;
        users[0].ByPassProcessBuilders__c = true;
        update users[0];
        
       List<Recordtype> RecTypeOffer = [Select Id from Recordtype where  SobjectType ='offer__c' and developername = 'SubProject'];
       Id RecTypeSubProject = RecTypeOffer[0].Id;

        
        system.runas(users[0]){ 
            
            
            //Id accountRecordType = [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName = 'ACC_Account' LIMIT 1].Id;
            
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
            //Create Division
            
            //Insert 'Division Account Relationship'        
            List<Relationship__c> relat = new List<Relationship__c>();
            List<VisitReport__c> vrList = new List<VisitReport__c>();
            List<Opportunity> oppList = new List<Opportunity>();
            List<Capacity__c> capList = new List<capacity__c>();
            List<Consumption__c> conList = new List<Consumption__c>();
            List<Case> caseList = new List<Case>();
            List<Sample__c> samList = new List<Sample__c>();
            
            //for(Division__c DivToInsert: divList) {
            Relationship__c relation = new Relationship__c();
            relation.AccountName__c = accTest.Id;
            relation.Divisions__c = 'Ceramics';
            relation.DivisionTier__c = 'B';
            relation.BusinessArea__c = 'HTS';
            relation.AccountManager__c = users[0].Id;
            relation.ValidityMoreThan1Year__c=True;            
            //relation.SegmentL2__c = 'Ceramics - OEM';
            relation.SubType__c = 'Consultant';
            relat.add(relation);
            
            Relationship__c relation2 = new Relationship__c();
            relation2.AccountName__c = accTest.Id;
            relation2.Divisions__c = 'Carbonates';
            relation2.DivisionTier__c = 'B';
            relation2.BusinessArea__c = 'RAC';
            relation2.ValidityMoreThan1Year__c=True; 
            relation2.AccountManager__c = users[0].Id;
            //relation2.SegmentL2__c = 'Ceramics - OEM';
            relation2.SubType__c = 'Consultant';
            relat.add(relation2);
            
            Relationship__c relation3 = new Relationship__c();
            relation3.AccountName__c = accTest.Id;
            relation3.Divisions__c = 'Calderys';
            relation3.DivisionTier__c = 'B';
            relation3.ValidityMoreThan1Year__c=True; 
            relation3.AccountManager__c = users[0].Id;
            relation3.BusinessArea__c = 'PM EMEA';
            //relation3.SegmentL2__c = 'Ceramics - OEM';
            relation3.SubType__c = 'Consultant';
            relat.add(relation3);
            
            Database.insert(relat,true);
            
            Test.startTest();  
            
            for(Relationship__c relList: relat){
                
                VisitReport__c visit = new VisitReport__c();
                visit.Account__c = accTest.Id;
                //visit.contact__c =  con.Id;
                visit.Type__c = 'Email';
                visit.Dateofvisit__c = mydate;
                visit.BusinessArea__c = 'RAC';
                visit.MainObjectivesofthemeeting__c = 'Courtesy';
                //visit.SegmentL2__c = 'Ceramics';
                visit.Division__c = 'Ceramics';
                vrList.add(visit);
            }
            
            Database.insert(vrList, true); 
            
            
            // Relationship__c[] rel = [SELECT id FROM Relationship__c 
            // WHERE Divisions__c = 'Ceramics'
            // AND AccountName__c =: accTest.id
            // AND BusinessArea__c = 'HTS'];
            
            // VisitReport__c[] vr = [SELECT Tech_RelationshipInformation__c FROM VisitReport__c
            // WHERE Division__c = 'Ceramics'
            // AND BusinessArea__c = 'RAC'
            // AND Account__c =: accTest.Id];
            
            //System.assertEquals(rel[0].Id, vr[0].Tech_RelationshipInformation__c); 
            
            
            opportunity o = new opportunity();
            o.name = 'Pizza King Oppty';
            o.AccountId = accTest.Id;
            o.CloseDate = system.today();
            o.StageName = 'New';
            o.Division__c = 'Ceramics';
            o.BusinessArea__c = 'HTS';
            o.Probability = 30;
            oppList.add(o);
            
            //insert oppList;  
            //update oppList;     
            
            // opportunity[] opp = [SELECT Tech_RelationshipInformation__c FROM Opportunity
            // WHERE Division__c = 'Ceramics'
            // AND BusinessArea__c = 'HTS'
            // AND AccountId =: accTest.Id];
            
            //System.assertEquals(rel[0].Id, opp[0].Tech_RelationshipInformation__c);
            
            
            for(Relationship__c relList: relat){
                
                Capacity__c cap = new Capacity__c();
                cap.Year__c = '2017';
                cap.RelatedAccount__c = accTest.Id;
                cap.Division__c = 'Ceramics';
                cap.BusinessArea__c = 'HTS';
                capList.add(cap);
            }
            insert capList; 
            update capList;     
            
            // Capacity__c[] cap = [SELECT Tech_RelationshipInformation__c FROM Capacity__c
            // WHERE Division__c = 'Ceramics'
            // AND BusinessArea__c = 'HTS'
            // AND RelatedAccount__c =: accTest.Id];
            
            //System.assertEquals(rel[0].Id, cap[0].Tech_RelationshipInformation__c);                     
            
            
            
            for(Relationship__c relList: relat){
                
                Consumption__c cons = new Consumption__c();
                //cons.RecordTypeId = recordName;
                cons.CompetitorProductName__c = 'xxcxc';
                cons.CustomerName__c = accTest.Id;
                cons.Year__c = '2018';
                cons.InvoicingDivision__c = 'Ceramics';
                cons.BusinessArea__c = 'RAC';
                conList.add(cons);
            }
            insert conList;  
            update conList;         
            
            // Consumption__c[] consump = [SELECT Tech_RelationshipInformation__c FROM consumption__c
            // WHERE InvoicingDivision__c = 'Ceramics'
            // AND BusinessArea__c = 'RAC'
            // AND CustomerName__c=: accTest.Id];
            
            // System.assertEquals(rel[0].Id, consump[0].Tech_RelationshipInformation__c); 
            
            Product2 p = new product2();
            p.Name = 'Test';
            p.ManufacturingImerysPlant__c = '';
            p.IsActive = true;
            p.Division__c = 'Ceramics';
            
            Database.insert(p, true);
            
            // RecordType recordNameCase = [SELECT Id, DeveloperName 
            // FROM RecordType 
            // WHERE SObjectType = 'Case'
            // AND DeveloperName = 'CSE_Complaint'];  // record type samplewithoutopp
            
            // recordName = recordNameCase.Id;
            
            for(Relationship__c relList: relat){         
                Case cas = New Case();
                cas.AccountId= accTest.Id;
                //cas.RecordTypeId = recordName;
                cas.ContactId = con.Id;
                //cas.Division__c = 'Ceramics';
                cas.Status = 'Draft Creation';
                cas.Type = 'Contamination';
                cas.CSAccountManager__c = users[2].id;
                cas.Receiver__c = users[4].id;
                cas.ProductName__c = p.Id;
                cas.DateRaisedCustomer__c = myDate; 
                //cas.DispatchSite__c = 'AT - Ebensee';
                //cas.Packaging__c = 'Bag';
                cas.Description = 'Test';
                //cas.Incoterm__c = ' 
                cas.BusinessArea__c = 'RAC';
                cas.Subject = 'Case'; 
                //cas.SalesOrderNumber__c = 'ddf';
                caseList.add(cas);
            }
            insert caseList;
            update caseList;            
            
            // case[] cas = [SELECT Tech_RelationshipInformation__c FROM case
            // WHERE Division__c  = 'Calderys'
            // AND BusinessArea__c = 'RAC'
            // AND AccountId=: accTest.Id];
            
            //System.assertEquals(0, cas[0].Tech_RelationshipInformation__c); 
            // RecordType recordNameSample = [SELECT Id, DeveloperName 
            // FROM RecordType 
            // WHERE SObjectType = 'Sample__c'
            // AND DeveloperName = 'SAM_SampleWithoutOpportunity'];  // record type samplewithoutopp
            
            // recordName = recordNameSample.Id;
            
            for(Relationship__c relList: relat){ 
                Sample__c sam = New Sample__c();
                sam.AccountName__c = accTest.Id;
                //sam.RecordTypeId = recordName;
                sam.RecipientName__c = con.Id;
                sam.Status__c = 'Draft Creation';
                sam.Type__c = 'Lab';
                // sam.Division__c = 'Calderys';
                sam.CSAccountManager__c = users[2].id;
                sam.ExpectedDeliveryDate__c = mydate2;
                sam.ProductName__c = p.Id;
                sam.BusinessArea__c = 'RAC';
                sam.Volume__c = 1233;
                sam.Unit__c = 'Metric tons (as sold)';
                sam.DispatchSite__c ='FR - Iko';
                sam.DateOfFeedback__c = mydate1;
                samList.add(sam);
            }
            //insert samList; 
            //update samList;         
            
            // Sample__c[] samp = [SELECT Tech_RelationshipInformation__c FROM Sample__c
            // WHERE Division__c  = ''
            // AND AccountName__c=: accTest.Id];                                      
            
            
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
            
            for(Relationship__c relList: relat){            
                
                TechnicalAssistanceRequest__c tech = new TechnicalAssistanceRequest__c();
                tech.Account__c = accTest.Id;
                tech.Opportunity__c = o.Id;
                tech.Division__c = 'Ceramics';
                tech.BusinessObjectiveandStakes__c= 'test';
                tech.Market_Segmentation__c = markSeg.Id;
                tech.Status__c = 'Creation';
                
                techList.add(tech);
            }
            
            techMap.putall(techList);
            insert techMap.values(); 
            update techMap.values();
            
            
            //for(Relationship__c relList: relat){            
                Offer__c off = new Offer__c();
                off.Account__c = accTest.Id;
                off.RecordTypeId = RecTypeSubProject;
                off.AccountInstallationIsPerformedOn__c = accTest.Id;
                off.OfferStatus__c = 'Draft';
                off.ABCSafetyCategorizationPB__c='A';
                //off.WonLostReason__c =  'Delivery Time';
                off.OurProbability__c = 23;
                off.Services__c = 'Installation';
                off.ProbabilityofCustomer__c = 45;
                off.TotalValue__c = 200;
                off.GrossMargin__c = 12;
                off.OfferDate__c = myDate;
                off.DecisionDate__c = mydate;
                off.BusinessArea__c = 'RAC';
                off.ParticipantType__c = 'Consultant';
                off.TECH_ReconnexionTarget__c = false;
                offerList.add(off);
            //}
            
            offerMap.putall(offerList);
            insert offerMap.values();
            update offerMap.values();
           
            
            
            for(Relationship__c relList: relat){            
                Project__c pro = new Project__c();
                pro.Account__c= accTest.Id;
                pro.Project_Name__c= 'Won';
                pro.ProjectType__c =  'Brownfield';
                //pro.EstimatedOrderValue__c = 'Under 100K €';
                pro.BusinessArea__c = 'HTS';
                //pro.ProjectCountry__c = 'Albania';
                projectList.add(pro);
            }
            
            projectMap.putall(projectList);
            insert projectMap.values();
            update projectMap.values();
            Test.stopTest();
            
        }
    }   
    
    
    /**
*@author Geerutsing Govind Kumar
*@Date Draft Creation 16/3/2018
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/   
    Public static void testSyncQuote(){
        Account accTest= new Account();
        accTest.Name = 'VRTEST';
        accTest.BillingCountry = 'United States';
        accTest.BillingCity = 'New York';
        accTest.SegmentL1__c = 'Abrasive';
        accTest.Type = 'Head Office';
        Database.insert(accTest, true);
        
        opportunity opp = new opportunity();
        opp.name = 'Pizza King Oppty';
        opp.AccountId = accTest.Id;
        opp.CloseDate = system.today();
        opp.StageName = 'New';
        opp.Probability = 20;
        opp.Division__c = 'Ceramics';
        opp.BusinessArea__c = 'RAC';
        insert opp;
        
        Quote quo = new Quote();
        quo.Name = 'Test Quote';
        quo.OpportunityId = opp.Id;        
        insert quo;
        
        quote qto = [SELECT Id, Status FROM Quote Where OpportunityId =: quo.OpportunityId];
        
        qto.Status = 'Approved';
        
        Test.startTest();
        update qto;
        Test.stopTest();
        
        Opportunity o = [select SyncedQuoteId from opportunity where id=:opp.Id];
        //system.assert(o.SyncedQuoteId != null, true);
        
    }
    
    /**
*@author Geerusting Govind Kumar
*@Date Draft Creation 3/16/2018
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/
    Public static void testinsertQuoteLineItems(){
        
        Test.startTest();
        
        List<Profile> lstAdminPro = [SELECT Id From Profile 
                                     WHERE Name = 'System Administrator' limit 1];
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User 
                            WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false 
                            AND ProfileId =: lstAdminPro[0].Id LIMIT 1];
        
        users[0].ByPassValidationRule__c =true;
        users[0].ByPassProcessBuilders__c = true;
        update users[0];
        
        system.RunAs(users[0]){
            
            Account accTest= new Account();
            accTest.Name = 'VRTEST';
            accTest.BillingCountry = 'United States';
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
            
            Pricebook2 stdPb = [Select IsActive, Id from Pricebook2 where isStandard = true AND
                                CurrencyIsoCode ='EUR'];
            //stdPb.CurrencyIsoCode = 'EUR';
            //stdPb.isActive = true;
            //update stdPb; 
            //PricebookEntry pbestd = new PricebookEntry(pricebook2id = stdPb.id, product2id = pro.id,unitprice=1.0, isActive=true ,CurrencyIsoCode = 'EUR');
            //insert pbestd;
            
            PricebookEntry pkBook =[select id, CurrencyIsoCode from PricebookEntry Where 
                                    product2id=: pro.Id
                                    and CurrencyIsoCode ='EUR' limit 1];
            system.debug('========PricebookEntry=========' + [select id, CurrencyIsoCode from PricebookEntry Where product2id=: pro.Id]);
            
            
            opportunity o = new opportunity();
            o.name = 'Pizza King Oppty';
            o.AccountId = accTest.Id;
            o.CloseDate = system.today();
            o.StageName = 'New';
            o.Probability = 20;
            o.Division__c = 'Ceramics';
            o.CurrencyIsoCode ='EUR';
            o.pricebook2Id =stdPb.Id;
            insert o;
            
            system.debug('======Opportunity===========' + [select id, CurrencyIsoCode from Opportunity Where id=: o.Id]);
            
            Quote qt = new Quote
                (Name='test quote',OpportunityId=o.id,Pricebook2Id = stdPb.Id, 
                 ContactId=con.id, ExpirationDate=system.today());
            insert qt;
            
            //OpportunityLineItem oli = new OpportunityLineItem(PricebookEntryId=pkBook.Id, Packaging__c ='Bag', opportunityid = o.id, Quantity = 2,unitprice=1.5);
            
            //insert oli;
            
            //system.debug('=======OpportunityLineItem==========' + [select id, CurrencyIsoCode from OpportunityLineItem Where id=: oli.Id]);
            QuoteLineItem qliliner = new QuoteLineItem(Product2Id=pro.id,
                                                       QuoteId=qt.id,PriceBookEntryID=pkBook.id,Quantity=4, UnitPrice =50);
            insert qliliner;
        } 
        Test.stopTest();
    }
    /**
*@author Geerusting Govind Kumar
*@Date Draft Creation 3/16/2018
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/
    Public static void testUpdateCase(){
        String recordTypeName;
        date mydate = date.parse('05/11/2012');
        List<User> usersListActive = [SELECT Id FROM User 
                                      WHERE IsActive = true 
                                      AND ByPassTriggerRule__c = false 
                                      LIMIT 100];
        
        List<User> userUpdBackup = new List<User>();
        List<outOfOffice> outOfList = new List<outOfOffice>();
        DateTime date1 = Date.today();
        
        List<Profile> lstAdminPro = [SELECT Id From Profile 
                                     WHERE Name = 'System Administrator'
                                     limit 1];
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User 
                            WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false 
                            AND ProfileId =: lstAdminPro[0].Id LIMIT 1];
        
        List<Case> caseList = new List<Case>();
        
        user bypassValidation = [SELECT Id, Email, ByPassValidationRule__c,MultiPicklistDivision__c, Division FROM 
                                 User WHERE Id=:users[0].Id LIMIT 1];
        
        if(bypassValidation.Division == null){
            bypassValidation.Division = 'None';
        }
        if(bypassValidation.MultiPicklistDivision__c == null){
            bypassValidation.MultiPicklistDivision__c = 'Calderys';
        }       
        
        bypassValidation.ByPassValidationRule__c = true;
        bypassValidation.BackupComplaint__c = usersListActive[2].Id;
        bypassValidation.CountryforGatekeeper__c = 'Albania';
        update bypassValidation;  
        
        
        users[0].ByPassValidationRule__c =true;
        update users[0];
        
        system.RunAs(users[0]){
            
            Account acc1 = new Account();
            acc1.Name = 'sdsdasassd1dsdsdd';
            acc1.BillingCountry = 'United States';
            acc1.BillingCity = 'New York';
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
            gat.Gatekeeper__c = users[0].Id;
            gat.AllPlants__c = True;
            gat.Object__c = 'Case';   
            gat.BusinessArea__c ='RAC';         
            
            Case cas = New Case();
            cas.AccountId= acc1.Id;
            cas.RecordTypeId = recordTypeName;
            cas.ContactId = con.Id;
            cas.Status = 'Draft Creation';
            cas.Type = 'Contamination';
            cas.CSAccountManager__c = users[0].id;
            cas.Receiver__c = users[0].id;
            cas.ProductName__c = p.Id;
            cas.GateKeeper__c = usersListActive[2].Id;
            cas.DateRaisedCustomer__c = myDate; 
            cas.OwnerId = users[0].Id;   
            cas.Description = 'Test'; 
            cas.Subject = 'Case';  
            cas.BusinessArea__c = 'RAC';
            caseList.add(cas);
            
            //Database.Insert(caseList, true);// insert new record with status Draft Creation
            
            OutOfOffice outOf = new OutOfOffice();
            outOf.EndDate = date1;
            outOf.StartDate = date1;
            outOf.IsEnabled = true;
            outOf.Message = 'Out of Office';
            outOf.UserId = users[0].Id;
            outOfList.add(outOf);
            
            
            insert outOf; 
            
            list<OutOfOffice> updOOO= new list<OutOfOffice>();
            list<OutOfOffice> updOO=[SELECT UserId, Id, Message, StartDate, EndDate FROM OutOfOffice where UserId=:users[0].Id limit 1];
            for(OutOfOffice updo:updOO)
            {
                updo.message='Updated OOO';
                updOOO.add(updo);
            }
            update updOOO;
            
            
            /* List<Case> caseRecord = [SELECT GateKeeper__c, OutOfOffice__c
FROM Case WHERE Id =:CaseList[0].Id];  

System.AssertEquals(caseRecord[0].GateKeeper__c, usersListActive[2].Id); 
System.AssertEquals(caseRecord[0].OutOfOffice__c, false);   
*/
            //delete outof;           
            
        }
        user bypassValidation2 = [SELECT Id, Email, ByPassValidationRule__c FROM 
                                  User WHERE Id=:users[0].Id LIMIT 1];
        
        
        bypassValidation2.ByPassValidationRule__c = false;
        update bypassValidation2;   
        
    }
    /**
*@author Geerusting Govind Kumar
*@Date Draft Creation 3/16/2018
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/
    Public static void testUpdateSample(){
        String recordTypeName;
        date mydate = date.parse('05/11/2012');
        date mydate2 = date.parse('08/12/2018');
        date mydate1 = date.parse('05/11/2017');
        
        List<User> usersListActive = [SELECT Id FROM User 
                                      WHERE IsActive = true 
                                      AND ByPassTriggerRule__c = false 
                                      LIMIT 100];
        
        List<User> userUpdBackup = new List<User>();
        List<outOfOffice> outOfList = new List<outOfOffice>();
        DateTime date1 = Date.today();
        
        List<Profile> lstAdminPro = [SELECT Id From Profile 
                                     WHERE Name = 'System Administrator'
                                     limit 1];
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User 
                            WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false 
                            AND ProfileId =: lstAdminPro[0].Id LIMIT 1];
        
        user bypassValidation = [SELECT Id, Email, ByPassValidationRule__c, MultiPicklistDivision__c, Division FROM 
                                 User WHERE Id=:users[0].Id LIMIT 1];
        
        if(bypassValidation.Division == null){
            bypassValidation.Division = 'None';
        }
        if(bypassValidation.MultiPicklistDivision__c == null){
            bypassValidation.MultiPicklistDivision__c = 'Calderys';
        }       
        
        bypassValidation.ByPassValidationRule__c = true;
        bypassValidation.CountryforGatekeeper__c = 'Albania';
        bypassValidation.BackupComplaint__c = usersListActive[2].Id;
        
        update bypassValidation;   
        system.debug('user:'+users[0]);
        system.debug('user trigger:'+users[0].ByPassTriggerRule__c);
        system.RunAs(users[0]){
            
            Account acc1 = new Account();
            acc1.Name = 'sdsdasassd1dsdsdd';
            acc1.BillingCountry = 'United States';
            acc1.BillingCity = 'New York';
            acc1.SegmentL1__c = 'Abrasive';
            acc1.Type = 'Head Office';
            Database.insert(acc1, true);    
            
            Contact con = new Contact();
            con.Salutation = 'Mr.';
            con.FirstName = 'Shia';
            con.Email = 'test@accenture.com.com';
            con.LastName= 'ALISHA';
            con.AccountId = acc1.Id;
            Database.insert(con, true);
            
            Product2 p = new product2();
            p.Name = 'zzzz';
            p.IsActive = true;
            p.ManufacturingImerysPlant__c = '';
            p.Division__c = 'Calderys';
            
            GatekeeperAssignment__c gat = New GatekeeperAssignment__c();
            gat.Division__c = 'Calderys';
            gat.Gatekeeper__c = Users[0].Id;
            gat.AllPlants__c = true;
            gat.Object__c = 'Sample';
            gat.BusinessArea__c = 'HTS';
            
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
            sam.Status__c = 'Draft Creation';
            sam.Type__c = 'Lab';
            sam.CSAccountManager__c = Users[0].Id;
            sam.ExpectedDeliveryDate__c = mydate2;
            sam.ProductName__c = p.Id;
            sam.Volume__c = 1233;
            sam.OwnerId = Users[0].Id;
            sam.BusinessArea__c = 'RAC';
            sam.Unit__c = 'Metric tons (as sold)';
            sam.GateKeeper__c = usersListActive[2].Id;
            sam.DateOfFeedback__c = mydate1;
            sam.DispatchSite__c ='FR - Iko';
            Database.Insert(sam, true);// insert new record with status Draft Creation
            
            OutOfOffice outOf = new OutOfOffice();
            outOf.EndDate = date1;
            outOf.StartDate = date1;
            outOf.Message = 'Out of Office';
            outOf.UserId = users[0].Id;
            outOf.IsEnabled = true;
            outOfList.add(outOf);
            
            Test.StartTest();
            insert outOf;
            //update outOf;
            Test.StopTest();
            
            List<Sample__c> sampleRecord = [SELECT GateKeeper__c, OutOfOffice__c
                                            FROM Sample__c WHERE Id =:sam.Id];  
            
            System.AssertEquals(sampleRecord[0].GateKeeper__c, usersListActive[2].Id); 
            System.AssertEquals(sampleRecord[0].OutOfOffice__c, false); 
            
            //delete outOf;
            
        }
        user bypassValidation2 = [SELECT Id, Email, ByPassValidationRule__c FROM 
                                  User WHERE Id=:users[0].Id LIMIT 1];
        
        
        bypassValidation2.ByPassValidationRule__c = false;
        update bypassValidation2; 
        
    }
    /**
*@author Geerusting Govind Kumar
*@Date Draft Creation 4/6/2018
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/
    Public static void testTechApproverSharing(){
        
        List<Profile> lstAdminPro = [SELECT Id From Profile 
                                     WHERE Name = 'System Administrator'
                                     limit 1];
        
        List<User> usersActive = [SELECT Id FROM User 
                                  WHERE IsActive = true 
                                  AND ByPassTriggerRule__c = false 
                                  LIMIT 100];                               
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User 
                            WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false 
                            AND ProfileId =: lstAdminPro[0].Id LIMIT 1];
        
        List<TechnicalAssistanceRequest__c> techUpdList = new List <TechnicalAssistanceRequest__c>();
        
        users[0].ByPassValidationRule__c =true;
        update users[0];
        
        system.RunAs(users[0]){  
            Account acc1 = new Account();
            acc1.Name = 'sdsdasassd1dsdsdd';
            acc1.BillingCountry = 'United States';
            acc1.BillingCity = 'New York';
            acc1.SegmentL1__c = 'Abrasive';
            acc1.Type = 'Head Office';
            Database.insert(acc1, true);  
            
            opportunity opp = new opportunity();
            opp.name = 'Pizza King Oppty';
            opp.AccountId = acc1.Id;
            opp.CloseDate = system.today();
            opp.StageName = 'New';
            opp.Probability = 20;
            opp.Division__c = 'Ceramics';
            insert opp;
            
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
            
            TechnicalAssistanceRequest__c tech = new TechnicalAssistanceRequest__c();
            tech.Account__c = acc1.Id;
            tech.Opportunity__c = opp.Id;
            tech.Division__c = 'Ceramics';
            tech.BusinessObjectiveandStakes__c= 'test';
            tech.Status__c = 'Creation';
            //tech.Approver__c = usersActive[2].Id;
            tech.Requester__c = usersActive[1].Id;
            tech.Market_Segmentation__c = markSeg.Id;
            insert tech;
            
            for(TechnicalAssistanceRequest__c techUpd: [Select Id FROM TechnicalAssistanceRequest__c
                                                        WHERE Id =: tech.Id]){
                                                            
                                                            //techUpd.Approver__c = usersActive[10].Id;
                                                            techUpdList.add(techUpd);
                                                        }
            
            test.startTest();
            update techUpdList;
            test.StopTest();
            
            Approval.ProcessSubmitRequest app = new Approval.ProcessSubmitRequest();
            app.setObjectId(tech.id);
            app.setNextApproverIds(new Id[] {tech.Requester__c});
            Approval.ProcessResult result = Approval.process(app);
            
            List<TechnicalAssistanceRequest__Share> techAssistShrs = [SELECT Id, UserOrGroupId, AccessLevel, 
                                                                      RowCause FROM TechnicalAssistanceRequest__share 
                                                                      WHERE ParentId = :tech.Id AND UserOrGroupId= :usersActive[10].Id];      
            // Test attributes of manual share.
            if(techAssistShrs.size() > 0) {
                System.assertEquals(techAssistShrs[0].AccessLevel, 'Edit');
                System.assertEquals(techAssistShrs[0].UserOrGroupId, usersActive[10].Id);
            }           
            
        }
    }
    /**
*@author Geerusting Govind Kumar
*@Date Draft Creation 4/6/2018
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/
    Public static void testspecApproverSharing(){
        
        List<Profile> lstAdminPro = [SELECT Id From Profile 
                                     WHERE Name = 'System Administrator'
                                     limit 1];
        
        List<User> usersActive = [SELECT Id FROM User 
                                  WHERE IsActive = true 
                                  AND ByPassTriggerRule__c = false 
                                  LIMIT 100];                               
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User 
                            WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false 
                            AND ProfileId =: lstAdminPro[0].Id LIMIT 1];
        
        List<SpecificCustomerRequirement__c> specUpdList = new List <SpecificCustomerRequirement__c>();
        
        users[0].ByPassValidationRule__c = true;
        update users[0];
        
        system.RunAs(users[0]){  
            Account acc1 = new Account();
            acc1.Name = 'sdsdasassd1dsdsdd';
            acc1.BillingCountry = 'United States';
            acc1.BillingCity = 'New york';
            acc1.SegmentL1__c = 'Abrasive';
            acc1.Type = 'Head Office';
            Database.insert(acc1, true); 
            
            opportunity opp = new opportunity();
            opp.name = 'Pizza King Oppty';
            opp.AccountId = acc1.Id;
            opp.CloseDate = system.today();
            opp.StageName = 'New';
            opp.Probability = 20;
            opp.Division__c = 'Ceramics';
            insert opp;
            
            
            Product2 p = new product2();
            p.Name = 'zzzz';
            p.IsActive = true;
            p.ManufacturingImerysPlant__c = '';
            p.Division__c = 'Calderys';
            
            SpecificCustomerRequirement__c spec = new SpecificCustomerRequirement__c();
            spec.Account__c = acc1.Id;
            spec.Product__c = p.Id;
            spec.Division__c = 'Ceramics';
            spec.Status__c = 'Open';
            insert spec;
            
            for(SpecificCustomerRequirement__c specUpd: [Select Id FROM SpecificCustomerRequirement__c
                                                         WHERE Id =: spec.Id]){
                                                             
                                                             specUpd.Approver__c = usersActive[10].Id;
                                                             specUpdList.add(specUpd);
                                                         }
            
            test.startTest();
            update specUpdList;
            test.StopTest();
            
            Approval.ProcessSubmitRequest app = new Approval.ProcessSubmitRequest();
            app.setObjectId(spec.id);
            app.setNextApproverIds(new Id[] {users[0].Id});
            Approval.ProcessResult result = Approval.process(app);
            
            List<SpecificCustomerRequirement__Share> specAssistShrs = [SELECT Id, UserOrGroupId, AccessLevel, 
                                                                       RowCause FROM SpecificCustomerRequirement__share 
                                                                       WHERE ParentId = :spec.Id AND UserOrGroupId= :usersActive[10].Id];      
            // Test attributes of manual share.
            if(specAssistShrs.size() > 0) {
                System.assertEquals(specAssistShrs[0].AccessLevel, 'Edit');
                System.assertEquals(specAssistShrs[0].UserOrGroupId, usersActive[10].Id);
            }           
            
        }
    }
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 20/8/2018
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/   
    Public static void testBatchOffer() {  
        
        date mydate = date.parse('05/11/2018');
        
        Profile lstAdminPro = [SELECT Id From Profile 
                               WHERE Name = 'System Administrator'
                               limit 1];
        
        List<CurrencyType> currencyTpyeList = [select id,IsoCode,ConversionRate from CurrencyType];
        
        User us = [Select id, ByPassValidationRule__c,MultiPicklistDivision__c, Email, Division from User where profileID= :lstAdminPro.Id
                   AND IsActive=true LIMIT 1];
        
        String targetOffer = Label.CL00005;
        System.runAs(us){
            RecordType recordNameTarget = [SELECT Id, DeveloperName 
                                           FROM RecordType 
                                           WHERE SObjectType = 'Target__c'
                                           AND DeveloperName =:targetOffer]; 
            
            Id recordTypeTargetId = recordNameTarget.Id;  
            
            if(us.Division == null){
                us.Division = 'None';
            }
            if(us.MultiPicklistDivision__c == null){
                us.MultiPicklistDivision__c = 'Calderys';
            }       
            
            us.ByPassValidationRule__c = true;
            
            update us;   
            
            List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User WHERE IsActive = true 
                                AND ByPassTriggerRule__c = false];
            
            List<Account> accountsList = new List<Account>();
            List<Offer__c> offerList = new List<Offer__c>();
            List<Offer__c> offerList2 = new List<Offer__c>();
            List<Target__c> targetList = new List<Target__c>();
            // insert 10 accounts
            for (Integer i=0;i<10;i++) {
                accountsList.add(new Account(name='Account '+i, 
                                             billingcity='New York', billingcountry='United States',
                                             SegmentL1__c='Abrasive',
                                             Type = 'Head Office',
                                             DnBNumber__c='zzz'+i));
            }
            insert accountsList;
            
            for(Account account : accountsList) {
                targetList.add(new Target__c(Account__c=account.Id, recordTypeId = recordTypeTargetId, CurrencyIsoCode =currencyTpyeList[0].IsoCode,
                                             TotalValueDirectSale__c=0, TotalValueProjectOffer__c =0,Sales__c=users[0].Id));
            }
            insert targetList;
            system.debug('target' + targetList);
            
            String projectSalesOffer = Label.CL00007;       
            String directSalesOffer = Label.CL00006;
            
            RecordType recordProjectSales = [SELECT Id, DeveloperName 
                                             FROM RecordType 
                                             WHERE SObjectType = 'Offer__c'
                                             AND DeveloperName =:projectSalesOffer]; // record type project sales offer
            
            Id recordTypeProjectSalesId = recordProjectSales.Id;    
            
            RecordType recordDirectSales = [SELECT Id, DeveloperName 
                                            FROM RecordType 
                                            WHERE SObjectType = 'Offer__c'
                                            AND DeveloperName =:directSalesOffer]; // record type direct sales offer
            
            Id recordTypeDirectSalesId = recordDirectSales.Id;      
            // find the account just inserted. add contact for each
            for (Account account : accountsList) {
                offerList.add(new Offer__c(Account__c = account.Id,
                                           //visit.contact__c =  con.Id;
                                           recordTypeId = recordTypeDirectSalesId,
                                           OfferStatus__c = 'Won',
                                           WonLostReason__c =  'Delivery Time',
                                           OurProbability__c = 23,
                                           ProbabilityofCustomer__c = 45,
                                           TotalValue__c = 200,
                                           CurrencyIsoCode = currencyTpyeList[1].IsoCode,
                                           GrossMargin__c = 12,
                                           OfferDate__c = myDate,
                                           DecisionDate__c = mydate,
                                           ParticipantType__c = 'Consultant',
                                           TECH_ReconnexionTarget__c = false));
            }
            insert offerList;
            system.debug('offer' + offerList);
            
            for(Account account : accountsList) {
                offerList2.add(new Offer__c(Account__c = account.Id,
                                            //visit.contact__c =  con.Id;
                                            recordTypeId = recordTypeProjectSalesId,
                                            OfferStatus__c = 'Won',
                                            WonLostReason__c =  'Delivery Time',
                                            OurProbability__c = 23,
                                            ProbabilityofCustomer__c = 45,
                                            TotalValue__c = 200,
                                            GrossMargin__c = 12,
                                            CurrencyIsoCode = currencyTpyeList[1].IsoCode,
                                            OfferDate__c = mydate,
                                            DecisionDate__c = mydate,
                                            ParticipantType__c = 'Consultant',
                                            TECH_ReconnexionTarget__c = false));
            }
            insert offerList2;
        }         
        Test.startTest();
        BA01_Offer uca = new BA01_Offer();
        Id batchId = Database.executeBatch(uca);
        Test.stopTest();
        user bypassValidation2 = [SELECT Id, Email, ByPassValidationRule__c FROM 
                                  User WHERE Id=:us.Id LIMIT 1];
        
        
        bypassValidation2.ByPassValidationRule__c = false;
        // update bypassValidation2; 
    }
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 17/9/2018
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/   
    Public static void testAccountManagerShrOffer() {  
        
        date mydate = date.parse('05/11/2018');
        
        List<CurrencyType> currencyTpyeList = [select id,IsoCode,ConversionRate from CurrencyType];
        
        User us = [Select id, ByPassValidationRule__c,MultiPicklistDivision__c, Email, Division from User where Id = :UserInfo.getUserId()];
        String targetOffer = Label.CL00005;
        System.runAs(us){
            RecordType recordNameTarget = [SELECT Id, DeveloperName 
                                           FROM RecordType 
                                           WHERE SObjectType = 'Target__c'
                                           AND DeveloperName =:targetOffer]; 
            
            Id recordTypeTargetId = recordNameTarget.Id;  
            
            if(us.Division == null){
                us.Division = 'None';
            }
            if(us.MultiPicklistDivision__c == null){
                us.MultiPicklistDivision__c = 'Calderys';
            }       
            
            us.ByPassValidationRule__c = true;
            
            update us;   
            
            List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User WHERE IsActive = true 
                                AND ByPassTriggerRule__c = false];
            
            List<Account> accountsList = new List<Account>();
            List<Offer__c> offerList = new List<Offer__c>();
            List<Offer__c> offerList2 = new List<Offer__c>();
            List<Target__c> targetList = new List<Target__c>();
            // insert 10 accounts
            for (Integer i=0;i<10;i++) {
                accountsList.add(new Account(name='Account '+i, 
                                             billingcity='New York', billingcountry='United States',
                                             SegmentL1__c = 'Abrasive',
                                             Type = 'Head Office',
                                             DnBNumber__c='zzz'+i));
            }
            insert accountsList;
            
            for(Account account : accountsList) {
                targetList.add(new Target__c(Account__c=account.Id, recordTypeId = recordTypeTargetId, CurrencyIsoCode =currencyTpyeList[0].IsoCode,
                                             TotalValueDirectSale__c=0, TotalValueProjectOffer__c =0,Sales__c=users[0].Id));
            }
            insert targetList;
            system.debug('target' + targetList);
            
            String projectSalesOffer = Label.CL00007;       
            String directSalesOffer = Label.CL00006;
            
            RecordType recordProjectSales = [SELECT Id, DeveloperName 
                                             FROM RecordType 
                                             WHERE SObjectType = 'Offer__c'
                                             AND DeveloperName =:projectSalesOffer]; // record type project sales offer
            
            Id recordTypeProjectSalesId = recordProjectSales.Id;    
            
            RecordType recordDirectSales = [SELECT Id, DeveloperName 
                                            FROM RecordType 
                                            WHERE SObjectType = 'Offer__c'
                                            AND DeveloperName =:directSalesOffer]; // record type direct sales offer
            
            Id recordTypeDirectSalesId = recordDirectSales.Id;      
            // find the account just inserted. add contact for each
            for (Account account : accountsList) {
                offerList.add(new Offer__c(Account__c = account.Id,
                                           //visit.contact__c =  con.Id;
                                           recordTypeId = recordTypeDirectSalesId,
                                           OfferStatus__c = 'Won',
                                           WonLostReason__c =  'Delivery Time',
                                           OurProbability__c = 23,
                                           ProbabilityofCustomer__c = 45,
                                           TotalValue__c = 200,
                                           CurrencyIsoCode = currencyTpyeList[1].IsoCode,
                                           GrossMargin__c = 12,
                                           OfferDate__c = myDate,
                                           DecisionDate__c = mydate,
                                           ParticipantType__c = 'Consultant',
                                           TECH_ReconnexionTarget__c = false));
            }
            insert offerList;
            system.debug('offer' + offerList);
            
            for(Account account : accountsList) {
                offerList2.add(new Offer__c(Account__c = account.Id,
                                            //visit.contact__c =  con.Id;
                                            recordTypeId = recordTypeProjectSalesId,
                                            OfferStatus__c = 'Won',
                                            WonLostReason__c =  'Delivery Time',
                                            OurProbability__c = 23,
                                            ProbabilityofCustomer__c = 45,
                                            TotalValue__c = 200,
                                            GrossMargin__c = 12,
                                            CurrencyIsoCode = currencyTpyeList[1].IsoCode,
                                            OfferDate__c = mydate,
                                            DecisionDate__c = mydate,
                                            ParticipantType__c = 'Consultant',
                                            TECH_ReconnexionTarget__c = false));
            }
            insert offerList2;
            update offerList2;          
            
            user bypassValidation2 = [SELECT Id, Email, ByPassValidationRule__c FROM 
                                      User WHERE Id=:us.Id LIMIT 1];
                        
            bypassValidation2.ByPassValidationRule__c = false;
            //update bypassValidation2; 
        }
        
    }
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 17/9/2018
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/   
    Public static void testInsertproductEntries(){  
        
        User us = [Select id, ByPassValidationRule__c,MultiPicklistDivision__c, Email, Division from User where Id = :UserInfo.getUserId()];
        
        system.runAs(us){
            
            // List<CurrencyType> currencyTypeList = [select id,IsoCode,ConversionRate from CurrencyType];
            
            // Product2 p = new Product2();
            // p.Name = 'Test Product';
            // p.Description = 'Test desc';
            // p.CurrencyISOCode = currencyTypeList[0].IsoCode;
            // p.IsActive = true;
            // insert p;                                    
            
            // //standard price book entry for Product p
            // PricebookEntry pbe1 = new PricebookEntry();
            // pbe1.Pricebook2Id = Test.getStandardPricebookId();
            // pbe1.IsActive = true;
            // pbe1.Product2Id = p.Id;
            // pbe1.UseStandardPrice = false;
            // pbe1.CurrencyISOCode = currencyTypeList[0].IsoCode;
            // pbe1.UnitPrice = 1;                                                       
            // insert pbe1;                      
            
            // //custom pricebook
            // PriceBook2 pb = new PriceBook2();
            // pb.Name = 'Custom PB';
            // pb.IsActive = true;            
            // insert pb;           
            
            // //custom pricebook entry for p1
            // PricebookEntry pbe = new PricebookEntry();
            // pbe.Pricebook2Id = pb.Id;
            // pbe.IsActive = true;
            // pbe.Product2Id = p.Id;
            // pbe.UseStandardPrice = false;
            // pbe.CurrencyISOCode = currencyTypeList[0].IsoCode;
            // pbe.UnitPrice = 1;                                                       
            // insert pbe; 
            
            //update Pricebookentry to use Standard Price
            //pbe.UseStandardPrice = true;
            //update pbe;
            
            // First, set up test price book entries.
            // Insert a test product.
            Product2 prod = new Product2(Name = 'Laptop X200', 
                                         Family = 'Hardware');
            insert prod;
            
            // Get standard price book ID.
            // This is available irrespective of the state of SeeAllData.
            Id pricebookId = Test.getStandardPricebookId();
            
            // 1. Insert a price book entry for the standard price book.
            // Standard price book entries require the standard price book ID we got earlier.
            PricebookEntry standardPrice = new PricebookEntry(
                Pricebook2Id = pricebookId, Product2Id = prod.Id,
                UnitPrice = 10000, IsActive = true);
            insert standardPrice;
            
            // Create a custom price book
            Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
            insert customPB;
            
            // 2. Insert a price book entry with a custom price.
            PricebookEntry customPrice = new PricebookEntry(
                Pricebook2Id = customPB.Id, Product2Id = prod.Id,
                UnitPrice = 12000, IsActive = true);
            insert customPrice;
            
            // Next, perform some tests with your test price book entries.
            
        }
        
    }
    
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 6/11/2018
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/   
    Public static void testAssignToPermissionSet() {  
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        
        User us = [Select id, ByPassValidationRule__c,
                   Division from User where IsActive =true
                   AND profile.Id =: p2.Id limit 1];
        
        String permissionSet = Label.CL00010;
        String permissionSet2 = Label.CL00024;
        String divisionCalderys = Label.CL00011;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        
        system.runAs(us){
            
            User u = new User(Alias = 'standt', Email='standarduser@testorg.com',
                              EmailEncodingKey='UTF-8', LastName='Testingzzzzzzzzzzzzzzzzzzzzzzzzzzzgyt', LanguageLocaleKey='en_US',FederationIdentifier = 'test@gmail.com',
                              LocaleSidKey='en_US', ProfileId = p.Id, division ='Calderys', NewBusinessArea__c='HTS', CountryforGatekeeper__c ='France',
                              TimeZoneSidKey='America/Los_Angeles', UserName='testCaldzzzeryspermissionsetuser@testorg.com');
            insert u;
            
            User u2 = new User(Alias = 'standts', Email='standarduserz@testorg.com',
                               EmailEncodingKey='UTF-8', LastName='Testingzzzzzzzzzzzzzzzzzzzzzzzzzzzgyt', LanguageLocaleKey='en_US',FederationIdentifier = 'testkl@gmail.com',
                               LocaleSidKey='en_US', ProfileId = p.Id, division ='Calderys', CountryforGatekeeper__c ='France',
                               TimeZoneSidKey='America/Los_Angeles', NewBusinessArea__c='HTS', UserName='testCaldzzzeryrrrspermissionsetuser@testorg.com');
            insert u2;
            update u;
            
        }
        
        
    }
    
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 16/11/2018
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/   
    //Verify deactivate User
    public static void testDeactivateUser() {
        
        Map<Id, User> usersToDeactivateMap = new Map<Id,User>([SELECT Id from User WHERE
                                                               IsActive=true AND Profile.Name <> 'System Administrator'
                                                               AND LastLoginDate<:System.now().addDays(-90)]); // all active users
        
        Map<Id,User> usersBack = new Map<Id,User>([SELECT id, BackupComplaint__c, BackupSample__c, Isactive from user WHERE 
                                                   BackupSample__c IN: usersToDeactivateMap.keyset() or BackupComplaint__c IN:usersToDeactivateMap.keyset()]);
        
        for(User u : usersBack.values()){
            u.BackupComplaint__c=null; 
            u.BackupSample__c = null;           
        }
        
        update usersBack.values();
        
        Test.startTest();          
        
        for(User u2 : usersToDeactivateMap.values()){
            u2.IsActive=false;         
        }
        
        //update usersToDeactivateMap.values();
        
        Test.stopTest();
        
        //BA01_User u = new BA01_User();
        //Id batchId = Database.executeBatch(u);
    }
    
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 7/11/2019
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/   
    public static void testinsertCurrency(){
        
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        
        User us = [Select id, ByPassValidationRule__c,
                   Division from User where IsActive =true
                   AND profile.Id =: p2.Id limit 1];    
        
        us.ByPassValidationRule__c =true;
        update us;
        system.runas(us){
            
            Account acc2 = new Account();
            acc2.Name = 'testDev5';
            acc2.BillingCountry = 'United States';
            acc2.BillingCity = 'New York';
            acc2.SegmentL1__c = 'Abrasive';
            acc2.Type = 'Head Office';
            
            Database.insert(acc2, true);    
            
            Contact con2 = new Contact();
            con2.Salutation = 'Mr.';
            con2.FirstName = 'TestDev5';
            con2.LastName= 'SMITH';
            con2.Email = 'test@accenture.com.com';
            con2.AccountId = acc2.Id;
            
            Database.insert(con2, true);
        }
        
    }
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 7/11/2019
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/   
    public static void testVerifyProductRelated(){
        
        date mydate = date.parse('05/11/2012');
        date mydate1 = date.parse('05/11/2017');
        date mydate2 = date.parse('08/12/2022');
        Id recSample;
        Id recComplaint;
        Id recConsumption;
        
        
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        
        List<User> users = [SELECT Id, BackupComplaint__c FROM User WHERE IsActive = true
                            AND ByPassTriggerRule__c = false AND
                            profile.Id =:p2.Id LIMIT 100]; 
        users[0].ByPassValidationRule__c =true;
        update users[0];
        
        system.runas(users[0]){
            
            Account acc1 = new Account();
            acc1.Name = 'sdsdasassd1dsdsdd';
            acc1.BillingCountry = 'United States';
            acc1.BillingCity = 'New York';
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
            
            Database.insert(p, true);
            
            RecordType recordName = [SELECT Id, DeveloperName 
                                     FROM RecordType 
                                     WHERE SObjectType = 'Case'
                                     AND DeveloperName = 'CSE_Complaint'];
            
            recSample = recordName.Id;
            
            
            Case cas = New Case();
            cas.AccountId= acc1.Id;
            cas.RecordTypeId = recSample;
            cas.ContactId = con.Id;
            cas.divisions__c = 'Calderys';
            cas.Status = 'Draft Creation';
            cas.Type = 'Contamination';
            cas.csAccountManager__c = users[4].id;
            cas.Receiver__c = users[4].id;
            cas.ProductName__c = p.Id;
            cas.GateKeeper__c = users[2].id;
            cas.DateRaisedCustomer__c = myDate; 
            cas.OwnerId = users[2].Id;   
            cas.Description = 'Test';
            cas.Subject = 'Case'; 
            Database.Insert(cas, true);
            
            RecordType recordTypeName = [SELECT Id, DeveloperName 
                                         FROM RecordType 
                                         WHERE SObjectType = 'Sample__c'
                                         AND DeveloperName = 'SAM_SampleWithoutOpportunity'];  // record type samplewithoutopp
            
            recComplaint = recordTypeName.Id;
            
            Sample__c sam = New Sample__c();
            sam.AccountName__c = acc1.Id;
            sam.RecordTypeId = recComplaint;
            sam.RecipientName__c = con.Id;
            sam.Status__c = 'Draft Creation';
            sam.Type__c = 'Lab';
            sam.CSAccountManager__c = users[3].Id;
            sam.ExpectedDeliveryDate__c = mydate2;
            sam.ProductName__c = p.Id;
            sam.Volume__c = 1233;
            sam.OwnerId = users[2].Id;
            //sam.Unit__c = 'Metric tons (as sold)';
            sam.GateKeeper__c = users[2].Id;
            sam.OutOfOffice__c = true;
            sam.DateOfFeedback__c = mydate1;
            sam.DispatchSite__c ='FR - Iko';
            //Database.Insert(sam, true);// insert new record with status Draft Creation
            
            RecordType recordNameCon = [SELECT Id 
                                        FROM RecordType 
                                        WHERE SObjectType = 'Consumption__c'
                                        AND DeveloperName = 'CON_CompetitorConsumption'];
            
            recConsumption =recordNameCon.Id;
            
            Consumption__c cons = new Consumption__c();
            cons.RecordTypeId = recConsumption;
            cons.CompetitorProductName__c = 'xxcxc';
            //cons.ProductName__c = p.Id;
            cons.CustomerName__c = acc1.Id;
            cons.Year__c = '2018';
            cons.InvoicingDivision__c = 'Ceramics';
            
            insert cons;
            
            
            try
                
            {
                Test.StartTest();           
                delete p;
                Test.StopTest();
                
            }
            catch(Exception e){
                
                System.assert(e.getMessage().contains('Delete failed.'));
                System.assert(e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION'));
                System.assert(e.getMessage().contains(Label.CL00027));
                
            }   
        }
        
    }
    
    /*
*@author Govind
*@Date Creation 9/17/2019
*@Date modification 
*@param 
*@ExceptionName
*@return 
*/
    // test getOpp apex method
    public static void testGetOpp(){
        
        User user = [SELECT Id, ByPassValidationRule__c,MultiPicklistDivision__c, Email, Division 
                     FROM User 
                     WHERE Id = :UserInfo.getUserId()];
        
        system.runAs(user){
            Date myDate = Date.newInstance(2050, 2, 17);
            Date oppCloseDate = Date.newInstance(2050, 11, 17);
            
            Account accTest = new Account();
            accTest.Name = 'test account';
            accTest.BillingCountry = 'United States';
            accTest.BillingCity = 'New York';
            insert accTest;
            
            Opportunity oppTest = new Opportunity();
            oppTest.Name = 'test opportunity';
            oppTest.AccountId = accTest.Id;
            oppTest.StageName = 'Identify Opportunity';
            oppTest.Probability = 10;
            oppTest.Type = 'Imerys Cannibalization - Own Division';
            oppTest.Amount = 100;
            oppTest.CloseDate = myDate;
            oppTest.Division__c = 'Aluminates';
            oppTest.CloseDate = oppCloseDate;
            oppTest.Unit__c = 'Cubic Meter';
            oppTest.OpportunityReference__c = 'asas';
            insert oppTest;
            
            
            test.startTest();
            
            List<Opportunity> oppList = [select Id, AccountId, Name, StageName, Amount, CloseDate
                                         From opportunity where Name = 'test opportunity' LIMIT 1];
            
            
            
            List<Account> accList = [select id, Name from Account where Name = 'test account' LIMIT 1];
            
            system.debug('opp in test' + oppList);
            
            List<Opportunity> returnedOppList =  AP02_RelatedListController.getOpp(accList[0].Id);
            
            system.assert(!returnedOppList.isEmpty());
            system.assertEquals(oppList[0].Name, returnedOppList[0].Name);
            
            test.stopTest();
        }
    }
    /*
*@author Govind
*@Date Creation 9/17/2019
*@Date modification 
*@param 
*@ExceptionName
*@return 
*/
    public static void testGetVisited(){
        
        User user = [SELECT Id, ByPassValidationRule__c,MultiPicklistDivision__c, Email, Division 
                     FROM User 
                     WHERE Id = :UserInfo.getUserId()];
        
        system.runAs(user){
            Date myDate = Date.newInstance(2019, 2, 17);
            Date oppCloseDate = Date.newInstance(2019, 11, 17);
            
            Account accTest = new Account();
            accTest.Name = 'test account';
            accTest.BillingCountry = 'United States';
            accTest.BillingCity = 'New York';
            insert accTest;
            
            VisitReport__c visitTest = new VisitReport__c();
            visitTest.Account__c = accTest.Id;
            visitTest.MainObjectivesoftheMeeting__c = 'Technical Service';
            visitTest.DateofVisit__c = myDate;
            visitTest.ProductType1__c = 'Merchandise';
            
            insert visitTest;
            
            test.startTest();
            
            List<Account> accList = [select id, Name from Account where Name = 'test account' LIMIT 1];
            
            List<VisitReport__c> visitList = [select Id, Account__c, Name, MainObjectivesoftheMeeting__c, DateofVisit__c, ProductType1__c
                                              From VisitReport__c where Account__c =: accList[0].id ];
            
            List<VisitReport__c> returnedVisitList =  AP02_RelatedListController.getVisit(accList[0].Id);
            
            system.assert(!returnedVisitList.isEmpty());
            system.assert(!accList.isEmpty());
            system.assertEquals(visitList[0].Name, returnedVisitList[0].Name);
            
            
            test.stopTest();
            
        }
    }
    
    /*
*@author Govind
*@Date Creation 9/11/2019
*@Date modification 
*@param 
*@ExceptionName
*@return 
*/
    
    public static void testGetSamples(){
        
        User user = [SELECT Id, ByPassValidationRule__c,MultiPicklistDivision__c, Email, Division 
                     FROM User 
                     WHERE Id = :UserInfo.getUserId()];
        
        system.runAs(user){
            
            List <Account> accounts = new List <Account>();
            
            for(Integer j=0; j<10; j++){
                Account acct = new Account(Name='Test Account urv' + j,
                                           BillingCity='New York',
                                           BillingCountry='United States');
                accounts.add(acct);                
            }
            
            insert accounts;
            
            List <contact> contacts = new List <contact>();
            
            for(Integer k=0; k<10; k++){
                Contact con = new Contact(FirstName='Urv' + k,
                                          LastName='TESTURV',
                                          AccountId=accounts[k].Id,
                                          JobDepartment__c= 'Corporate',
                                          Phone = '+12345678');
                
                contacts.add(con);
            }
            insert contacts;
            
            String[] values = new String[]{};
                String[] types = new String[]{'product2'};
                    Schema.DescribeSobjectResult[] results = Schema.describeSObjects(types);
            for(Schema.DescribeSobjectResult res : results) {
                for (Schema.PicklistEntry entry : res.fields.getMap().get('ManufacturingImerysPlant__c').getDescribe().getPicklistValues()) {
                    if (entry.isActive()) {values.add(entry.getValue());}
                }
            }
            
            List <product2> products = new List <product2>();
            
            for(Integer m=0; m<10; m++){
                product2 prod = new product2(Name=('test' + m), 
                                             ProductType1__c='Projects',
                                             Division__c='Aluminates',
                                             IsActive = true,
                                             TECH_ProductType2__c = 'Bricks',
                                             ManufacturingImerysPlant__c = values[6]); 
                products.add(prod);
            }
            insert products;
            
            List<User> accManager = [SELECT Id, Profile.Name FROM User WHERE Profile.Name = : 'System Administrator']; 
            
            List <Sample__c> sampleList = new List <Sample__c>();
            
            for(Integer i=0; i<10; i++){
                Sample__c sam = new Sample__c(AccountName__c = accounts[i].Id,
                                              RecipientName__c = contacts[i].Id, 
                                              Status__c = 'Customer Evaluation',
                                              Type__c = 'Lab',
                                              CSAccountManager__c = accManager[4].Id,
                                              ExpectedDeliveryDate__c = Date.newInstance(2019,12,31),
                                              ProductName__c = products[i].Id,
                                              ProductForm__c = 'Cake',
                                              Volume__c = (10 + i),
                                              Unit__c = 'Grams',
                                              DispatchSite__c = 'AR - Ledesma', 
                                              CostChargedToCustomer__c = 'Transport',
                                              Incoterm__c = 'Collected',
                                              RequiredDocumentation__c = 'COA',
                                              Packaging__c = 'Bag',
                                              DateSent__c = Date.newInstance(2019,07,31),
                                              LogisticsCharge__c = 1000,
                                              ProductCharge__c = 1000,
                                              ResultOfSampleEvaluation__c = 'Not provided',
                                              Approved__c = 'yes',
                                              DeliveryAddress__c = 'Ebene');
                sampleList.add(sam);
                
            }
            insert sampleList;
            
            List <case> caseList= new List <case>();
            
            for(Integer n=0; n<10; n++){
                Case complaint = new Case(AccountId = accounts[n].Id,
                                          ContactId = contacts[n].Id,
                                          Divisions__c = 'Aluminates',
                                          CSAccountManager__c = accManager[4].Id,
                                          Type = 'External',
                                          Receiver__c = accManager[3].Id,
                                          DateRaisedCustomer__c = Date.newInstance(2019,02,31),
                                          Subject = 'Test subject',
                                          Description__c = 'Test description',
                                          ProductName__c = products[n].Id);
                caseList.add(complaint);
            }
            insert caseList;
            
            test.startTest();
            AP01_SampleController.AccountWrapper samples = AP01_SampleController.getSamples(accounts[1].Id);
            System.assert(!samples.sampleList.isEmpty());
            System.assertEquals(1, samples.sampleList.size());
            System.assertEquals(1, samples.noOfRecords);
            
            AP01_SampleController.AccountWrapper complaints = AP01_SampleController.getComplaints(accounts[2].Id);
            System.assert(!complaints.complaintsList.isEmpty());
            System.assertEquals(1, complaints.complaintsList.size());
            System.assertEquals(1, complaints.noOfComplaints);
            
            List <RecordType> recordTypes = AP01_SampleController.getRecordType('Case');
            System.assertEquals('Complaint', recordTypes[0].Name);
            test.stopTest();
        }
        
    }
    
    /**
*@author Geerutsing Govind Kumar
*@Date Draft Creation 12/6/2019
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/      
    public static void testCreateTeamTech(){
        // Select users for the test.
        
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
            
            TechnicalAssistanceRequest__c tech = new TechnicalAssistanceRequest__c();
            tech.Account__c = acc1.Id;
            tech.Division__c = 'Ceramics';
            tech.BusinessObjectiveandStakes__c= 'test';
            tech.Status__c = 'Closed';
            //tech.Approver__c = usersActive[2].Id;
            tech.Requester__c = user2Id;
            tech.Market_Segmentation__c = markSeg.Id;
            insert tech;
            
            TechnicalAssistanceRequestTeam__c team = new TechnicalAssistanceRequestTeam__c();
            team.Member__c = user1Id;
            team.Role__c = 'Front Office';
            team.TechnicalAssistanceRequestNo__c = tech.Id;
            
            Test.startTest();           
            Database.Insert(team, true);
            Test.stopTest();
            
            Database.update(team,true);
            
            Database.delete(team,true);
            
            // Insert manual share for user who is not record owner. 
            // Query visit report records.
            List<TechnicalAssistanceRequest__Share> techShrs = [SELECT Id, UserOrGroupId, AccessLevel, 
                                                                RowCause FROM TechnicalAssistanceRequest__Share WHERE ParentId =: tech.Id AND UserOrGroupId= :user2Id];
            
            // Test attributes of manual share.
            if(techShrs.size() > 0){
                System.assertEquals(techShrs[0].AccessLevel, 'Edit');
                System.assertEquals(techShrs[0].UserOrGroupId, user2Id);
            }
            
        }              
    }
    /**
*@author Geerutsing Govind Kumar
*@Date Draft Creation 12/6/2019
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/      
    public static void testContentDocumentTAR(){
        // Select users for the test.
        
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
            
            TechnicalAssistanceRequest__c tech = new TechnicalAssistanceRequest__c();
            tech.Account__c = acc1.Id;
            tech.Division__c = 'Ceramics';
            tech.BusinessObjectiveandStakes__c= 'test';
            tech.Status__c = 'Closed';
            //tech.Approver__c = usersActive[2].Id;
            tech.Requester__c = user2Id;
            tech.Market_Segmentation__c = markSeg.Id;
            insert tech;
            
            TechnicalAssistanceRequestTeam__c team = new TechnicalAssistanceRequestTeam__c();
            team.Member__c = user1Id;
            team.Role__c = 'Front Office';
            team.TechnicalAssistanceRequestNo__c = tech.Id;
            Database.Insert(team, true);
            
            Product2 p = new product2();
            p.Name = 'kjskd';
            p.ManufacturingImerysPlant__c = '';
            p.IsActive = true;
            p.Division__c = 'Calderys';
            
            Database.insert(p, true);
            
            ERPCode__c erp = new ERPCode__c();
            erp.Account__c = acc1.Id;
            erp.BusinessArea__c = 'RAC';
            
            Database.insert(erp,true);
            
            //Create Document
            ContentVersion contentVersion = new ContentVersion(
                Title = Label.CL00044,
                PathOnClient = 'Penguins.jpg',
                VersionData = Blob.valueOf('Test Content'),
                IsMajorVersion = true
            );
            
            insert contentVersion;    
            
            List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
            
            ContentDocumentLink contentlink=new ContentDocumentLink();
            contentlink.LinkedEntityId=tech.id;               
            contentlink.ContentDocumentId=documents[0].Id;
            contentlink.Visibility = 'AllUsers'; 
            contentlink.ShareType ='V';
            
            insert contentlink;
            
            ContentDocumentLink contentlink2=new ContentDocumentLink();
            contentlink2.LinkedEntityId=p.id;               
            contentlink2.ContentDocumentId=documents[0].Id;
            contentlink2.Visibility = 'AllUsers'; 
            contentlink2.ShareType ='V';
            insert contentlink2;
            
            ContentDocumentLink contentlink3=new ContentDocumentLink();
            contentlink3.LinkedEntityId=erp.id;               
            contentlink3.ContentDocumentId=documents[0].Id;
            contentlink3.Visibility = 'AllUsers'; 
            contentlink3.ShareType ='V';
            insert contentlink3;
            
            delete documents;
            
            System.assertEquals(documents.size(), 1);
            
            
        }              
    }
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 2/3/2020
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/   
    //Verify deactivate User
    public static void testDeactivateUser03() {
        
        Map<Id, User> usersToDeactivateMap = new Map<Id,User>([SELECT Id from User WHERE
                                                               IsActive=true AND Profile.Name <> 'System Administrator'
                                                               AND LastLoginDate<:System.now().addDays(-90)]); // all active users
        
        Map<Id,User> usersBack = new Map<Id,User>([SELECT id, BackupComplaint__c, BackupSample__c, Isactive from user WHERE 
                                                   BackupSample__c IN: usersToDeactivateMap.keyset() or BackupComplaint__c IN:usersToDeactivateMap.keyset()]);
        
        for(User u : usersBack.values()){
            u.BackupComplaint__c=null; 
            u.BackupSample__c = null;           
        }
        
        update usersBack.values();
        
        
        for(User u2 : usersToDeactivateMap.values()){
            u2.IsActive=false;         
        }
        
        //update usersToDeactivateMap.values();
        
        Test.startTest();    
        BA03_User u = new BA03_User();
        Id batchId = Database.executeBatch(u);
        System.abortJob(batchId);
        Test.stopTest();
    }
    /**
*@author Geerusting Govind Kumar
*@Date Draft Creation 3/16/2018
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/
    Public static void testIncrementOppNumber(){
        
        List<Profile> lstAdminPro = [SELECT Id From Profile 
                                     WHERE Name = 'System Administrator' limit 1];
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User 
                            WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false 
                            AND ProfileId =: lstAdminPro[0].Id LIMIT 1];
        
        users[0].ByPassValidationRule__c =true;
        users[0].ByPassProcessBuilders__c = true;
        update users[0];
        
        system.RunAs(users[0]){
            
            Account accTest= new Account();
            accTest.Name = 'VRTEST';
            accTest.BillingCountry = 'United States';
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
            
            Product2 prod = new Product2(Name = 'Laptop X200', 
                                         Family = 'Hardware');
            insert prod;
            
            // Get standard price book ID.
            // This is available irrespective of the state of SeeAllData.
            
            
            Id pricebookId = Test.getStandardPricebookId();
            
            //Id pricebookId = '01s580000049ATNAA2';
            
            // 1. Insert a price book entry for the standard price book.
            //Standard price book entries require the standard price book ID we got earlier.
            PricebookEntry standardPrice = new PricebookEntry(
                Pricebook2Id = pricebookId, Product2Id = prod.Id,
                UnitPrice = 10000, IsActive = true);
            insert standardPrice;
            
            
            opportunity o = new opportunity();
            o.name = 'Pizza King Oppty';
            o.AccountId = accTest.Id;
            o.CloseDate = system.today();
            o.StageName = 'New';
            o.Probability = 20;
            o.Division__c = 'Ceramics';
            O.CurrencyIsoCode ='EUR';
            o.Pricebook2Id = pricebookId;
            insert o;
            
            system.debug('======Opportunity===========' + [select id, CurrencyIsoCode from Opportunity Where id=: o.Id]);
            
            OpportunityLineItem oli = new OpportunityLineItem(PricebookEntryId=standardPrice.Id, Packaging__c ='Bag', opportunityid = o.id, Quantity = 2,unitprice=1.5);
            
            Test.startTest();    
            insert oli;
            update oli;
            Test.stopTest();
        } 
        
    }
    /**
*@author Geerutsing Govind Kumar
*@Date Draft Creation 24/02/2020
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/          
    public static void testCreateCorrectActionShare(){
        // Select users for the test.
        String RecordTypeName;
        String RecordTypeRemark;
        date mydate = date.parse('05/11/2017');
        
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        
        List<User> users = [SELECT Id, email, ByPassTriggerRule__c FROM User WHERE IsActive = true AND
                            ByPassTriggerRule__c = false 
                            AND profile.Id =: p2.Id LIMIT 100];
        
        Id user1Id = users[0].Id;
        Id user2Id = users[1].Id;
        Id user3Id = users[2].Id;
        
        user bypassValidation = [SELECT Id, Email, ByPassValidationRule__c, MultiPicklistDivision__c, Division FROM 
                                 User WHERE Id=:users[0].Id LIMIT 1];
        
        if(bypassValidation.Division == null){
            bypassValidation.Division = 'None';
        }
        if(bypassValidation.MultiPicklistDivision__c == null){
            bypassValidation.MultiPicklistDivision__c = 'Ceramics';
        }       
        bypassValidation.ByPassValidationRule__c = true;
        bypassValidation.ByPassTriggerRule__c = true;
        bypassValidation.CountryforGatekeeper__c = 'Albania';
        bypassValidation.BackupComplaint__c = users[3].Id;
        
        update bypassValidation;        
        
        users[0].ByPassValidationRule__c =true;
        update users[0];
        
        system.runas(users[0]){
            Account acc1 = new Account();
            acc1.Name = 'sdsdasassd1dsdsdd';
            acc1.BillingCountry = 'United States';
            acc1.BillingCity = 'New York';
            acc1.SegmentL1__c = 'Abrasive';
            acc1.Type = 'Head Office';
            Database.insert(acc1, true);    
            
            Contact con = new Contact();
            con.Salutation = 'Mr.';
            con.FirstName = 'SHIA';
            con.Email = 'test@accenture.com.com';
            con.LastName= 'Alisha';
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
            cas.CSAccountManager__c = users[5].id;
            cas.Receiver__c = users[4].id;
            cas.ProductName__c = p.Id;
            cas.DateRaisedCustomer__c = myDate; 
            cas.OwnerId = user3Id;
            cas.Description = 'Test';
            cas.BusinessArea__c = 'HTS';
            cas.Subject = 'Case'; 
            Database.Insert(cas, true);// insert new record with status Draft Creation 
            
            CorrectiveAction__c cv = new CorrectiveAction__c();
            cv.RelatedComplaint__c = cas.Id;
            cv.Status__c ='Open';
            cv.DueDate__c = mydate;
            cv.Description__c = 'Test';
            cv.ResponsiblePerson1__c = users[8].email;
            cv.Responsible_Person_2_User__c= users[9].Id;
            cv.ResponsiblePerson3__c = users[7].email;
            cv.Responsible_Person_4_User__c = users[4].Id;
            
            Test.StartTest();
            Database.Insert(cv, true);
            Test.StopTest();
            
            update cv;
            delete cv;
            
            // Query case share records.
            CaseShare[] caseShrs = [SELECT Id, UserOrGroupId, CaseAccessLevel, 
                                    RowCause 
                                    FROM Caseshare 
                                    WHERE CaseId = :cas.Id
                                    AND UserorGroupId =: users[8].id
                                    AND UserorGroupId =: users[7].id
                                    AND UserorGroupId =: users[4].id
                                    AND CaseAccessLevel =: 'Edit'];
            
            // Test attributes of manual share.
            if(caseShrs.size() > 0) {
                System.assertEquals(caseShrs[0].CaseAccessLevel, 'Edit');
                System.assertEquals(caseShrs[0].UserOrGroupId, users[4].id);
            }                       
        }     
    }
    /**
*@author Geerutsing Govind Kumar
*@Date Draft Creation 24/02/2020
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/          
    public static void testCaseWorkRequestShare(){
        // Select users for the test.
        String RecordTypeName;
        String RecordTypeRemark;
        date mydate = date.parse('05/11/2017');
        
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        
        List<User> users = [SELECT Id, email, ByPassTriggerRule__c FROM User WHERE IsActive = true AND
                            ByPassTriggerRule__c = false 
                            AND profile.Id =: p2.Id LIMIT 100];
        
        Id user1Id = users[0].Id;
        Id user2Id = users[1].Id;
        Id user3Id = users[2].Id;
        
        user bypassValidation = [SELECT Id, Email, ByPassValidationRule__c, MultiPicklistDivision__c, Division FROM 
                                 User WHERE Id=:users[0].Id LIMIT 1];
        
        if(bypassValidation.Division == null){
            bypassValidation.Division = 'None';
        }
        if(bypassValidation.MultiPicklistDivision__c == null){
            bypassValidation.MultiPicklistDivision__c = 'Ceramics';
        }       
        bypassValidation.ByPassValidationRule__c = true;
        bypassValidation.ByPassTriggerRule__c = true;
        bypassValidation.CountryforGatekeeper__c = 'Albania';
        bypassValidation.BackupComplaint__c = users[3].Id;
        
        update bypassValidation;        
        
        users[0].ByPassValidationRule__c =true;
        update users[0];
        
        system.runas(users[0]){
            Account acc1 = new Account();
            acc1.Name = 'sdsdasassd1dsdsdd';
            acc1.BillingCountry = 'United States';
            acc1.BillingCity = 'New York';
            acc1.SegmentL1__c = 'Abrasive';
            acc1.Type = 'Head Office';
            Database.insert(acc1, true);    
            
            Contact con = new Contact();
            con.Salutation = 'Mr.';
            con.FirstName = 'SHIA';
            con.Email = 'test@accenture.com.com';
            con.LastName= 'Alisha';
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
            cas.CSAccountManager__c = users[5].id;
            cas.Receiver__c = users[4].id;
            cas.ProductName__c = p.Id;
            cas.DateRaisedCustomer__c = myDate; 
            cas.OwnerId = user3Id;
            cas.Description = 'Test';
            cas.BusinessArea__c = 'HTS';
            cas.Subject = 'Case'; 
            Database.Insert(cas, true);// insert new record with status Draft Creation 
            
            ComplaintWorkRequest__c cv = new ComplaintWorkRequest__c();
            cv.RelatedComplaint__c = cas.Id;
            cv.Status__c ='Open';
            cv.DueDate__c = mydate;
            cv.Description__c = 'Test';
            cv.ResponsiblePerson1__c = users[8].email;
            cv.ResponsiblePerson2__c= users[9].email;
            cv.ResponsiblePerson3__c = users[7].email;
            cv.ResponsiblePerson4__c = users[4].email;
            
            Test.StartTest();
            Database.Insert(cv, true);
            Test.StopTest();
            
            update cv;
            delete cv;
            
            // Query case share records.
            CaseShare[] caseShrs = [SELECT Id, UserOrGroupId, CaseAccessLevel, 
                                    RowCause 
                                    FROM Caseshare 
                                    WHERE CaseId = :cas.Id
                                    AND UserorGroupId =: users[8].id
                                    AND UserorGroupId =: users[7].id
                                    AND UserorGroupId =: users[4].id
                                    AND CaseAccessLevel =: 'Edit'];
            
            // Test attributes of manual share.
            if(caseShrs.size() > 0) {
                System.assertEquals(caseShrs[0].CaseAccessLevel, 'Edit');
                System.assertEquals(caseShrs[0].UserOrGroupId, users[4].id);
            }                       
        }     
    }                                                                                                           
    /**
*@author Geerusting Govind Kumar
*@Date Draft Creation 12/5/2020
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/
    Public static void testInsertSalesData(){
        
        List<Profile> lstAdminPro = [SELECT Id From Profile 
                                     WHERE Name = 'System Administrator' limit 1];
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c, Email, Name FROM User 
                            WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false 
                            AND ProfileId =: lstAdminPro[0].Id LIMIT 1];
        
        users[0].ByPassValidationRule__c =true;
        update users[0];
        
        system.RunAs(users[0]){
            
            Account accTest= new Account();
            accTest.Name = 'VRTEST';
            accTest.BillingCountry = 'United States';
            accTest.BillingCity = 'New York';
            accTest.BillingStreet='Test';
            accTest.SegmentL1__c = 'Abrasive';
            accTest.DnBNumber__c = '01256hhj';
            accTest.Type = 'Head Office';
            Database.insert(accTest, true);
            
            String objectName = 'Product2';
            String fieldName ='ManufacturingImerysPlant__c';
            
            Schema.SObjectType s = Schema.getGlobalDescribe().get(objectName) ;
            Schema.DescribeSObjectResult r = s.getDescribe() ;
            Map<String,Schema.SObjectField> fields = r.fields.getMap() ;
            Schema.DescribeFieldResult fieldResult = fields.get(fieldName).getDescribe();
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
            
            List<Product2> prodPlant = [Select Id, ManufacturingImerysPlant__c, Name from product2 where ManufacturingImerysPlant__c <> null];
            
            Product2 pro = new Product2(Name = 'Test Product', ManufacturingImerysPlant__c ='IT - Gran Bianco', CurrencyIsoCode = 'EUR');
            insert pro;
            
            Sales_Data__c salDat = new Sales_Data__c();
            salDat.Tech_AccountDNB__c = accTest.DnBNumber__c;
            salDat.Tech_ProductName__c = pro.Name;
            salDat.Tech_ProductPlant__c = pro.ManufacturingImerysPlant__c;
            salDat.Tech_OwnerEmail__c= users[0].Name;
            Insert salDat;      
            
        } 
        
    }
    /**
*@author Geerusting Govind Kumar
*@Date Draft Creation 17/9/2020
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/
    Public static void testUserManagApproverSharing(){
        
        List<Profile> lstAdminPro = [SELECT Id From Profile 
                                     WHERE Name = 'System Administrator'
                                     limit 1];
        
        List<User> usersActive = [SELECT Id FROM User 
                                  WHERE IsActive = true 
                                  AND ByPassTriggerRule__c = false 
                                  LIMIT 100];                               
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c, KeyUser__c,IsKeyUser__c FROM User 
                            WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false 
                            AND ProfileId =: lstAdminPro[0].Id LIMIT 1];
        
        List<User_creation__c> urUpdList = new List <User_creation__c>();
        
        users[0].ByPassValidationRule__c =true;
        users[0].IsKeyUser__c =false;
        update users[0];
        
        system.RunAs(users[0]){  
            
            User_creation__c userCreation = new User_creation__c();
            userCreation.First_Name__c = 'test';
            insert userCreation;
            
            for(User_creation__c userCr: [Select Id, Approver__c,First_Name__c  FROM User_creation__c
                                          WHERE Id =: userCreation.Id]){
                                              
                                              urUpdList.add(userCr);
                                          }
            
            test.startTest();
            update urUpdList;
            test.StopTest();
            
            Approval.ProcessSubmitRequest app = new Approval.ProcessSubmitRequest();
            app.setObjectId(userCreation.id);
            app.setNextApproverIds(new Id[] {users[0].Id});
            Approval.ProcessResult result = Approval.process(app);
            
            
            // Test attributes of manual share.
            if(urUpdList.size() > 0) {
                System.assertEquals(urUpdList[0].First_Name__c, 'test');
            }           
            
        }
    }                                
    /**
*@author Geerutsing Govind Kumar
*@Date Draft Creation 12/6/2019
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/      
    public static void testCreateTeamSample(Integer numRec, Integer numTeamPerSamp){
        // Select users for the test.
        date mydate1 = date.parse('05/11/2017');
        date mydate2 = date.parse('05/11/2030');
        DateTime date1 = Date.today();
        
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        List<Account> accts = new List<Account>();
        List<Contact> conts = new List<Contact>();
        List<Sample__c> samList = new List<Sample__c>();
        List<relationship__c> relList = new List<relationship__c>();
        List<SampleTeam__c> samTeamList = new List<SampleTeam__c>();
        List<Product2> productList = new List<Product2>();
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User WHERE IsActive = true AND ByPassTriggerRule__c = false
                            AND ProfileId =: p2.Id LIMIT 5];
        Id user1Id = users[0].Id;
        Id user2Id = users[1].Id;
        Id user3Id = users[2].Id;
        
        users[0].ByPassValidationRule__c = true;
        update users[0];
        
        system.runas(users[0]){
            
            for(Integer i=0;i<numRec;i++) {
                
                Product2 p3 = new product2();
                p3.Name = 'kjskd' + i;
                p3.ManufacturingImerysPlant__c = '';
                p3.IsActive = true;
                productList.add(p3);
            }
            
            for(Integer i=0;i<numRec;i++) {
                
                Account acc1 = new Account();
                acc1.Name = 'sdsdasassd1dsdsdd' + i;
                acc1.BillingCountry = 'United States';
                acc1.BillingCity = 'New York';
                acc1.SegmentL1__c = 'Abrasive';
                acc1.Type = 'Head Office';
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
                Sample__c sam4 = New Sample__c();
                sam4.AccountName__c = acct.Id;
                sam4.RecipientName__c = cct.Id;
                sam4.Status__c = 'Draft Creation';
                sam4.Type__c = 'Lab';
                sam4.CSAccountManager__c = user3Id;
                sam4.ExpectedDeliveryDate__c = mydate2;
                sam4.ProductName__c = prod.Id;
                sam4.Volume__c = 1233;
                sam4.OwnerId = User1Id;
                //sam4.Unit__c = 'Metric tons (as sold)';
                //sam4.BusinessArea__c ='RAC';
                sam4.GateKeeper__c = null;
                sam4.outOfOffice__c = true;
                sam4.DateOfFeedback__c = mydate1;     
                sam4.DispatchSite__c ='FR - Iko';
                samList.add(sam4);
            }
            
            insert samList;
            
            
            for(Integer j=0;j<numRec;j++) {
                
                Sample__c sam = samList[j];
                
                for (Integer k=0;k<numTeamPerSamp;k++) {
                    
                    SampleTeam__c team = new SampleTeam__c();
                    team.Member__c = user1Id;
                    team.Role__c = 'Front Office';
                    team.Sample__c = sam.Id;
                    team.Access__c = 'Edit';
                    samTeamList.add(team);
                }
            }
            
            Test.startTest();           
            Database.Insert(samTeamList, true);
            Test.stopTest();
            
            Database.update(samTeamList,true);
            
            Database.delete(samTeamList,true);
            
            // Insert manual share for user who is not record owner. 
            // Query visit report records.
            List<Sample__Share> sampleShrs = [SELECT Id, UserOrGroupId, AccessLevel, 
                                              RowCause FROM Sample__Share WHERE ParentId =: samTeamList[0].Id];
            
            // Test attributes of manual share.
            if(sampleShrs.size() > 0){
                System.assertEquals(sampleShrs[0].AccessLevel, 'Edit');
            }
            
        }              
    }
    /**
*@author Geerutsing Govind Kumar
*@Date Draft Creation 16/2/2021
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/      
    public static void testCreateCustomerRequestForm(Integer numRec, Integer numTeamPerSamp){
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
            
            for(Integer i=0;i<numRec;i++) {
                
                Product2 p3 = new product2();
                p3.Name = 'kjskd' + i;
                p3.ManufacturingImerysPlant__c = '';
                p3.IsActive = true;
                productList.add(p3);
            }
            
            GatekeeperAssignment__c gat = New GatekeeperAssignment__c();
            gat.Gatekeeper__c = User2Id;
            gat.Gatekeeper2__c = user1Id;
            gat.Gatekeeper3__c = user2Id;
            gat.Gatekeeper4__c =user2Id;
            gat.ImerysSellingEntity__c ='1';
            gat.Object__c = 'Customer Service in Charge';
            Database.insert(gat, true);
            
            GatekeeperAssignment__c gat3 = New GatekeeperAssignment__c();
            gat3.Gatekeeper__c = User2Id;
            gat3.Gatekeeper2__c = User2Id;
            gat3.Gatekeeper3__c = user1Id;
            gat3.Gatekeeper4__c =user1Id;
            gat3.ImerysSellingEntity__c ='1';
            gat3.Object__c = 'Credit Controller in Charge';
            
            Database.insert(gat3, true);
            
            GatekeeperAssignment__c gat2 = New GatekeeperAssignment__c();
            gat2.Gatekeeper__c = User2Id;
            gat2.Gatekeeper2__c = User2Id;
            gat.Gatekeeper3__c = user1Id;
            gat.Gatekeeper4__c =user1Id;
            gat2.ImerysSellingEntity__c ='100';
            gat2.Object__c = 'Credit Controller in Charge';
            Database.insert(gat2, true);
            
            
            GatekeeperAssignment__c gat4 = New GatekeeperAssignment__c();
            gat4.Gatekeeper__c = User2Id;
            gat4.Gatekeeper2__c = user1Id;
            gat4.Gatekeeper3__c = user2Id;
            gat4.Gatekeeper4__c =user2Id;
            gat4.ImerysSellingEntity__c ='100';
            gat4.Object__c = 'Customer Service in Charge';
            Database.insert(gat4, true);
            
            for(Integer i=0;i<numRec;i++) {
                
                Account acc1 = new Account();
                acc1.Name = 'sdsdasassd1dsdsdd' + i;
                acc1.BillingCountry = 'United States';
                acc1.BillingCity = 'New York';
                acc1.SegmentL1__c = 'Abrasive';
                acc1.Type = 'Head Office';
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
                //cust.ImerysSellingEntity__c = '1';
                cust.ImerysSellingEntityGlobal__c='	AR - Imerys Minerales Argentina';
                cust.Account_Manager__c =user1Id;
                cust.Ship_To__c = acct.Id;
                custList.add(cust);
                
                Customer_Request_Form__c cust2 = new Customer_Request_Form__c();
                cust2.Business_Area__c ='RAC';
               // cust2.ImerysSellingEntity__c = '100';
                cust2.ImerysSellingEntityGlobal__c='AR - Imerys Minerales Argentina';
                cust2.Account_Manager__c =user1Id;
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
                custUpdate.ImerysSellingEntityGlobal__c ='AR - Imerys Minerales Argentina';
                custUpdate.Account_Manager__c = user3Id;
                custUpdList.add(custUpdate);
            }               
            
            Test.startTest();           
            Database.Insert(cusTeamList, true);
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
    
    /**
*@author Jaunbocus Muhammad Irshaad
*@Date Draft Creation 3/3/2021
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/
    
    
    
    Public static void testVFC_ShortlistedProducts(){
        List<Shortlisted_Imerys_Product__c> ProdList = new List<Shortlisted_Imerys_Product__c>();
        
        List<Profile> lstAdminPro = [SELECT Id From Profile 
                                     WHERE Name = 'System Administrator'
                                     limit 1];
        
        List<User> usersActive = [SELECT Id FROM User 
                                  WHERE IsActive = true 
                                  AND ByPassTriggerRule__c = false 
                                  LIMIT 100];                               
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User 
                            WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false 
                            AND ProfileId =: lstAdminPro[0].Id LIMIT 1];
        
        
        users[0].ByPassValidationRule__c = true;
        update users[0];
        
        system.RunAs(users[0]){ 
            Account acc1 = new Account();
            acc1.Name = 'sdsdasassd1dsdsdd';
            acc1.BillingCountry = 'United States';
            acc1.BillingCity = 'New york';
            acc1.SegmentL1__c = 'Abrasive';
            acc1.Type = 'Head Office';
            Database.insert(acc1, true); 
            
            Product2 prod = new Product2(Name = 'Laptop X200',CurrencyIsoCode = 'USD',
                                         Family = 'Hardware');
            insert prod;
            
            // Get standard price book ID.
            // This is available irrespective of the state of SeeAllData.
            Id pricebookId = Test.getStandardPricebookId();
            
            // 1. Insert a price book entry for the standard price book.
            // Standard price book entries require the standard price book ID we got earlier.
            PricebookEntry standardPrice = new PricebookEntry(
                Pricebook2Id = pricebookId, Product2Id = prod.Id, CurrencyIsoCode = 'USD',
                UnitPrice = 10000, IsActive = true);
            insert standardPrice;
            
            // Create a custom price book
            Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
            insert customPB;
            
            // 2. Insert a price book entry with a custom price.
            PricebookEntry customPrice = new PricebookEntry(
                Pricebook2Id = customPB.Id, Product2Id = prod.Id, CurrencyIsoCode = 'USD',
                UnitPrice = 12000, IsActive = true);
            insert customPrice;
            
            opportunity opp = new opportunity();
            opp.name = 'Pizza King Oppty';
            opp.AccountId = acc1.Id;
            opp.CloseDate = system.today();
            opp.StageName = 'New';
            opp.Probability = 20;
            opp.CurrencyIsoCode = 'USD';
            opp.Division__c = 'Ceramics';
            insert opp;
            
            Shortlisted_Imerys_Product__c ImerysProd = new Shortlisted_Imerys_Product__c();
            ImerysProd.Opportunity__c = opp.id;
            ImerysProd.Imerys_Product__c = prod.id;
            ImerysProd.Technical_Status__c = 'Qualified';
            ImerysProd.Shortlisted__c = 'Preferred';
            ImerysProd.Unit_Price__c = 100;
            ImerysProd.Volume__c= 100;
            
            ProdList.add(ImerysProd);    
            Insert ProdList;
            
            test.startTest();
            //Test.setCurrentPage(Page.VFC_ShortListedProducts);
            apexpages.standardsetcontroller std=new apexpages.StandardSetController(ProdList);
            std.setselected(ProdList);
            //VFC_ShortListedProducts obj = new VFC_ShortListedProducts(std);
            //VFC_ShortListedProducts obj = new VFC_ShortListedProducts();
            //obj.pageAction();
            
            test.stopTest();
        }
        
    }
    
    
    /**
*@author Jaunbocus Muhammad Irshaad
*@Date Draft Creation 2/3/2021
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/
    
    
    
    Public static void testAP01_ShortListProdTriggerHandler(){
        
        List<Profile> lstAdminPro = [SELECT Id From Profile 
                                     WHERE Name = 'System Administrator'
                                     limit 1];
        
        List<User> usersActive = [SELECT Id FROM User 
                                  WHERE IsActive = true 
                                  AND ByPassTriggerRule__c = false 
                                  LIMIT 100];                               
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User 
                            WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false 
                            AND ProfileId =: lstAdminPro[0].Id LIMIT 1];
        
        List<Shortlisted_Imerys_Product__c> ImerysProdList = new List <Shortlisted_Imerys_Product__c>();
        
        users[0].ByPassValidationRule__c = true;
        update users[0];
        
        system.RunAs(users[0]){ 
            
            Account acc1 = new Account();
            acc1.Name = 'sdsdasassd1dsdsdd';
            acc1.BillingCountry = 'United States';
            acc1.BillingCity = 'New york';
            acc1.SegmentL1__c = 'Abrasive';
            acc1.Type = 'Head Office';
            Database.insert(acc1, true); 
            
            opportunity opp = new opportunity();
            opp.name = 'Pizza King Oppty';
            opp.AccountId = acc1.Id;
            opp.CloseDate = system.today();
            opp.StageName = 'New';
            opp.Probability = 20;
            opp.Division__c = 'Ceramics';
            insert opp;
            
            Shortlisted_Imerys_Product__c ImerysProd = new Shortlisted_Imerys_Product__c();
            ImerysProd.Opportunity__c = opp.id;
            ImerysProd.Technical_Status__c = 'Qualified';
            ImerysProd.Shortlisted__c = 'Preferred';
            ImerysProd.Unit_Price__c = 100;
            ImerysProd.Volume__c= 100;
            
            
            
            //OpportunityLineItem OppoLineItem = new OpportunityLineItem();
            //OppoLineItem.OpportunityId = opp.id;
            // OppoLineItem.Product2Id = ImerysProd.Id;
            // OppoLineItem.Quantity = 2;
            // OppoLineItem.TotalPrice = 100;
            // OppoLineItem.PricebookEntryId = pricebookId ;
            
            // insert OppoLineItem;
            
            ImerysProdList.add(ImerysProd);
            
            
            test.startTest();   
            insert ImerysProdList;
            test.stopTest();
            
            List<OpportunityLineItem> testOppLineItem = [SELECT Id, name FROM OpportunityLineItem 
                                                         WHERE OpportunityId = :opp.id
                                                         AND  Product2Id=: ImerysProd.id ];      
            
            
            System.assertEquals(0,testOppLineItem.size());
            
        }
        
    }
    
    
    
    
    /**
*@author Sookan Abhishak
*@Date Draft Creation 24/3/2021
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/ 
    
    public static void testFilImerysSolution(integer numOppty){
        
        List<Profile> lstAdminPro = [SELECT Id From Profile 
                                     WHERE Name = 'System Administrator'
                                     limit 1];
        
        List<User> usersActive = [SELECT Id FROM User 
                                  WHERE IsActive = true 
                                  AND ByPassTriggerRule__c = false 
                                  LIMIT 100];                               
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User 
                            WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false 
                            AND ProfileId =: lstAdminPro[0].Id LIMIT 1];
        
        List<Shortlisted_Imerys_Product__c> ImerysProdList = new List <Shortlisted_Imerys_Product__c>();
        
        users[0].ByPassValidationRule__c = true;
        update users[0];
        
        system.RunAs(users[0]){ 
            //Create Account
            Account accTest= new Account();
            accTest.Name = 'TEST';
            accTest.BillingCountry = 'United States';
            accTest.BillingCity = 'New York';
            accTest.SegmentL1__c = 'Abrasive';
            accTest.Type = 'Head Office';
            Database.insert(accTest, true);
            
            //Selected products
            Opportunity oppt = new Opportunity();
            oppt.Name = 'testOpportunity';
            oppt.AccountId = accTest.Id;
            oppt.CloseDate = system.today();
            oppt.BusinessArea__c = 'HTS';
            oppt.MultiProduct__c = false;
            oppt.Type = 'Up-sell';
            oppt.StageName = 'Non-qualified opportunities';
            oppt.Probability = 90;
            insert oppt;
            
            Shortlisted_Imerys_Product__c testproduct0 = new Shortlisted_Imerys_Product__c ();
            testproduct0.Shortlisted__c = 'Selected';
            testproduct0.Technical_Status__c= 'Not started';
            testproduct0.Volume__c = 10;
            testproduct0.Unit_Price__c = 5;
            testproduct0.Opportunity__c = oppt.Id;
            insert testProduct0;
            update oppt;
            
            //Prefered products
            List <Opportunity> oppTestPrefered = new List<Opportunity>();
            List <Shortlisted_Imerys_Product__c> testproductsPrefered = new List<Shortlisted_Imerys_Product__c> ();
            
            for(Integer i=0;i<numOppty;i++) {
                Opportunity opptPrefered = new Opportunity();
                opptPrefered.Name = 'testOpportunity';
                opptPrefered.AccountId = accTest.Id;
                opptPrefered.CloseDate = system.today();
                opptPrefered.BusinessArea__c = 'HTS';
                opptPrefered.Type = 'Up-sell';
                opptPrefered.StageName = 'Non-qualified opportunities';
                opptPrefered.Probability = 90;
                oppTestPrefered.add(opptPrefered);
            }
            
            for(integer j = 0; j<numOppty; j++){
                Opportunity oppo = oppTestPrefered[j];
                Shortlisted_Imerys_Product__c testproduct1 = new Shortlisted_Imerys_Product__c ();
                testproduct1.Shortlisted__c = 'Preferred';
                testproduct1.Technical_Status__c= 'Not started';
                testproduct1.Volume__c = 10;
                testproduct1.Unit_Price__c = 5;
                testproduct1.Opportunity__c = oppo.Id;
                testproductsPrefered.add(testproduct1);
                
                //update oppTestPrefered;
            }
            
            Test.startTest();
            Database.Insert(oppTestPrefered);
            Test.stopTest();
            
            List<Opportunity> oList = [SELECT Name, Type, StageName, Imerys_Solution__c, MultiProduct__c FROM Opportunity WHERE id =: oppt.id];
            
            for(Opportunity op:oList){
                if(op.Imerys_Solution__c != null && op.MultiProduct__c == false){
                    system.AssertEquals(1,oList.size());
                }
            }
        }
        
    }
    
    /**
*@author Jaunbocus Muhammad Irshaad
*@Date Draft Creation 06/05/2021
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/ 
    
    public static void testVFC_AddSelectedProductTest(){
        List<Profile> lstAdminPro = [SELECT Id From Profile 
                                     WHERE Name = 'System Administrator'
                                     limit 1];
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User 
                            WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false 
                            AND ProfileId =: lstAdminPro[0].Id LIMIT 1];
        
        
        users[0].ByPassValidationRule__c = true;
        update users[0];
        
        system.RunAs(users[0]){ 
            //Create Account   
            Account accTest= new Account();
            accTest.Name = 'VRTEST';
            accTest.BillingCountry = 'United States';
            accTest.BillingCity = 'New York';
            accTest.SegmentL1__c = 'Abrasive';
            accTest.Type = 'Head Office';
            Database.insert(accTest, true);
            
            //Create opportunity
            opportunity opp = new opportunity();
            opp.name = 'Pizza King Oppty';
            opp.AccountId = accTest.Id;
            opp.type = 'Up-Sell';
            opp.CloseDate = system.today();
            opp.StageName = 'New';
            opp.Probability = 20;
            opp.Division__c = 'Ceramics';
            opp.BusinessArea__c = 'RAC';
            insert opp;
            
            Shortlisted_Imerys_Product__c obj = new Shortlisted_Imerys_Product__c(opportunity__c = opp.id);
            insert obj;
            
            list<Shortlisted_Imerys_Product__c> selected = new list<Shortlisted_Imerys_Product__c>();
            selected.add(obj);
            
            PageReference pageRef = Page.VFP_AddSelectedProduct;
            Test.setCurrentPage(pageRef);
            
            pageRef.getParameters().put('Id', String.valueOf(obj.Id));
            ApexPages.StandardSetController sc = new ApexPages.StandardSetController(selected);
            //ListViewController l = new ListViewController(sc);
            VFC_AddSelectedProduct l = new VFC_AddSelectedProduct(sc);
            
        }
    }
 
        /**
*@author Jaunbocus Muhammad Irshaad
*@Date Draft Creation 06/05/2021
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/ 
    public static void testFillMarketSegment(){
        
        date mydate = date.parse('05/11/2012');
       
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false AND profileID =: p2.Id LIMIT 5];
        
        List<Opportunity> oppoList = new List<Opportunity>();
        
        users[0].ByPassValidationRule__c = true;
        users[0].Job_Department__c = 'Customer Service & Sales Administration';
        update users[0];
        
        
        system.runas(users[0]){ 
            
            //Create Account
            Account accTest= new Account();
            accTest.Name = 'VRTEST';
            accTest.BillingCountry = 'United States';
            accTest.BillingCity = 'New York';
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
            opportunity opp = new opportunity();
            opp.name = 'Pizza King Oppty';
            opp.type = 'New Customer';
            //opp.RecordTypeId = '0121l0000009xwHAAQ';
            opp.AccountId = accTest.Id;
            opp.CloseDate = system.today();
            opp.StageName = 'New';
            opp.Probability = 20;
            opp.Division__c = 'Ceramics';
            opp.BusinessArea__c = 'RAC';
            
                oppoList.add(opp);
            }
            insert oppoList;
			
           Test.stopTest();
		
        }
    }
    
    /**
*@author Jaunbocus Muhammad Irshaad
*@Date Draft Creation 27/7/2021
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/ 
    public static void testFillMarketSegmentMasterProject(){
        
        date mydate = date.parse('05/11/2012');
       
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false AND profileID =: p2.Id LIMIT 5];
        
        List<Project__c> projList = new List<Project__c>();
        
        users[0].ByPassValidationRule__c = true;
        users[0].Job_Department__c = 'Customer Service & Sales Administration';
        update users[0];
        
        Recordtype RecTypeOffer = [Select Id from Recordtype where  SobjectType ='Project__c' and developername = 'MasterProject'];
        Id RecTypeMasterProject = RecTypeOffer.Id;
        
        
        system.runas(users[0]){ 
            
            //Create Account
            Account accTest= new Account();
            accTest.Name = 'VRTEST';
            accTest.BillingCountry = 'United States';
            accTest.BillingCity = 'New York';
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
            project__c proj = new project__c();
            proj.Project_Name__c = 'Pizza King Oppty';
            proj.Account__c = accTest.Id;
            proj.RecordTypeId = RecTypeMasterProject;
            proj.ProjectType__c = 'Trials';
            proj.ProjectStatus__c = 'Pre-Opportunity';
            proj.CurrencyIsoCode = 'EUR';
            proj.BusinessArea__c = 'RAC';
            
                projList.add(proj);
            }
            insert projList;
			
           Test.stopTest();
		
        }
    }
    
   /*@author Jaunbocus Muhammad Irshaad
*@Date Draft Creation 06/05/2021
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/ 
        public static void testFillMarketSegmentAndAccMgr(){
        
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
*@Date Draft Creation 23/8/2021
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/ 
    public static void testFillMarketSegmentOffer(){
        
        date mydate = date.parse('05/11/2012');
       
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false AND profileID =: p2.Id LIMIT 5];
        
        List<Offer__c> offerList = new List<Offer__c>();
        
        users[0].ByPassValidationRule__c = true;
        users[0].Job_Department__c = 'Customer Service & Sales Administration';
        update users[0];
        
        Recordtype RecTypeOffer = [Select Id from Recordtype where  SobjectType ='offer__c' and developername = 'SubProject'];
        Id RecTypeSubProject = RecTypeOffer.Id;

        
        
        system.runas(users[0]){ 
            
            //Create Account
            Account accTest= new Account();
            accTest.Name = 'VRTEST';
            accTest.BillingCountry = 'United States';
            accTest.BillingCity = 'New York';
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
                  Offer__c off = new Offer__c();
                  off.RecordTypeId = RecTypeSubProject;
                  off.Account__c = accTest.Id;
                  off.AccountInstallationIsPerformedOn__c = accTest.Id;
                  off.Services__c = 'Installation';
                  off.OfferStatus__c = 'Draft';
                  //off.WonLostReason__c =  'Delivery Time';
                  off.OurProbability__c = 23;
                  off.ProbabilityofCustomer__c = 45;
                  off.TotalValue__c = 200;
                  off.GrossMargin__c = 12;
                  off.OfferDate__c = myDate;
                  off.DecisionDate__c = mydate;
                  off.BusinessArea__c = 'RAC';
                  off.ParticipantType__c = 'Consultant';
                  off.TECH_ReconnexionTarget__c = false;
                  offerList.add(off);
		             }
            insert offerList;
			
           Test.stopTest();
		
        }
    }
    
/**
*@author Jaunbocus Muhammad Irshaad
*@Date Draft Creation 23/8/2021
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/ 
    public static void testFillMarketSegmentTAR(){
        
        date mydate = date.parse('05/11/2012');
       
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false AND profileID =: p2.Id LIMIT 5];
        
        List<TechnicalAssistanceRequest__c> TARList = new List<TechnicalAssistanceRequest__c>();
        
        users[0].ByPassValidationRule__c = true;
        users[0].Job_Department__c = 'Customer Service & Sales Administration';
        update users[0];
        
        
        system.runas(users[0]){ 
            
            //Create Account
            Account accTest= new Account();
            accTest.Name = 'VRTEST';
            accTest.BillingCountry = 'United States';
            accTest.BillingCity = 'New York';
            accTest.SegmentL1__c = 'Abrasive';
            accTest.Type = 'Head Office';
            Database.insert(accTest, true);
            
            opportunity opp = new opportunity();
            opp.name = 'Pizza King Oppty';
            opp.type = 'New Customer';
            //opp.RecordTypeId = '0121l0000009xwHAAQ';
            opp.AccountId = accTest.Id;
            opp.CloseDate = system.today();
            opp.StageName = 'New';
            opp.Probability = 20;
            opp.Division__c = 'Ceramics';
            opp.BusinessArea__c = 'RAC';
            Database.insert(opp,true);
            
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
            insert markSeg;

            
            List<Relationship__c> relat = new List<Relationship__c>();

            Relationship__c relation = new Relationship__c();
            relation.AccountName__c = accTest.Id;
            relation.Divisions__c = 'Ceramics';
            relation.DivisionTier__c = 'B';
            relation.BusinessArea__c = 'HTS';
            relation.AccountManager__c = users[0].Id;
            relation.MarketSegmentation__c = markSeg.id;
            //relation.NewMarketL1__c = 'test';
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
                
                  TechnicalAssistanceRequest__c tech = new TechnicalAssistanceRequest__c();
                  tech.Account__c = accTest.Id;
                  tech.BusinessArea__c = 'HTS';
                  tech.Opportunity__c = opp.Id;
                  tech.Division__c = 'Ceramics';
                  tech.BusinessObjectiveandStakes__c= 'test';
                  tech.Status__c = 'Creation';
                  tech.Requester__c = users[0].Id;
                  //tech.Market_Segmentation__c = markSeg.Id;
                  //insert tech;
                  TARList.add(tech);
              }
            insert TARList;
            
            Test.stopTest();
            
        }
    }
    
/**
*@author Jaunbocus Muhammad Irshaad
*@Date Draft Creation 24/8/2021
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/ 
    public static void testFillMarketSegmentCapacity(){
        
        date mydate = date.parse('05/11/2012');
       
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false AND profileID =: p2.Id LIMIT 5];
        
        List<Capacity__c> capacityList = new List<Capacity__c>();
        
        users[0].ByPassValidationRule__c = true;
        users[0].Job_Department__c = 'Customer Service & Sales Administration';
        update users[0];
        
        
        system.runas(users[0]){ 
            
            //Create Account
            Account accTest= new Account();
            accTest.Name = 'VRTEST';
            accTest.BillingCountry = 'United States';
            accTest.BillingCity = 'New York';
            accTest.SegmentL1__c = 'Abrasive';
            accTest.Type = 'Head Office';
            Database.insert(accTest, true);
            
            opportunity opp = new opportunity();
            opp.name = 'Pizza King Oppty';
            opp.type = 'New Customer';
            //opp.RecordTypeId = '0121l0000009xwHAAQ';
            opp.AccountId = accTest.Id;
            opp.CloseDate = system.today();
            opp.StageName = 'New';
            opp.Probability = 20;
            opp.Division__c = 'Ceramics';
            opp.BusinessArea__c = 'RAC';
            Database.insert(opp,true);
            
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
            insert markSeg;

            
            List<Relationship__c> relat = new List<Relationship__c>();

            Relationship__c relation = new Relationship__c();
            relation.AccountName__c = accTest.Id;
            relation.Divisions__c = 'Ceramics';
            relation.DivisionTier__c = 'B';
            relation.BusinessArea__c = 'HTS';
            relation.AccountManager__c = users[0].Id;
            relation.MarketSegmentation__c = markSeg.id;
            //relation.NewMarketL1__c = 'test';
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
                
                Capacity__c cap = new Capacity__c();
                cap.Year__c = '2017';
                cap.RelatedAccount__c = accTest.Id;
                cap.BusinessArea__c = 'HTS';
                cap.Division__c = 'Ceramics';
                capacityList.add(cap);
            }
            insert capacityList;
            
            Test.stopTest();
            
        }
    }

    /**
*@author Jaunbocus Muhammad Irshaad
*@Date Draft Creation 24/8/2021
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/ 
    public static void testFillMarketSegmentVR(){
        
        date mydate = date.parse('05/11/2012');
        
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false AND profileID =: p2.Id LIMIT 5];
        
        List<VisitReport__c> visitRepList = new List<VisitReport__c>();
        
        users[0].ByPassValidationRule__c = true;
        users[0].Job_Department__c = 'Customer Service & Sales Administration';
        update users[0];
        
        
        system.runas(users[0]){ 
            
            //Create Account
            Account accTest= new Account();
            accTest.Name = 'VRTEST';
            accTest.BillingCountry = 'United States';
            accTest.BillingCity = 'New York';
            accTest.SegmentL1__c = 'Abrasive';
            accTest.Type = 'Head Office';
            Database.insert(accTest, true);
            
            opportunity opp = new opportunity();
            opp.name = 'Pizza King Oppty';
            opp.type = 'New Customer';
            //opp.RecordTypeId = '0121l0000009xwHAAQ';
            opp.AccountId = accTest.Id;
            opp.CloseDate = system.today();
            opp.StageName = 'New';
            opp.Probability = 20;
            opp.Division__c = 'Ceramics';
            opp.BusinessArea__c = 'RAC';
            Database.insert(opp,true);
            
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
            insert markSeg;
            
            
            List<Relationship__c> relat = new List<Relationship__c>();
            
            Relationship__c relation = new Relationship__c();
            relation.AccountName__c = accTest.Id;
            relation.Divisions__c = 'Ceramics';
            relation.DivisionTier__c = 'B';
            relation.BusinessArea__c = 'HTS';
            relation.AccountManager__c = users[0].Id;
            relation.MarketSegmentation__c = markSeg.id;
            //relation.NewMarketL1__c = 'test';
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
                
                // Create new visit Report.
                VisitReport__c visit = new VisitReport__c();
                visit.Account__c = accTest.Id;
                //visit.contact__c =  con.Id;
                visit.Type__c = 'Email';
                visit.BusinessArea__c = 'HTS';
                visit.Dateofvisit__c = mydate;
                visit.MainObjectivesofthemeeting__c = 'Courtesy';
                // visit.SegmentL2__c = 'Ceramics';
                visit.OwnerId =  users[0].Id;
                Visit.Division__c = 'Ceramics';
                visitRepList.add(visit);
            }
            
            insert visitRepList;
            
            Test.stopTest();
            
        }
    }
    
 /**
*@author Jaunbocus Muhammad Irshaad
*@Date Draft Creation 04/08/2021
*@Date modification 04/08/2021
*@param 
*@ExcptionName
*@return 
*/      
    public static void testupdateOwnerIdonCreation(){
      // Select users for the test
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
    
/**
*@author Jaunbocus Muhammad Irshaad
*@Date Draft Creation 09/09/2021
*@Date modification 09/09/2021
*@param 
*@ExcptionName
*@return 
*/     
        
    public static void testFillRelationshipMATarget(){
        
        date mydate = date.parse('05/11/2012');
        date mydate1 = date.parse('05/11/2017');
        date mydate2 = date.parse('08/12/2022');
        String recordName;
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false AND profileID =: p2.Id LIMIT 2];
        
        users[0].ByPassValidationRule__c = true;
        users[0].ByPassDuplicateRules__c = true;
        update users[0];
        
        system.runas(users[0]){ 
            
            Id accountRecordType = [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName = 'ACC_Account' LIMIT 1].Id;
            
            //Create Account
            Account accTest= new Account();
            accTest.Name = 'VRTEST';
            accTest.BillingCountry = 'United States';
            accTest.BillingCity = 'New York';
            accTest.SegmentL1__c = 'Abrasive';
            accTest.Type = 'Head Office';
            Database.insert(accTest, true);
            
            //Create Market Segmentation
            
            Market_Segmentation__c markSeg =  new Market_Segmentation__c();
            markSeg.Name = 'test';
            markSeg.Segmentation_Level_2__c =true;
            markSeg.Segmentation_Level_3__c = true;
            markSeg.Record_Level_1__c = true;
            markSeg.Record_Level_2__c = true;
            markSeg.Record_Level_3__c = true;
            markSeg.Market_Segmentation_Code__c = '12352df02';
            markSeg.Market_Segmentation_Global_Code__c='12-34-56-78';
            insert markSeg;
            
            
            //Insert 'Division Account Relationship'        
            List<Relationship__c> relat = new List<Relationship__c>();
            List<M_A_Target__c>MATargetList = new List <M_A_Target__c>();
            
            //for(Division__c DivToInsert: divList) {
            Relationship__c relation = new Relationship__c();
            relation.AccountName__c = accTest.Id;
            relation.Divisions__c = 'Ceramics';
            relation.DivisionTier__c = 'B';
            relation.BusinessArea__c = 'HTS';
            //relation.SegmentL2__c = 'Ceramics - OEM';
            relation.SubType__c = 'Consultant';
            relat.add(relation);
            
            Relationship__c relation2 = new Relationship__c();
            relation2.AccountName__c = accTest.Id;
            relation2.Divisions__c = 'Carbonates';
            relation2.DivisionTier__c = 'B';
            relation2.BusinessArea__c = 'RAC';
            relation2.AccountManager__c = users[0].Id;
            //relation2.SegmentL2__c = 'Ceramics - OEM';
            relation2.SubType__c = 'Consultant';
            relat.add(relation2);
            
            Relationship__c relation3 = new Relationship__c();
            relation3.AccountName__c = accTest.Id;
            relation3.Divisions__c = 'Calderys';
            relation3.DivisionTier__c = 'B';
            relation3.BusinessArea__c = 'PM EMEA';
            //relation3.SegmentL2__c = 'Ceramics - OEM';
            relation3.SubType__c = 'Consultant';
            relat.add(relation3);
            
            Database.insert(relat,true);         
            
   				
            M_A_Target__c MA_Target = new M_A_Target__c();
            MA_Target.Year__c = '2021';
            MA_Target.Account__c = accTest.Id;
            MA_Target.Market_Segmentation__c = markSeg.id;
            MA_Target.Business_Area__c = 'HTS';
            MATargetList.add(MA_Target);
            
            Test.StartTest();
            insert MATargetList; 
            update MATargetList;
            Test.stopTest();
            
        }
    }
    

    
   /*@author Jaunbocus Muhammad Irshaad
*@Date Draft Creation 06/05/2021
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/ 
        public static void fillMarketSegmentSample(){
        
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
    
/**
    
*@author Jaunbocus Muhammad Irshaad
*@Date Draft Creation 04/08/2021
*@Date modification 04/08/2021
*@param 
*@ExcptionName
*@return */
    
    public static void testSetOwnerIdonCreation(){
      // Select users for the test
        String recordTypeName;
        Integer countOwner;
        date myDate = date.parse('05/11/2017');
        date mydate2 = date.parse('08/12/2018');
        DateTime date1 = Date.today(); 
        List <PriceStorage__c> PriceStorageList = new List<PriceStorage__c>();
        
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
           
            Group gr = new Group();
            gr.name = 'Bahrain';
            gr.Type = 'Queue';
            Insert gr;
                
                
            
            Group grp2 = new Group();
            grp2.name = 'Bahrain';
            grp2.Type = 'Queue'; 
            Insert grp2; 
            
            //Note : Apex doesnot allow DML operation on setup objects (like Group, Profile, Role,....) inside testmethod.
            //Solution: There  is an object named "QueueSobject". It Represents the mapping between a queue Group and the sObject types associated with the queue, including custom objects.
            
            QueueSobject mappingObject = new QueueSobject (QueueId = gr.Id, SobjectType = 'PriceStorage__c');
            insert mappingObject;
            
            QueueSobject mappingObject2 = new QueueSobject (QueueId = grp2.Id, SobjectType = 'PriceStorage__c');
            insert mappingObject2;
     
            
            //Create Group Member ( Queue Members)
            GroupMember grpMem1 = new GroupMember();
            grpMem1.UserOrGroupId = user1Id;
            grpMem1.GroupId = gr.Id;
            Insert grpMem1;
            
            
            GroupMember grpMem2 = new GroupMember();
            grpMem2.UserOrGroupId = user2Id;
            grpMem2.GroupId = gr.Id;
            Insert grpMem2;
            
            
            Account acc1 = new Account();
            acc1.Name = 'sdsdasassd1dsdsdd';
            acc1.BillingCountry = 'Kenya';
            acc1.BillingCity = 'New York';
            acc1.SegmentL1__c = 'Abrasive';
            acc1.Type = 'Head Office';
            Database.insert(acc1, true); 
            
             Market_Segmentation__c markSeg =  new Market_Segmentation__c();
            markSeg.Name = 'test';
            markSeg.Segmentation_Level_2__c =true;
            markSeg.Segmentation_Level_3__c = true;
            markSeg.Record_Level_1__c = true;
            markSeg.Record_Level_2__c = true;
            markSeg.Record_Level_3__c = true;
            markSeg.Market_Segmentation_Code__c = '12352df02';
            markSeg.Market_Segmentation_Global_Code__c='12-34-56-78';
            insert markSeg;
            
            
            //Insert 'Division Account Relationship'        
            List<Relationship__c> relat = new List<Relationship__c>();
           
            
            //for(Division__c DivToInsert: divList) {
            Relationship__c relation = new Relationship__c();
            relation.AccountName__c = acc1.Id;
            relation.Divisions__c = 'Ceramics';
            relation.DivisionTier__c = 'B';
            relation.BusinessArea__c = 'HTS';
            relation.AccountManager__c = users[0].Id;
            //relation.SegmentL2__c = 'Ceramics - OEM';
            relation.SubType__c = 'Consultant';
            relat.add(relation);
            
            Relationship__c relation2 = new Relationship__c();
            relation2.AccountName__c = acc1.Id;
            relation2.Divisions__c = 'Carbonates';
            relation2.DivisionTier__c = 'B';
            relation2.BusinessArea__c = 'RAC';
            relation2.AccountManager__c = users[0].Id;
            //relation2.SegmentL2__c = 'Ceramics - OEM';
            relation2.SubType__c = 'Consultant';
            relat.add(relation2);
            insert relat;
            
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
            
            
            GatekeeperAssignment__c gat = New GatekeeperAssignment__c();
            gat.Division__c = 'Calderys';
            gat.Gatekeeper__c = user2Id;
            //gat.AllPlants__c = True;
            gat.ManufacturingImerysPlant__c = 'AR - Tucuman';
            gat.BusinessArea__c = 'HTS';
            gat.ImerysSellingEntity__c = '10';
            gat.ImerysSellingEntity2__c = 'AT - Imerys Carbonates Austria';
            gat.PriceStorageQueue__c = 'BahrainQueue';
            gat.Object__c = 'Price Storage';   
            
            Database.insert(gat, true);
            
            GatekeeperAssignment__c gat2 = New GatekeeperAssignment__c();
            gat2.Division__c = 'Aluminates';
            gat2.Gatekeeper__c = user1Id;
            gat2.ManufacturingImerysPlant__c = 'AT - Villach';
            gat2.BusinessArea__c = 'HTS';
            gat2.ImerysSellingEntity2__c = 'AT - Imerys Carbonates Austria';
            gat2.ImerysSellingEntity__c = '100';
            gat2.PriceStorageQueue__c = 'BahrainQueue';
            gat2.Object__c = 'Price Storage';
            Database.insert(gat2, true);  

               
            PriceStorage__c ps = new PriceStorage__c();
            ps.Account__c = acc1.id;
            ps.BusinessArea__c = 'HTS';
            ps.SellingEntity2__c = 'AT - Imerys Carbonates Austria';
            ps.Start_of_Validity__c = mydate;
            ps.End_Of_Validity__c = mydate2;
            ps.status__c = 'To be created in ERP';
            Insert ps;
            
            ps.Selling_Entity__c = '100';
            Update ps;
            
    
            
            Test.StopTest();
            
            //List<Case> caseRecord = [SELECT GateKeeper__c
            //                       FROM Case WHERE Id =:cas.Id];  
            
            //System.AssertEquals(caseRecord[0].GateKeeper__c, users[1].Id);
           
        }
      
    }
    
/**
*@author Jaunbocus Muhammad Irshaad
*@Date  Creation 8/11/2021

*@param 
*@ExcptionName
*@return */
   
        
    public static void testFillRelationshipPriceStorage(){
        
        date mydate = date.parse('05/11/2012');
        date mydate1 = date.parse('05/11/2017');
        date mydate2 = date.parse('08/12/2022');
        String recordName;
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false AND profileID =: p2.Id LIMIT 2];
        
        users[0].ByPassValidationRule__c = true;
        users[0].ByPassDuplicateRules__c = true;
        update users[0];
        
        system.runas(users[0]){ 
            
            Id accountRecordType = [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName = 'ACC_Account' LIMIT 1].Id;
            
            //Create Account
            Account accTest= new Account();
            accTest.Name = 'VRTEST';
            accTest.BillingCountry = 'United States';
            accTest.BillingCity = 'New York';
            accTest.SegmentL1__c = 'Abrasive';
            accTest.Type = 'Head Office';
            Database.insert(accTest, true);
            
            //Create Market Segmentation
            
            Market_Segmentation__c markSeg =  new Market_Segmentation__c();
            markSeg.Name = 'test';
            markSeg.Segmentation_Level_2__c =true;
            markSeg.Segmentation_Level_3__c = true;
            markSeg.Record_Level_1__c = true;
            markSeg.Record_Level_2__c = true;
            markSeg.Record_Level_3__c = true;
            markSeg.Market_Segmentation_Code__c = '12352df02';
            markSeg.Market_Segmentation_Global_Code__c='12-34-56-78';
            insert markSeg;
            
            
            //Insert 'Division Account Relationship'        
            List<Relationship__c> relat = new List<Relationship__c>();
            List<PriceStorage__c>priceStorageList = new List <PriceStorage__c>();
            
            //for(Division__c DivToInsert: divList) {
            Relationship__c relation = new Relationship__c();
            relation.AccountName__c = accTest.Id;
            relation.Divisions__c = 'Ceramics';
            relation.DivisionTier__c = 'B';
            relation.BusinessArea__c = 'HTS';
            relation.AccountManager__c = users[0].Id;
            //relation.SegmentL2__c = 'Ceramics - OEM';
            relation.SubType__c = 'Consultant';
            relat.add(relation);
            
            Relationship__c relation2 = new Relationship__c();
            relation2.AccountName__c = accTest.Id;
            relation2.Divisions__c = 'Carbonates';
            relation2.DivisionTier__c = 'B';
            relation2.BusinessArea__c = 'RAC';
            relation2.AccountManager__c = users[0].Id;
            //relation2.SegmentL2__c = 'Ceramics - OEM';
            relation2.SubType__c = 'Consultant';
            relat.add(relation2);
            
            Relationship__c relation3 = new Relationship__c();
            relation3.AccountName__c = accTest.Id;
            relation3.Divisions__c = 'Calderys';
            relation3.DivisionTier__c = 'B';
            relation3.BusinessArea__c = 'PM EMEA';
            //relation3.SegmentL2__c = 'Ceramics - OEM';
            relation3.SubType__c = 'Consultant';
            relat.add(relation3);
            
            Database.insert(relat,true);         
            
   				
            PriceStorage__c priceStorage = new PriceStorage__c();
            priceStorage.Account__c = accTest.Id;
            PriceStorage.AccountManager__c = users[0].Id;
            priceStorage.Start_of_Validity__c = mydate1;
           	priceStorage.End_Of_Validity__c = mydate2;
            priceStorage.Status__c = 'To be created in ERP';
            priceStorage.SellingEntity2__c = 'AR - Imerys Minerales Argentina';
            priceStorage.BusinessArea__c = 'HTS';
            priceStorageList.add(priceStorage);
            
            Test.StartTest();
            insert priceStorageList; 
            update priceStorageList;
            Test.stopTest();
            
        }
    }
    
    /**
*@author Jaunbocus Muhammad Irshaad
*@Date Draft Creation 15/11/2021
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/          
    public static void testcreatePriceStorageShare(){
        // Select users for the test.
        String RecordTypeName;
        String RecordTypeRemark;
        date mydate = date.parse('05/11/2017');
        
        List<PriceStorage__c> priceStorageList = new List<PriceStorage__c>();
        
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User WHERE IsActive = true AND
                            ByPassTriggerRule__c = false 
                            AND profile.Id =: p2.Id LIMIT 100];
        
        Id user1Id = users[0].Id;
        Id user2Id = users[1].Id;
        Id user3Id = users[2].Id;
        
        user bypassValidation = [SELECT Id, Email, ByPassValidationRule__c, MultiPicklistDivision__c, Division FROM 
                                 User WHERE Id=:users[0].Id LIMIT 1];
        
        if(bypassValidation.Division == null){
            bypassValidation.Division = 'None';
        }
        if(bypassValidation.MultiPicklistDivision__c == null){
            bypassValidation.MultiPicklistDivision__c = 'Ceramics';
        }       
        bypassValidation.ByPassValidationRule__c = true;
        bypassValidation.ByPassTriggerRule__c = true;
        bypassValidation.CountryforGatekeeper__c = 'Albania';
        bypassValidation.BackupComplaint__c = users[3].Id;
        
        update bypassValidation;        
        
        users[0].ByPassValidationRule__c =true;
        users[0].ByPassProcessBuilders__c = true;
        
        update users[0];
        
        system.runas(users[0]){
            Account acc1 = new Account();
            acc1.Name = 'sdsdasassd1dsdsdd';
            acc1.BillingCountry = 'United States';
            acc1.BillingCity = 'New York';
            acc1.SegmentL1__c = 'Abrasive';
            acc1.Type = 'Head Office';
            Database.insert(acc1, true);    
            
            Contact con = new Contact();
            con.Salutation = 'Mr.';
            con.FirstName = 'SHIA';
            con.Email = 'test@accenture.com.com';
            con.LastName= 'Alisha';
            con.AccountId = acc1.Id;
            Database.insert(con, true);
            
            Product2 p = new product2();
            p.Name = 'Test';
            p.ManufacturingImerysPlant__c = '';
            p.IsActive = true;
            p.Division__c = 'Calderys';
            Database.insert(p, true);
            
            Relationship__c relation = new Relationship__c();
            relation.AccountName__c = acc1.Id;
            relation.Divisions__c = 'Ceramics';
            relation.DivisionTier__c = 'B';
            relation.BusinessArea__c = 'HTS';
            //relation.SegmentL2__c = 'Ceramics - OEM';
            relation.SubType__c = 'Consultant';
            database.insert(relation,true);
            
            
            
            
            /*RecordType recordName = [SELECT Id, DeveloperName 
                                     FROM RecordType 
                                     WHERE SObjectType = 'Case'
                                     AND DeveloperName = 'CSE_Complaint'];  // record type samplewithoutopp */
            
            //recordTypeName = recordName.Id;
            
            PriceStorage__c priceStorage = new PriceStorage__c();
            priceStorage.Account__c = acc1.Id;
            priceStorage.Status__c = 'To be created in ERP';
            priceStorage.BusinessArea__c = 'HTS';
            PriceStorage.AccountManager__c = user1Id;
            PriceStorage.SellingEntity2__c = 'AT - Imerys Carbonates Austria';
            PriceStorage.Selling_Entity__c = '10';
            priceStorage.SellingEntity2__c = 'AR - Imerys Minerales Argentina';
            PriceStorage.Start_of_Validity__c = mydate;
            PriceStorage.End_Of_Validity__c = mydate;
            priceStorageList.add(priceStorage);
            
            Test.StartTest();
            Database.Insert(priceStorageList, true);// insert new record with status Draft Creation
            Test.StopTest();
            
            /*RecordType recordName2 = [SELECT Id, DeveloperName 
                                      FROM RecordType 
                                      WHERE SObjectType = 'Case'
                                      AND DeveloperName = 'CSE_Remark'];  // record type samplewithoutopp
            
            recordTypeRemark = recordName2.Id;*/
            
            PriceStorage__c priceStorage2 = new PriceStorage__c();
            priceStorage2.Account__c = acc1.Id;
            PriceStorage.AccountManager__c = user1Id;
            priceStorage2.Status__c = 'To be created in ERP';
            priceStorage2.BusinessArea__c = 'HTS';
            PriceStorage2.SellingEntity2__c = 'AT - Imerys Carbonates Austria';
            PriceStorage2.Start_of_Validity__c = mydate;
            PriceStorage2.End_Of_Validity__c = mydate;
            PriceStorage2.Selling_Entity__c = '102';
            
            
            Database.Insert(PriceStorage2, true);
            // insert new record with status Draft Creation
            
            // Query case share records.
            PriceStorage__Share[] PriceStoraegShrs = [SELECT Id, UserOrGroupId, AccessLevel, 
                                    RowCause 
                                    FROM PriceStorage__Share 
                                    WHERE ParentId = :priceStorage2.Id
                                    AND UserorGroupId =: users[5].id
                                    AND UserorGroupId =: users[4].id
                                    AND UserorGroupId =: users[6].id
                                    AND AccessLevel  =: 'Edit'];
            
            // Test attributes of manual share.
            if(PriceStoraegShrs.size() > 0) {
                System.assertEquals(PriceStoraegShrs[0].AccessLevel, 'Edit');
                System.assertEquals(PriceStoraegShrs[0].UserOrGroupId, users[5].id);
            }                       
        }     
    }
    
        /**
*@author Jaunbocus Muhammad Irshaad
*@Date Creation 31/1/2022
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/      
    public static void testCreateTeamPriceStorage(Integer numRec, Integer numTeamPerSamp){
        // Select users for the test.
        date mydate1 = date.parse('05/11/2017');
        date mydate2 = date.parse('05/11/2030');
        DateTime date1 = Date.today();
        
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        List<Account> accts = new List<Account>();
        List<Contact> conts = new List<Contact>();
        List<PriceStorage__c> psList = new List<PriceStorage__c>();
        List<relationship__c> relList = new List<relationship__c>();
        List<PriceStorageTeam__c> psTeamList = new List<PriceStorageTeam__c>();
        List<Product2> productList = new List<Product2>();
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User WHERE IsActive = true AND ByPassTriggerRule__c = false
                            AND ProfileId =: p2.Id LIMIT 5];
        Id user1Id = users[0].Id;
        Id user2Id = users[1].Id;
        Id user3Id = users[2].Id;
        
        users[0].ByPassValidationRule__c = true;
        update users[0];
        
        system.runas(users[0]){
            
            for(Integer i=0;i<numRec;i++) {
                
                Product2 p3 = new product2();
                p3.Name = 'kjskd' + i;
                p3.ManufacturingImerysPlant__c = '';
                p3.IsActive = true;
                productList.add(p3);
            }
            
            for(Integer i=0;i<numRec;i++) {
                
                Account acc1 = new Account();
                acc1.Name = 'sdsdasassd1dsdsdd' + i;
                acc1.BillingCountry = 'United States';
                acc1.BillingCity = 'New York';
                acc1.SegmentL1__c = 'Abrasive';
                acc1.Type = 'Head Office';
                accts.add(acc1);
            }
            Database.insert(accts, true); 
            
            for(Integer i=0;i<numRec;i++) {
                
                Account acct = accts[i];
                relationship__c relation = new Relationship__c();
                relation.AccountName__c = acct.Id;
                relation.AccountManager__c = user1Id;
                relation.SubType__c = 'Consultant';
                relation.BusinessArea__c = 'HTS';
                //relation.SegmentL2__c = 'Automotive';
                relList.add(relation);
            }   
            
            Database.insert(relList, true);
            
            /*for(Integer j=0;j<numRec;j++) {
                
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
            insert markSeg;*/
            
            
            
            for(Integer j=0;j<numRec;j++) {
                
                Account acct = accts[j];
                //Contact cct = conts[j];
               // Product2 prod = productList[j];
                                
                PriceStorage__c priceStorage = new PriceStorage__c();
                priceStorage.Account__c = acct.Id;
                priceStorage.Status__c = 'Draft Creation';
                priceStorage.BusinessArea__c = 'HTS';
                PriceStorage.AccountManager__c = User1Id;
                PriceStorage.SellingEntity2__c = 'AT - Imerys Carbonates Austria';
                PriceStorage.Selling_Entity__c = '10';
                priceStorage.SellingEntity2__c = 'AR - Imerys Minerales Argentina';
                PriceStorage.Start_of_Validity__c = mydate1;
                PriceStorage.End_Of_Validity__c = mydate2;
                psList.add(priceStorage);
            }
            
            insert psList;
            
            
            for(Integer j=0;j<numRec;j++) {
                
                PriceStorage__c ps = psList[j];
                
                for (Integer k=0;k<numTeamPerSamp;k++) {
                    
                    PriceStorageTeam__c team = new PriceStorageTeam__c();
                    team.Member__c = user1Id;
                    team.Role__c = 'Front Office';
                    team.Price_Storage__c = ps.Id;
                    team.Access__c = 'Edit';
                    psTeamList.add(team);
                }
            }
            
            Test.startTest();           
            	Database.Insert(psTeamList, true);
            Test.stopTest();
            
            Database.update(psTeamList,true);
            
            Database.delete(psTeamList,true);
            
            // Insert manual share for user who is not record owner. 
            // Query visit report records.
           /* List<Sample__Share> sampleShrs = [SELECT Id, UserOrGroupId, AccessLevel, 
                                              RowCause FROM Sample__Share WHERE ParentId =: samTeamList[0].Id];
            
            // Test attributes of manual share.
            if(sampleShrs.size() > 0){
                System.assertEquals(sampleShrs[0].AccessLevel, 'Edit');
            }*/
            
        }              
    }



         
    public static void testMapResponsibleParty(){
        
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
            o.StageName = 'New';
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
    
public static void testMapResponsibleParty2(){
        
        
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
            o.StageName = 'New';
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
    public static void testMapResponsibleParty3(){
        
        
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
            o.StageName = 'New';
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

     
    
   /*@author Jaunbocus Muhammad Irshaad
*@Date Draft Creation 06/05/2021
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/ 
    
    /**
*@author Jaunbocus Muhammad Irshaad
*@Date Draft Creation 09/05/2021
*@Date modification 
*@param 
*@ExcptionName
*@return 
*/ 
    /*
public static void testUpdateOpportunity(){
List<Profile> lstAdminPro = [SELECT Id From Profile 
WHERE Name = 'System Administrator'
limit 1];

List<User> usersActive = [SELECT Id FROM User 
WHERE IsActive = true 
AND ByPassTriggerRule__c = false 
LIMIT 100];                               

List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User 
WHERE IsActive = true 
AND ByPassTriggerRule__c = false 
AND ProfileId =: lstAdminPro[0].Id LIMIT 1];

// List<Shortlisted_Imerys_Product__c> ImerysProdList = new List <Shortlisted_Imerys_Product__c>();

users[0].ByPassValidationRule__c = true;
update users[0];

system.RunAs(users[0]){ 

Account acc1 = new Account();
acc1.Name = 'sdsdasassd1dsdsdd';
acc1.BillingCountry = 'United States';
acc1.BillingCity = 'New york';
acc1.SegmentL1__c = 'Abrasive';
acc1.Type = 'Head Office';
Database.insert(acc1, true); 

opportunity opp = new opportunity();
opp.name = 'Pizza King Oppty';
opp.AccountId = acc1.Id;
opp.CloseDate = system.today();
opp.StageName = 'New';
opp.Probability = 20;
opp.Division__c = 'Ceramics';
insert opp;

// Insert a test product.
Product2 prod = new Product2(Name = 'Laptop X200', 
Family = 'Hardware');
insert prod;

// Get standard price book ID.
// This is available irrespective of the state of SeeAllData.
Id pricebookId = Test.getStandardPricebookId();

// 1. Insert a price book entry for the standard price book.
// Standard price book entries require the standard price book ID we got earlier.
PricebookEntry standardPrice = new PricebookEntry(
Pricebook2Id = pricebookId, Product2Id = prod.Id,
UnitPrice = 10000, IsActive = true);
insert standardPrice;


OpportunityLineItem OppoLineItem = new OpportunityLineItem();
OppoLineItem.OpportunityId = opp.id;
OppoLineItem.Product2Id = prod.Id;
OppoLineItem.Quantity = 2;
OppoLineItem.TotalPrice = 100;
OppoLineItem.PricebookEntryId = standardPrice.id ;

insert OppoLineItem;

Map<id,Opportunity> OppoToUpdate

}
}*/
    
/*@author sipra Sahoo
*@Date Creation 07/01/2022
*@Date modification 
*@param aNewList to fill relationship.                      
*/ 
    public static void testpopulateOwnerFromGateKeeperAssignment() {
        Profile p2 = [select id from profile where name='System Administrator' LIMIT 1];
        List<User> users = [SELECT Id, ByPassTriggerRule__c,ByPassValidationRule__c FROM User WHERE IsActive = true AND
                            ByPassTriggerRule__c = false 
                            AND profile.Id =: p2.Id LIMIT 100];
        
        users[0].ByPassValidationRule__c = true;
        update users[0];
        
        system.runas(users[0]){
            
            Id user1Id = users[0].Id;
            GatekeeperAssignment__c gat = New GatekeeperAssignment__c();
            gat.Division__c = 'Aluminates';
            gat.Gatekeeper__c = User1Id;
            gat.ManufacturingImerysPlant__c = 'AT - Villach';
            gat.Object__c = 'Lead';
            gat.BusinessArea__c = 'RAC';
            gat.MarketSegmentL1__c = 'ACS';
            gat.Area__c ='EMEA';
            Test.startTest(); 
            insert gat;
            Lead lead = new Lead();
            lead.MarketL1__c =gat.MarketSegmentL1__c;
            lead.Area__c =gat.Area__c;
            lead.Country ='United States';
            lead.Email = 'gktest123@gmail.com';
            lead.Company ='account';
            lead.LastName =  'Client';
            insert lead;
            test.stopTest(); 
            
        }
        
        
    }   

Public static void testDeleteOutOfOfficeUser(){
        String recordTypeName;
        date mydate = date.parse('05/11/2012');
        date mydate2 = date.parse('08/12/2018');
        date mydate1 = date.parse('05/11/2017');
        
        List<User> usersListActive = [SELECT Id FROM User 
                                      WHERE IsActive = true 
                                      AND ByPassTriggerRule__c = false 
                                      LIMIT 100];
        
        List<User> userUpdBackup = new List<User>();
        List<outOfOffice> outOfList = new List<outOfOffice>();
        DateTime date1 = Date.today();
        
        List<Profile> lstAdminPro = [SELECT Id From Profile 
                                     WHERE Name = 'System Administrator'
                                     limit 1];
        
        List<User> users = [SELECT Id, ByPassTriggerRule__c FROM User 
                            WHERE IsActive = true 
                            AND ByPassTriggerRule__c = false 
                            AND ProfileId =: lstAdminPro[0].Id LIMIT 1];
        
        user bypassValidation = [SELECT Id, Email, ByPassValidationRule__c, MultiPicklistDivision__c, Division FROM 
                                 User WHERE Id=:users[0].Id LIMIT 1];
        
        if(bypassValidation.Division == null){
            bypassValidation.Division = 'None';
        }
        if(bypassValidation.MultiPicklistDivision__c == null){
            bypassValidation.MultiPicklistDivision__c = 'Calderys';
        }       
        
        bypassValidation.ByPassValidationRule__c = true;
        bypassValidation.CountryforGatekeeper__c = 'Albania';
        bypassValidation.BackupComplaint__c = usersListActive[2].Id;
        
        update bypassValidation;   
        
        system.RunAs(users[0]){
            
            Account acc1 = new Account();
            acc1.Name = 'sdsdasassd1dsdsdd';
            acc1.BillingCountry = 'United States';
            acc1.BillingCity = 'New York';
            acc1.SegmentL1__c = 'Abrasive';
            acc1.Type = 'Head Office';
            Database.insert(acc1, true);    
            
            Contact con = new Contact();
            con.Salutation = 'Mr.';
            con.FirstName = 'Shia';
            con.Email = 'test@accenture.com.com';
            con.LastName= 'ALISHA';
            con.AccountId = acc1.Id;
            Database.insert(con, true);
            
            Product2 p = new product2();
            p.Name = 'zzzz';
            p.IsActive = true;
            p.ManufacturingImerysPlant__c = '';
            p.Division__c = 'Calderys';
            
            GatekeeperAssignment__c gat = New GatekeeperAssignment__c();
            gat.Division__c = 'Calderys';
            gat.Gatekeeper__c = Users[0].Id;
            gat.AllPlants__c = true;
            gat.Object__c = 'Sample';
            gat.BusinessArea__c = 'HTS';
            
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
            sam.Status__c = 'Draft Creation';
            sam.Type__c = 'Lab';
            sam.CSAccountManager__c = Users[0].Id;
            sam.ExpectedDeliveryDate__c = mydate2;
            sam.ProductName__c = p.Id;
            sam.Volume__c = 1233;
            sam.OwnerId = Users[0].Id;
            sam.BusinessArea__c = 'RAC';
            sam.Unit__c = 'Metric tons (as sold)';
            sam.GateKeeper__c = usersListActive[2].Id;
            sam.DateOfFeedback__c = mydate1;
            sam.DispatchSite__c ='FR - Iko';
            Database.Insert(sam, true);// insert new record with status Draft Creation
            
            OutOfOffice outOf = new OutOfOffice();
            outOf.EndDate = date1;
            outOf.StartDate = date1;
            outOf.Message = 'Out of Office';
            outOf.UserId = users[0].Id;
            outOf.IsEnabled = true;
            outOfList.add(outOf);
            
            insert outOf;
            
            list<OutOfOffice> deleOO=[SELECT Id, UserId, IsEnabled, Message, StartDate, EndDate FROM OutOfOffice];
            
            test.startTest();
     		delete deleOO;
           	test.stopTest();
        }
}
}