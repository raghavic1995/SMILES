public class AccountPlanStages {
   @AuraEnabled
    public static boolean haspermission(id AccountplanId){
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
            return Permission; 
           
        }
    }
       
    
    @AuraEnabled
    public static list<Account_Plan_Priorities__c> getAccountPlanPrioritiesList(Id AccountplanID) 
    {       list<Account_Plan_Priorities__c> listOfaccPlanPrioritiesList;
     try{
         if(AccountplanID != null){
             listOfaccPlanPrioritiesList = [Select id,Top_5_Priorities__c,List_Priorities_of_the_Key_Account__c,
                                            Rating_for_Priorities_of_the_Key_Account__c,Rating_for_Imerys_Internal_Fit__c,
                                            Description_for_the_Priorities_of_the_Ke__c from Account_Plan_Priorities__c where Account_Plan__c =:AccountplanID   Order by  CreatedDate ASC  ];
         } 
     }catch(Exception EX){
         EX.getMessage();
     }
     return listOfaccPlanPrioritiesList;
    }
    
    @AuraEnabled
    public static List<Account_Plan_Priorities__c> saveAccountPlanPrioritiesList(List<Account_Plan_Priorities__c> accPlanPrioritiesList){  
        
        try{
            if(accPlanPrioritiesList != null){
                update accPlanPrioritiesList;
            }
        }catch(Exception EX){
            EX.getMessage();
        }
        return accPlanPrioritiesList;
        
    }
    
    
    @AuraEnabled
    public static void InsertAccountPlanPrioritiesList( Id Accplanrecid,string accppPriorityKA,string accppRatingPriority,
                                                       string accppRatingIMS,string accppDescription)
    {      
        try{
            if(Accplanrecid != null &&  accppPriorityKA != null && accppRatingPriority !=null && accppRatingIMS !=null){
                
                Account_Plan_Priorities__c  AccPlanPriority = new Account_Plan_Priorities__c();
                AccPlanPriority.Account_Plan__c = Accplanrecid;
                AccPlanPriority.List_Priorities_of_the_Key_Account__c = accppPriorityKA;
                AccPlanPriority.Rating_for_Priorities_of_the_Key_Account__c = accppRatingPriority;
                AccPlanPriority.Rating_for_Imerys_Internal_Fit__c = accppRatingIMS;
                AccPlanPriority.Description_for_the_Priorities_of_the_Ke__c = accppDescription;
                insert AccPlanPriority;
            }
        }catch(Exception EX){
            EX.getMessage();
        }
        
    }
    
    @AuraEnabled
    public static String deletePriorities(List<Account_Plan_Priorities__c> accPriorities){
       	String value= 'No';
        system.debug('hello');
        
        List<Account_Plan_Priorities__c> accPrioritiesList=[select Top_5_Priorities__c from Account_Plan_Priorities__c where id in:accPriorities ];
        for(Account_Plan_Priorities__c appList:accPrioritiesList){
            if(appList.Top_5_Priorities__c==true){
                delete appList;
                value='Yes';
            }
        }
        return value;
        

    }
    
}