public class AccountOverview {  
    @AuraEnabled
    public static boolean haspermission(id accountPlanId){
        {   
            boolean Permission;
            set<Id> setOfUsers = new set<Id>(); 
            Id userid = UserInfo.getUserId();
            ID accountid =[select id,Account__r.id   from Account_Plan__c  where id =: accountPlanId].Account__r.id ;
            list<AccountTeamMember> listOfAccountTeamMember = [select id,UserId,User.Profile.name  from AccountTeamMember where Account.id =:accountid];
            for(AccountTeamMember atm : listOfAccountTeamMember ){       
                setOfUsers.add(atm.UserId);  
            }

            if(setOfUsers.contains(userid)){
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
    public static List<Account> getChildAccounts(String accountPlanId){
        system.debug('====Inside getChildAccounts....');
        if(String.isNotEmpty(accountPlanId)){
            system.debug('====Account ID : ' + accountPlanId);
            return [select Id,Name,Owner.name, ShippingStreet,ShippingCountry, ShippingCity, ShippingPostalCode from account 
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
                Geographical_Reach__c, Important_Innovations__c, Major_Clients__c, Key_Competitors__c , Comments__c from Account_Plan__c 
                where Id =: accountPlanId limit 1];    
    }
    
    @AuraEnabled
    public static String updateAccountPlanOnSave(String accountPlan ){
        system.debug('accountPlanRecord : '+ accountPlan);
        if(null !=accountPlan){
            try{
                Account_Plan__c accountPlanRec = (Account_Plan__c)JSON.deserialize(accountPlan, Account_Plan__c.class);
                system.debug('Account foundation value is: '+accountPlanRec.Account__r.Foundation__c);
                system.debug('Account Id value is: '+accountPlanRec.Account__c);
                update accountPlanRec;
                system.debug('=== accountPlanRec : ' + accountPlanRec);
                return 'Success';
            }catch(DmlException ex){
                Account_Plan__c accountPlanRec = (Account_Plan__c)JSON.deserialize(accountPlan, Account_Plan__c.class);
                accountPlanRec.adderror('User Access Restricted');
                system.debug('=== ex : ' + ex);
                system.debug('=== Message : ' + ex.getMessage());
                system.debug('=== StackTraceString : ' + ex.getStackTraceString());
               // return ex.getMessage();
            }  
        }
        
        return null;
    }


}