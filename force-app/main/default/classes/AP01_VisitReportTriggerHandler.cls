/**
*@author Geerutsing Govind Kumar
*@Date Creation 24/7/2017
*@Date modification 7/8/2017- ByPassTriggerRule for admin users
*@description AP01_VisitReport – Display error message on update/delete if user does not belong to internal attendees
                                 and is not an owner.
*/
public class AP01_VisitReportTriggerHandler extends TriggerHandler {
       
// /**
// *@author Geerutsing Govind Kumar
// *@Date Creation 25/7/2017
// *@Date modification 25/7/2017
// *@param aUpdateList to pass update records.                      
// *@return error message if user does not belong to internal attendees/owner
// */  
    // public static void updateVisitReport(List<VisitReport__c> aUpdateList, List<VisitReport__c> aoldList) {
       // // Id currentUserId = userinfo.getUserId();
        // Set<Id> visitReportIdSet = new Set<Id>();
        // Set<Id> ownerIdSet = new Set<Id>(); 
        // Boolean byPassTrigger;
        // Id userId = UserInfo.getUserId();
        // Map<Id, Set<Id>> internalAttendeeIdMap = new Map<Id, Set<Id>>();
        // Id currentUserId = userinfo.getUserId();
   
        // for(VisitReport__c visit : aoldList){
                // if(currentUserId == visit.OwnerId){
                    // ownerIdSet.add(visit.OwnerId);
                // }
            // }
            
        // Id profileId = UserInfo.getProfileId();
        // String profileName =[Select Id, Name from Profile where Id=:profileId].Name;
            
        // List<User> userList = [SELECT Id, ByPassTriggerRule__c FROM User WHERE Id=:userinfo.getUserId() LIMIT 1];
        // byPassTrigger = userList[0].ByPassTriggerRule__c;
        // if(!aUpdateList.isEmpty() && byPassTrigger == false && ownerIdSet.Size() == 0 && profileName <> 'System Administrator'){ //check if list is not empty and user has By-Pass permission
            // for(VisitReport__c visit : aUpdateList){
                // if(currentUserId != visit.OwnerId){
                    // visitReportIdSet.add(visit.Id);
                // }
            // }   
            
            // if(visitReportIdSet.size() > 0){ // check if set is not empty
                // for(User_Visit_Report_Relationship__c acc : [SELECT Id, VisitReportName__c, InternalAttendeeName__c FROM 
                                                             // User_Visit_Report_Relationship__c 
                                                             // WHERE VisitReportName__c = :visitReportIdSet
                                                             // Order By VisitReportName__c
                                                             // LIMIT 50000]){
                    
                    // if(internalAttendeeIdMap.containsKey(acc.VisitReportName__c)){// add visitReportName as Key
                        // internalAttendeeIdMap.get(acc.VisitReportName__c).add(acc.InternalAttendeeName__c);
                    // }else{
                        // internalAttendeeIdMap.put(acc.VisitReportName__c, new Set<Id> { acc.InternalAttendeeName__c });
                    // }
                // }               
                // if(!internalAttendeeIdMap.isEmpty()){ // check if Map is not empty
                    // for(VisitReport__c vr : aUpdateList){
                        // if(internalAttendeeIdMap.containsKey(vr.Id)){
                            // if(!internalAttendeeIdMap.get(vr.Id).contains(currentUserId)){
                                // vr.addError(Label.CL00001);
                            // }
                        // }else{
                            // vr.addError(Label.CL00001); // display label
                        // }
                    // }
                // }else{
                    // for(VisitReport__c vr : aUpdateList){
                        // vr.addError(Label.CL00001);
                    // }
                // }
            // }
        // }
    // }
    
    // /**
// *@author Geerutsing Govind Kumar
// *@Date Creation 25/7/2017
// *@Date modification 26/7/2017
// *@param aDeleteList to pass delete records.                      
// *@return error message if user does not belong to internal attendees/owner
// */  
    // public static void deleteVisitReport(List<VisitReport__c> aDeleteList) {
        // Boolean byPassTrigger;
        // Set<Id> visitReportIdSet = new Set<Id>();
        // Set<String> myName = new Set<String>();
        // Id userId = UserInfo.getUserId();
        // Map<Id, Set<Id>> internalAttendeeIdMap = new Map<Id, Set<Id>>();
        // Id currentUserId = userinfo.getUserId();
        
