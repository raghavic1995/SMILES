public without sharing class AP01_FreightRateRequestTriggerHandler extends TriggerHandler {
    
/**
*@author Jaunbocus Muhammad Irshaad
*@Date Creation 12/8/2021
*@Date modification
*@param
*/
 public static void MapResponsibleParty(List<FreightRateRequest__c> aNewList){
     Set<Id> objRecordType = new Set<Id>();
     Set<String> imerysPlantSet = new Set<String>();
     Set<String> productTypeSet = new Set<String>();
     String recordTypeApi;
     List<GatekeeperAssignment__c> gatekeeperList = new  List<GatekeeperAssignment__c>();
     
     For(FreightRateRequest__c obj : aNewList){
         objRecordType.add(obj.RecordTypeId); 
         imerysPlantSet.add(obj.Manufacturing_Plant__c);
         productTypeSet.add(obj.New_Product_Type_1__c);
     }
     
     system.debug('Imerys Plant Set : '+imerysPlantSet );
     system.debug('productTypeSet : --->'+productTypeSet);
     
     if(objRecordType.size()>0){
         
         try{
             recordTypeApi = [SELECT DeveloperName FROM RecordType 
                              WHERE SobjectType =: Label.CL00091 //FreightRateRequest__c
                             AND Id IN: objRecordType][0].DeveloperName;
         }
         catch(DMLException e){
                
             System.Debug('Error in getting Record type name :  '+ e);
          }
      }
     
     system.debug('Record type name : -->'+recordTypeApi);
     
     //If RecordType == Transload,Rail
     if(recordTypeApi.equals(Label.CL00092) ){ //TransloadRail
         system.debug('Inside Transload Rail');
         
         try{
          gatekeeperList = [SELECT Gatekeeper__c,Gatekeeper2__c,Gatekeeper3__c,Gatekeeper4__c
                           								FROM GatekeeperAssignment__c 
                                                        WHERE Object__c =: Label.CL00095 //Freight Rate Request
                                                        AND ModeOfShipment__c =: recordTypeApi];
         }
         catch(DMLException e){
                
             System.Debug('Error in Gatekeeper :  '+ e);
          }
         
         system.debug('gatekeeperList Transload,Rail :-->'+gatekeeperList);
         
         if(!gatekeeperList.isEmpty()){         
             for(FreightRateRequest__c obj : aNewList){
             obj.ResponsibleParty1__c = gatekeeperList[0].Gatekeeper__c;
             obj.ResponsibleParty2__c = gatekeeperList[0].Gatekeeper2__c;
             obj.AccountableParty1__c = gatekeeperList[0].Gatekeeper3__c;
             obj.AccountableParty2__c = gatekeeperList[0].Gatekeeper4__c;
         	}
   
         }
     }//End of transport,rail
     
     
     //If RecordType == Truck,Intermodal
      if(recordTypeApi.equals(Label.CL00093) ){ //TruckIntermodal
         system.debug('Inside Truck Intermodal');
          
          
         try{
          gatekeeperList = [SELECT Gatekeeper__c,Gatekeeper2__c,Gatekeeper3__c,Gatekeeper4__c
                           								FROM GatekeeperAssignment__c 
                                                        WHERE Object__c =: Label.CL00095 
                                                        AND ModeOfShipment__c =: recordTypeApi
                           								AND	Manufacturing_Plant__c IN:	imerysPlantSet	];
         }
         catch(DMLException e){
                
             System.Debug('Error in Gatekeeper :  '+ e);
          }
         
         system.debug('gatekeeperList Truck Intermodal :-->'+gatekeeperList);
         
         if(!gatekeeperList.isEmpty()){         
             for(FreightRateRequest__c obj : aNewList){
             obj.ResponsibleParty1__c = gatekeeperList[0].Gatekeeper__c;
             obj.ResponsibleParty2__c = gatekeeperList[0].Gatekeeper2__c;
             obj.AccountableParty1__c = gatekeeperList[0].Gatekeeper3__c;
             obj.AccountableParty2__c = gatekeeperList[0].Gatekeeper4__c;
         	}
   
         }
     }//End of Truck,Intermodal
     
     //If RecordType == Ocean,Air
     if(recordTypeApi.equals(Label.CL00094) ){//OceanAIr
         system.debug('Inside Ocean Air');
         
         try{
          gatekeeperList = [SELECT Gatekeeper__c,Gatekeeper2__c,Gatekeeper3__c,Gatekeeper4__c
                           								FROM GatekeeperAssignment__c 
                                                        WHERE Object__c =: Label.CL00095  //Freight Rate Request
                                                        AND ModeOfShipment__c =: recordTypeApi 
                           								AND Product_Type_1__c IN:productTypeSet	];
         }
         catch(DMLException e){
                
             System.Debug('Error in Gatekeeper :  '+ e);
          }
         
         system.debug('gatekeeperList Ocean,Air :-->'+gatekeeperList);
         
         if(!gatekeeperList.isEmpty()){         
             for(FreightRateRequest__c obj : aNewList){
             obj.ResponsibleParty1__c = gatekeeperList[0].Gatekeeper__c;
             obj.ResponsibleParty2__c = gatekeeperList[0].Gatekeeper2__c;
             obj.AccountableParty1__c = gatekeeperList[0].Gatekeeper3__c;
             obj.AccountableParty2__c = gatekeeperList[0].Gatekeeper4__c;
         	}
   
         }
     }
     
     
 }
    
    /**
*@author Jaunbocus Muhammad Irshaad
*@Date Creation 12/8/2021
*@Date modification
*@param
*/
 public static void getImerysPlantAndProductType(List<FreightRateRequest__c> aNewList){
     Set<Id> quoteLineItemIdSet = new Set<Id>();
     List<QuoteLineItem> productQli = new List<QuoteLineItem>();
     List<Product2> prodDetails = new List<Product2>();
     List<Manufacturing_Plant__c>ManufacturingplantDetails = new List<Manufacturing_Plant__c>();
     Set<Id> objRecordType = new Set<Id>();
     Id prodId ;
     String recordTypeApi;
     
     
     For(FreightRateRequest__c obj : aNewList){
         objRecordType.add(obj.RecordTypeId);
         quoteLineItemIdSet.add(obj.Quote_Line_Item__c);
     }
     
     
     if(objRecordType.size()>0){
         
         try{
             recordTypeApi = [SELECT DeveloperName FROM RecordType 
                              WHERE SobjectType =: Label.CL00091 
                             AND Id IN: objRecordType][0].DeveloperName;
         }
         catch(DMLException e){
                
             System.Debug('Error in getting Record type name :  '+ e);
          }
      }
     
     
     //Get productId
     prodId = [Select Product2Id from QuoteLineItem where id IN:quoteLineItemIdSet ].Product2Id;
     
     //Get Imerys Manufacturing Plant and Product type 1 from ProductId
     try{
         ManufacturingplantDetails = [SELECT Imerys_Product__c,Imerys_Site__c  from Manufacturing_Plant__c where Imerys_Product__c =: prodId];
         prodDetails = [SELECT New_Product_Type_1__c from Product2 where Id =: prodId];
     }
     catch(DMLException e){
         
         System.Debug('Error in ProdDetails :  '+ e);
     }
     
     if(!prodDetails.isEmpty()){
         //If RecordType == Transload,Rail
         if(recordTypeApi.equals(Label.CL00092) ){
             for(FreightRateRequest__c obj : aNewList){
                 obj.Manufacturing_Plant__c = ManufacturingplantDetails[0].Id;
                 obj.New_Product_Type_1__c = prodDetails[0].New_Product_Type_1__c;
             }
         }
         
      //If RecordType == Truck,Intermodal
         if(recordTypeApi.equals(Label.CL00093) ){
             for(FreightRateRequest__c obj : aNewList){
                 obj.Manufacturing_Plant__c = ManufacturingplantDetails[0].Id;
                 obj.New_Product_Type_1__c = prodDetails[0].New_Product_Type_1__c;  
             }
         }
         
         //If RecordType == Ocean,Air
         if(recordTypeApi.equals(Label.CL00094) ){
             for(FreightRateRequest__c obj : aNewList){
                 obj.New_Product_Type_1__c = prodDetails[0].New_Product_Type_1__c;
                 obj.Manufacturing_Plant__c = ManufacturingplantDetails[0].Id;
             }
         }
         
     }
     
     
 }
     
    
    
    
/**
*@author Jaunbocus Muhammad Irshaad
*@Date Creation 12/8/2021
*@Date modification
*@param
*/  
    public override void BeforeInsert() {
        getImerysPlantAndProductType(Trigger.new);
        MapResponsibleParty(Trigger.new);
        
    }

}