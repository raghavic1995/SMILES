public class AP01_AccountPlanTeamTriggerHandler extends TriggerHandler {
    
    
    public static void hasPermission(list<AccountPlanTeam__c> aNewList) {
        list<AccountPlanTeam__c>  listOfAccountPlanTeam;
        ID accountPlanId;
        ID accountPlanOwnerId;
        ID userid = UserInfo.getUserId();
        Set<Id> APTIds = new Set<Id>();
        Account_Plan__c  AccountplanRecord;
        Id profileId=userinfo.getProfileId();
		String profileName=[Select Id,Name from Profile where Id=:profileId].Name;
        
        for(AccountPlanTeam__c APT : aNewList){
            accountPlanId = APT.AccountPlanNo__c;
        }
        
        if(accountPlanId != null){
              AccountplanRecord = [SELECT Id,Ownerid  from Account_Plan__c where Id =: accountPlanId ];
        }
        
        if(accountPlanId != null){
            listOfAccountPlanTeam = [select id,AccountPlanNo__c,Member__c from AccountPlanTeam__c where AccountPlanNo__c =:accountPlanId  AND Access__c = 'Edit' ];        
        }
        for(AccountPlanTeam__c eachAccPlanTeam : listOfAccountPlanTeam){
            APTIds.add(eachAccPlanTeam.Member__c);  
        }
        
        if(AccountplanRecord != null)
        {
            for(AccountPlanTeam__c aPlanTeam : aNewList){   
                if(!APTIds.contains(userid) && AccountplanRecord.Ownerid != userid && profileName!='System Administrator' ){
                    aPlanTeam.addError('Access restricted. Available only to the current Account Plan Owner and Account Plan Team member with read and write access');
                }
                
            }  
        }
        
    }
    
    public override void beforeInsert() {      
        hasPermission(Trigger.new); 
    } 
     public override void beforeUpdate() {      
        hasPermission(Trigger.new); 
    } 
    
    public override void beforeDelete() {      
        hasPermission(Trigger.Old); 
    } 
    
}