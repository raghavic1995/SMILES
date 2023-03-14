public class Strategicpriorities {
  
  @AuraEnabled
    public static boolean haspermission(id AccountplanId){
        {	
            boolean Permission;
            set<Id> setOfUsers = new set<Id>();
            set<Id> AccPlanOwner = new set<Id>();
            set<Id> AccPlanTeammember = new set<Id>();
            Id userid = UserInfo.getUserId();
            ID accountid =[select id,Account__r.id   from Account_Plan__c  where id =: AccountplanId].Account__r.id ;
            list<AccountTeamMember> listOfAccountTeamMember = [select id,UserId,User.Profile.name  from AccountTeamMember where Account.id =:accountid];
            list<AccountPlanTeam__c> listOfAccountPlanTeamMember = [select id,AccountPlanNo__c,Access__c,Member__c from AccountPlanTeam__c where AccountPlanNo__c =:AccountplanId];

            list<Account_Plan__c> AccplanOwnerlist = [select id,ownerid from Account_Plan__c  where id =: AccountplanId];
            for(AccountTeamMember atm : listOfAccountTeamMember ){       
                setOfUsers.add(atm.UserId);  
            }
             for(Account_Plan__c acplanowner : AccplanOwnerlist ){       
                AccPlanOwner.add(acplanowner.ownerid);  
            }
            for(AccountPlanTeam__c aptm : listOfAccountPlanTeamMember ){   
                if(aptm.Access__c == 'Read'){
                    AccPlanTeammember.add(aptm.Member__c);   
                }
            }
            if(setOfUsers.contains(userid) && !AccPlanOwner.contains(userid) ||AccPlanTeammember.contains(userid) && !AccPlanOwner.contains(userid) || !setOfUsers.contains(userid) && !AccPlanOwner.contains(userid) && AccPlanTeammember.contains(userid) ){
                Permission = true;
            }
            else{
                Permission = false;
            }
             system.debug('=== ex : ' + Permission);
            return Permission; 
           
        }
    }
       
    
    
    @AuraEnabled
    public static  list<Account_Plan_Priorities__c>  getAccountpriorites(id AccountplanID){
        list<Account_Plan_Priorities__c> listOfaccPlanPrioritiesList;
        try {	
            if(AccountplanID != null){
                listOfaccPlanPrioritiesList = [Select id, Top_5_Priorities__c, List_Priorities_of_the_Key_Account__c, Account_Plan__c,Win_Win_Partnership__c,Imerys_Strategic__c
                                               from Account_Plan_Priorities__c  where Account_Plan__c =:AccountplanID  AND Top_5_Priorities__c = true order by createddate ASC  ];
            } 
            
        }catch(Exception EX){
            EX.getMessage();
        }
        
        System.debug('@@listOfaccPlanPrioritiesList'+listOfaccPlanPrioritiesList);
        return listOfaccPlanPrioritiesList; 
    }
    
    
    @AuraEnabled
    public static  void  sumbitAccountPriorites(Id AccountplanID, list<Account_Plan_Priorities__c> row1, list<Account_Plan_Priorities__c> row2, list<Account_Plan_Priorities__c> row3, 
                                               list<Account_Plan_Priorities__c> row4, list<Account_Plan_Priorities__c> row5)
    {
        
        list<Account_Plan_Priorities__c> listtoinsert = new list<Account_Plan_Priorities__c>();
        try {	
            if(AccountplanID != null){
                
                if(row1!=Null){
                for(Account_Plan_Priorities__c APProw1 : row1 ){
                    if(APProw1.id != null){
                        listtoinsert.add(APProw1);
                    }
                }
                }
                
                if(row2!=Null){
                for(Account_Plan_Priorities__c APProw2 : row2 ){
                    if(APProw2.id != null){
                        listtoinsert.add(APProw2);
                    }
                }
                }
                
                
                if(row3!=Null){
                for(Account_Plan_Priorities__c APProw3 : row3 ){
                    if(APProw3.id != null){
                        listtoinsert.add(APProw3);
                    }
                }
                }
                
                if(row4!=Null){
                for(Account_Plan_Priorities__c APProw4 : row4 ){
                    if(APProw4.id != null){
                        listtoinsert.add(APProw4);
                    }
                }
                }
                if(row5!=Null){
                    for(Account_Plan_Priorities__c APProw5 : row5 ){
                    if(APProw5.id != null){
                        listtoinsert.add(APProw5);
                    }
                }
                    
                }
                
                if(listtoinsert != null){
                    update listtoinsert;
                    system.debug('listtoinsert is'+listtoinsert);
                }
            }      
        }catch(Exception EX){
            EX.getMessage();
            system.debug('listtoinsert is in catch'+listtoinsert);
        }
    }
   
}