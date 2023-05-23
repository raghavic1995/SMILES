public class ShareOfWallet {

    @AuraEnabled
    public static List<Account> fetchchildAcc(id AccountplanID){
        list<account> listOfAccount;
        if(AccountplanID != null){
            Id accid = [Select id,Name,Account__c from Account_Plan__c where id =: AccountplanID].Account__c;
            if(accid != null){
                listOfAccount = [select Id,Name,OwnerId,Owner.Name,Imerys_Product__r.Name, ShippingAddress,ShippingCountry,ShippingCity, ShippingPostalCode,Imerys_share_of_wallet__c,
                                 Imerys_potential__c,Target_share_of_wallet__c,Imerys_margin__c,Units__c,AnnualRevenue,Area__c,Total_consumption_in_Volume__c from account where ParentId =: accid];
                
            }
        }
        return listOfAccount;
    }
    
    
    
    @AuraEnabled   
    public static boolean updateChildAccts( List<Account> UpdatedAcctList ) {   
        try { 
            update UpdatedAcctList; 
            return true; 
        } catch(Exception e) { 
            return false;   
        }      
    }   
    
    
    @AuraEnabled(cacheable=true)
    public static List<User> fetchAcc (String searchKey){
        String query= 'SELECT Id, Name FROM User';
        if ( searchKey != Null ) {
            String key = '%' + searchKey + '%';
            query += ' WHERE Name LIKE :key';
        }system.debug(Database.query( query ));
        return Database.query( query );
        
    }  
    
    @AuraEnabled
    public static List<Account_Plan__c> KeyAccountOverview(id recid){
        List<Account_Plan__c> KeyAccountOverviewList = [Select id,Key_Account_Challenges__c,Key_Account_Benefits__c,
                                                        Value_Proposition__c,HowdoesImerysdeliverthisvalueprop__c from Account_Plan__c where id =: recid];
        
        
        return KeyAccountOverviewList;
    }
    
    
    @AuraEnabled
    public static void KeyAccountOverviewRecordUpdate(Id recid , string AccountChallengesvalue,string AccountBenefitsvalue,string valueProposition,string ImerysDeliverthisvalueproposition){
        List<Account_Plan__c> accountplant = new  List<Account_Plan__c>();
        
        List<Account_Plan__c> KeyAccountOverviewList = [Select id,Key_Account_Challenges__c,Key_Account_Benefits__c,
                                                        Value_Proposition__c,HowdoesImerysdeliverthisvalueprop__c from Account_Plan__c where id =: recid];
        
        for(Account_Plan__c accplan : KeyAccountOverviewList){
            if(AccountChallengesvalue !=null)
                accplan.Key_Account_Challenges__c =  AccountChallengesvalue != null ?  AccountChallengesvalue : null;
            accplan.Key_Account_Benefits__c =  AccountBenefitsvalue != null ?  AccountBenefitsvalue : null;
            accplan.Value_Proposition__c = valueProposition != null ?  valueProposition : null;
            accplan.HowdoesImerysdeliverthisvalueprop__c =  ImerysDeliverthisvalueproposition != null ?  ImerysDeliverthisvalueproposition : null;
            
            accountplant.add(accplan);
        }
        
        if(accountplant != null){
            update accountplant;
        }
        
    }
    
    @AuraEnabled
    public static boolean haspermission(id recid){
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
            ID accountid =[select id,Account__r.id   from Account_Plan__c  where id =: recid].Account__r.id ;
            
            list<AccountPlanTeam__c> listOfAccountPlanTeamMember = [select id,AccountPlanNo__c,Access__c,Member__c from AccountPlanTeam__c where AccountPlanNo__c =:recid];

            list<Account_Plan__c> AccplanOwnerlist = [select id,ownerid from Account_Plan__c  where id =: recid];
            list<Account_Plan__Share> AccPlanShareList= [select id,UserOrGroupId,AccessLevel from Account_Plan__Share where parent.id=: recid and AccessLevel='Edit' ];
            
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
            return Permission; 
           
        }
    }
    
    @AuraEnabled
    public static List<Account> getChildAccounts(String accountPlanId){
        system.debug('====Inside getChildAccounts....');
        if(String.isNotEmpty(accountPlanId)){
            system.debug('====Account ID : ' + accountPlanId);
            return [select Id,Name,Owner.name,Business_Areas__c	,BillingCity ,BillingCountry, BillingPostalCode from account 
                    where ParentId In (Select Account__c from Account_Plan__c where Id=:accountPlanId)];
        }
        return null;
        
    }
    
    @AuraEnabled
    public static Account_Plan__c getParentInfo(String accountPlanId ){
        system.debug('===== inside getParentInfo....');
        return [Select Id, Name,Account__r.Name,Account__r.Contact_Name__c,Account__r.Foundation__c,Account__r.HQ__c,
                Account__r.Employees__c,Account__r.Company_type__c,Account__r.Ownership,Account__r.Management__c,
                Account__r.Market_Shares__c,Account__r.Contact__r.Name, Account__r.Id, Business_Description__c,
                Geographical_Reach__c, Important_Innovations__c, Major_Clients__c, Key_Competitors__c from Account_Plan__c 
                where Id =: accountPlanId limit 1];    
    }
    
    @AuraEnabled
    public static String updateAccountPlanOnSave(String accountPlan ){
        system.debug('accountPlanRecord : '+ accountPlan);
        if(accountPlan != null){
            try{
                Account_Plan__c accountPlanRec = (Account_Plan__c)JSON.deserialize(accountPlan, Account_Plan__c.class);
                update accountPlanRec;
                system.debug('=== accountPlanRec : ' + accountPlanRec);
                return 'Success';
            }catch(DmlException ex){
              //  system.debug('=== ex : ' + ex);
              //  system.debug('=== Message : ' + ex.getMessage());
              //  system.debug('=== StackTraceString : ' + ex.getStackTraceString());
              //  return ex.getMessage();
            }  
        }
        
        return null;
    }
    
}