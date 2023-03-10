public class AP01_AccountController {
    
    @AuraEnabled
    public static List <Account_Plan__c> fetchAccountPlan(String recId, Integer pageSize, Integer pageNumber) {
        Integer offset = (pageNumber - 1) * pageSize;
        List<Account_Plan__c> accPlanList = [SELECT Id, AccountPlanName__c,Stage__c, Year__c,Owner.Name, Business_Area__c from Account_Plan__c where Account__c =:recId LIMIT :pageSize OFFSET :offset];
        
        return accPlanList;
    }
    
    
    @AuraEnabled
    public static List<Account_Plan__c> fetchAccPlandetails(string searchstr) {
        System.debug('@@'+searchstr);
        String newSearchText = '%'+searchstr+'%';
        List <Account_Plan__c> AccPlanList = [SELECT AccountPlanName__c,Stage__c, Year__c,Owner.Name, Business_Area__c from Account_Plan__c WHERE AccountPlanName__c LIKE: newSearchText ];
        System.debug('@@'+AccPlanList);
        return AccPlanList;
    }
    
    @AuraEnabled
    public static String getUserDetails(){
        List<User> user1 = [select NewBusinessArea__c FROM User Where id =: userInfo.getUserId() limit 1];
        return user1[0].NewBusinessArea__c;
    }
    
    @AuraEnabled
    public static Account_Plan__c getEditUserDetails(ID recordId){
        Account_Plan__c accPlanList = [SELECT Id, AccountPlanName__c, Stage__c,Year__c,CurrencyIsoCode , Business_Area__c from Account_Plan__c where Id =: recordId ];
        return accPlanList;
    }
    
    
    
    @AuraEnabled 
    public static string accountPlanPermission(Id AccountId, Id AccountplanId) {
        String hasPermission;
        list<AccountTeamMember> listOfAccountTeamMember;
        list<AccountPlanTeam__c> listOfAccountPlanTeam;
        list<Account_Plan__c> listOfAccountPlan;
        ID userid = UserInfo.getUserId();
        set<Id> ATMids = new  set<Id>(); // Acccount Team 
        set<Id> APTMids = new  set<Id>(); // Account Plan Team
        Id profileId=userinfo.getProfileId();
		String profileName=[Select Id,Name from Profile where Id=:profileId].Name;
        
        if(AccountId != null){
            listOfAccountTeamMember= [select id,UserId from AccountTeamMember where Account.id =: AccountId];
        }
        if(listOfAccountTeamMember != null){
            for(AccountTeamMember ATM : listOfAccountTeamMember){
                if(ATM.UserId != null){
                    ATMids.add(ATM.UserId);
                }   
            }  
        }
        
        if( AccountplanId  != null){
            listOfAccountPlanTeam  =[select id,AccountPlanNo__c,Member__c,OwnerId from AccountPlanTeam__c where AccountPlanNo__c =: AccountplanId AND Access__c != 'Private'];   
        }
        if(listOfAccountPlanTeam != null){
            for(AccountPlanTeam__c APTM : listOfAccountPlanTeam){
                APTMids.add(APTM.Member__c);
            }        
        }
        
        if( AccountplanId  != null){
            listOfAccountPlan  =[select Id,OwnerId from Account_Plan__c where Id =: AccountplanId];   
        }
        
        
        if(listOfAccountPlan != null){
            for(Account_Plan__c aPlan : listOfAccountPlan){
                if(aPlan.OwnerId == userid || profileName=='System Administrator'){
                    hasPermission = 'false' ;// readable
                }
                else{
                if(ATMids.contains(userid) && !APTMids.contains(userid)){
                    hasPermission = 'True'; // read only
                }
                else if(!APTMids.contains(userid) && !ATMids.contains(userid)  && aPlan.OwnerId != userid ){
                    hasPermission = 'True' ;// read only
                }
                
                else if(!APTMids.contains(userid) && !ATMids.contains(userid) && aPlan.OwnerId == userid ){
                    hasPermission = 'false' ;// readable
                }
                else if(!APTMids.contains(userid) && ATMids.contains(userid) && aPlan.OwnerId == userid ){
                    hasPermission = 'false' ;// readable
                }
                else if((APTMids.contains(userid) || aPlan.OwnerId == userid) && ATMids.contains(userid)){
                    system.debug('last second else if');
                    hasPermission = 'false'; // readable
                }
                else if((APTMids.contains(userid) || aPlan.OwnerId == userid) && !ATMids.contains(userid)){ 
                    system.debug('last  else if');
                    hasPermission = 'false'; // readable
                } 
                }
            } 
                
        }
        return hasPermission;
    }
    
    
    
    //Delete Account
    @AuraEnabled
    public static void deleteAccountPlan(Account_Plan__c accPlan){
        System.debug('@@'+accPlan);
        Delete accPlan;
        
    } 
}