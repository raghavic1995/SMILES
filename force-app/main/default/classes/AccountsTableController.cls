public with sharing class AccountsTableController {
     @AuraEnabled
    public static boolean haspermission(id AccountPlanId){
        {	
            boolean Permission;
            set<Id> setOfUsers = new set<Id>();
            set<Id> AccPlanOwner = new set<Id>();
            set<Id> AccPlanTeammember = new set<Id>();
            set<Id> AccPlanShare= new set<Id>();	
            set<Id> groupId= new set<Id>();
            Id userid = UserInfo.getUserId();
            Id profileId=UserInfo.getProfileId();
            String profileName=[Select Id,Name from Profile where Id=:profileId].Name;
            ID accountid =[select id,Account__r.id   from Account_Plan__c  where id =: AccountPlanId].Account__r.id ;
            
            list<AccountPlanTeam__c> listOfAccountPlanTeamMember = [select id,AccountPlanNo__c,Access__c,Member__c from AccountPlanTeam__c where AccountPlanNo__c =:AccountPlanId];

            list<Account_Plan__c> AccplanOwnerlist = [select id,ownerid from Account_Plan__c  where id =: AccountPlanId];
            list<Account_Plan__Share> AccPlanShareList= [select id,UserOrGroupId,AccessLevel from Account_Plan__Share where parent.id=: AccountPlanId and AccessLevel='Edit' ];
            
            for(Account_Plan__Share ashare : AccPlanShareList ){   
                groupId.add(ashare.UserOrGroupId); 
            }
            
             List<GroupMember> GroupMemberList= [select id,UserOrGroupId from GroupMember where groupId in: groupId ];
            
            for(GroupMember gm : GroupMemberList){
                if(userid == gm.UserOrGroupId ){
                    AccPlanShare.add(userid);
                }
            }

            
            
            
            /* Modified by Anshu Singh 20/04/2023
             * as part of US 2266
             
             list<AccountTeamMember> listOfAccountTeamMember = [select id,UserId,User.Profile.name  from AccountTeamMember where Account.id =:accountid];
            for(AccountTeamMember atm : listOfAccountTeamMember ){       
                setOfUsers.add(atm.UserId);  
            }*/
             for(Account_Plan__c acplanowner : AccplanOwnerlist ){       
                AccPlanOwner.add(acplanowner.ownerid);  
            }
            for(AccountPlanTeam__c aptm : listOfAccountPlanTeamMember ){   
                if(aptm.Access__c == 'Edit'){
                    AccPlanTeammember.add(aptm.Member__c);   
                }
            }
            if(AccPlanTeammember.contains(userid)|| AccPlanOwner.contains(userid)||profileName=='System Administrator'||AccPlanShare.contains(userid) ){
                Permission = false;
            }
            else{
                Permission = true;
            }
             system.debug('=== ex : ' + Permission);
            //system.debug('=== AccountPlanTeam Member : ' + AccPlanTeammember.size());
            //system.debug('=== Owner: ' + AccPlanOwner);
            
            return Permission; 
           
        }
    }
   
   
     @AuraEnabled
    public static string getaccID(Id recordId) {
        List<Contact> listOfContact; 
        string  accountId;
        if(recordId != null){
            accountId  = [select id,Account__c from Account_Plan__c where id =:recordId].Account__c;   
        }
        return accountId;
        
    }
    
    
    @AuraEnabled
    public static List<Contact> getRecords(Id recordId) {
        List<Contact> listOfContact; 
        List<Contact> listOfContact2; 
        List<Contact> listOfContact3;
        List<Contact> CombineContacts= new  List<Contact>();
        Id accountId;
        List<Id> accountIds = new List<Id>();
        List<Id> accountIds2 = new List<Id>();
        List<Id> accountIds3 = new List<Id>();
        Set<Id> childAccountIds = new Set<Id>();
        
        if(recordId != null){
            accountId  = [select id,Account__c from Account_Plan__c where id =:recordId].Account__c;   
        }
        
        if(accountId != null){
            list<Account> accountListRecord = [select id from account where id=:accountId];
            for(Account eachRecord : accountListRecord ){
                accountIds.add(eachRecord.Id);
            }
            
        listOfContact = [select id,name,Imerys_action__c,Imerys_Strategy__c, Attitude__c,MailingCity, MailingCountry, Influence__c from Contact where AccountId IN: accountIds];
            
        list<Account> parentAccountList = [select id from account where ParentId =:accountId];
        for(Account eachRecord : parentAccountList ){
            accountIds2.add(eachRecord.Id);
            //By Anshu for accessing grandchild records
            childAccountIds.add(eachRecord.Id);
            }
            
        listOfContact2 = [select id,name,Imerys_action__c,Imerys_Strategy__c, Attitude__c,MailingCity, MailingCountry, Influence__c from Contact where AccountId IN: accountIds2];
            
        //retrieving grand child records by Anshu
        list<Account> grandChildAccountList = [select id from account where ParentId in:childAccountIds ];
        for(Account eachRecord : grandChildAccountList ){
            accountIds3.add(eachRecord.Id);
            }
            
        listOfContact3 = [select id,name,Imerys_action__c,Imerys_Strategy__c, Attitude__c,MailingCity, MailingCountry, Influence__c from Contact where AccountId IN: accountIds3];
            
        }
        
        CombineContacts.addAll(listOfContact);
        CombineContacts.addAll(listOfContact2);
        CombineContacts.addAll(listOfContact3);
        
        
        return CombineContacts;
    }
    
    @AuraEnabled 
    public static void updateContact(Id ContactRecordId, string Country,string City, string Attitude,string Action,string Influence,string Strategy){
        
        System.debug('@coubnt '+Country);
          
        Map<String, String> countrymap = getIndustryFieldValue();
         string actualcountry = countrymap.get(Country);
        System.debug('@actualcountry '+actualcountry);
        
        list<Contact>  listOfContact = [select id,name,Imerys_action__c,Imerys_Strategy__c, Attitude__c,MailingCity, MailingCountry, Influence__c from Contact where  id=: ContactRecordId];
        
        list<Contact> updatecontactlist = new list<Contact>();
        for(Contact cont : listOfContact){
            cont.MailingCountry = actualcountry;
            cont.MailingCity = City;
            cont.Attitude__c = Attitude;
            cont.Imerys_action__c = Action;
            cont.Influence__c = Influence;
            cont.Imerys_Strategy__c = Strategy; 
            updatecontactlist.add(cont); 
        }
        
        if(updatecontactlist != null){
            update updatecontactlist;
        }   
    }
    
    @AuraEnabled
    public static String getUserName(Id userId){
        return [SELECT Name FROM User WHERE Id=:userId].Name;
    }
    
    
    
    @AuraEnabled 
    public static Map<String, String> getIndustryFieldValue(){
        Map<String, String> options = new Map<String, String>();
        Schema.DescribeFieldResult fieldResult = Contact.MailingCountryCode.getDescribe();
        List<Schema.PicklistEntry> pValues = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pValues) {
            options.put(p.getValue(), p.getLabel());
        }
        return options;
    }
    
    @AuraEnabled 
    public static Map<String, String> getPicklistValuesForAttitue(){
        Map<String, String> options = new Map<String, String>();
        Schema.DescribeFieldResult fieldResult = Contact.Attitude__c.getDescribe();
        List<Schema.PicklistEntry> pValues = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pValues) {
            options.put(p.getValue(), p.getLabel());
        }
        return options;
    }
    
    @AuraEnabled 
    public static Map<String, String> getPicklistValuesForInfluence(){
        Map<String, String> options = new Map<String, String>();
        Schema.DescribeFieldResult fieldResult = Contact.Influence__c.getDescribe();
        List<Schema.PicklistEntry> pValues = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pValues) {
            options.put(p.getValue(), p.getLabel());
        }
        return options;
    }
    
    
    
    
}