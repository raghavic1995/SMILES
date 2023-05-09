public class SOW {
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
   /*
    @AuraEnabled
    public static boolean haspermission(id AccountplanId){
        boolean hasPermission;
        Id AccountId;
        list<AccountTeamMember> listOfAccountTeamMember;
        list<AccountPlanTeam__c> listOfAccountPlanTeam;
        list<Account_Plan__c> listOfAccountPlan;
        ID userid = UserInfo.getUserId();
        set<Id> ATMids = new  set<Id>(); // Acccount Team 
        set<Id> APTMids = new  set<Id>(); // Account Plan Team
        
        if(AccountPlanId != null){
            AccountId  = [select id,Account__c from Account_Plan__c where id =:AccountplanId].Account__c;   
        }
        
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
            listOfAccountPlanTeam  =[select id,AccountPlanNo__c,Member__c from AccountPlanTeam__c where AccountPlanNo__c =: AccountplanId];   
        }
        if(listOfAccountPlanTeam != null){
            for(AccountPlanTeam__c APTM : listOfAccountPlanTeam){
                APTMids.add(APTM.Member__c);
            }        
        }
        
        if( AccountplanId  != null){
            listOfAccountPlan  =[select Id from Account_Plan__c where Id =: AccountplanId];   
        }
        
        
        if(listOfAccountPlan != null){
            for(Account_Plan__c aPlan : listOfAccountPlan){
                if(ATMids.contains(userid) && !APTMids.contains(userid) ){
                    hasPermission = True; // read only
                }
                else if(!APTMids.contains(userid) && !ATMids.contains(userid)){
                    hasPermission = True ;// read only
                }
                else if(APTMids.contains(userid) && ATMids.contains(userid)){
                    hasPermission = false; // readable
                }
                else if(APTMids.contains(userid) && !ATMids.contains(userid)){
                    hasPermission = false; // readable
                }
            } 
        }
        
        
        return hasPermission;
    }
    
    */
   
    @AuraEnabled
    public static List <Account> fetchAccounts(Id AccountPlanID) {
        
        Id AccountId;
        List<Account> accList;
        List<Account> accListParent;
        List<Account> combineList= new List<Account>();
        if(AccountPlanID != null){
            AccountId  = [select id,Account__c from Account_Plan__c where id =:AccountPlanID].Account__c;   
        }    
        if(AccountId != null){
            
            accListParent = [SELECT Id,Name,ShippingCity,Owner.name,Area__c,Account_Manager_Rel_BA__c,Business_Areas__c from Account where Id =: AccountId];
            combineList.addAll(accListParent);
            accList = [SELECT Id,Name,ShippingCity,Owner.name,Area__c,Account_Manager_Rel_BA__c,Business_Areas__c from Account where Parent.Id =: AccountId];
            combineList.addAll(accList);
             
        }        
        
        return combineList;
    }
    @AuraEnabled
    public static boolean updateproduct(List<product2> editedProductList){
        try{
            if(editedProductList != null){
                update editedProductList;
                
            }
            return true;
        } catch(Exception e){
            return false;
        }
    }
    
    @AuraEnabled
    public static List<product2> fetchProddetails(string searchstr) {
        
        String newSearchText = '%'+searchstr+'%';
        List <product2> productList = [SELECT Id,Name from product2 WHERE Name LIKE: newSearchText ];
        
        return productList;
    }
    
    //Edit- 08/08/2022 by Anshu. Added Total customer revenue,Imerys Share of Wallet Revenue (%),Target Share of Wallet Revenue (%) Fields US 1402
    
    
    @AuraEnabled
    public static List<product2> fetchProdlistfortable(Id AccountId) { 
        
        List<product2> productList;
        if(AccountId != null){
            productlist = [ SELECT Id,Name,Annual_Revenue__c,Total_customer_revenue__c,Units1__c,Imerys_Share_of_Wallet_Revenue__c,Target_Share_of_Wallet_Revenue__c, Imerys_margin__c,Total_consumption_in_Volume__c,Units__c,Imerys_share_of_wallet__c,Target_share_of_wallet__c, 
                           Imerys_potential__c,Annual_Volume__c  from product2 WHERE Account__r.id =: AccountId ];   
        }
        return productList;
    }
    
    @AuraEnabled
    public static String fetchCurrencyOfAccPlan(Id AccountPlanId) { //pranay
        List<Account_Plan__c> apList;
        if(AccountPlanId != null){
            apList = [SELECT Id, Name, CurrencyIsoCode FROM Account_Plan__c WHERE Id=: AccountPlanId LIMIT 1];
        }
        String currency1 = apList[0].CurrencyIsoCode;
        return currency1;
    }
    

    
    @AuraEnabled
    public static list<product2> productInsertion(Id AccountRecordID, Id productrecordID, decimal OurAnnualRevenue,string Unit,decimal TotalCustomerRevenue,decimal ImerysMargin,String TotalConsumptioninVolume, String Units,
                                                  decimal Imerysshareofwallet,decimal ImerysshareofwalletRevenue,decimal Targetshareofwallet,decimal TargetshareofwalletRevenue, String Imeryspotential, String AnnualVolume) 
    {	
        list<product2> productlist;
        list<product2> producttobeupdate = new list<product2>() ;
        
        
        if(productrecordID != null){
            productlist = [ SELECT Id,Name,Annual_Revenue__c,Total_customer_revenue__c,Units1__c,Imerys_Share_of_Wallet_Revenue__c,Target_Share_of_Wallet_Revenue__c, Imerys_margin__c,Total_consumption_in_Volume__c,Units__c,Imerys_share_of_wallet__c,Target_share_of_wallet__c, 
                           Imerys_potential__c, Annual_Volume__c  from product2 WHERE id =: productrecordID ];   
        }
        
        
        for(product2 prod : productlist){
            if(AccountRecordID != null){
                prod.Account__c = AccountRecordID; }
            
            prod.Annual_Revenue__c = OurAnnualRevenue;
            prod.Total_customer_revenue__c = TotalCustomerRevenue;
            prod.Imerys_margin__c = ImerysMargin;
            prod.Total_consumption_in_Volume__c = TotalConsumptioninVolume;
            prod.Units__c = Units;
            prod.Imerys_share_of_wallet__c =Imerysshareofwallet;
            prod.Imerys_Share_of_Wallet_Revenue__c	 =ImerysshareofwalletRevenue;
            prod.Target_share_of_wallet__c = Targetshareofwallet;
            prod.Target_Share_of_Wallet_Revenue__c	 =TargetshareofwalletRevenue;
            prod.Imerys_potential__c = Imeryspotential;
            prod.Annual_Volume__c = AnnualVolume;
            
            prod.Units1__c=Unit;
            producttobeupdate.add(prod); 
        }
        if(producttobeupdate != null){
            update producttobeupdate;
        }
        
        return producttobeupdate;
    }
    
    @AuraEnabled 
    public static Map<String, String> getPicklistValues(){
        Map<String, String> options = new Map<String, String>();
        Schema.DescribeFieldResult fieldResult = Product2.Units1__c.getDescribe();
        List<Schema.PicklistEntry> pValues = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pValues) {
            options.put(p.getValue(), p.getLabel());
        }
        return options;
    }
    
     @AuraEnabled
    public static void deleteProduct(id AccountId,id ProdId){
        list<product2> producttodelete = new list<product2>() ;
        List<Product2> prodList=[select id, account__c,Annual_Revenue__c,Total_customer_revenue__c,Units1__c,Imerys_Share_of_Wallet_Revenue__c,Target_Share_of_Wallet_Revenue__c, Imerys_margin__c,Total_consumption_in_Volume__c,Units__c,Imerys_share_of_wallet__c,Target_share_of_wallet__c, 
                           Imerys_potential__c, Annual_Volume__c from Product2 where id=:ProdId and account__c=:AccountId];
        for(Product2 prod:prodList ){
            prod.Annual_Revenue__c = Null;
            prod.Total_customer_revenue__c = Null;
            prod.Imerys_margin__c = Null;
            prod.Total_consumption_in_Volume__c = Null;
            prod.Units__c = Null;
            prod.Imerys_share_of_wallet__c =Null;
            prod.Imerys_Share_of_Wallet_Revenue__c	 =Null;
            prod.Target_share_of_wallet__c = Null;
            prod.Target_Share_of_Wallet_Revenue__c	 =Null;
            prod.Imerys_potential__c = Null;
            prod.Annual_Volume__c = Null;
            prod.Units1__c=Null;
            prod.account__c=Null;
            producttodelete.add(prod);
        }
        
        if(producttodelete != null){
            update producttodelete;
        }
        
         
    }
    
    
    
    
}