/**
*@author Geerutsing Govind Kumar
*@Date Creation 2/8/2018
*@Date modification 
*@description AP01_Opportunity – prefill Relationship field
*/
public class AP01_OpportunityTriggerHandler extends TriggerHandler {
 
   /**
*@author Geerutsing Govind Kumar
*@Date Creation 18/4/2019
*@Date modification 18/4/2019
*@param aNewList to return new values.
*@ExcptionName                   
*@return
*/  
    public static void createShare(List<Opportunity> aNewList) {           
     
        Map<id,OpportunityShare> MarketVPMap = new Map<id,OpportunityShare>();
        Map<id,OpportunityShare> BPMMap = new Map<id,OpportunityShare>(); 
        Map<id,OpportunityShare> SalesDirMap = new Map<id,OpportunityShare>(); 
        
        OpportunityShare MarketVPShare; 
        OpportunityShare BPMShare; 
        OpportunityShare SalesDirShare; 

        
        if(!aNewList.isEmpty()){                   
            // Declare variables for sharing    
             // Instantiate the sharing objects                      
            for(Opportunity tech : aNewList){   
            
                MarketVPShare = new OpportunityShare();
                BPMShare = new OpportunityShare();
                SalesDirShare = new OpportunityShare();
                    
                 if(tech.Business_Performance_Manager__c!=null){
                    
                    BPMShare.OpportunityId = tech.Id;
                    BPMShare.UserOrGroupId= tech.Business_Performance_Manager__c;          
                        // Set the access level
                    BPMShare.OpportunityAccessLevel = 'edit';           
                        // Add objects to list for insert               
                    BPMMap.put(BPMShare.Id, BPMShare);
                }
                
                 if(tech.Market_VP__c!=null){
                    
                    MarketVPShare.OpportunityId = tech.Id;
                    MarketVPShare.UserOrGroupId= tech.Market_VP__c;          
                        // Set the access level
                    MarketVPShare.OpportunityAccessLevel = 'edit';           
                        // Add objects to list for insert               
                    MarketVPMap.put(MarketVPShare.Id, MarketVPShare);
                }
                
                if(tech.Sales_Director__c!=null){
                    
                    SalesDirShare.OpportunityId = tech.Id;
                    SalesDirShare.UserOrGroupId= tech.Sales_Director__c;          
                        // Set the access level
                    SalesDirShare.OpportunityAccessLevel = 'edit';           
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
*@Date modification 11/12/2019 to add Opportunity team sharing rights
*@param aNewList to pass new values.
*@ExcptionName                      
*@return 
*/  
    public static void updateShare(List<Opportunity> aoldList, List<Opportunity> aNewList){             
        Set<Id> ownerId = new Set<Id>();
        Set<Id> memberShare = new Set<Id>();
        Set<Id> BPMSetOld = new Set<Id>();
        Set<Id> MarketVPSetOld = new Set<Id>();
        Set<Id> SalesDirSetOld = new Set<Id>();
        Set<id> recordIdSet = new set<id>();
        Map<id,OpportunityShare> BPMMap = new Map<id,OpportunityShare>(); 
        Map<id,OpportunityShare> MarketVPMap = new Map<id,OpportunityShare>(); 
        Map<id,OpportunityShare> SalesDirMap = new Map<id,OpportunityShare>(); 
        OpportunityShare BPMShare; 
        OpportunityShare MarketVPShare; 
        OpportunityShare SalesDirShare; 

        
        if(!aoldList.isEmpty()){
            for(Opportunity techOld: aoldList){// old records
                recordIdSet.add(techOld.Id);
                ownerId.add(techOld.OwnerId);
                BPMSetOld.add(techOld.Business_Performance_Manager__c);
                MarketVPSetOld.add(techOld.Market_VP__c);
                SalesDirSetOld.add(techOld.Sales_Director__c);
            }
        }
        
         Map<Id,OpportunityShare> techDelBPMShare = new Map<Id, OpportunityShare>([SELECT OpportunityId, UserOrGroupId, OpportunityAccessLevel, 
                                                                               RowCause FROM OpportunityShare
                                                                               WHERE OpportunityId IN : recordIdSet
                                                                               AND OpportunityAccessLevel = 'Edit'
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

         Map<Id,OpportunityShare> techDelMarketVPShare = new Map<Id, OpportunityShare>([SELECT OpportunityId, UserOrGroupId, OpportunityAccessLevel, 
                                                                               RowCause FROM OpportunityShare
                                                                               WHERE OpportunityId IN : recordIdSet
                                                                               AND OpportunityAccessLevel = 'Edit'
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

        
         Map<Id,OpportunityShare> techDelSalesDirShare = new Map<Id, OpportunityShare>([SELECT OpportunityId, UserOrGroupId, OpportunityAccessLevel, 
                                                                               RowCause FROM OpportunityShare
                                                                               WHERE OpportunityId IN : recordIdSet
                                                                               AND OpportunityAccessLevel = 'Edit'
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

                
        for(Opportunity tech : aNewList){                              
            BPMShare = new OpportunityShare();
            MarketVPShare = new OpportunityShare();
            SalesDirShare = new OpportunityShare();
                
            if(tech.Business_Performance_Manager__c!=null){                         
                BPMShare.OpportunityId = tech.Id;
                BPMShare.UserOrGroupId= tech.Business_Performance_Manager__c;          
                    // Set the access level
                BPMShare.OpportunityAccessLevel = 'Edit';           
                   // Add objects to list for insert               
                  BPMMap.put(BPMShare.Id, BPMShare);
            }
            
            if(tech.Market_VP__c!=null){                         
                MarketVPShare.OpportunityId = tech.Id;
                MarketVPShare.UserOrGroupId= tech.Market_VP__c;          
                    // Set the access level
                MarketVPShare.OpportunityAccessLevel = 'Edit';           
                   // Add objects to list for insert               
                  MarketVPMap.put(MarketVPShare.Id, MarketVPShare);
            }
            
            if(tech.Sales_Director__c!=null){                         
                SalesDirShare.OpportunityId = tech.Id;
                SalesDirShare.UserOrGroupId= tech.Sales_Director__c;          
                    // Set the access level
                SalesDirShare.OpportunityAccessLevel = 'Edit';           
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
    public static void FillRelationship(List<Opportunity> aNewList) {
        Set<String>businessAreaSet=new set<String>();
        Set<Id>accountIdSet = new set<Id>();
        list<Opportunity>oppList =new list<Opportunity>();
        Map<Id, Relationship__c> rels = new Map<Id, Relationship__c>();
        for(Opportunity b:aNewList){
            if(b.BusinessArea__c!=Null){
                businessAreaSet.add(b.BusinessArea__c);
                rels.put(b.Tech_RelationshipInformation__c, null);
                accountIdSet.add(b.AccountId);
                //lookup field to opportunity on bid__c
            }
        }
        if(!businessAreaSet.IsEmpty()){
            list<Relationship__c>relList=[SELECT id,name, BusinessArea__c from Relationship__c 
                                          WHERE BusinessArea__c IN: businessAreaSet
                                          AND AccountName__c IN: accountIdSet LIMIT 1];                                       
            for(Relationship__c relDivName :relList){
                try{
                    for(Opportunity bd: aNewList){
                        bd.Tech_RelationshipInformation__c= relDivName.Id;
                        oppList.add(bd);
                        system.debug('bd' + oppList);                       
                    }
                }
                catch(DMLException e){
                    System.Debug('Error in opportunity '+ e);
                }
            }
        }           
    }
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 2/8/2018
*@Date modification 
*@param aNewList to update relationship.                      
*@return error message
*/  
    public static void updateRelationship(List<Opportunity> aNewList){
        Set<String>businessAreaSet=new set<String>();
        Set<Id>accountIdSet = new set<Id>();
        list<Opportunity>oppList =new list<Opportunity>();
        Map<Id, Relationship__c> rels = new Map<Id, Relationship__c>();
        For(Opportunity b:aNewList){
            if(b.BusinessArea__c!=Null){
                businessAreaSet.add(b.BusinessArea__c);
                rels.put(b.Tech_RelationshipInformation__c, null);
                accountIdSet.add(b.AccountId);
                //lookup field to opportunity on bid__c
            }
        }
        if(!businessAreaSet.IsEmpty()){
            list<Relationship__c>relList=[SELECT id,name, BusinessArea__c from Relationship__c 
                                          WHERE BusinessArea__c IN: businessAreaSet
                                          AND AccountName__c IN: accountIdSet LIMIT 1]; 
            if(relList.size() == 0){
                try{
                    for(Opportunity bd: aNewList){
                        bd.Tech_RelationshipInformation__c= null;
                        oppList.add(bd);
                        system.debug('bd' + oppList);                       
                    }
                }
                catch(DMLException e){
                    System.Debug('Error in opportunity '+ e);
                }
            }
            else{                             
                for(Relationship__c relDivName :relList){
                    try{
                        for(Opportunity bd: aNewList){
                            bd.Tech_RelationshipInformation__c= relDivName.Id;
                            oppList.add(bd);
                            system.debug('bd' + oppList);                       
                        }
                    }
                    catch(Exception e){
                        System.Debug('Error in opportunity '+ e);
                    }
                }
            }               
        }
    }       
    
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 13/1/2021
*@Date modification 
*@param aNewList                       
*@return error message
*/  
    
    /*
public static void filImerysSolution(List<Opportunity> aNewList) {
Set<Id>oppIdSet = new set<Id>();       
string assignedTo='';
for(Opportunity b:aNewList){
oppIdSet.add(b.Id);
}

Map<Id, Shortlisted_Imerys_Product__c> shortlistedSelectedMap = new Map<Id,Shortlisted_Imerys_Product__c>();

for(Shortlisted_Imerys_Product__c shortImerys:[SELECT Id,Product_Name__c, Opportunity__c, Shortlisted__c,Technical_Status__c
FROM Shortlisted_Imerys_Product__c WHERE Opportunity__c IN: oppIdSet
AND Shortlisted__c = 'Selected']){

shortlistedSelectedMap.put(shortImerys.Id, shortImerys);
}

Map<Id, Shortlisted_Imerys_Product__c> shortlistedPreferedMap = new Map<Id,Shortlisted_Imerys_Product__c>();

for(Shortlisted_Imerys_Product__c shortPreferedImerys:[SELECT Id, Product_Name__c, Opportunity__c, Shortlisted__c,Technical_Status__c
FROM Shortlisted_Imerys_Product__c WHERE Opportunity__c IN: oppIdSet
AND Shortlisted__c = 'Preferred']){

shortlistedPreferedMap.put(shortPreferedImerys.Id, shortPreferedImerys);    
}           

if(shortlistedSelectedMap.size() > 0){
try{
for(Opportunity bd: aNewList){
bd.Imerys_Solution__c = '';
for(Shortlisted_Imerys_Product__c shortprod:shortlistedSelectedMap.values()){            
if(bd.MultiProduct__c == false && shortlistedSelectedMap.size() > 1){
assignedTo += shortprod.Product_Name__c + ',';                                      
}                       
if(bd.MultiProduct__c == false && shortlistedSelectedMap.size() == 1){
assignedTo += shortprod.Product_Name__c;                      
}
bd.ImerysSolutionTechnicalStatus__c = shortprod.Technical_Status__c;
//bd.ImerysSolutionProductStatus__c = shortprod.Shortlisted__c;             
}
assignedTo = assignedTo.removeEnd(',');
if(assignedTo.length() <=255){
bd.Imerys_Solution__c = assignedTo;
}                       
}
}           
catch(Exception e){
System.Debug('Error in filImerysSolution '+ e);
}

}
if(shortlistedSelectedMap.size() == 0 && shortlistedPreferedMap.size()> 0){
try{    
for(Opportunity bd2: aNewList){
bd2.Imerys_Solution__c = '';
for(Shortlisted_Imerys_Product__c shortprod2:shortlistedPreferedMap.values()){
if(bd2.MultiProduct__c == false && shortlistedPreferedMap.size() > 1){
assignedTo += shortprod2.Product_Name__c + ','; 
}
if(bd2.MultiProduct__c == false && shortlistedPreferedMap.size() == 1){
assignedTo += shortprod2.Product_Name__c; 
}
bd2.ImerysSolutionTechnicalStatus__c = shortprod2.Technical_Status__c;
//bd2.ImerysSolutionProductStatus__c = shortprod2.Shortlisted__c;    
}
assignedTo = assignedTo.removeEnd(',');
if(assignedTo.length() <=255){
bd2.Imerys_Solution__c = assignedTo;
}
}
}   
catch(Exception e){
System.Debug('Error in filImerysSolution '+ e);
}

}
if(shortlistedSelectedMap.size() == 0 && shortlistedPreferedMap.size() == 0){
try{    
for(Opportunity bd3: aNewList){                  
bd3.Imerys_Solution__c = '';
}

}   
catch(Exception e){
System.Debug('Error in filImerysSolution '+ e);
}

}   
// for(Opportunity bd4: aNewList){
// try{
// if(bd4.MultiProduct__c == true){
// bd4.Imerys_Solution__c = '';
// bd4.Imerys_Solution__c = 'Multi-product selected';                      
// }
// if(bd4.Technical_Status__c!=null){
// bd4.ImerysSolutionTechnicalStatus__c = bd4.Technical_Status__c;
// }
// }               
// catch(DMLException e){
// System.Debug('Error in filImerysSolution '+ e);
// }

// }
}*/
    
    
    
    /**
*@author Jaunbocus Muhammad Irshaad
*@Date Creation 16/4/2021
*@Date modification 
*@param aNewList                       
*@return error message
*/  
    
    public static void filImerysSolution(List<Opportunity> aNewList) {
        Set<Id>oppIdSet = new set<Id>();       
        string assignedTo='';
        string techStatus='';
        for(Opportunity b:aNewList){
            oppIdSet.add(b.Id);
        }
        
        Map<Id, opportunitylineitem> oppoLineItemMap = new Map<Id,opportunitylineitem>();
        
        for(opportunitylineitem oppoLine:[SELECT Id,Product2.Name, OpportunityId, Product2Id,Technical_Status__c
                                          FROM opportunitylineitem WHERE OpportunityId IN: oppIdSet
                                         ]){
                                             
                                             oppoLineItemMap.put(oppoLine.Id, oppoLine);
                                         }
        
        system.debug('oppoLineItemMap.size------>'+oppoLineItemMap.size());
        if(oppoLineItemMap.size() > 0){
            try{
                for(Opportunity bd: aNewList){
                    bd.Imerys_Solution__c = '';
                    bd.ImerysSolutionTechnicalStatus__c = '';
                    for(OpportunityLineItem shortprod:oppoLineItemMap.values()){ 
                        system.debug('Shortprod: --->'+shortprod);           
                        if(bd.MultiProduct__c == false && oppoLineItemMap.size() > 1){
                            assignedTo += shortprod.Product2.Name + ',';
                            if (shortprod.Technical_Status__c!=null)
                            {
                                techStatus += shortprod.Technical_Status__c + ',';
                            }
                            else{
                                techStatus+='';
                            }                     
                            
                        }                       
                        if(bd.MultiProduct__c == false && oppoLineItemMap.size() == 1){
                            assignedTo += shortprod.Product2.Name;
                            if (shortprod.Technical_Status__c!=null)
                            {
                                techStatus += shortprod.Technical_Status__c ;
                            }
                            else{
                                techStatus+='';
                            }   
                            
                            // techStatus += shortprod.Technical_Status__c;
                        }
                        //bd.ImerysSolutionTechnicalStatus__c = shortprod.Technical_Status__c;
                        //bd.ImerysSolutionProductStatus__c = shortprod.Shortlisted__c;             
                    }
                    system.debug('assignedTo-------->'+assignedTo);
                    assignedTo = assignedTo.removeEnd(',');
                    if(assignedTo.length() <=255){
                        bd.Imerys_Solution__c = assignedTo;
                    }
                    
                    system.debug('techStatus-------->'+techStatus);
                    techStatus = techStatus.removeEnd(',');
                    if(techStatus.length()<255){
                        bd.ImerysSolutionTechnicalStatus__c = techStatus;
                    }
                }
            }           
            catch(Exception e){
                System.Debug('Error in filImerysSolution '+ e);
            }
        }
        
        if(oppoLineItemMap.size() == 0){
            try{    
                for(Opportunity bd3: aNewList){                  
                    bd3.Imerys_Solution__c = '';
                    bd3.ImerysSolutionTechnicalStatus__c = '';
                }
                
            }   
            catch(Exception e){
                System.Debug('Error in filImerysSolution '+ e);
            }
            
        }   
    }
    
    /**
*@author Jaunbocus Muhammad Irshaad
*@Date Creation 24/6/2021
*@Date modification 
*@param aNewList                       
*@return error message
*/  
    public static void fillMarketSegment(List<Opportunity> aNewList) {
        Set<id>relationshipInfoIdSet = new Set<id>();
        set<id>marketSegmentationIdSet = new Set<Id>();
        
        //get the relationship on Opportunity
        for(opportunity c : aNewList){
            if(c.Tech_RelationshipInformation__c != null){relationshipInfoIdSet.add(c.Tech_RelationshipInformation__c);}
            
            if(c.Market_Segmentation_new__c != null){marketSegmentationIdSet.add(c.Market_Segmentation_new__c);}
        }
        //Query to get MarketSegment from the relationshipId
        
        if(!relationshipInfoIdSet.isEmpty()){
            
            List<Relationship__c> relList = new List<Relationship__c>([Select name,MarketSegmentation__c,NewMarketL1__c,NewMarketL2__c,NewMarketL3__c
                                                                       from relationship__c 
                                                                       where id IN: relationshipInfoIdSet  ]);
            
            //Fill market segmentation
            //Idea : If user does not fill Market segmentation, take Market segmentation from relationship.
            //If user fill market segmentation, do nothing.
            if(marketSegmentationIdSet.isEmpty()){
                for(opportunity b : aNewList){
                    b.Market_Segmentation_new__c = relList[0].MarketSegmentation__c;
                    b.NewMarketL1__c = relList[0].NewMarketL1__c;
                    b.NewMarketL2__c = relList[0].NewMarketL2__c;
                    b.NewMarketL3__c = relList[0].NewMarketL3__c;
                }
            }
            
        }
    }
    
    
    /**
*@author Jaunbocus Muhammad Irshaad
*@Date Creation 24/6/2021
*@Date modification 
*@param aNewList                       
*@return error message
*/  
    /*public static void updateMarketSegment(List<Opportunity> aOldList,List<Opportunity> aNewList) {
        Set<id>oldRelationshipInfoIdSet = new Set<id>();
        Set<id>oldMarketSegmentationIdSet = new set<id>();
        Set<id>newRelationshipInfoIdSet = new Set<id>();
        Set<id>newMarketSegmentationIdSet = new set<id>();
        
        //Fill sets for old values
        for(Opportunity c : aOldList){
            if(c.Tech_RelationshipInformation__c != null){oldRelationshipInfoIdSet.add(c.Tech_RelationshipInformation__c);
                                                          if(c.Market_Segmentation_new__c != null){oldMarketSegmentationIdSet.add(c.Market_Segmentation_new__c);}
                                                         }
        }
        
        //get the relationship on Opportunity new values
        for(opportunity c : aNewList){
            if(c.Tech_RelationshipInformation__c != null){newRelationshipInfoIdSet.add(c.Tech_RelationshipInformation__c); }
            if(c.Market_Segmentation_new__c != null){newMarketSegmentationIdSet.add(c.Market_Segmentation_new__c);}
            
        }
        
        
        if(!newRelationshipInfoIdSet.isEmpty()){
            
            List<Relationship__c>  relList = new List<Relationship__c>([Select name,accountManager__c,MarketSegmentation__c,NewMarketL1__c,NewMarketL2__c,NewMarketL3__c
                                                                        from relationship__c 
                                                                        where id IN: newRelationshipInfoIdSet  ]);
            
            if(!newRelationshipInfoIdSet.equals(oldRelationshipInfoIdSet)){
                for(opportunity c : aNewList){
                    c.Market_Segmentation_new__c = relList[0].MarketSegmentation__c;
                    c.NewMarketL1__c = relList[0].NewMarketL1__c;
                    c.NewMarketL2__c = relList[0].NewMarketL2__c;
                    c.NewMarketL3__c = relList[0].NewMarketL3__c;
                    
                }
            }
        }
    }*/
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 2/2/2018
*@Date modification 2/2/2018
*@param
*@ExcptionName                  
*@return method updateVisitReport with new values.
*/  
    public override void beforeInsert() {
        //Override method BeforeUpdate from class Handler to create new Account Team record.
        
        FillRelationship(Trigger.new);
        filImerysSolution(trigger.new);
        fillMarketSegment(Trigger.new);
        
        
    }
    
      /**
*@author Geerutsing Govind Kumar
*@Date Creation 2/2/2018
*@Date modification 2/2/2018
*@param
*@ExcptionName                  
*@return method updateVisitReport with new values.
*/  
    public override void AfterInsert() {
        //Override method BeforeUpdate from class Handler to create new Account Team record.
        
        FillRelationship(Trigger.new);
        filImerysSolution(trigger.new);
        fillMarketSegment(Trigger.new);
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
    public override void beforeUpdate() {
        //Override method BeforeUpdate from class Handler to create new Account Team record.
        //updateVisitReport(Trigger.new, Trigger.old);
        UpdateRelationship(trigger.new);
        filImerysSolution(trigger.new);
        //updateMarketSegment(trigger.old,trigger.new);
        
        
    }
    
        /**
*@author Geerutsing Govind Kumar
*@Date Creation 25/7/2017
*@Date modification 25/7/2017
*@param
*@ExcptionName                  
*@return method updateVisitReport with new values.
*/  
    public override void AfterUpdate() {
        //Override method BeforeUpdate from class Handler to create new Account Team record.
        //updateVisitReport(Trigger.new, Trigger.old);
        updateShare(trigger.old, trigger.new);
        //updateMarketSegment(trigger.old,trigger.new);
        
        
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
    
    // }   
    
}