        // Id profileId = UserInfo.getProfileId();
        // String profileName =[Select Id, Name from Profile where Id=:profileId].Name;
       
        // List<User> userList = [SELECT Id, ByPassTriggerRule__c FROM User WHERE Id=:userinfo.getUserId() LIMIT 1];
        // byPassTrigger = userList[0].ByPassTriggerRule__c;
        // if(!aDeleteList.isEmpty() && byPassTrigger == false && profileName <> 'System Administrator'){ //check if list is not empty and user has By-Pass permission
            // for(VisitReport__c visit : aDeleteList){
                // if(currentUserId != visit.OwnerId){
                    // visitReportIdSet.add(visit.Id);
                // }
            // }   
            
            // if(visitReportIdSet.size() > 0){ // check if set is not empty
                // for(VisitReport__c acc : [SELECT Id, OwnerId FROM 
                                                             // VisitReport__c 
                                                             // WHERE Id = :visitReportIdSet
                                                             // Order By OwnerId
                                                             // LIMIT 50000]){
                    
                    // if(internalAttendeeIdMap.containsKey(acc.Id)){// add visitReportName as Key
                        // internalAttendeeIdMap.get(acc.Id).add(acc.OwnerId);
                    // }else{
                        // internalAttendeeIdMap.put(acc.Id, new Set<Id> { acc.OwnerId});
                    // }
                // }               
                // if(!internalAttendeeIdMap.isEmpty()){ // check if Map is not empty
                    // for(VisitReport__c vr : aDeleteList){
                        // if(internalAttendeeIdMap.containsKey(vr.Id)){
                            // if(!internalAttendeeIdMap.get(vr.Id).contains(currentUserId)){
                                // vr.addError(Label.CL00002);
                            // }
                        // }else{
                            // vr.addError(Label.CL00002); // display label
                        // }
                    // }
                // }else{
                    // for(VisitReport__c vr : aDeleteList){
                        // vr.addError(Label.CL00002);
                    // }
                // }
            // }
        // }
    // }
  /**
*@author Geerutsing Govind Kumar
*@Date Creation 18/4/2019
*@Date modification 18/4/2019
*@param aNewList to return new values.
*@ExcptionName                   
*@return
*/  
    public static void createShare(List<VisitReport__c> aNewList) {           
     
        Map<id,VisitReport__Share> MarketVPMap = new Map<id,VisitReport__Share>();
        Map<id,VisitReport__Share> BPMMap = new Map<id,VisitReport__Share>(); 
        Map<id,VisitReport__Share> SalesDirMap = new Map<id,VisitReport__Share>(); 
        
        VisitReport__Share MarketVPShare; 
        VisitReport__Share BPMShare; 
        VisitReport__Share SalesDirShare; 

        
        if(!aNewList.isEmpty()){                   
            // Declare variables for sharing    
             // Instantiate the sharing objects                      
            for(VisitReport__c tech : aNewList){   
            
                MarketVPShare = new VisitReport__Share();
                BPMShare = new VisitReport__Share();
                SalesDirShare = new VisitReport__Share();
                                    
                if(tech.Business_Performance_Manager__c!=null){
                    
                    BPMShare.ParentId = tech.Id;
                    BPMShare.UserOrGroupId= tech.Business_Performance_Manager__c;          
                        // Set the access level
                    BPMShare.AccessLevel = 'edit';           
                        // Add objects to list for insert               
                    BPMMap.put(BPMShare.Id, BPMShare);
                }
                
                 if(tech.Market_VP__c!=null){
                    
                    MarketVPShare.ParentId = tech.Id;
                    MarketVPShare.UserOrGroupId= tech.Market_VP__c;          
                        // Set the access level
                    MarketVPShare.AccessLevel = 'edit';           
                        // Add objects to list for insert               
                    MarketVPMap.put(MarketVPShare.Id, MarketVPShare);
                }
                
                if(tech.Sales_Director__c!=null){
                    
                    SalesDirShare.ParentId = tech.Id;
                    SalesDirShare.UserOrGroupId= tech.Sales_Director__c;          
                        // Set the access level
                    SalesDirShare.AccessLevel = 'edit';           
                        // Add objects to list for insert               
                    SalesDirMap.put(SalesDirShare.Id, SalesDirShare);
                }
                           
            }                   

            if(BPMMap.size() > 0){
                try{
                    Database.upsert(BPMMap.values(), false);
                }
                catch(DMLException e){
                    System.Debug('Error in Business Process Manager createShare' + e);
                }  
            }
            
            if(MarketVPMap.size() > 0){
                try{
                    Database.upsert(MarketVPMap.values(), false);
                }
                catch(DMLException e){
                    System.Debug('Error in Market VP createShare' + e);
                }  
            }
            
            if(SalesDirMap.size() > 0){
                try{
                    Database.upsert(SalesDirMap.values(), false);
                }
                catch(DMLException e){
                    System.Debug('Error in Sales director createShare' + e);
                }  
            }                
        }
    }
    
    
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 18/4/2019
*@Date modification 11/12/2019 to add TAR team sharing rights
*@param aNewList to pass new values.
*@ExcptionName                      
*@return 
*/  
    public static void updateShare(List<VisitReport__c> aoldList, List<VisitReport__c> aNewList){             
        Set<Id> ownerId = new Set<Id>();
        Set<Id> memberShare = new Set<Id>();
        Set<Id> BPMSetOld = new Set<Id>();
        Set<Id> MarketVPSetOld = new Set<Id>();
        Set<Id> SalesDirSetOld = new Set<Id>();
        Set<id> recordIdSet = new set<id>();
        Map<id,VisitReport__Share> BPMMap = new Map<id,VisitReport__Share>(); 
        Map<id,VisitReport__Share> MarketVPMap = new Map<id,VisitReport__Share>(); 
        Map<id,VisitReport__Share> SalesDirMap = new Map<id,VisitReport__Share>(); 

        VisitReport__Share BPMShare; 
        VisitReport__Share MarketVPShare; 
        VisitReport__Share SalesDirShare; 

        if(!aoldList.isEmpty()){
            for(VisitReport__c techOld: aoldList){// old records
                recordIdSet.add(techOld.Id);
                ownerId.add(techOld.OwnerId);
                BPMSetOld.add(techOld.Business_Performance_Manager__c);
                MarketVPSetOld.add(techOld.Market_VP__c);
                SalesDirSetOld.add(techOld.Sales_Director__c);
            }
        }
                        
         Map<Id,VisitReport__Share> techDelBPMShare = new Map<Id, VisitReport__Share>([SELECT Id, UserOrGroupId, AccessLevel, 
                                                                               RowCause FROM VisitReport__Share
                                                                               WHERE ParentId IN : recordIdSet
                                                                               AND AccessLevel = 'Edit'
                                                                               AND UserOrGroupId IN:BPMSetOld]);
            
        if(ownerId!=BPMSetOld){
            if(techDelBPMShare.size() > 0){
                try{
                    Database.delete(techDelBPMShare.values(),false);
                }
                catch(DMLException e){
                    System.Debug('Error in updateShare delete BPM'+ e);
                }       
            }
        }

         Map<Id,VisitReport__Share> techDelMarketVPShare = new Map<Id, VisitReport__Share>([SELECT Id, UserOrGroupId, AccessLevel, 
                                                                               RowCause FROM VisitReport__Share
                                                                               WHERE ParentId IN : recordIdSet
                                                                               AND AccessLevel = 'Edit'
                                                                               AND UserOrGroupId IN:MarketVPSetOld]);
            
        if(ownerId!=MarketVPSetOld){
            if(techDelMarketVPShare.size() > 0){
                try{
                    Database.delete(techDelMarketVPShare.values(),false);
                }
                catch(DMLException e){
                    System.Debug('Error in updateShare delete Market VP'+ e);
                }       
            }
        }

        
         Map<Id,VisitReport__Share> techDelSalesDirShare = new Map<Id, VisitReport__Share>([SELECT Id, UserOrGroupId, AccessLevel, 
                                                                               RowCause FROM VisitReport__Share
                                                                               WHERE ParentId IN : recordIdSet
                                                                               AND AccessLevel = 'Edit'
                                                                               AND UserOrGroupId IN:SalesDirSetOld]);
            
        if(ownerId!=SalesDirSetOld){
            if(techDelSalesDirShare.size() > 0){
                try{
                    Database.delete(techDelSalesDirShare.values(),false);
                }
                catch(DMLException e){
                    System.Debug('Error in updateShare delete Sales Dir'+ e);
                }       
            }
        }
       
        for(VisitReport__c tech : aNewList){                              
            BPMShare = new VisitReport__Share();
            MarketVPShare = new VisitReport__Share();
            SalesDirShare = new VisitReport__Share();
                
           
            if(tech.Business_Performance_Manager__c!=null){                         
                BPMShare.ParentId = tech.Id;
                BPMShare.UserOrGroupId= tech.Business_Performance_Manager__c;          
                    // Set the access level
                BPMShare.AccessLevel = 'Edit';           
                   // Add objects to list for insert               
                  BPMMap.put(BPMShare.Id, BPMShare);
            }
            
            if(tech.Market_VP__c!=null){                         
                MarketVPShare.ParentId = tech.Id;
                MarketVPShare.UserOrGroupId= tech.Market_VP__c;          
                    // Set the access level
                MarketVPShare.AccessLevel = 'Edit';           
                   // Add objects to list for insert               
                  MarketVPMap.put(MarketVPShare.Id, MarketVPShare);
            }
            
            if(tech.Sales_Director__c!=null){                         
                SalesDirShare.ParentId = tech.Id;
                SalesDirShare.UserOrGroupId= tech.Sales_Director__c;          
                    // Set the access level
                SalesDirShare.AccessLevel = 'Edit';           
                   // Add objects to list for insert               
                  SalesDirMap.put(SalesDirShare.Id, SalesDirShare);
            }
          
                            
     
         if(BPMMap.size() > 0){
            try{
                upsert BPMMap.values();
            }
            catch(DMLException e){
                System.Debug('Error in BPM updateShare' + e);
            }  
        } 
        
         if(MarketVPMap.size() > 0){
            try{
                upsert MarketVPMap.values();
            }
            catch(DMLException e){
                System.Debug('Error in MarketVP updateShare' + e);
            }  
        } 
        
         if(SalesDirMap.size() > 0){
            try{
                upsert SalesDirMap.values();
            }
            catch(DMLException e){
                System.Debug('Error in Sales Dir updateShare' + e);
            }  
        } 
     }
    
    }       

  
  /**
*@author Geerutsing Govind Kumar
*@Date Creation 2/8/2018
*@Date modification 
*@param aNewList to fill relationship.                      
*@return error message
*/  
    public static void FillRelationship(List<VisitReport__c> aNewList) {
        Set<String>businessAreaSet=new set<String>();
        Set<id>accountIdSet = new set<id>();
        list<VisitReport__c>visitList =new list<VisitReport__c>();
        Map<Id, VisitReport__c>visitMap = new Map<Id, VisitReport__c>();
        Map<Id, Relationship__c> rels = new Map<Id, Relationship__c>();
        
        for(VisitReport__c b:aNewList){
            if(b.BusinessArea__c!=Null){
                businessAreaSet.add(b.BusinessArea__c);
                rels.put(b.Tech_RelationshipInformation__c, null);
                accountIdSet.add(b.Account__c);
                //lookup field to opportunity on bid__c
            }
        }
        if(!businessAreaSet.IsEmpty()){
            list<Relationship__c>relList=[SELECT id,name, BusinessArea__c from Relationship__c 
                                        WHERE BusinessArea__c IN: businessAreaSet
                                        AND AccountName__c IN: accountIdSet LIMIT 1];                                       
            for(Relationship__c relDivName :relList){
                for(VisitReport__c bd: aNewList){
                        bd.Tech_RelationshipInformation__c= relDivName.Id;
                        visitList.add(bd);
                        system.debug('bd' + visitList);                       
                }
               
            }
        }
        visitMap.putall(visitList);
        if(visitMap.size() > 0){
           try{
                Database.update(visitMap.values(), true);          
            }
            catch(DMLException e){
                System.Debug('Error in fillRelationship'+ e);
            }
        }       
    }
/**
*@author Geerutsing Govind Kumar
*@Date Creation 2/8/2018
*@Date modification 
*@param aNewList to fill relationship.                      
*@return error message
*/  
@future
    public static void UpdateRelationship(set<Id> aNewList) {
        Set<String>businessAreaSet=new set<String>();
        Set<id>accountIdSet = new set<id>();
        list<VisitReport__c>visitList =new list<VisitReport__c>();
        Map<Id, VisitReport__c>visitMap = new Map<Id, VisitReport__c>();
        Map<Id, Relationship__c> rels = new Map<Id, Relationship__c>();
        
        List<VisitReport__c> visitNewList = new List<VisitReport__c>();
        
        for(visitReport__c visit : [Select Id, BusinessArea__c, Account__c, Tech_RelationshipInformation__c from VisitReport__c
                            where id in: aNewList]){
                                
            visitNewList.add(visit);
        }
        
        for(VisitReport__c b:visitNewList){
            if(b.BusinessArea__c!=Null){
                businessAreaSet.add(b.BusinessArea__c);
                rels.put(b.Tech_RelationshipInformation__c, null);
                accountIdSet.add(b.Account__c);
            }
        }
        if(!businessAreaSet.IsEmpty()){
            list<Relationship__c>relList=[SELECT id,name, BusinessArea__c from Relationship__c 
                                        WHERE BusinessArea__c IN: businessAreaSet
                                        AND AccountName__c IN: accountIdSet LIMIT 1];                                       
            if(relList.size() == 0){    
                for(VisitReport__c bd: visitNewList){
                    bd.Tech_RelationshipInformation__c= null;
                    visitList.add(bd);
                    system.debug('bd' + visitList);                       
                }
                
            }
            else{
                for(Relationship__c relDivName :relList){
                    for(VisitReport__c bd: visitNewList){
                        bd.Tech_RelationshipInformation__c= relDivName.Id;
                        visitList.add(bd);
                        system.debug('bd' + visitList);                       
                    }                               
                }
            }
        }
        visitMap.putall(visitList);
        if(visitMap.size() > 0){
           try{
                Database.update(visitMap.values(), true);          
            }
            catch(DMLException e){
                System.Debug('Error in updateRelationship'+ e);
            }
        }   
    }

/**
*@author Geerutsing Govind Kumar
*@Date Creation 2/2/2018
*@Date modification 2/2/2018
*@param
*@ExcptionName                  
*@return method updateVisitReport with new values.
*/  
    public override void afterInsert() {
        //Override method BeforeUpdate from class Handler to create new Account Team record.
        List<VisitReport__c> visitReportListIds = new List<VisitReport__c> (); 
        
        for (VisitReport__c visit : [Select Id, BusinessArea__c, Account__c, Tech_RelationshipInformation__c from VisitReport__c 
                                            where Id in :Trigger.newMap.keyset()]) { 
            visitReportListIds.add(visit); 
        }
        FillRelationship(visitReportListIds);
        createShare(trigger.new);
        
    }    
    
/**
*@author Geerutsing Govind Kumar
*@Date Creation 25/7/2017
*@Date modification 25/7/2017
*@param
*@ExcptionName                  
*@return method updateVisitReport with new values.
*/  
    public override void afterUpdate() {
        
         if(!System.isFuture() && !System.isBatch()){
        //updateVisitReport(Trigger.new, Trigger.old);
        Set<Id> visitReportListIds = new Set<Id>(); 
        
        for (VisitReport__c visit : [Select Id, BusinessArea__c, Account__c, Tech_RelationshipInformation__c from VisitReport__c 
                                     where Id in :Trigger.newMap.keyset()]) { 
            visitReportListIds.add(visit.Id); 
        }
        UpdateRelationship(visitReportListIds);
        updateShare(trigger.old, trigger.new);
        }
        
    }
/**
*@author Geerutsing Govind Kumar
*@Date Creation 25/7/2017
*@Date modification 25/7/2017
*@param
*@ExcptionName                  
*@return method deleteVisitReport with old values.
*/      
    //public override void beforeDelete() {
        //Override method BeforeDelete from class Handler to create new Account Team record.
        //deleteVisitReport(Trigger.old);
        
    //}   
    
}