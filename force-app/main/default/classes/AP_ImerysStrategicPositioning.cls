public class AP_ImerysStrategicPositioning {
    
    
    @AuraEnabled
    public static List<Account_Plan__c> newAccPlan(id recid){
     	return [Select Id, Production_and_Solution_Development_Stra__c,Strategy__c,Pricing_Strategy__c, Contract_Strategy__c,Service_Strategy__c From Account_Plan__c Where Id=:recid];
        
    }
    
    @AuraEnabled
    public static void KeyAccountOverviewRecordUpdate(Id recid , string ProductionStrategy,string Strategy,string PricingStrategy,string ServiceStrategy, string ContractStrategy){
        List<Account_Plan__c> accountplant = new  List<Account_Plan__c>();
        
        List<Account_Plan__c> KeyAccountOverviewList = [Select id,Production_and_Solution_Development_Stra__c,Pricing_Strategy__c,Service_Strategy__c,
                                                        Contract_Strategy__c,Strategy__c from Account_Plan__c where id =: recid];
        
        for(Account_Plan__c accplan : KeyAccountOverviewList){
           // if(AccountChallengesvalue !=null)
            accplan.Production_and_Solution_Development_Stra__c =  ProductionStrategy != null ?  ProductionStrategy : null;
            accplan.Pricing_Strategy__c =  PricingStrategy != null ?  PricingStrategy : null;
            accplan.Contract_Strategy__c = ContractStrategy != null ?  ContractStrategy : null;
            accplan.Service_Strategy__c =  ServiceStrategy != null ?  ServiceStrategy : null;
            accplan.Strategy__c =  Strategy != null ?  Strategy : null;
            
            
            accountplant.add(accplan);
        }
        
        if(accountplant != null){
            update accountplant;
        }
        
    }
    
    @AuraEnabled
    public static boolean haspermission(id AccountplanId){
        	
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