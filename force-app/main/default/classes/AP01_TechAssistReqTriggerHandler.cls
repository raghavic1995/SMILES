/**
*@author Geerutsing Govind Kumar
*@Date Creation 31/05/2018
*description 
*Date Modification 28/11/2018 -Add division with relationship trigger
*/
public without sharing class AP01_TechAssistReqTriggerHandler extends TriggerHandler {
/**
*@author Geerutsing Govind Kumar
*@Date Creation 31/05/2018
*@Date modification 
*@param                      
*@return 
*/  
@future
    public static void techApproverSharing(set<String> aNewList) {
        Set<Boolean>approvedSet=new set<Boolean>();
        Set<String>statusSet = new set<String>();
        Set<Id>techIdSet = new set<Id>();
        Set<Id>approverIdSet = new set<Id>();       
        Set<Id>processIdSet = new set<Id>();
        set<Id>userSet = new set<Id>();
        List<TechnicalAssistanceRequest__c> tarNewList = new List<TechnicalAssistanceRequest__c>();
        List<TechnicalAssistanceRequest__Share> techApproveList = New List<TechnicalAssistanceRequest__Share>(); 
        Map<Id,TechnicalAssistanceRequest__Share> techMap = new Map<Id, TechnicalAssistanceRequest__Share>();
        Map<Id,TechnicalAssistanceRequest__c> techUpdMap = new Map<Id, TechnicalAssistanceRequest__c>();
        List<TechnicalAssistanceRequest__Share> memberShareList = new List<TechnicalAssistanceRequest__Share>();  
        String strFilename= Label.CL00044;
        TechnicalAssistanceRequest__Share memberShareUpd; 
       
        for(TechnicalAssistanceRequest__c tarNew : [select Id, Tech_ApprovalAccess__c FROM 
                                                    TechnicalAssistanceRequest__c where id in: aNewList]){
            tarNewList.add(tarNew);
        }       
        for(TechnicalAssistanceRequest__c tar: tarNewList){
            approvedSet.add(tar.Tech_ApprovalAccess__c);
            techIdSet.add(tar.Id);
        }
        system.debug('approverAccess' + approvedSet);
        if(approvedSet.contains(true)){
            
            for(ProcessInstance ins: [SELECT Id, TargetObject.Name, TargetObjectID, TargetObject.Type
                                    FROM ProcessInstance  
                                    WHERE Status = 'Pending' 
                                    AND IsDeleted = False
                                    AND TargetObjectID IN: techIdSet]){
                processIdSet.add(ins.Id);
               
            }
            system.debug('process' + processIdSet);
             
            for(ProcessInstanceWorkitem wrkItems:[SELECT Id, Actor.email, Actor.Id FROM ProcessInstanceWorkitem
                                    WHERE ProcessInstanceId IN: processIdSet
                                    ]){ 
                //statusSet.add(ins.Status);
                userSet.add(wrkItems.ActorId);
            }                                    
                      
            TechnicalAssistanceRequest__Share techApproverShr;
            
            for(User us:[SELECT Id FROM User WHERE Id IN: userSet]){ 
                for(TechnicalAssistanceRequest__c  techApp : tarNewList){               
                    // Instantiate the sharing objects
                    techApproverShr = new TechnicalAssistanceRequest__Share();                  
                    // Set the ID of record being shared
                    techApproverShr.ParentId = techApp.Id;    
                    // Set the ID of user or group being granted access
                    techApproverShr.UserOrGroupId = us.Id;      
                    // Set the access level
                    techApproverShr.AccessLevel = 'edit';           
                    // Add objects to list for insert             
                }   techApproveList.add(techApproverShr);
            }   
        }
        techMap.putall(techApproveList);
        if(techMap.size() > 0){
            try{
                system.debug('approve' + techMap.values());
                Database.insert(techMap.values(), true);          
            }
            catch(DMLException e){
                System.Debug('Error in  techAssistApproverShr'+ e);
            }
        }
        
        Set<string> setNames=  new Set<string>();
        setNames.add(Label.CL00065+'%');
        setNames.add(Label.CL00066+'%');
        setNames.add(Label.CL00067+'%');
       
        Map<Id, ContentDocumentLink> mapDoc = new Map<Id,ContentDocumentLink>([SELECT LinkedEntityId,ContentDocumentId, ContentDocument.Title 
                                                                            FROM ContentDocumentLink WHERE LinkedEntityId IN:techIdSet
                                                                            AND contentDocument.Title LIKE:setNames]);

        for(TechnicalAssistanceRequest__c tarUpd: tarNewList){
            if(mapDoc.size() > 0){
                tarUpd.Attachment__c = true;
            }
            else{
                tarUpd.Attachment__c = false;
            }
            techUpdMap.put(tarUpd.Id, tarUpd);
        }
        if(techUpdMap.size() > 0){
            Database.update(techUpdMap.values(), true);
        }
        Map<Id,TechnicalAssistanceRequestTeam__c> techTeamShare = new Map<Id, TechnicalAssistanceRequestTeam__c>([SELECT Id, TechnicalAssistanceRequestNo__c, Member__c, Access__c 
                                                                               FROM TechnicalAssistanceRequestTeam__c 
                                                                               WHERE TechnicalAssistanceRequestNo__c IN:techIdSet]);        
        if(techTeamShare.size() > 0){
            for(TechnicalAssistanceRequestTeam__c techTeam: techTeamShare.values()){
                for(TechnicalAssistanceRequest__c techT: tarNewList){ 
                    memberShareUpd = new TechnicalAssistanceRequest__Share(); 
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
/**
*@author Geerutsing Govind Kumar
*@Date Creation 18/4/2019
*@Date modification 18/4/2019
*@param aNewList to return new values.
*@ExcptionName                   
*@return
*/  
    public static void createShare(List<TechnicalAssistanceRequest__c> aNewList) {           
        Set<Id>labManagerSet = new Set<Id>();
        Map<id,TechnicalAssistanceRequest__Share> labManagerMap = new Map<id,TechnicalAssistanceRequest__Share>();  
        Map<id,TechnicalAssistanceRequest__Share> approverMap = new Map<id,TechnicalAssistanceRequest__Share>();  
        Map<id,TechnicalAssistanceRequest__Share> requesterMap = new Map<id,TechnicalAssistanceRequest__Share>(); 
        Map<id,TechnicalAssistanceRequest__Share> MarketVPMap = new Map<id,TechnicalAssistanceRequest__Share>();
        Map<id,TechnicalAssistanceRequest__Share> BPMMap = new Map<id,TechnicalAssistanceRequest__Share>(); 
        Map<id,TechnicalAssistanceRequest__Share> SalesDirMap = new Map<id,TechnicalAssistanceRequest__Share>(); 
        
        
        TechnicalAssistanceRequest__Share labManagerShare;
        TechnicalAssistanceRequest__Share approverShare; 
        TechnicalAssistanceRequest__Share requesterShare; 
        TechnicalAssistanceRequest__Share MarketVPShare; 
        TechnicalAssistanceRequest__Share BPMShare; 
        TechnicalAssistanceRequest__Share SalesDirShare; 

        
        if(!aNewList.isEmpty()){                   
            // Declare variables for sharing    
             // Instantiate the sharing objects                      
            for(TechnicalAssistanceRequest__c tech : aNewList){   
            
                labManagerShare = new TechnicalAssistanceRequest__Share();
                approverShare = new TechnicalAssistanceRequest__Share();                
                requesterShare = new TechnicalAssistanceRequest__Share();
                MarketVPShare = new TechnicalAssistanceRequest__Share();
                BPMShare = new TechnicalAssistanceRequest__Share();
                SalesDirShare = new TechnicalAssistanceRequest__Share();
                    
                
                if(tech.LabTechnicalAssistanceManager__c!=null){
                    
                    labManagerShare.ParentId = tech.Id;
                    labManagerShare.UserOrGroupId= tech.LabTechnicalAssistanceManager__c;          
                        // Set the access level
                    labManagerShare.AccessLevel = 'edit';           
                        // Add objects to list for insert               
                    labManagerMap.put(labManagerShare.Id, labManagerShare);
                }
                
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
                //if(tech.Approver__c!=null){
                    
                    //approverShare.ParentId = tech.Id;
                    //approverShare.UserOrGroupId= tech.Approver__c;          
                        // Set the access level
                    //approverShare.AccessLevel = 'edit';           
                        // Add objects to list for insert               
                    //approverMap.put(approverShare.Id, approverShare);
                //}
                if(tech.Requester__c!=null){    
                
                    requesterShare.ParentId = tech.Id;
                    requesterShare.UserOrGroupId= tech.Requester__c;          
                        // Set the access level
                    requesterShare.AccessLevel = 'edit';           
                        // Add objects to list for insert               
                    requesterMap.put(requesterShare.Id, requesterShare);
                }
                                
            }                   
            if(labManagerMap.size() > 0){
                try{
                    Database.upsert(labManagerMap.values(), false);
                }
                catch(DMLException e){
                    System.Debug('Error in lab manager createShare' + e);
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
            //if(approverMap.size() > 0){
               // try{
                   // Database.upsert(approverMap.values(), false);
               // }
                //catch(DMLException e){
                   // System.Debug('Error in approver createShare' + e);
                //}  
            //}
            if(requesterMap.size() > 0){
                try{
                    Database.upsert(requesterMap.values(), false);
                }
                catch(DMLException e){
                    System.Debug('Error in requester createShare' + e);
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
    public static void updateShare(List<TechnicalAssistanceRequest__c> aoldList, List<TechnicalAssistanceRequest__c> aNewList){             
        Set<Id> ownerId = new Set<Id>();
        Set<Id> memberShare = new Set<Id>();
        set<Id> approverSetOld = new set<id>();
        Set<Id> labManagerSetOld = new Set<Id>();
        Set<Id> requesterSetOld = new Set<Id>();
        Set<Id> BPMSetOld = new Set<Id>();
        Set<Id> MarketVPSetOld = new Set<Id>();
        Set<Id> SalesDirSetOld = new Set<Id>();
        Set<id> recordIdSet = new set<id>();
        Map<id,TechnicalAssistanceRequest__Share> labManagerMap = new Map<id,TechnicalAssistanceRequest__Share>();  
        Map<id,TechnicalAssistanceRequest__Share> approverMap = new Map<id,TechnicalAssistanceRequest__Share>();  
        Map<id,TechnicalAssistanceRequest__Share> requesterMap = new Map<id,TechnicalAssistanceRequest__Share>(); 
        Map<id,TechnicalAssistanceRequest__Share> BPMMap = new Map<id,TechnicalAssistanceRequest__Share>(); 
        Map<id,TechnicalAssistanceRequest__Share> MarketVPMap = new Map<id,TechnicalAssistanceRequest__Share>(); 
        Map<id,TechnicalAssistanceRequest__Share> SalesDirMap = new Map<id,TechnicalAssistanceRequest__Share>(); 
        TechnicalAssistanceRequest__Share labManagerShare;
        TechnicalAssistanceRequest__Share approverShare; 
        TechnicalAssistanceRequest__Share requesterShare; 
        TechnicalAssistanceRequest__Share BPMShare; 
        TechnicalAssistanceRequest__Share MarketVPShare; 
        TechnicalAssistanceRequest__Share SalesDirShare; 

        
        if(!aoldList.isEmpty()){
            for(TechnicalAssistanceRequest__c techOld: aoldList){// old records
                recordIdSet.add(techOld.Id);
                ownerId.add(techOld.OwnerId);
                labManagerSetOld.add(techOld.LabTechnicalAssistanceManager__c);
                //approverSetOld.add(techOld.Approver__c);
                requesterSetOld.add(techOld.Requester__c);
                BPMSetOld.add(techOld.Business_Performance_Manager__c);
                MarketVPSetOld.add(techOld.Market_VP__c);
                SalesDirSetOld.add(techOld.Sales_Director__c);
            }
        }
                        
        Map<Id,TechnicalAssistanceRequest__Share> techDelLabManagerShare = new Map<Id, TechnicalAssistanceRequest__Share>([SELECT Id, UserOrGroupId, AccessLevel, 
                                                                               RowCause FROM TechnicalAssistanceRequest__Share
                                                                               WHERE ParentId IN : recordIdSet
                                                                               AND AccessLevel = 'Edit'
                                                                               AND UserOrGroupId IN:labManagerSetOld]);
            
        if(ownerId!=labManagerSetOld){
            if(techDelLabManagerShare.size() > 0){
                try{
                    Database.delete(techDelLabManagerShare.values(),false);
                }
                catch(DMLException e){
                    System.Debug('Error in updateShare delete lab'+ e);
                }       
            }
        }
        
         Map<Id,TechnicalAssistanceRequest__Share> techDelBPMShare = new Map<Id, TechnicalAssistanceRequest__Share>([SELECT Id, UserOrGroupId, AccessLevel, 
                                                                               RowCause FROM TechnicalAssistanceRequest__Share
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

         Map<Id,TechnicalAssistanceRequest__Share> techDelMarketVPShare = new Map<Id, TechnicalAssistanceRequest__Share>([SELECT Id, UserOrGroupId, AccessLevel, 
                                                                               RowCause FROM TechnicalAssistanceRequest__Share
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

        
         Map<Id,TechnicalAssistanceRequest__Share> techDelSalesDirShare = new Map<Id, TechnicalAssistanceRequest__Share>([SELECT Id, UserOrGroupId, AccessLevel, 
                                                                               RowCause FROM TechnicalAssistanceRequest__Share
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

                                                                                                      
        Map<Id,TechnicalAssistanceRequest__Share> techDelRequesterShare = new Map<Id, TechnicalAssistanceRequest__Share>([SELECT Id, UserOrGroupId, AccessLevel, 
                                                                               RowCause FROM TechnicalAssistanceRequest__Share
                                                                               WHERE ParentId IN : recordIdSet
                                                                               AND AccessLevel = 'Edit'
                                                                               AND UserOrGroupId IN:requesterSetOld]);
        
            
        if(ownerId!=requesterSetOld){
            if(techDelRequesterShare.size() > 0){
                try{
                    Database.delete(techDelRequesterShare.values(), false);
                }
                catch(DMLException e){
                    System.Debug('Error in updateShare delete approver'+ e);
                }       
            }
        }           
        for(TechnicalAssistanceRequest__c tech : aNewList){                              
            labManagerShare = new TechnicalAssistanceRequest__Share(); // Instantiate the sharing objects  
            approverShare = new TechnicalAssistanceRequest__Share();                
            requesterShare = new TechnicalAssistanceRequest__Share();
            BPMShare = new TechnicalAssistanceRequest__Share();
            MarketVPShare = new TechnicalAssistanceRequest__Share();
            SalesDirShare = new TechnicalAssistanceRequest__Share();
                
            if(tech.LabTechnicalAssistanceManager__c!=null){                         
                labManagerShare.ParentId = tech.Id;
                labManagerShare.UserOrGroupId= tech.LabTechnicalAssistanceManager__c;          
                    // Set the access level
                labManagerShare.AccessLevel = 'Edit';           
                   // Add objects to list for insert               
                  labManagerMap.put(labManagerShare.Id, labManagerShare);
            }
            
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
            //if(tech.Approver__c!=null){
                    
                //approverShare.ParentId = tech.Id;
                //approverShare.UserOrGroupId= tech.Approver__c;          
                   // Set the access level
                //approverShare.AccessLevel = 'edit';           
                   // Add objects to list for insert               
                //approverMap.put(approverShare.Id, approverShare);
            //}
            if(tech.Requester__c!=null){
                    
                requesterShare.ParentId = tech.Id;
                requesterShare.UserOrGroupId= tech.Requester__c;          
                    // Set the access level
                requesterShare.AccessLevel = 'edit';           
                    // Add objects to list for insert               
               requesterMap.put(requesterShare.Id, requesterShare);
           }
                                                                                                 
        } 
                            
        if(labManagerMap.size() > 0){
            try{
                upsert labManagerMap.values();
            }
            catch(DMLException e){
                System.Debug('Error in lab updateShare' + e);
            }  
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
        
        if(requesterMap.size() > 0){
            try{
                Database.upsert(requesterMap.values(), false);
            }
            catch(DMLException e){
                System.Debug('Error in requester createShare' + e);
            }  
        }                  
    }       
/**
*@author Geerutsing Govind Kumar
*@Date Creation 28/11/2018
*@Date modification 
*@param aNewList to fill relationship.                      
*@return error message
*/  
    public static void FillRelationship(List<TechnicalAssistanceRequest__c> aNewList) {
        Set<String>businessAreaSet=new set<String>();
        Set<id>accountIdSet = new set<id>();
        list<TechnicalAssistanceRequest__c>techList =new list<TechnicalAssistanceRequest__c>();
        Map<Id, Relationship__c> rels = new Map<Id, Relationship__c>();
        for(TechnicalAssistanceRequest__c t:aNewList){
            if(t.BusinessArea__c!=Null){
                businessAreaSet.add(t.BusinessArea__c);
                rels.put(t.Tech_RelationshipInformation__c, null);
                accountIdSet.add(t.Account__c);
                //lookup to account
            }
        }
        if(!businessAreaSet.IsEmpty()){
            list<Relationship__c>relList=[SELECT id,name, BusinessArea__c from Relationship__c 
                                          WHERE BusinessArea__c IN: businessAreaSet
                                          AND AccountName__c IN: accountIdSet LIMIT 1];                                       
            for(Relationship__c relDivName :relList){ //retrieve relationship
                try{
                    for(TechnicalAssistanceRequest__c bd: aNewList){
                        bd.Tech_RelationshipInformation__c= relDivName.Id;
                        techList.add(bd); //add relationship
                        system.debug('bd' + techList);                       
                    }
                }
                 catch(DMLException e){
                    System.Debug('Error in insert relationship '+ e);
                }
            }
        }           
    }
/**
*@author Geerutsing Govind Kumar
*@Date Creation 28/11/2018
*@Date modification 
*@param aNewList to fill relationship.                      
*@return error message
*/  
    public static void UpdateRelationship(List<TechnicalAssistanceRequest__c> aNewList) {
        Set<String>businessAreaSet=new set<String>();
        Set<id>accountIdSet = new set<id>();
        list<TechnicalAssistanceRequest__c>techList =new list<TechnicalAssistanceRequest__c>();
        Map<Id, Relationship__c> rels = new Map<Id, Relationship__c>();
        For(TechnicalAssistanceRequest__c t:aNewList){
            if(t.BusinessArea__c!=Null){
                businessAreaSet.add(t.BusinessArea__c);
                rels.put(t.Tech_RelationshipInformation__c, null);
                accountIdSet.add(t.Account__c);
                //lookup field to account
            }
        }
        if(!businessAreaSet.IsEmpty()){
            list<Relationship__c>relList=[SELECT id,name, BusinessArea__c from Relationship__c 
                                        WHERE BusinessArea__c IN: businessAreaSet
                                        AND AccountName__c IN: accountIdSet LIMIT 1];                                       
            if(relList.size() == 0){    
                try{
                    for(TechnicalAssistanceRequest__c bd: aNewList){
                        bd.Tech_RelationshipInformation__c= null; // relationship to null
                        techList.add(bd);
                        system.debug('bd' + techList);                       
                    }
                }
                 catch(DMLException e){
                    System.Debug('Error in update relationship to null '+ e);
                }
            }
            else{
                for(Relationship__c relDivName :relList){
                    try{
                        for(TechnicalAssistanceRequest__c bd: aNewList){
                            bd.Tech_RelationshipInformation__c= relDivName.Id; // assign relationship
                            techList.add(bd);
                            system.debug('bd' + techList);                       
                        }
                    }
                     catch(DMLException e){
                        System.Debug('Error in update relationship '+ e);
                    }
                }
            }
        }           
    }
/**
*@author Geerutsing Govind Kumar
*@Date Creation 19/4/2019
*@Date modification
*@param
*@ExcptionName                  
*@return method createShare with new values.
*/  
    public override void AfterInsert() {
    //Override method AfterInsert from class Handler
        createShare(trigger.new);
    } 


/**
*@author Geerutsing Govind Kumar
*@Date Creation 28/11/2018
*@Date modification 
*@param
*@ExcptionName                  
*@return
*/  
    public override void beforeInsert() {
        //Override method BeforeUpdate from class Handler 
        FillRelationship(Trigger.new);
        
    }
    
/**
*@author Geerutsing Govind Kumar
*@Date Creation 28/11/2018
*@Date modification 
*@param
*@ExcptionName                  
*@return 
*/  
    public override void beforeUpdate() {
        //Override method BeforeUpdate from class Handler
        UpdateRelationship(Trigger.new);
        
    }
/**
 *@author Geerutsing Govind Kumar
 *@Date Creation 31/5/2018
 *@Date modification 
 *@param
 *@ExcptionName                  
 *@return method updateSampleShare with new values.
 */  
    public override void AfterUpdate() {
    //Override method BeforeUpdate from class Handler to update Technical Assistance Request record.
   
        Set<string> techIds = new Set<string> (); 
        
        for(TechnicalAssistanceRequest__c tar : [Select Id from TechnicalAssistanceRequest__c 
                                            where Id in :Trigger.newMap.keyset()]) { 
            techIds.add(tar.id); 
        }
        if(System.IsBatch() == false && System.isFuture() == false){ 
            techApproverSharing(techIds);
        }
        
        updateShare(trigger.old, trigger.new);
    }
        
}