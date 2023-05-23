public without sharing class AP01_AccountPlanTriggerHandler extends TriggerHandler {
    
    /* commented by Anshu 24/4/23 
    public static void hasPermission(list<Account_Plan__c> aNewList , list<Account_Plan__c> aoldsList ) {
        Id accountId;
        Id accountPlanId;
        Id OldownerId;
        list<AccountTeamMember> listOfAccountTeamMember;
        list<AccountPlanTeam__c> listOfAccountPlanTeam;
        ID userid = UserInfo.getUserId();
        set<Id> ATMids = new  set<Id>();
        set<Id> APTMids = new  set<Id>();
        
        for(Account_Plan__c eachAccPlan : aNewList  ){
            accountPlanId = eachAccPlan.Id; 
            if(eachAccPlan.Account__c  != null  ){
                accountId = eachAccPlan.Account__c;
            }
        }    
        if(accountId != null){
            listOfAccountTeamMember= [select id,UserId from AccountTeamMember where Account.id =: accountId];
        }
        if(listOfAccountTeamMember != null){
            for(AccountTeamMember ATM : listOfAccountTeamMember){
                if(ATM.UserId != null){
                    ATMids.add(ATM.UserId);
                }   
            }  
        }
        if( accountPlanId  != null){
            listOfAccountPlanTeam  =[select id,AccountPlanNo__c,Member__c from AccountPlanTeam__c where AccountPlanNo__c =: accountPlanId AND Access__c = 'Edit' ];   
        }
        if(listOfAccountPlanTeam != null){
            for(AccountPlanTeam__c APTM : listOfAccountPlanTeam){
                APTMids.add(APTM.Member__c);
            }        
        }
        for(Account_Plan__c aPlan : aoldsList){
            OldownerId = aPlan.OwnerId;  
        }
        for(Account_Plan__c aPlan : aNewList){
           if(ATMids.contains(userid) && !APTMids.contains(userid) && OldownerId != userid  ){
                aPlan.addError('Access restricted. Available only to the current Account Plan Owner and Account Plan Team member with read and write access');
            }
            else if(!ATMids.contains(userid) && !APTMids.contains(userid) && OldownerId != userid  ){
                aPlan.addError('Access restricted. Available only to the current Account Plan Owner and Account Plan Team member with read and write access');
            }  
        } 
    }
    */
    
    /*
*@author Geerutsing Govind Kumar
*@Date Creation 7/12/2020
*@Date modification 
*@param                      
*@return 
*/  
    @future
    public static void techUpdateTeamMembers(set<String> aNewList) {
        Map<Id,Account_Plan__Share> techMap = new Map<Id, Account_Plan__Share>();
        Map<Id,Account_Plan__c> techUpdMap = new Map<Id, Account_Plan__c>();
        List<Account_Plan__Share> memberShareList = new List<Account_Plan__Share>();
        List<Account_Plan__c> tarNewList = new List<Account_Plan__c>();  
        Set<Id>techIdSet = new Set<Id>();
        Account_Plan__Share memberShareUpd; 
        
        for(Account_Plan__c tarNew : [select Id FROM Account_Plan__c where id in: aNewList]){
            tarNewList.add(tarNew);
        }       
        for(Account_Plan__c tar: tarNewList){
            techIdSet.add(tar.Id);
        }
        
        Map<Id, AccountPlanTeam__c> techTeamShare = new Map<Id, AccountPlanTeam__c>([SELECT Id, AccountPlanNo__c, Member__c, Access__c 
                                                                                     FROM AccountPlanTeam__c 
                                                                                     WHERE AccountPlanNo__c IN:techIdSet]);        
        if(techTeamShare.size() > 0){
            for(AccountPlanTeam__c techTeam: techTeamShare.values()){
                for(Account_Plan__c techT: tarNewList){ 
                    memberShareUpd = new Account_Plan__Share(); 
                    memberShareUpd.ParentId = techT.Id;
                    memberShareUpd.UserOrGroupId= techTeam.Member__c;          
                    // Set the access level
                    if(techTeam.Access__c == null){
                        memberShareUpd.AccessLevel = 'Edit';
                    }
                    else{
                        memberShareUpd.AccessLevel = techTeam.Access__c;
                    }                            
                    // Add objects to list for insert               
                    memberShareList.add(memberShareUpd);
                    
                }
            }
        }
        if(memberShareList.size() > 0){
            try{
                Database.upsert(memberShareList,false);
            }
            catch(DMLException e){
                System.Debug('Error in member createShare' + e);
            }  
        }
    }
    
    /*
    public static void techUpdateTeamMembersParents(set<String> aNewList) {    
        Map<Id,Account_Plan__Share> techMap = new Map<Id, Account_Plan__Share>();
        Map<Id,Account_Plan__c> techUpdMap = new Map<Id, Account_Plan__c>();
        List<Account_Plan__Share> memberShareList = new List<Account_Plan__Share>();
        List<Account_Plan__c> tarNewList = new List<Account_Plan__c>();  
        Set<Id>techIdSet = new Set<Id>();
        Account_Plan__Share memberShareUpd; 
        
        
        for(Account_Plan__c tarNew : [select Id FROM Account_Plan__c where id in: aNewList]){
            tarNewList.add(tarNew);
        }       
        for(Account_Plan__c tar: tarNewList){
            techIdSet.add(tar.Id);
        }
        
        Map<Id, AccountTeamMember> techTeamShare = new Map<Id, AccountTeamMember>([SELECT Id,AccountId,TeamMemberRole, AccountAccessLevel,ContactAccessLevel 
                                                                                   FROM AccountTeamMember
                                                                                   WHERE AccountId IN:techIdSet]);        
        if(techTeamShare.size() > 0){
            for(AccountTeamMember techTeam: techTeamShare.values()){
                for(Account_Plan__c techT: tarNewList){ 
                    memberShareUpd = new Account_Plan__Share(); 
                    memberShareUpd.ParentId = techT.Id;
                    memberShareUpd.UserOrGroupId= techTeam.TeamMemberRole;          
                    // Set the access level
                    if(techTeam.AccountAccessLevel == null){
                        memberShareUpd.AccessLevel = techTeam.AccountAccessLevel;
                        //  memberShareUpd.AccessLevel = 'Read only';
                    }
                    else{
                        //  memberShareUpd.AccessLevel = techTeam.AccountAccessLevel;
                        memberShareUpd.AccessLevel = 'Read';
                    }   
                    
                    // Add objects to list for insert               
                    memberShareList.add(memberShareUpd);
                    
                }
            }
        }
        if(memberShareList.size() > 0){
            try{
                Database.upsert(memberShareList,false);
            }
            catch(DMLException e){
                System.Debug('Error in member createShare' + e);
            }  
        }
    }
 */
    public override void beforeUpdate() {      
        //hasPermission(Trigger.new,Trigger.old); 
        
    }   
}