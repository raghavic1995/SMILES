/**
*@author Geerutsing Govind Kumar
*@Date Creation 
*@Date modification 
*@description 
*/
public class AP01_CustomerReqFormTriggerHandler extends TriggerHandler {
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 
*@Date modification 
*@param aNewList to pass update records.                      
*@return
*/  
    public static void createGatekeeper(List<Customer_Request_Form__c> aNewList){
        Set<String>sellingEntitySet = new Set<String>();
        set<String>businessArea=new set<String>();
        Map<String,GatekeeperAssignment__c> customerServiceGKMap = new Map<String,GatekeeperAssignment__c>();
        Map<String,GatekeeperAssignment__c> creditControllerGKMap = new Map<String,GatekeeperAssignment__c>();
        Map<String,GatekeeperAssignment__c> ERPCreatorGKMap = new Map<String,GatekeeperAssignment__c>();

        
        for(Customer_Request_Form__c obj : aNewList){
            sellingEntitySet.add(obj.Imerys_Selling_Entity_Lookup__c);
            businessArea.add(obj.Business_Area__c);                        
        }
        if(businessArea !=null)
        {    
            if(!businessArea.contains('PM EMEA'))
            {
                system.debug('Business area is not EMEA');
                if(sellingEntitySet !=null){   
                    for(GatekeeperAssignment__c gate : [SELECT Imerys_Site__c, Gatekeeper__c,ImerysSellingEntity2__c 
                                                        FROM GatekeeperAssignment__c 
                                                        WHERE Imerys_Site__c IN: sellingEntitySet
                                                        AND Process__c =: Label.CL00072
                                                        AND Object__c =: Label.CL00082
                                                        ORDER BY Id DESC]){ 
                                                            
                                                            customerServiceGKMap.put(gate.Imerys_Site__c, gate);
                                                        }
                    
                    for(GatekeeperAssignment__c gate2 : [SELECT Imerys_Site__c,Gatekeeper__c, ImerysSellingEntity2__c
                                                         FROM GatekeeperAssignment__c 
                                                         WHERE Imerys_Site__c IN: sellingEntitySet
                                                         AND Process__c =: Label.CL00073
                                                         AND Object__c =: Label.CL00082
                                                         ORDER BY Id DESC]){ 
                                                             
                                                             creditControllerGKMap.put(gate2.Imerys_Site__c, gate2);
                                                         }
                    
                     for(GatekeeperAssignment__c gate3 : [SELECT Imerys_Site__c,Gatekeeper__c, ImerysSellingEntity2__c
                                                         FROM GatekeeperAssignment__c 
                                                         WHERE Imerys_Site__c IN: sellingEntitySet
                                                         AND Process__c =: Label.CL00098
                                                         AND Object__c =: Label.CL00082
                                                         ORDER BY Id DESC]){ 
                                                             
                                                             ERPCreatorGKMap.put(gate3.Imerys_Site__c, gate3);
                                                         }
                }
                try{        
                    if(customerServiceGKMap.size() > 0){
                        for(Customer_Request_Form__c cust : aNewList){
                            cust.Customer_Service_in_Charge__c = customerServiceGKMap.get(cust.Imerys_Selling_Entity_Lookup__c).Gatekeeper__c;
                        }                               
                    }
                    if(creditControllerGKMap.size() > 0){
                        for(Customer_Request_Form__c cust2 : aNewList){
                            cust2.CreditControllerinCharge__c = creditControllerGKMap.get(cust2.Imerys_Selling_Entity_Lookup__c).Gatekeeper__c;
                        }                               
                    }
                     if(ERPCreatorGKMap.size() > 0){
                        for(Customer_Request_Form__c cust3 : aNewList){
                            cust3.ERP_Creator_in_Charge__c = ERPCreatorGKMap.get(cust3.Imerys_Selling_Entity_Lookup__c).Gatekeeper__c;
                        }                               
                    }
                }
                catch(Exception e){
                    System.Debug('Error in assign GK '+ e);
                }                
            }
            else
            {
                system.debug('Business area is EMEA');
                Set<String>marketSegmentation = new Set<String>();
                Map<String,GatekeeperAssignment__c> customerServiceGKMSMap = new Map<String,GatekeeperAssignment__c>();
                Map<String,GatekeeperAssignment__c> creditControllerGKMSMap = new Map<String,GatekeeperAssignment__c>();
                Map<String,GatekeeperAssignment__c> ERPCreatorGKMSMap = new Map<String,GatekeeperAssignment__c>();

                for(Customer_Request_Form__c obj : aNewList){
                    marketSegmentation.add(obj.Market_Segmentation__c);
                }
                if(marketSegmentation !=null){   
                    for(GatekeeperAssignment__c gateMS : [SELECT Gatekeeper__c,MarketSegmentation__c 
                                                          FROM GatekeeperAssignment__c 
                                                          WHERE MarketSegmentation__c IN: marketSegmentation
                                                          AND Process__c =: Label.CL00072
                                                          AND Object__c =: Label.CL00082
                                                          ORDER BY Id DESC]){ 
                                                              
                                                              customerServiceGKMSMap.put(gateMS.MarketSegmentation__c, gateMS);
                                                          }
                    
                    for(GatekeeperAssignment__c gateMS2 : [SELECT Gatekeeper__c, MarketSegmentation__c
                                                           FROM GatekeeperAssignment__c 
                                                           WHERE MarketSegmentation__c IN: marketSegmentation
                                                           AND Process__c =: Label.CL00073
                                                           AND Object__c =: Label.CL00082
                                                           ORDER BY Id DESC]){ 
                                                               
                                                               creditControllerGKMSMap.put(gateMS2.MarketSegmentation__c, gateMS2);
                                                           }
                     for(GatekeeperAssignment__c gateMS3 : [SELECT Gatekeeper__c, MarketSegmentation__c
                                                           FROM GatekeeperAssignment__c 
                                                           WHERE MarketSegmentation__c IN: marketSegmentation
                                                           AND Process__c =: Label.CL00098
                                                           AND Object__c =: Label.CL00082
                                                           ORDER BY Id DESC]){ 
                                                               
                                                               ERPCreatorGKMSMap.put(gateMS3.MarketSegmentation__c, gateMS3);
                                                           }
                }
                try{        
                    if(customerServiceGKMSMap.size() > 0){
                        for(Customer_Request_Form__c cust : aNewList){
                            cust.Customer_Service_in_Charge__c = customerServiceGKMSMap.get(cust.Market_Segmentation__c).Gatekeeper__c;
                        }                               
                    }
                    if(creditControllerGKMap.size() > 0){
                        for(Customer_Request_Form__c cust2 : aNewList){
                            cust2.CreditControllerinCharge__c = creditControllerGKMap.get(cust2.Market_Segmentation__c).Gatekeeper__c;
                        }                               
                    }
                          if(ERPCreatorGKMSMap.size() > 0){
                        for(Customer_Request_Form__c cust3 : aNewList){
                            cust3.ERP_Creator_in_Charge__c = ERPCreatorGKMSMap.get(cust3.Market_Segmentation__c).Gatekeeper__c;
                        }                               
                    }
                }
                catch(Exception e){
                    System.Debug('Error in assign GK '+ e);
                }
                
            }
        }
    }
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 
*@Date modification 
*@param aNewList to pass update records.                      
*@return
*/  
    public static void updateGatekeeper(List<Customer_Request_Form__c> aNewList, List<Customer_Request_Form__c> aOldList){
        system.debug('inside updateGatekeeper');
        Set<String>sellingNewEntitySet = new Set<String>();
        Set<String>sellingOldEntitySet = new Set<String>();
        Map<String,GatekeeperAssignment__c> customerServiceGKMap = new Map<String,GatekeeperAssignment__c>();
        Map<String,GatekeeperAssignment__c> creditControllerGKMap = new Map<String,GatekeeperAssignment__c>();
        Map<String,GatekeeperAssignment__c> ERPCreatorGKMap = new Map<String,GatekeeperAssignment__c>();
        
        for(Customer_Request_Form__c obj : aNewList){
            sellingNewEntitySet.add(obj.Imerys_Selling_Entity_Lookup__c); 
            
        }
        for(Customer_Request_Form__c obj : aOldList){
            sellingOldEntitySet.add(obj.Imerys_Selling_Entity_Lookup__c); 
            
        }       
        system.debug('checking if sellingEntitySet are different'+sellingNewEntitySet);
        system.debug('checking if sellingEntitySet are different'+sellingOldEntitySet);
        if(sellingNewEntitySet !=sellingOldEntitySet){   
            system.debug('sellingEntitySet are different');
            for(GatekeeperAssignment__c gate : [SELECT Imerys_Site__c,Gatekeeper__c,ImerysSellingEntity2__c 
                                                FROM GatekeeperAssignment__c 
                                                WHERE Imerys_Site__c IN: sellingNewEntitySet
                                                AND Process__c =: Label.CL00072
                                                AND Object__c =: Label.CL00082
                                                ORDER BY Id DESC]){ 
                                                    
                                                    customerServiceGKMap.put(gate.Imerys_Site__c, gate);
                                                }
            
            for(GatekeeperAssignment__c gate2 : [SELECT Imerys_Site__c,Gatekeeper__c, ImerysSellingEntity2__c
                                                 FROM GatekeeperAssignment__c 
                                                 WHERE Imerys_Site__c IN: sellingNewEntitySet
                                                 AND Process__c =: Label.CL00073
                                                 AND Object__c =: Label.CL00082
                                                 ORDER BY Id DESC]){ 
                                                     
                                                     creditControllerGKMap.put(gate2.Imerys_Site__c, gate2);
                                                 }
            system.debug('ERP Code start:'+sellingNewEntitySet );
            for(GatekeeperAssignment__c gate3 : [SELECT Imerys_Site__c,Gatekeeper__c, ImerysSellingEntity2__c
                                                 FROM GatekeeperAssignment__c 
                                                 WHERE Imerys_Site__c IN: sellingNewEntitySet
                                                 AND Process__c =: Label.CL00098
                                                 AND Object__c =: Label.CL00082
                                                 ORDER BY Id DESC]){ 
                                                     
                                                     ERPCreatorGKMap.put(gate3.Imerys_Site__c, gate3);
                                                 }
        }
        try{        
            if(customerServiceGKMap.size() > 0){
                for(Customer_Request_Form__c cust : aNewList){
                    cust.Customer_Service_in_Charge__c = customerServiceGKMap.get(cust.Imerys_Selling_Entity_Lookup__c).Gatekeeper__c;
                }                               
            }
            if(creditControllerGKMap.size() > 0){
                for(Customer_Request_Form__c cust2 : aNewList){
                    cust2.CreditControllerinCharge__c = creditControllerGKMap.get(cust2.Imerys_Selling_Entity_Lookup__c).Gatekeeper__c;
                }                               
            }
            system.debug('ERP creator found:'+ERPCreatorGKMap.size());
            if(ERPCreatorGKMap.size() > 0){
                for(Customer_Request_Form__c cust3 : aNewList){
                    cust3.ERP_Creator_in_Charge__c = ERPCreatorGKMap.get(cust3.Imerys_Selling_Entity_Lookup__c).Gatekeeper__c;
                }                               
            }
        }
        catch(DMLException e){
            System.Debug('Error in update GK '+ e);
        }                
    }           
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 
*@Date modification 
*@param aNewList to pass update records.                      
*@return
*/  
    public static void createCustomerServiceTeam(List<Customer_Request_Form__c> aNewList){
        Set<String> sellingEntitySet = new Set<String>();
        Set<Id> gatekeeper2Set = new Set<Id>();
        Set<Id> gatekeeper3Set = new Set<Id>();
        Set<Id> gatekeeper4Set = new Set<Id>();
        Set<Id> gateRecordId = new Set<Id>();       
        Map<Id,GatekeeperAssignment__c> gatekeeperMap = new Map<Id,GatekeeperAssignment__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamMap2 = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamMap3 = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamMap4 = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamAcctMang = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamGK = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleCreatedBy = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, Customer_Request_Form__share> insertSampleShare2 = new Map<id, Customer_Request_Form__share>();
        Map<Id, Customer_Request_Form__share> insertSampleShare3 = new Map<id, Customer_Request_Form__share>();
        Map<Id, Customer_Request_Form__share> insertSampleShare4 = new Map<id, Customer_Request_Form__share>();
        Map<Id, Customer_Request_Form__share> insertSampleShareAcctMang = new Map<id, Customer_Request_Form__share>();
        Map<Id, Customer_Request_Form__share> insertSampleShareGK = new Map<id, Customer_Request_Form__share>();
        CustomerRequestTeam__c sampleNewTeam2;
        CustomerRequestTeam__c sampleNewTeam3;
        CustomerRequestTeam__c sampleNewTeam4;
        CustomerRequestTeam__c sampleNewTeamAcctMang;
        CustomerRequestTeam__c sampleNewTeamGk;
        CustomerRequestTeam__c sampleNewCreatedBy;
        Customer_Request_Form__share sampleShare2;
        Customer_Request_Form__share sampleShare3;
        Customer_Request_Form__share sampleShare4;
        Customer_Request_Form__share sampleShareAcctMang;
        Customer_Request_Form__share sampleShareGK;
        
        for(Customer_Request_Form__c obj : aNewList){
            sellingEntitySet.add(obj.Imerys_Selling_Entity_Lookup__c); 
            
        }       
        
        if(sellingEntitySet !=null){   
            for(GatekeeperAssignment__c gate : [SELECT Imerys_Site__c,Gatekeeper__c, Gatekeeper2__c, Gatekeeper3__c, Gatekeeper4__c
                                                FROM GatekeeperAssignment__c 
                                                WHERE Imerys_Site__c IN: sellingEntitySet
                                                AND Process__c =: Label.CL00072
                                                AND Object__c =: Label.CL00082
                                                ORDER BY Id DESC]){                                             
                                                    gatekeeperMap.put(gate.GateKeeper__c, gate);
                                                    gatekeeper2Set.add(gate.Gatekeeper2__c);
                                                    gatekeeper3Set.add(gate.Gatekeeper3__c);
                                                    gatekeeper4Set.add(gate.Gatekeeper4__c);
                                                    gateRecordId.add(gate.Id);
                                                }
        }            
        
        try{
            for(Customer_Request_Form__c objSampleTeam: aNewList){              
                if(gatekeeperMap.containsKey(objSampleTeam.Customer_Service_in_Charge__c)){                 
                    if(gatekeeperMap.size() > 0 && !gatekeeper2Set.contains(null)){             
                        sampleNewTeam2 = new CustomerRequestTeam__c();
                        sampleNewTeam2.Member__c = gatekeeperMap.get(objSampleTeam.Customer_Service_in_Charge__c).Gatekeeper2__c;
                        sampleNewTeam2.Role__c =  Label.CL00072;
                        sampleNewTeam2.Access__c =   Label.CL00071;
                        sampleNewTeam2.CustomerRequestForm__c = objSampleTeam.Id;
                        insertSampleTeamMap2.put(sampleNewTeam2.Id, sampleNewTeam2);
                        
                        sampleShare2 =  new Customer_Request_Form__share();
                        sampleShare2.ParentId = objSampleTeam.Id;               
                        sampleShare2.UserOrGroupId = gatekeeperMap.get(objSampleTeam.Customer_Service_in_Charge__c).Gatekeeper2__c;         
                        // Set the access level
                        sampleShare2.AccessLevel = Label.CL00071; 
                        insertSampleShare2.put(sampleShare2.Id,sampleShare2);                   
                    }
                    if(gatekeeperMap.size() > 0 && !gatekeeper3Set.contains(null)){              
                        sampleNewTeam3 = new CustomerRequestTeam__c();
                        sampleNewTeam3.Member__c = gatekeeperMap.get(objSampleTeam.Customer_Service_in_Charge__c).Gatekeeper3__c;
                        sampleNewTeam3.Role__c =  Label.CL00072;
                        sampleNewTeam3.Access__c =   Label.CL00071;             
                        sampleNewTeam3.CustomerRequestForm__c = objSampleTeam.Id;
                        insertSampleTeamMap3.put(sampleNewTeam3.Id, sampleNewTeam3);
                        
                        sampleShare3 =  new Customer_Request_Form__share();
                        sampleShare3.ParentId = objSampleTeam.Id;               
                        sampleShare3.UserOrGroupId = gatekeeperMap.get(objSampleTeam.Customer_Service_in_Charge__c).Gatekeeper3__c;          
                        // Set the access level
                        sampleShare3.AccessLevel =  Label.CL00071; 
                        insertSampleShare3.put(sampleShare3.Id,sampleShare3);   
                    }
                    if(gatekeeperMap.size() > 0 && !gatekeeper4Set.contains(null)){              
                        sampleNewTeam4 = new CustomerRequestTeam__c();
                        sampleNewTeam4.Member__c = gatekeeperMap.get(objSampleTeam.Customer_Service_in_Charge__c).Gatekeeper4__c;
                        sampleNewTeam4.Role__c =   Label.CL00072;
                        sampleNewTeam4.Access__c =   Label.CL00071;     
                        sampleNewTeam4.CustomerRequestForm__c = objSampleTeam.Id;
                        insertSampleTeamMap4.put(sampleNewTeam4.Id, sampleNewTeam4);
                        
                        sampleShare4 =  new Customer_Request_Form__share();
                        sampleShare4.ParentId = objSampleTeam.Id;               
                        sampleShare4.UserOrGroupId = gatekeeperMap.get(objSampleTeam.Customer_Service_in_Charge__c).Gatekeeper4__c;          
                        // Set the access level
                        sampleShare4.AccessLevel =  Label.CL00071; 
                        insertSampleShare4.put(sampleShare4.Id,sampleShare4);   
                    }
                    
                    if(objSampleTeam.Customer_Service_in_Charge__c!=null){
                        
                        sampleNewTeamGk = new CustomerRequestTeam__c();
                        sampleNewTeamGk.Member__c = objSampleTeam.Customer_Service_in_Charge__c;
                        sampleNewTeamGk.Role__c =   Label.CL00072;
                        sampleNewTeamGk.Access__c =   Label.CL00071;     
                        sampleNewTeamGk.CustomerRequestForm__c = objSampleTeam.Id;
                        insertSampleTeamGK.put(sampleNewTeamGk.Id, sampleNewTeamGk);
                        
                        
                        sampleShareGK =  new Customer_Request_Form__share();
                        sampleShareGK.ParentId = objSampleTeam.Id;               
                        sampleShareGK.UserOrGroupId = objSampleTeam.Customer_Service_in_Charge__c;          
                        // Set the access level
                        sampleShareGK.AccessLevel =  Label.CL00071; 
                        insertSampleShareGK.put(sampleShareGK.Id,sampleShareGK);
                    }
                }
                if(!gatekeeperMap.containsKey(objSampleTeam.Customer_Service_in_Charge__c)){
                    for(GatekeeperAssignment__c gateAssign:[SELECT Gatekeeper__c, Gatekeeper2__c, Gatekeeper3__c, Gatekeeper4__c
                                                            FROM GatekeeperAssignment__c WHERE Gatekeeper__c IN: gatekeeperMap.KeySet()
                                                            AND Id IN: gateRecordId
                                                            AND Process__c =: Label.CL00072
                                                            AND Object__c =: Label.CL00082]){
                                                                
                                                                if(gateAssign.Gatekeeper2__c!= null){                                
                                                                    sampleNewTeam2 = new CustomerRequestTeam__c();
                                                                    sampleNewTeam2.Member__c = gateAssign.Gatekeeper2__c;
                                                                    sampleNewTeam2.Role__c =   Label.CL00072;
                                                                    sampleNewTeam2.Access__c =   Label.CL00071;
                                                                    sampleNewTeam2.CustomerRequestForm__c = objSampleTeam.Id;
                                                                    insertSampleTeamMap2.put(sampleNewTeam2.Id, sampleNewTeam2);
                                                                    
                                                                    sampleShare2 =  new Customer_Request_Form__share();
                                                                    sampleShare2.ParentId = objSampleTeam.Id;               
                                                                    sampleShare2.UserOrGroupId = gateAssign.Gatekeeper2__c;         
                                                                    // Set the access level
                                                                    sampleShare2.AccessLevel = Label.CL00071; 
                                                                    insertSampleShare2.put(sampleShare2.Id,sampleShare2); 
                                                                }                                                   
                                                                if(gateAssign.Gatekeeper3__c!= null){       
                                                                    sampleNewTeam3 = new CustomerRequestTeam__c();
                                                                    sampleNewTeam3.Member__c = gateAssign.Gatekeeper3__c;
                                                                    sampleNewTeam3.Role__c =   Label.CL00072;
                                                                    sampleNewTeam3.Access__c =   Label.CL00071;             
                                                                    sampleNewTeam3.CustomerRequestForm__c = objSampleTeam.Id;
                                                                    insertSampleTeamMap3.put(sampleNewTeam3.Id, sampleNewTeam3);
                                                                    
                                                                    sampleShare3 =  new Customer_Request_Form__share();
                                                                    sampleShare3.ParentId = objSampleTeam.Id;               
                                                                    sampleShare3.UserOrGroupId = gateAssign.Gatekeeper3__c;          
                                                                    // Set the access level
                                                                    sampleShare3.AccessLevel =  Label.CL00071; 
                                                                    insertSampleShare3.put(sampleShare3.Id,sampleShare3); 
                                                                }
                                                                if(gateAssign.Gatekeeper4__c!= null){
                                                                    sampleNewTeam4 = new CustomerRequestTeam__c();
                                                                    sampleNewTeam4.Member__c = gateAssign.Gatekeeper4__c;
                                                                    sampleNewTeam4.Role__c =   Label.CL00072;
                                                                    sampleNewTeam4.Access__c =   Label.CL00071;     
                                                                    sampleNewTeam4.CustomerRequestForm__c = objSampleTeam.Id;
                                                                    insertSampleTeamMap4.put(sampleNewTeam4.Id, sampleNewTeam4);
                                                                    
                                                                    sampleShare4 =  new Customer_Request_Form__share();
                                                                    sampleShare4.ParentId = objSampleTeam.Id;               
                                                                    sampleShare4.UserOrGroupId = gateAssign.Gatekeeper4__c;          
                                                                    // Set the access level
                                                                    sampleShare4.AccessLevel =  Label.CL00071; 
                                                                    insertSampleShare4.put(sampleShare4.Id,sampleShare4); 
                                                                }
                                                                
                                                                if(objSampleTeam.Customer_Service_in_Charge__c!=null){
                                                                    
                                                                    sampleNewTeamGk = new CustomerRequestTeam__c();
                                                                    sampleNewTeamGk.Member__c = objSampleTeam.Customer_Service_in_Charge__c;
                                                                    sampleNewTeamGk.Role__c =   Label.CL00072;
                                                                    sampleNewTeamGk.Access__c =   Label.CL00071;     
                                                                    sampleNewTeamGk.CustomerRequestForm__c = objSampleTeam.Id;
                                                                    insertSampleTeamGK.put(sampleNewTeamGk.Id, sampleNewTeamGk);
                                                                    
                                                                    
                                                                    sampleShareGK =  new Customer_Request_Form__share();
                                                                    sampleShareGK.ParentId = objSampleTeam.Id;               
                                                                    sampleShareGK.UserOrGroupId = objSampleTeam.Customer_Service_in_Charge__c;          
                                                                    // Set the access level
                                                                    sampleShareGK.AccessLevel =  Label.CL00071; 
                                                                    insertSampleShareGK.put(sampleShareGK.Id,sampleShareGK);
                                                                }                        
                                                            }
                }
            }
            if(insertSampleTeamMap2.size() > 0){
                Database.insert(insertSampleTeamMap2.values(), false);
                Database.insert(insertSampleShare2.values(), false);
                
            }
            if(insertSampleTeamMap3.size() > 0){
                Database.insert(insertSampleTeamMap3.values(), false);
                Database.insert(insertSampleShare3.values(), false);
                
            }
            if(insertSampleTeamMap4.size() > 0){
                Database.insert(insertSampleTeamMap4.values(), false);
                Database.insert(insertSampleShare4.values(), false);
                
            }
            if(insertSampleShareAcctMang.size() > 0){
                //Database.insert(insertSampleShareAcctMang.values(), false);
                //Database.insert(insertSampleTeamAcctMang.values(), false);
                
            }
            if(insertSampleShareGK.size() > 0){
                Database.insert(insertSampleTeamGK.values(), false);
                Database.insert(insertSampleShareGK.values(), false);
                
            }
        }
        catch(Exception e){
            System.Debug('Error in assign customer service team '+ e);
        }                
    }
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 
*@Date modification 
*@param aNewList to pass update records.                      
*@return
*/  
    public static void createCreditControllerTeam(List<Customer_Request_Form__c> aNewList){
        Set<String> sellingEntitySet = new Set<String>();
        Set<Id> gatekeeper2Set = new Set<Id>();
        Set<Id> gatekeeper3Set = new Set<Id>();
        Set<Id> gatekeeper4Set = new Set<Id>();
        Set<Id> gateRecordId = new Set<Id>();       
        Map<Id,GatekeeperAssignment__c> gatekeeperMap = new Map<Id,GatekeeperAssignment__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamMap2 = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamMap3 = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamMap4 = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamAcctMang = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamGK = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleCreatedBy = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, Customer_Request_Form__share> insertSampleShare2 = new Map<id, Customer_Request_Form__share>();
        Map<Id, Customer_Request_Form__share> insertSampleShare3 = new Map<id, Customer_Request_Form__share>();
        Map<Id, Customer_Request_Form__share> insertSampleShare4 = new Map<id, Customer_Request_Form__share>();
        Map<Id, Customer_Request_Form__share> insertSampleShareAcctMang = new Map<id, Customer_Request_Form__share>();
        Map<Id, Customer_Request_Form__share> insertSampleShareGK = new Map<id, Customer_Request_Form__share>();
        CustomerRequestTeam__c sampleNewTeam2;
        CustomerRequestTeam__c sampleNewTeam3;
        CustomerRequestTeam__c sampleNewTeam4;
        CustomerRequestTeam__c sampleNewTeamGk;
        CustomerRequestTeam__c sampleNewTeamAcctMang;
        Customer_Request_Form__share sampleShare2;
        Customer_Request_Form__share sampleShare3;
        Customer_Request_Form__share sampleShare4;
        Customer_Request_Form__share sampleShareAcctMang;
        Customer_Request_Form__share sampleShareGK;
        
        for(Customer_Request_Form__c obj : aNewList){
            sellingEntitySet.add(obj.Imerys_Selling_Entity_Lookup__c); 
            
        }       
        
        if(sellingEntitySet !=null){   
            for(GatekeeperAssignment__c gate : [SELECT Imerys_Site__c,Gatekeeper__c, Gatekeeper2__c, Gatekeeper3__c, Gatekeeper4__c
                                                FROM GatekeeperAssignment__c 
                                                WHERE Imerys_Site__c	 IN: sellingEntitySet
                                                AND Process__c =: Label.CL00073
                                                AND Object__c =: Label.CL00082
                                                ORDER BY Id DESC]){                                             
                                                    gatekeeperMap.put(gate.GateKeeper__c, gate);
                                                    gatekeeper2Set.add(gate.Gatekeeper2__c);
                                                    gatekeeper3Set.add(gate.Gatekeeper3__c);
                                                    gatekeeper4Set.add(gate.Gatekeeper4__c);
                                                    gateRecordId.add(gate.Id);
                                                }
        }            
        
        try{
            for(Customer_Request_Form__c objSampleTeam: aNewList){              
                if(gatekeeperMap.containsKey(objSampleTeam.CreditControllerinCharge__c)){                 
                    if(gatekeeperMap.size() > 0 && !gatekeeper2Set.contains(null)){             
                        sampleNewTeam2 = new CustomerRequestTeam__c();
                        sampleNewTeam2.Member__c = gatekeeperMap.get(objSampleTeam.CreditControllerinCharge__c).Gatekeeper2__c;
                        sampleNewTeam2.Role__c =  Label.CL00073;
                        sampleNewTeam2.Access__c =   Label.CL00071;
                        sampleNewTeam2.CustomerRequestForm__c = objSampleTeam.Id;
                        insertSampleTeamMap2.put(sampleNewTeam2.Id, sampleNewTeam2);
                        
                        sampleShare2 =  new Customer_Request_Form__share();
                        sampleShare2.ParentId = objSampleTeam.Id;               
                        sampleShare2.UserOrGroupId = gatekeeperMap.get(objSampleTeam.CreditControllerinCharge__c).Gatekeeper2__c;         
                        // Set the access level
                        sampleShare2.AccessLevel = Label.CL00071; 
                        insertSampleShare2.put(sampleShare2.Id,sampleShare2);                   
                    }
                    if(gatekeeperMap.size() > 0 && !gatekeeper3Set.contains(null)){              
                        sampleNewTeam3 = new CustomerRequestTeam__c();
                        sampleNewTeam3.Member__c = gatekeeperMap.get(objSampleTeam.CreditControllerinCharge__c).Gatekeeper3__c;
                        sampleNewTeam3.Role__c =  Label.CL00073;
                        sampleNewTeam3.Access__c =   Label.CL00071;             
                        sampleNewTeam3.CustomerRequestForm__c = objSampleTeam.Id;
                        insertSampleTeamMap3.put(sampleNewTeam3.Id, sampleNewTeam3);
                        
                        sampleShare3 =  new Customer_Request_Form__share();
                        sampleShare3.ParentId = objSampleTeam.Id;               
                        sampleShare3.UserOrGroupId = gatekeeperMap.get(objSampleTeam.CreditControllerinCharge__c).Gatekeeper3__c;          
                        // Set the access level
                        sampleShare3.AccessLevel =  Label.CL00071; 
                        insertSampleShare3.put(sampleShare3.Id,sampleShare3);   
                    }
                    if(gatekeeperMap.size() > 0 && !gatekeeper4Set.contains(null)){              
                        sampleNewTeam4 = new CustomerRequestTeam__c();
                        sampleNewTeam4.Member__c = gatekeeperMap.get(objSampleTeam.CreditControllerinCharge__c).Gatekeeper4__c;
                        sampleNewTeam4.Role__c =   Label.CL00073;
                        sampleNewTeam4.Access__c =   Label.CL00071;     
                        sampleNewTeam4.CustomerRequestForm__c = objSampleTeam.Id;
                        insertSampleTeamMap4.put(sampleNewTeam4.Id, sampleNewTeam4);
                        
                        sampleShare4 =  new Customer_Request_Form__share();
                        sampleShare4.ParentId = objSampleTeam.Id;               
                        sampleShare4.UserOrGroupId = gatekeeperMap.get(objSampleTeam.CreditControllerinCharge__c).Gatekeeper4__c;          
                        // Set the access level
                        sampleShare4.AccessLevel =  Label.CL00071; 
                        insertSampleShare4.put(sampleShare4.Id,sampleShare4);   
                    }
                    
                    if(objSampleTeam.CreditControllerinCharge__c!=null){
                        
                        sampleNewTeamGk = new CustomerRequestTeam__c();
                        sampleNewTeamGk.Member__c = objSampleTeam.CreditControllerinCharge__c;
                        sampleNewTeamGk.Role__c =   Label.CL00073;
                        sampleNewTeamGk.Access__c =   Label.CL00071;     
                        sampleNewTeamGk.CustomerRequestForm__c = objSampleTeam.Id;
                        insertSampleTeamGK.put(sampleNewTeamGk.Id, sampleNewTeamGk);
                        
                        
                        sampleShareGK =  new Customer_Request_Form__share();
                        sampleShareGK.ParentId = objSampleTeam.Id;               
                        sampleShareGK.UserOrGroupId = objSampleTeam.CreditControllerinCharge__c;          
                        // Set the access level
                        sampleShareGK.AccessLevel =  Label.CL00071; 
                        insertSampleShareGK.put(sampleShareGK.Id,sampleShareGK);
                    }   
                }
                if(!gatekeeperMap.containsKey(objSampleTeam.CreditControllerinCharge__c)){
                    for(GatekeeperAssignment__c gateAssign:[SELECT Gatekeeper__c, Gatekeeper2__c, Gatekeeper3__c, Gatekeeper4__c
                                                            FROM GatekeeperAssignment__c WHERE Gatekeeper__c IN: gatekeeperMap.KeySet()
                                                            AND Id IN: gateRecordId
                                                            AND Process__c =: Label.CL00073
                                                            AND Object__c =: Label.CL00082]){
                                                                
                                                                if(gateAssign.Gatekeeper2__c!= null){                                
                                                                    sampleNewTeam2 = new CustomerRequestTeam__c();
                                                                    sampleNewTeam2.Member__c = gateAssign.Gatekeeper2__c;
                                                                    sampleNewTeam2.Role__c =   Label.CL00073;
                                                                    sampleNewTeam2.Access__c =   Label.CL00071;
                                                                    sampleNewTeam2.CustomerRequestForm__c = objSampleTeam.Id;
                                                                    insertSampleTeamMap2.put(sampleNewTeam2.Id, sampleNewTeam2);
                                                                    
                                                                    sampleShare2 =  new Customer_Request_Form__share();
                                                                    sampleShare2.ParentId = objSampleTeam.Id;               
                                                                    sampleShare2.UserOrGroupId = gateAssign.Gatekeeper2__c;         
                                                                    // Set the access level
                                                                    sampleShare2.AccessLevel = Label.CL00071; 
                                                                    insertSampleShare2.put(sampleShare2.Id,sampleShare2); 
                                                                }                                                   
                                                                if(gateAssign.Gatekeeper3__c!= null){       
                                                                    sampleNewTeam3 = new CustomerRequestTeam__c();
                                                                    sampleNewTeam3.Member__c = gateAssign.Gatekeeper3__c;
                                                                    sampleNewTeam3.Role__c =   Label.CL00073;
                                                                    sampleNewTeam3.Access__c =   Label.CL00071;             
                                                                    sampleNewTeam3.CustomerRequestForm__c = objSampleTeam.Id;
                                                                    insertSampleTeamMap3.put(sampleNewTeam3.Id, sampleNewTeam3);
                                                                    
                                                                    sampleShare3 =  new Customer_Request_Form__share();
                                                                    sampleShare3.ParentId = objSampleTeam.Id;               
                                                                    sampleShare3.UserOrGroupId = gateAssign.Gatekeeper3__c;          
                                                                    // Set the access level
                                                                    sampleShare3.AccessLevel =  Label.CL00071; 
                                                                    insertSampleShare3.put(sampleShare3.Id,sampleShare3); 
                                                                }
                                                                if(gateAssign.Gatekeeper4__c!= null){
                                                                    sampleNewTeam4 = new CustomerRequestTeam__c();
                                                                    sampleNewTeam4.Member__c = gateAssign.Gatekeeper4__c;
                                                                    sampleNewTeam4.Role__c =   Label.CL00073;
                                                                    sampleNewTeam4.Access__c =   Label.CL00071;     
                                                                    sampleNewTeam4.CustomerRequestForm__c = objSampleTeam.Id;
                                                                    insertSampleTeamMap4.put(sampleNewTeam4.Id, sampleNewTeam4);
                                                                    
                                                                    sampleShare4 =  new Customer_Request_Form__share();
                                                                    sampleShare4.ParentId = objSampleTeam.Id;               
                                                                    sampleShare4.UserOrGroupId = gateAssign.Gatekeeper4__c;          
                                                                    // Set the access level
                                                                    sampleShare4.AccessLevel =  Label.CL00071; 
                                                                    insertSampleShare4.put(sampleShare4.Id,sampleShare4); 
                                                                }
                                                                if(objSampleTeam.CreditControllerinCharge__c!=null){
                                                                    
                                                                    sampleNewTeamGk = new CustomerRequestTeam__c();
                                                                    sampleNewTeamGk.Member__c = objSampleTeam.CreditControllerinCharge__c;
                                                                    sampleNewTeamGk.Role__c =   Label.CL00073;
                                                                    sampleNewTeamGk.Access__c =   Label.CL00071;     
                                                                    sampleNewTeamGk.CustomerRequestForm__c = objSampleTeam.Id;
                                                                    insertSampleTeamGK.put(sampleNewTeamGk.Id, sampleNewTeamGk);
                                                                    
                                                                    
                                                                    sampleShareGK =  new Customer_Request_Form__share();
                                                                    sampleShareGK.ParentId = objSampleTeam.Id;               
                                                                    sampleShareGK.UserOrGroupId = objSampleTeam.CreditControllerinCharge__c;          
                                                                    // Set the access level
                                                                    sampleShareGK.AccessLevel =  Label.CL00071; 
                                                                    insertSampleShareGK.put(sampleShareGK.Id,sampleShareGK);
                                                                }   
                                                            }
                }
            }
            if(insertSampleTeamMap2.size() > 0){
                Database.insert(insertSampleTeamMap2.values(), false);
                Database.insert(insertSampleShare2.values(), false);
                
            }
            if(insertSampleTeamMap3.size() > 0){
                Database.insert(insertSampleTeamMap3.values(), false);
                Database.insert(insertSampleShare3.values(), false);
                
            }
            if(insertSampleTeamMap4.size() > 0){
                Database.insert(insertSampleTeamMap4.values(), false);
                Database.insert(insertSampleShare4.values(), false);
                
            }
            if(insertSampleShareAcctMang.size() > 0){
                //Database.insert(insertSampleShareAcctMang.values(), false);
                //Database.insert(insertSampleTeamAcctMang.values(), false);
                
            }
            if(insertSampleShareGK.size() > 0){
                Database.insert(insertSampleShareAcctMang.values(), false);
                Database.insert(insertSampleShareGK.values(), false);
                
            }
            
        }
        catch(DMLException e){
            System.Debug('Error in assign customer service team '+ e);
        }                
    }
    
    
    public static void createERPCreatorinChargeTeam(List<Customer_Request_Form__c> aNewList){
        system.debug('inside ERP');
        Set<String> sellingEntitySet = new Set<String>();
        Set<Id> gatekeeper2Set = new Set<Id>();
        Set<Id> gatekeeper3Set = new Set<Id>();
        Set<Id> gatekeeper4Set = new Set<Id>();
        Set<Id> gateRecordId = new Set<Id>();       
        Map<Id,GatekeeperAssignment__c> gatekeeperMap = new Map<Id,GatekeeperAssignment__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamMap2 = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamMap3 = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamMap4 = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamAcctMang = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamGK = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleCreatedBy = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, Customer_Request_Form__share> insertSampleShare2 = new Map<id, Customer_Request_Form__share>();
        Map<Id, Customer_Request_Form__share> insertSampleShare3 = new Map<id, Customer_Request_Form__share>();
        Map<Id, Customer_Request_Form__share> insertSampleShare4 = new Map<id, Customer_Request_Form__share>();
        Map<Id, Customer_Request_Form__share> insertSampleShareAcctMang = new Map<id, Customer_Request_Form__share>();
        Map<Id, Customer_Request_Form__share> insertSampleShareGK = new Map<id, Customer_Request_Form__share>();
        CustomerRequestTeam__c sampleNewTeam2;
        CustomerRequestTeam__c sampleNewTeam3;
        CustomerRequestTeam__c sampleNewTeam4;
        CustomerRequestTeam__c sampleNewTeamGk;
        CustomerRequestTeam__c sampleNewTeamAcctMang;
        Customer_Request_Form__share sampleShare2;
        Customer_Request_Form__share sampleShare3;
        Customer_Request_Form__share sampleShare4;
        Customer_Request_Form__share sampleShareAcctMang;
        Customer_Request_Form__share sampleShareGK;
        
        for(Customer_Request_Form__c obj : aNewList){
            sellingEntitySet.add(obj.Imerys_Selling_Entity_Lookup__c); 
            
        }       
        
        if(sellingEntitySet !=null){   
            for(GatekeeperAssignment__c gate : [SELECT Imerys_Site__c,Gatekeeper__c, Gatekeeper2__c, Gatekeeper3__c, Gatekeeper4__c
                                                FROM GatekeeperAssignment__c 
                                                WHERE Imerys_Site__c	 IN: sellingEntitySet
                                                AND Process__c =: Label.CL00098
                                                AND Object__c =: Label.CL00082
                                                ORDER BY Id DESC]){                                             
                                                    gatekeeperMap.put(gate.GateKeeper__c, gate);
                                                    gatekeeper2Set.add(gate.Gatekeeper2__c);
                                                    gatekeeper3Set.add(gate.Gatekeeper3__c);
                                                    gatekeeper4Set.add(gate.Gatekeeper4__c);
                                                    gateRecordId.add(gate.Id);
                                                   system.debug('SOQL Records'+gate);
                                                }
        }            
        
        try{
            for(Customer_Request_Form__c objSampleTeam: aNewList){              
                if(gatekeeperMap.containsKey(objSampleTeam.ERP_Creator_in_Charge__c)){                 
                    if(gatekeeperMap.size() > 0 && !gatekeeper2Set.contains(null)){             
                        sampleNewTeam2 = new CustomerRequestTeam__c();
                        sampleNewTeam2.Member__c = gatekeeperMap.get(objSampleTeam.ERP_Creator_in_Charge__c).Gatekeeper2__c;
                        sampleNewTeam2.Role__c =  Label.CL00098;
                        sampleNewTeam2.Access__c =   Label.CL00071;
                        sampleNewTeam2.CustomerRequestForm__c = objSampleTeam.Id;
                        insertSampleTeamMap2.put(sampleNewTeam2.Id, sampleNewTeam2);
                        
                        sampleShare2 =  new Customer_Request_Form__share();
                        sampleShare2.ParentId = objSampleTeam.Id;               
                        sampleShare2.UserOrGroupId = gatekeeperMap.get(objSampleTeam.ERP_Creator_in_Charge__c).Gatekeeper2__c;         
                        // Set the access level
                        sampleShare2.AccessLevel = Label.CL00071; 
                        insertSampleShare2.put(sampleShare2.Id,sampleShare2);                   
                    }
                    if(gatekeeperMap.size() > 0 && !gatekeeper3Set.contains(null)){              
                        sampleNewTeam3 = new CustomerRequestTeam__c();
                        sampleNewTeam3.Member__c = gatekeeperMap.get(objSampleTeam.ERP_Creator_in_Charge__c).Gatekeeper3__c;
                        sampleNewTeam3.Role__c =  Label.CL00098;
                        sampleNewTeam3.Access__c =   Label.CL00071;             
                        sampleNewTeam3.CustomerRequestForm__c = objSampleTeam.Id;
                        insertSampleTeamMap3.put(sampleNewTeam3.Id, sampleNewTeam3);
                        
                        sampleShare3 =  new Customer_Request_Form__share();
                        sampleShare3.ParentId = objSampleTeam.Id;               
                        sampleShare3.UserOrGroupId = gatekeeperMap.get(objSampleTeam.ERP_Creator_in_Charge__c).Gatekeeper3__c;          
                        // Set the access level
                        sampleShare3.AccessLevel =  Label.CL00071; 
                        insertSampleShare3.put(sampleShare3.Id,sampleShare3);   
                    }
                    if(gatekeeperMap.size() > 0 && !gatekeeper4Set.contains(null)){              
                        sampleNewTeam4 = new CustomerRequestTeam__c();
                        sampleNewTeam4.Member__c = gatekeeperMap.get(objSampleTeam.ERP_Creator_in_Charge__c).Gatekeeper4__c;
                        sampleNewTeam4.Role__c =   Label.CL00098;
                        sampleNewTeam4.Access__c =   Label.CL00071;     
                        sampleNewTeam4.CustomerRequestForm__c = objSampleTeam.Id;
                        insertSampleTeamMap4.put(sampleNewTeam4.Id, sampleNewTeam4);
                        
                        sampleShare4 =  new Customer_Request_Form__share();
                        sampleShare4.ParentId = objSampleTeam.Id;               
                        sampleShare4.UserOrGroupId = gatekeeperMap.get(objSampleTeam.ERP_Creator_in_Charge__c).Gatekeeper4__c;          
                        // Set the access level
                        sampleShare4.AccessLevel =  Label.CL00071; 
                        insertSampleShare4.put(sampleShare4.Id,sampleShare4);   
                    }
                    
                    if(objSampleTeam.ERP_Creator_in_Charge__c!=null){
                        
                        sampleNewTeamGk = new CustomerRequestTeam__c();
                        sampleNewTeamGk.Member__c = objSampleTeam.ERP_Creator_in_Charge__c;
                        sampleNewTeamGk.Role__c =   Label.CL00098;
                        sampleNewTeamGk.Access__c =   Label.CL00071;     
                        sampleNewTeamGk.CustomerRequestForm__c = objSampleTeam.Id;
                        insertSampleTeamGK.put(sampleNewTeamGk.Id, sampleNewTeamGk);
                        
                        
                        sampleShareGK =  new Customer_Request_Form__share();
                        sampleShareGK.ParentId = objSampleTeam.Id;               
                        sampleShareGK.UserOrGroupId = objSampleTeam.ERP_Creator_in_Charge__c;         
                        // Set the access level
                        sampleShareGK.AccessLevel =  Label.CL00071; 
                        insertSampleShareGK.put(sampleShareGK.Id,sampleShareGK);
                    }   
                }
                if(!gatekeeperMap.containsKey(objSampleTeam.ERP_Creator_in_Charge__c)){
                    for(GatekeeperAssignment__c gateAssign:[SELECT Gatekeeper__c, Gatekeeper2__c, Gatekeeper3__c, Gatekeeper4__c
                                                            FROM GatekeeperAssignment__c WHERE Gatekeeper__c IN: gatekeeperMap.KeySet()
                                                            AND Id IN: gateRecordId
                                                            AND Process__c =: Label.CL00098
                                                            AND Object__c =: Label.CL00082]){
                                                                
                                                                if(gateAssign.Gatekeeper2__c!= null){                                
                                                                    sampleNewTeam2 = new CustomerRequestTeam__c();
                                                                    sampleNewTeam2.Member__c = gateAssign.Gatekeeper2__c;
                                                                    sampleNewTeam2.Role__c =   Label.CL00098;
                                                                    sampleNewTeam2.Access__c =   Label.CL00071;
                                                                    sampleNewTeam2.CustomerRequestForm__c = objSampleTeam.Id;
                                                                    insertSampleTeamMap2.put(sampleNewTeam2.Id, sampleNewTeam2);
                                                                    
                                                                    sampleShare2 =  new Customer_Request_Form__share();
                                                                    sampleShare2.ParentId = objSampleTeam.Id;               
                                                                    sampleShare2.UserOrGroupId = gateAssign.Gatekeeper2__c;         
                                                                    // Set the access level
                                                                    sampleShare2.AccessLevel = Label.CL00071; 
                                                                    insertSampleShare2.put(sampleShare2.Id,sampleShare2); 
                                                                }                                                   
                                                                if(gateAssign.Gatekeeper3__c!= null){       
                                                                    sampleNewTeam3 = new CustomerRequestTeam__c();
                                                                    sampleNewTeam3.Member__c = gateAssign.Gatekeeper3__c;
                                                                    sampleNewTeam3.Role__c =   Label.CL00098;
                                                                    sampleNewTeam3.Access__c =   Label.CL00071;             
                                                                    sampleNewTeam3.CustomerRequestForm__c = objSampleTeam.Id;
                                                                    insertSampleTeamMap3.put(sampleNewTeam3.Id, sampleNewTeam3);
                                                                    
                                                                    sampleShare3 =  new Customer_Request_Form__share();
                                                                    sampleShare3.ParentId = objSampleTeam.Id;               
                                                                    sampleShare3.UserOrGroupId = gateAssign.Gatekeeper3__c;          
                                                                    // Set the access level
                                                                    sampleShare3.AccessLevel =  Label.CL00071; 
                                                                    insertSampleShare3.put(sampleShare3.Id,sampleShare3); 
                                                                }
                                                                if(gateAssign.Gatekeeper4__c!= null){
                                                                    sampleNewTeam4 = new CustomerRequestTeam__c();
                                                                    sampleNewTeam4.Member__c = gateAssign.Gatekeeper4__c;
                                                                    sampleNewTeam4.Role__c =   Label.CL00098;
                                                                    sampleNewTeam4.Access__c =   Label.CL00071;     
                                                                    sampleNewTeam4.CustomerRequestForm__c = objSampleTeam.Id;
                                                                    insertSampleTeamMap4.put(sampleNewTeam4.Id, sampleNewTeam4);
                                                                    
                                                                    sampleShare4 =  new Customer_Request_Form__share();
                                                                    sampleShare4.ParentId = objSampleTeam.Id;               
                                                                    sampleShare4.UserOrGroupId = gateAssign.Gatekeeper4__c;          
                                                                    // Set the access level
                                                                    sampleShare4.AccessLevel =  Label.CL00071; 
                                                                    insertSampleShare4.put(sampleShare4.Id,sampleShare4); 
                                                                }
                                                                if(objSampleTeam.ERP_Creator_in_Charge__c!=null){
                                                                    
                                                                    sampleNewTeamGk = new CustomerRequestTeam__c();
                                                                    sampleNewTeamGk.Member__c = objSampleTeam.ERP_Creator_in_Charge__c;
                                                                    sampleNewTeamGk.Role__c =   Label.CL00098;
                                                                    sampleNewTeamGk.Access__c =   Label.CL00071;     
                                                                    sampleNewTeamGk.CustomerRequestForm__c = objSampleTeam.Id;
                                                                    insertSampleTeamGK.put(sampleNewTeamGk.Id, sampleNewTeamGk);
                                                                    
                                                                    
                                                                    sampleShareGK =  new Customer_Request_Form__share();
                                                                    sampleShareGK.ParentId = objSampleTeam.Id;               
                                                                    sampleShareGK.UserOrGroupId = objSampleTeam.ERP_Creator_in_Charge__c;          
                                                                    // Set the access level
                                                                    sampleShareGK.AccessLevel =  Label.CL00071; 
                                                                    insertSampleShareGK.put(sampleShareGK.Id,sampleShareGK);
                                                                }   
                                                            }
                }
            }
            if(insertSampleTeamMap2.size() > 0){
                Database.insert(insertSampleTeamMap2.values(), false);
                Database.insert(insertSampleShare2.values(), false);
                
                
            }
            if(insertSampleTeamMap3.size() > 0){
                Database.insert(insertSampleTeamMap3.values(), false);
                Database.insert(insertSampleShare3.values(), false);
                
                
            }
            if(insertSampleTeamMap4.size() > 0){
                Database.insert(insertSampleTeamMap4.values(), false);
                Database.insert(insertSampleShare4.values(), false);
                System.debug('GK4 inserted');
                
            }
            if(insertSampleShareAcctMang.size() > 0){
                //Database.insert(insertSampleShareAcctMang.values(), false);
                //Database.insert(insertSampleTeamAcctMang.values(), false);
                
            }
            if(insertSampleShareGK.size() > 0){
                Database.insert(insertSampleTeamGK.values(), false);
                Database.insert(insertSampleShareGK.values(), false);
                
            }
            
        }
        catch(DMLException e){
            System.Debug('Error in assign customer service team '+ e);
        }                
    }
    
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 
*@Date modification 
*@param aNewList to pass update records.                      
*@return
*/  @future
    public static void createCreatedById(set<String> aNewList){
        //write your code here            
        
        Map<Id, CustomerRequestTeam__c> insertSampleCreatedBy = new Map<id,  CustomerRequestTeam__c>();   
        CustomerRequestTeam__c sampleNewTeamGk;
        Set<Id>recordId=new Set<Id>();
        Map<Id, CustomerRequestTeam__c> insertSampleAcctMang = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, Customer_Request_Form__share> insertSampleShareAcctMang = new Map<id, Customer_Request_Form__share>();
        List<Customer_Request_Form__c>CustomerNewList = new List<Customer_Request_Form__c>();       
        CustomerRequestTeam__c sampleNewTeamAcctMang;
        Customer_Request_Form__share sampleShareAcctMang;
        
        for(Customer_Request_Form__c samp : [select Id, CreatedById,Account_Manager__c from Customer_Request_Form__c where id in: aNewList]){
            CustomerNewList.add(samp);
        }
        for(Customer_Request_Form__c cust: CustomerNewList){
            recordId.add(cust.Id);
        }
        integer count =0;
        count =[SELECT count() from CustomerRequestTeam__c where Role__c=:Label.CL00074 AND CustomerRequestForm__c IN:recordId];
        try{
            for(Customer_Request_Form__c objSampleTeam: CustomerNewList){
                
                sampleNewTeamGk = new CustomerRequestTeam__c();
                sampleNewTeamGk.Member__c = objSampleTeam.createdById;
                sampleNewTeamGk.Role__c = Label.CL00075;
                sampleNewTeamGk.Access__c =   Label.CL00071;
                sampleNewTeamGk.CustomerRequestForm__c = objSampleTeam.Id;
                insertSampleCreatedBy.put(sampleNewTeamGk.Id, sampleNewTeamGk);
                
                if(objSampleTeam.Account_Manager__c!=null && count == 0){
                    sampleNewTeamAcctMang = new CustomerRequestTeam__c();
                    sampleNewTeamAcctMang.Member__c = objSampleTeam.Account_Manager__c;
                    sampleNewTeamAcctMang.Role__c =   Label.CL00074;
                    sampleNewTeamAcctMang.Access__c =   Label.CL00071;     
                    sampleNewTeamAcctMang.CustomerRequestForm__c = objSampleTeam.Id;
                    insertSampleAcctMang.put(sampleNewTeamAcctMang.Id, sampleNewTeamAcctMang);
                    
                    
                    sampleShareAcctMang =  new Customer_Request_Form__share();
                    sampleShareAcctMang.ParentId = objSampleTeam.Id;               
                    sampleShareAcctMang.UserOrGroupId = objSampleTeam.Account_Manager__c;          
                    // Set the access level
                    sampleShareAcctMang.AccessLevel =  Label.CL00071; 
                    insertSampleShareAcctMang.put(sampleShareAcctMang.Id,sampleShareAcctMang);
                    
                }
                if(insertSampleCreatedBy.size() > 0){
                    Database.insert(insertSampleCreatedBy.values(), false);
                    
                }
                if(insertSampleAcctMang.size() > 0){
                    Database.insert(insertSampleAcctMang.values(), false);
                    Database.insert(insertSampleShareAcctMang.values(), false);                           
                }
            }
        }
        catch(DMLException e){
            System.Debug('Error in assign customer service team '+ e);
        }
    }                   
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 
*@Date modification 
*@param aNewList to pass update records.                      
*@return
*/  
    public static void updateCustomerTeam(List<Customer_Request_Form__c> aNewList, List<Customer_Request_Form__c> aOldList){
        Set<Id> gatekeeperNewSet = new Set<Id>();
        Set<Id> gateRecordId = new Set<Id>();
        Set<Id> recordIdSet = new Set<Id>();
        Set<Id> gatekeeperOldSet = new Set<Id>();
        Set<Id> gatekeeper2Set = new Set<Id>();
        Set<Id> gatekeeper3Set = new Set<Id>();
        Set<Id> gatekeeper4Set = new Set<Id>();
        Set<String> entityOld = new Set<String>();
        Set<String> entityNew = new Set<String>();
        Map<Id,GatekeeperAssignment__c> gatekeeperMap = new Map<Id,GatekeeperAssignment__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamMap2 = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamMap3 = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamMap4 = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamAcctMang = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamGK = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleCreatedBy = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, Customer_Request_Form__share> insertSampleShare2 = new Map<id, Customer_Request_Form__share>();
        Map<Id, Customer_Request_Form__share> insertSampleShare3 = new Map<id, Customer_Request_Form__share>();
        Map<Id, Customer_Request_Form__share> insertSampleShare4 = new Map<id, Customer_Request_Form__share>();
        Map<Id, Customer_Request_Form__share> insertSampleShareAcctMang = new Map<id, Customer_Request_Form__share>();
        Map<Id, Customer_Request_Form__share> insertSampleShareGK = new Map<id, Customer_Request_Form__share>();
        CustomerRequestTeam__c sampleNewTeam2;
        CustomerRequestTeam__c sampleNewTeam3;
        CustomerRequestTeam__c sampleNewTeam4;
        CustomerRequestTeam__c sampleNewTeamAcctMang;
        CustomerRequestTeam__c sampleNewTeamGk;
        CustomerRequestTeam__c sampleNewCreatedBy;
        Customer_Request_Form__share sampleShare2;
        Customer_Request_Form__share sampleShare3;
        Customer_Request_Form__share sampleShare4;
        Customer_Request_Form__share sampleShareAcctMang;
        Customer_Request_Form__share sampleShareGK;
        
        for(Customer_Request_Form__c objOld : aOldList){
            entityOld.add(objOld.Imerys_Selling_Entity_Lookup__c); 
            gatekeeperOldSet.add(objOld.Customer_Service_in_Charge__c);
            recordIdSet.add(objOld.Id);
            
        }
        
        for(Customer_Request_Form__c obj : aNewList){
            
            entityNew.add(obj.Imerys_Selling_Entity_Lookup__c);
            gatekeeperNewSet.add(obj.Customer_Service_in_Charge__c);
            
        }
        
        if(entityOld!=entityNew){   
            system.Debug('Entity  Not same');
            try{
                delete [select Id, UserOrGroupId FROM Customer_Request_Form__share 
                        WHERE ParentId IN:recordIdSet
                        AND RowCause != 'Owner'
                        AND Rowcause = 'Manual'
                       ];
                
                delete [select Id, Member__c FROM CustomerRequestTeam__c WHERE CustomerRequestForm__c IN:recordIdSet AND Role__c NOT IN(:Label.CL00074, :Label.CL00075)
                        AND Role__c IN(:Label.CL00072)];
                
            }catch(DMLException e){
                system.Debug('Error in updateShareTeam' + e);
            }   
        }
        
        
        
        if (entityNew!=entityOld && gatekeeperNewSet!=null){           
            for(GatekeeperAssignment__c gate : [SELECT Imerys_Site__c,Gatekeeper__c, Gatekeeper2__c, Gatekeeper3__c, Gatekeeper4__c  
                                                FROM GatekeeperAssignment__c
                                                WHERE Imerys_Site__c IN: entityNew
                                                AND Process__c =: Label.CL00072
                                                AND Object__c =: Label.CL00082
                                                ORDER BY Id DESC]){                                             
                                                    
                                                    gatekeeperMap.put(gate.GateKeeper__c, gate);
                                                    gatekeeper2Set.add(gate.Gatekeeper2__c);
                                                    gatekeeper3Set.add(gate.Gatekeeper3__c);
                                                    gatekeeper4Set.add(gate.Gatekeeper4__c);
                                                    gateRecordId.add(gate.Id);
                                                }
        }                            
        try{
            for(Customer_Request_Form__c objSampleTeam: aNewList){              
                if(gatekeeperMap.containsKey(objSampleTeam.Customer_Service_in_Charge__c)){                 
                    if(gatekeeperMap.size() > 0 && !gatekeeper2Set.contains(null)){             
                        sampleNewTeam2 = new CustomerRequestTeam__c();
                        sampleNewTeam2.Member__c = gatekeeperMap.get(objSampleTeam.Customer_Service_in_Charge__c).Gatekeeper2__c;
                        sampleNewTeam2.Role__c =  Label.CL00072;
                        sampleNewTeam2.Access__c =   Label.CL00071;
                        sampleNewTeam2.CustomerRequestForm__c = objSampleTeam.Id;
                        insertSampleTeamMap2.put(sampleNewTeam2.Id, sampleNewTeam2);
                        
                        sampleShare2 =  new Customer_Request_Form__share();
                        sampleShare2.ParentId = objSampleTeam.Id;               
                        sampleShare2.UserOrGroupId = gatekeeperMap.get(objSampleTeam.Customer_Service_in_Charge__c).Gatekeeper2__c;         
                        // Set the access level
                        sampleShare2.AccessLevel = Label.CL00071; 
                        insertSampleShare2.put(sampleShare2.Id,sampleShare2);                   
                    }
                    if(gatekeeperMap.size() > 0 && !gatekeeper3Set.contains(null)){              
                        sampleNewTeam3 = new CustomerRequestTeam__c();
                        sampleNewTeam3.Member__c = gatekeeperMap.get(objSampleTeam.Customer_Service_in_Charge__c).Gatekeeper3__c;
                        sampleNewTeam3.Role__c =  Label.CL00072;
                        sampleNewTeam3.Access__c =   Label.CL00071;             
                        sampleNewTeam3.CustomerRequestForm__c = objSampleTeam.Id;
                        insertSampleTeamMap3.put(sampleNewTeam3.Id, sampleNewTeam3);
                        
                        sampleShare3 =  new Customer_Request_Form__share();
                        sampleShare3.ParentId = objSampleTeam.Id;               
                        sampleShare3.UserOrGroupId = gatekeeperMap.get(objSampleTeam.Customer_Service_in_Charge__c).Gatekeeper3__c;          
                        // Set the access level
                        sampleShare3.AccessLevel =  Label.CL00071; 
                        insertSampleShare3.put(sampleShare3.Id,sampleShare3);   
                    }
                    if(gatekeeperMap.size() > 0 && !gatekeeper4Set.contains(null)){              
                        sampleNewTeam4 = new CustomerRequestTeam__c();
                        sampleNewTeam4.Member__c = gatekeeperMap.get(objSampleTeam.Customer_Service_in_Charge__c).Gatekeeper4__c;
                        sampleNewTeam4.Role__c =   Label.CL00072;
                        sampleNewTeam4.Access__c =   Label.CL00071;     
                        sampleNewTeam4.CustomerRequestForm__c = objSampleTeam.Id;
                        insertSampleTeamMap4.put(sampleNewTeam4.Id, sampleNewTeam4);
                        
                        sampleShare4 =  new Customer_Request_Form__share();
                        sampleShare4.ParentId = objSampleTeam.Id;               
                        sampleShare4.UserOrGroupId = gatekeeperMap.get(objSampleTeam.Customer_Service_in_Charge__c).Gatekeeper4__c;          
                        // Set the access level
                        sampleShare4.AccessLevel =  Label.CL00071; 
                        insertSampleShare4.put(sampleShare4.Id,sampleShare4);   
                    }
                    
                    if(objSampleTeam.Customer_Service_in_Charge__c!=null){
                        
                        sampleNewTeamGk = new CustomerRequestTeam__c();
                        sampleNewTeamGk.Member__c = objSampleTeam.Customer_Service_in_Charge__c;
                        sampleNewTeamGk.Role__c =   Label.CL00072;
                        sampleNewTeamGk.Access__c =   Label.CL00071;     
                        sampleNewTeamGk.CustomerRequestForm__c = objSampleTeam.Id;
                        insertSampleTeamGK.put(sampleNewTeamGk.Id, sampleNewTeamGk);
                        
                        
                        sampleShareGK =  new Customer_Request_Form__share();
                        sampleShareGK.ParentId = objSampleTeam.Id;               
                        sampleShareGK.UserOrGroupId = objSampleTeam.Customer_Service_in_Charge__c;          
                        // Set the access level
                        sampleShareGK.AccessLevel =  Label.CL00071; 
                        insertSampleShareGK.put(sampleShareGK.Id,sampleShareGK);
                    }
                }
                if(!gatekeeperMap.containsKey(objSampleTeam.Customer_Service_in_Charge__c)){
                    for(GatekeeperAssignment__c gateAssign:[SELECT Gatekeeper__c, Gatekeeper2__c, Gatekeeper3__c, Gatekeeper4__c
                                                            FROM GatekeeperAssignment__c WHERE Gatekeeper__c IN: gatekeeperMap.KeySet()
                                                            AND Id IN: gateRecordId
                                                            AND Process__c =: Label.CL00072
                                                            AND Object__c =: Label.CL00082]){
                                                                
                                                                if(gateAssign.Gatekeeper2__c!= null){                                
                                                                    sampleNewTeam2 = new CustomerRequestTeam__c();
                                                                    sampleNewTeam2.Member__c = gateAssign.Gatekeeper2__c;
                                                                    sampleNewTeam2.Role__c =   Label.CL00072;
                                                                    sampleNewTeam2.Access__c =   Label.CL00071;
                                                                    sampleNewTeam2.CustomerRequestForm__c = objSampleTeam.Id;
                                                                    insertSampleTeamMap2.put(sampleNewTeam2.Id, sampleNewTeam2);
                                                                    
                                                                    sampleShare2 =  new Customer_Request_Form__share();
                                                                    sampleShare2.ParentId = objSampleTeam.Id;               
                                                                    sampleShare2.UserOrGroupId = gateAssign.Gatekeeper2__c;         
                                                                    // Set the access level
                                                                    sampleShare2.AccessLevel = Label.CL00071; 
                                                                    insertSampleShare2.put(sampleShare2.Id,sampleShare2); 
                                                                }                                                   
                                                                if(gateAssign.Gatekeeper3__c!= null){       
                                                                    sampleNewTeam3 = new CustomerRequestTeam__c();
                                                                    sampleNewTeam3.Member__c = gateAssign.Gatekeeper3__c;
                                                                    sampleNewTeam3.Role__c =   Label.CL00072;
                                                                    sampleNewTeam3.Access__c =   Label.CL00071;             
                                                                    sampleNewTeam3.CustomerRequestForm__c = objSampleTeam.Id;
                                                                    insertSampleTeamMap3.put(sampleNewTeam3.Id, sampleNewTeam3);
                                                                    
                                                                    sampleShare3 =  new Customer_Request_Form__share();
                                                                    sampleShare3.ParentId = objSampleTeam.Id;               
                                                                    sampleShare3.UserOrGroupId = gateAssign.Gatekeeper3__c;          
                                                                    // Set the access level
                                                                    sampleShare3.AccessLevel =  Label.CL00071; 
                                                                    insertSampleShare3.put(sampleShare3.Id,sampleShare3); 
                                                                }
                                                                if(gateAssign.Gatekeeper4__c!= null){
                                                                    sampleNewTeam4 = new CustomerRequestTeam__c();
                                                                    sampleNewTeam4.Member__c = gateAssign.Gatekeeper4__c;
                                                                    sampleNewTeam4.Role__c =   Label.CL00072;
                                                                    sampleNewTeam4.Access__c =   Label.CL00071;     
                                                                    sampleNewTeam4.CustomerRequestForm__c = objSampleTeam.Id;
                                                                    insertSampleTeamMap4.put(sampleNewTeam4.Id, sampleNewTeam4);
                                                                    
                                                                    sampleShare4 =  new Customer_Request_Form__share();
                                                                    sampleShare4.ParentId = objSampleTeam.Id;               
                                                                    sampleShare4.UserOrGroupId = gateAssign.Gatekeeper4__c;          
                                                                    // Set the access level
                                                                    sampleShare4.AccessLevel =  Label.CL00071; 
                                                                    insertSampleShare4.put(sampleShare4.Id,sampleShare4); 
                                                                }
                                                                if(objSampleTeam.Customer_Service_in_Charge__c!=null){
                                                                    
                                                                    sampleNewTeamGk = new CustomerRequestTeam__c();
                                                                    sampleNewTeamGk.Member__c = objSampleTeam.Customer_Service_in_Charge__c;
                                                                    sampleNewTeamGk.Role__c =   Label.CL00072;
                                                                    sampleNewTeamGk.Access__c =   Label.CL00071;     
                                                                    sampleNewTeamGk.CustomerRequestForm__c = objSampleTeam.Id;
                                                                    insertSampleTeamGK.put(sampleNewTeamGk.Id, sampleNewTeamGk);
                                                                    
                                                                    
                                                                    sampleShareGK =  new Customer_Request_Form__share();
                                                                    sampleShareGK.ParentId = objSampleTeam.Id;               
                                                                    sampleShareGK.UserOrGroupId = objSampleTeam.Customer_Service_in_Charge__c;          
                                                                    // Set the access level
                                                                    sampleShareGK.AccessLevel =  Label.CL00071; 
                                                                    insertSampleShareGK.put(sampleShareGK.Id,sampleShareGK);
                                                                }                        
                                                            }
                }
            }
            if(insertSampleTeamMap2.size() > 0){
                Database.insert(insertSampleTeamMap2.values(), false);
                Database.insert(insertSampleShare2.values(), false);
                
            }
            if(insertSampleTeamMap3.size() > 0){
                Database.insert(insertSampleTeamMap3.values(), false);
                Database.insert(insertSampleShare3.values(), false);
                
            }
            if(insertSampleTeamMap4.size() > 0){
                Database.insert(insertSampleTeamMap4.values(), false);
                Database.insert(insertSampleShare4.values(), false);
                
            }
            if(insertSampleShareAcctMang.size() > 0){
                //Database.insert(insertSampleShareAcctMang.values(), false);
                //Database.insert(insertSampleTeamAcctMang.values(), false);
                
            }
            if(insertSampleTeamGK.size() > 0){
                Database.insert(insertSampleTeamGK.values(), false);
                Database.insert(insertSampleShareGK.values(), false);
                
            }
            if(insertSampleCreatedBy.size() > 0){
                //Database.insert(insertSampleCreatedBy.values(), false);
                
            }
        }
        catch(Exception e){
            System.Debug('Error in assign customer service team '+ e);
        }                
    }
    
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 
*@Date modification 
*@param aNewList to pass update records.                      
*@return
*/  
    public static void updateCreditControllerTeam(List<Customer_Request_Form__c> aNewList, List<Customer_Request_Form__c> aOldList){
        Set<Id> gatekeeperNewSet = new Set<Id>();
        Set<Id> gateRecordId = new Set<Id>();
        Set<Id> recordIdSet = new Set<Id>();
        Set<Id> gatekeeperOldSet = new Set<Id>();
        Set<Id> gatekeeper2Set = new Set<Id>();
        Set<Id> gatekeeper3Set = new Set<Id>();
        Set<Id> gatekeeper4Set = new Set<Id>();
        Set<String> entityOld = new Set<String>();
        Set<String> entityNew = new Set<String>();
        Map<Id,GatekeeperAssignment__c> gatekeeperMap = new Map<Id,GatekeeperAssignment__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamMap2 = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamMap3 = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamMap4 = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamAcctMang = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamGK = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleCreatedBy = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, Customer_Request_Form__share> insertSampleShare2 = new Map<id, Customer_Request_Form__share>();
        Map<Id, Customer_Request_Form__share> insertSampleShare3 = new Map<id, Customer_Request_Form__share>();
        Map<Id, Customer_Request_Form__share> insertSampleShare4 = new Map<id, Customer_Request_Form__share>();
        Map<Id, Customer_Request_Form__share> insertSampleShareAcctMang = new Map<id, Customer_Request_Form__share>();
        Map<Id, Customer_Request_Form__share> insertSampleShareGK = new Map<id, Customer_Request_Form__share>();
        CustomerRequestTeam__c sampleNewTeam2;
        CustomerRequestTeam__c sampleNewTeam3;
        CustomerRequestTeam__c sampleNewTeam4;
        CustomerRequestTeam__c sampleNewTeamAcctMang;
        CustomerRequestTeam__c sampleNewTeamGk;
        CustomerRequestTeam__c sampleNewCreatedBy;
        Customer_Request_Form__share sampleShare2;
        Customer_Request_Form__share sampleShare3;
        Customer_Request_Form__share sampleShare4;
        Customer_Request_Form__share sampleShareAcctMang;
        Customer_Request_Form__share sampleShareGK;
        
        for(Customer_Request_Form__c objOld : aOldList){
            entityOld.add(objOld.Imerys_Selling_Entity_Lookup__c); 
            gatekeeperOldSet.add(objOld.CreditControllerinCharge__c);
            recordIdSet.add(objOld.Id);
            
        }
        
        for(Customer_Request_Form__c obj : aNewList){
            
            entityNew.add(obj.Imerys_Selling_Entity_Lookup__c);
            gatekeeperNewSet.add(obj.CreditControllerinCharge__c);
            
        }
        
        if(entityOld!=entityNew){  
            try{
                delete [select Id, UserOrGroupId FROM Customer_Request_Form__share 
                        WHERE ParentId IN:recordIdSet
                        AND RowCause != 'Owner'
                        AND Rowcause = 'Manual'
                       ];
                
                delete [select Id, Member__c FROM CustomerRequestTeam__c WHERE CustomerRequestForm__c IN:recordIdSet AND Role__c NOT IN(:Label.CL00074, :Label.CL00075)
                        AND Role__c IN(:Label.CL00073)];
                
            }catch(DMLException e){
                system.Debug('Error in updateShareTeam' + e);
            }   
        }                     
        
        if (entityNew!=entityOld && gatekeeperNewSet!=null){   
            
            for(GatekeeperAssignment__c gate : [SELECT Imerys_Site__c,Gatekeeper__c, Gatekeeper2__c, Gatekeeper3__c, Gatekeeper4__c  
                                                FROM GatekeeperAssignment__c
                                                WHERE Imerys_Site__c IN: entityNew
                                                AND Process__c =: Label.CL00073
                                                AND Object__c =: Label.CL00082
                                                ORDER BY Id DESC]){                                             
                                                    
                                                    gatekeeperMap.put(gate.GateKeeper__c, gate);
                                                    gatekeeper2Set.add(gate.Gatekeeper2__c);
                                                    gatekeeper3Set.add(gate.Gatekeeper3__c);
                                                    gatekeeper4Set.add(gate.Gatekeeper4__c);
                                                    gateRecordId.add(gate.Id);
                                                    
                                                }
        }                            
        try{
            for(Customer_Request_Form__c objSampleTeam: aNewList){
                
                if(gatekeeperMap.containsKey(objSampleTeam.CreditControllerinCharge__c)){                 
                    if(gatekeeperMap.size() > 0 && !gatekeeper2Set.contains(null)){             
                        sampleNewTeam2 = new CustomerRequestTeam__c();
                        sampleNewTeam2.Member__c = gatekeeperMap.get(objSampleTeam.CreditControllerinCharge__c).Gatekeeper2__c;
                        sampleNewTeam2.Role__c =  Label.CL00073;
                        sampleNewTeam2.Access__c =   Label.CL00071;
                        sampleNewTeam2.CustomerRequestForm__c = objSampleTeam.Id;
                        insertSampleTeamMap2.put(sampleNewTeam2.Id, sampleNewTeam2);
                        
                        sampleShare2 =  new Customer_Request_Form__share();
                        sampleShare2.ParentId = objSampleTeam.Id;               
                        sampleShare2.UserOrGroupId = gatekeeperMap.get(objSampleTeam.CreditControllerinCharge__c).Gatekeeper2__c;         
                        // Set the access level
                        sampleShare2.AccessLevel = Label.CL00071; 
                        insertSampleShare2.put(sampleShare2.Id,sampleShare2);                   
                    }
                    if(gatekeeperMap.size() > 0 && !gatekeeper3Set.contains(null)){              
                        sampleNewTeam3 = new CustomerRequestTeam__c();
                        sampleNewTeam3.Member__c = gatekeeperMap.get(objSampleTeam.CreditControllerinCharge__c).Gatekeeper3__c;
                        sampleNewTeam3.Role__c =  Label.CL00073;
                        sampleNewTeam3.Access__c =   Label.CL00071;             
                        sampleNewTeam3.CustomerRequestForm__c = objSampleTeam.Id;
                        insertSampleTeamMap3.put(sampleNewTeam3.Id, sampleNewTeam3);
                        
                        sampleShare3 =  new Customer_Request_Form__share();
                        sampleShare3.ParentId = objSampleTeam.Id;               
                        sampleShare3.UserOrGroupId = gatekeeperMap.get(objSampleTeam.CreditControllerinCharge__c).Gatekeeper3__c;          
                        // Set the access level
                        sampleShare3.AccessLevel =  Label.CL00071; 
                        insertSampleShare3.put(sampleShare3.Id,sampleShare3);   
                    }
                    if(gatekeeperMap.size() > 0 && !gatekeeper4Set.contains(null)){              
                        sampleNewTeam4 = new CustomerRequestTeam__c();
                        sampleNewTeam4.Member__c = gatekeeperMap.get(objSampleTeam.CreditControllerinCharge__c).Gatekeeper4__c;
                        sampleNewTeam4.Role__c =   Label.CL00073;
                        sampleNewTeam4.Access__c =   Label.CL00071;     
                        sampleNewTeam4.CustomerRequestForm__c = objSampleTeam.Id;
                        insertSampleTeamMap4.put(sampleNewTeam4.Id, sampleNewTeam4);
                        
                        sampleShare4 =  new Customer_Request_Form__share();
                        sampleShare4.ParentId = objSampleTeam.Id;               
                        sampleShare4.UserOrGroupId = gatekeeperMap.get(objSampleTeam.CreditControllerinCharge__c).Gatekeeper4__c;          
                        // Set the access level
                        sampleShare4.AccessLevel =  Label.CL00071; 
                        insertSampleShare4.put(sampleShare4.Id,sampleShare4);   
                    }
                    if(objSampleTeam.CreditControllerinCharge__c!=null){
                        
                        sampleNewTeamGk = new CustomerRequestTeam__c();
                        sampleNewTeamGk.Member__c = objSampleTeam.CreditControllerinCharge__c;
                        sampleNewTeamGk.Role__c =   Label.CL00073;
                        sampleNewTeamGk.Access__c =   Label.CL00071;     
                        sampleNewTeamGk.CustomerRequestForm__c = objSampleTeam.Id;
                        insertSampleTeamGK.put(sampleNewTeamGk.Id, sampleNewTeamGk);
                        
                        
                        sampleShareGK =  new Customer_Request_Form__share();
                        sampleShareGK.ParentId = objSampleTeam.Id;               
                        sampleShareGK.UserOrGroupId = objSampleTeam.CreditControllerinCharge__c;          
                        // Set the access level
                        sampleShareGK.AccessLevel =  Label.CL00071; 
                        insertSampleShareGK.put(sampleShareGK.Id,sampleShareGK);
                    }
                }
                if(!gatekeeperMap.containsKey(objSampleTeam.CreditControllerinCharge__c)){
                    for(GatekeeperAssignment__c gateAssign:[SELECT Gatekeeper__c, Gatekeeper2__c, Gatekeeper3__c, Gatekeeper4__c
                                                            FROM GatekeeperAssignment__c WHERE Gatekeeper__c IN: gatekeeperMap.KeySet()
                                                            AND Id IN: gateRecordId
                                                            AND Process__c =: Label.CL00073
                                                            AND Object__c =: Label.CL00082]){
                                                                
                                                                if(gateAssign.Gatekeeper2__c!= null){                                
                                                                    sampleNewTeam2 = new CustomerRequestTeam__c();
                                                                    sampleNewTeam2.Member__c = gateAssign.Gatekeeper2__c;
                                                                    sampleNewTeam2.Role__c =   Label.CL00073;
                                                                    sampleNewTeam2.Access__c =   Label.CL00071;
                                                                    sampleNewTeam2.CustomerRequestForm__c = objSampleTeam.Id;
                                                                    insertSampleTeamMap2.put(sampleNewTeam2.Id, sampleNewTeam2);
                                                                    
                                                                    sampleShare2 =  new Customer_Request_Form__share();
                                                                    sampleShare2.ParentId = objSampleTeam.Id;               
                                                                    sampleShare2.UserOrGroupId = gateAssign.Gatekeeper2__c;         
                                                                    // Set the access level
                                                                    sampleShare2.AccessLevel = Label.CL00071; 
                                                                    insertSampleShare2.put(sampleShare2.Id,sampleShare2); 
                                                                }                                                   
                                                                if(gateAssign.Gatekeeper3__c!= null){       
                                                                    sampleNewTeam3 = new CustomerRequestTeam__c();
                                                                    sampleNewTeam3.Member__c = gateAssign.Gatekeeper3__c;
                                                                    sampleNewTeam3.Role__c =   Label.CL00073;
                                                                    sampleNewTeam3.Access__c =   Label.CL00071;             
                                                                    sampleNewTeam3.CustomerRequestForm__c = objSampleTeam.Id;
                                                                    insertSampleTeamMap3.put(sampleNewTeam3.Id, sampleNewTeam3);
                                                                    
                                                                    sampleShare3 =  new Customer_Request_Form__share();
                                                                    sampleShare3.ParentId = objSampleTeam.Id;               
                                                                    sampleShare3.UserOrGroupId = gateAssign.Gatekeeper3__c;          
                                                                    // Set the access level
                                                                    sampleShare3.AccessLevel =  Label.CL00071; 
                                                                    insertSampleShare3.put(sampleShare3.Id,sampleShare3); 
                                                                }
                                                                if(gateAssign.Gatekeeper4__c!= null){
                                                                    sampleNewTeam4 = new CustomerRequestTeam__c();
                                                                    sampleNewTeam4.Member__c = gateAssign.Gatekeeper4__c;
                                                                    sampleNewTeam4.Role__c =   Label.CL00073;
                                                                    sampleNewTeam4.Access__c =   Label.CL00071;     
                                                                    sampleNewTeam4.CustomerRequestForm__c = objSampleTeam.Id;
                                                                    insertSampleTeamMap4.put(sampleNewTeam4.Id, sampleNewTeam4);
                                                                    
                                                                    sampleShare4 =  new Customer_Request_Form__share();
                                                                    sampleShare4.ParentId = objSampleTeam.Id;               
                                                                    sampleShare4.UserOrGroupId = gateAssign.Gatekeeper4__c;          
                                                                    // Set the access level
                                                                    sampleShare4.AccessLevel =  Label.CL00071; 
                                                                    insertSampleShare4.put(sampleShare4.Id,sampleShare4); 
                                                                }
                                                                if(objSampleTeam.CreditControllerinCharge__c!=null){
                                                                    
                                                                    sampleNewTeamGk = new CustomerRequestTeam__c();
                                                                    sampleNewTeamGk.Member__c = objSampleTeam.CreditControllerinCharge__c;
                                                                    sampleNewTeamGk.Role__c =   Label.CL00073;
                                                                    sampleNewTeamGk.Access__c =   Label.CL00071;     
                                                                    sampleNewTeamGk.CustomerRequestForm__c = objSampleTeam.Id;
                                                                    insertSampleTeamGK.put(sampleNewTeamGk.Id, sampleNewTeamGk);
                                                                    
                                                                    
                                                                    sampleShareGK =  new Customer_Request_Form__share();
                                                                    sampleShareGK.ParentId = objSampleTeam.Id;               
                                                                    sampleShareGK.UserOrGroupId = objSampleTeam.CreditControllerinCharge__c;          
                                                                    // Set the access level
                                                                    sampleShareGK.AccessLevel =  Label.CL00071; 
                                                                    insertSampleShareGK.put(sampleShareGK.Id,sampleShareGK);
                                                                }                        
                                                            }
                }
            }
            if(insertSampleTeamMap2.size() > 0){
                Database.insert(insertSampleTeamMap2.values(), false);
                Database.insert(insertSampleShare2.values(), false);
                
            }
            if(insertSampleTeamMap3.size() > 0){
                Database.insert(insertSampleTeamMap3.values(), false);
                Database.insert(insertSampleShare3.values(), false);
                
            }
            if(insertSampleTeamMap4.size() > 0){
                Database.insert(insertSampleTeamMap4.values(), false);
                Database.insert(insertSampleShare4.values(), false);
                
            }
            if(insertSampleShareAcctMang.size() > 0){
                //Database.insert(insertSampleShareAcctMang.values(), false);
                //Database.insert(insertSampleTeamAcctMang.values(), false);
                
            }
            if(insertSampleTeamGK.size() > 0){
                Database.insert(insertSampleTeamGK.values(), false);
                Database.insert(insertSampleShareGK.values(), false);
                
            }
            if(insertSampleCreatedBy.size() > 0){
                Database.insert(insertSampleCreatedBy.values(), false);
                
            }
        }
        catch(Exception e){
            System.Debug('Error in assign customer service team '+ e);
        }                
    }
    
    // Modified by Anshu on 25/08/22. For adding ERP Creator in Charge Team.
    
    
    
    
    public static void updateERPCreatorinChargeTeam(List<Customer_Request_Form__c> aNewList, List<Customer_Request_Form__c> aOldList){
        Set<Id> gatekeeperNewSet = new Set<Id>();
        Set<Id> gateRecordId = new Set<Id>();
        Set<Id> recordIdSet = new Set<Id>();
        Set<Id> gatekeeperOldSet = new Set<Id>();
        Set<Id> gatekeeper2Set = new Set<Id>();
        Set<Id> gatekeeper3Set = new Set<Id>();
        Set<Id> gatekeeper4Set = new Set<Id>();
        Set<String> entityOld = new Set<String>();
        Set<String> entityNew = new Set<String>();
        Map<Id,GatekeeperAssignment__c> gatekeeperMap = new Map<Id,GatekeeperAssignment__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamMap2 = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamMap3 = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamMap4 = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamAcctMang = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamGK = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, CustomerRequestTeam__c> insertSampleCreatedBy = new Map<id,  CustomerRequestTeam__c>();
        Map<Id, Customer_Request_Form__share> insertSampleShare2 = new Map<id, Customer_Request_Form__share>();
        Map<Id, Customer_Request_Form__share> insertSampleShare3 = new Map<id, Customer_Request_Form__share>();
        Map<Id, Customer_Request_Form__share> insertSampleShare4 = new Map<id, Customer_Request_Form__share>();
        Map<Id, Customer_Request_Form__share> insertSampleShareAcctMang = new Map<id, Customer_Request_Form__share>();
        Map<Id, Customer_Request_Form__share> insertSampleShareGK = new Map<id, Customer_Request_Form__share>();
        CustomerRequestTeam__c sampleNewTeam2;
        CustomerRequestTeam__c sampleNewTeam3;
        CustomerRequestTeam__c sampleNewTeam4;
        CustomerRequestTeam__c sampleNewTeamAcctMang;
        CustomerRequestTeam__c sampleNewTeamGk;
        CustomerRequestTeam__c sampleNewCreatedBy;
        Customer_Request_Form__share sampleShare2;
        Customer_Request_Form__share sampleShare3;
        Customer_Request_Form__share sampleShare4;
        Customer_Request_Form__share sampleShareAcctMang;
        Customer_Request_Form__share sampleShareGK;
        
        for(Customer_Request_Form__c objOld : aOldList){
            entityOld.add(objOld.Imerys_Selling_Entity_Lookup__c); 
            gatekeeperOldSet.add(objOld.ERP_Creator_in_Charge__c);
            recordIdSet.add(objOld.Id);
            
        }
        
        for(Customer_Request_Form__c obj : aNewList){
            
            entityNew.add(obj.Imerys_Selling_Entity_Lookup__c);
            gatekeeperNewSet.add(obj.ERP_Creator_in_Charge__c);
            
        }
        
        if(entityOld!=entityNew){   
            system.Debug('Entity  Not same');
            try{
                delete [select Id, UserOrGroupId FROM Customer_Request_Form__share 
                        WHERE ParentId IN:recordIdSet
                        AND RowCause != 'Owner'
                        AND Rowcause = 'Manual'
                       ];
                
                delete [select Id, Member__c FROM CustomerRequestTeam__c WHERE CustomerRequestForm__c IN:recordIdSet AND Role__c NOT IN(:Label.CL00074, :Label.CL00075)
                        AND Role__c IN(:Label.CL00098)];
                
            }catch(DMLException e){
                system.Debug('Error in updateShareTeam' + e);
            }   
        }
        
        
        
        if (entityNew!=entityOld && gatekeeperNewSet!=null){           
            for(GatekeeperAssignment__c gate : [SELECT Imerys_Site__c,Gatekeeper__c, Gatekeeper2__c, Gatekeeper3__c, Gatekeeper4__c  
                                                FROM GatekeeperAssignment__c
                                                WHERE Imerys_Site__c IN: entityNew
                                                AND Process__c =: Label.CL00098
                                                AND Object__c =: Label.CL00082
                                                ORDER BY Id DESC]){                                             
                                                    
                                                    gatekeeperMap.put(gate.GateKeeper__c, gate);
                                                    gatekeeper2Set.add(gate.Gatekeeper2__c);
                                                    gatekeeper3Set.add(gate.Gatekeeper3__c);
                                                    gatekeeper4Set.add(gate.Gatekeeper4__c);
                                                    gateRecordId.add(gate.Id);
                                                     system.debug('SOQL Records Update'+gate);
                                                }
        }                            
        try{
            for(Customer_Request_Form__c objSampleTeam: aNewList){              
                if(gatekeeperMap.containsKey(objSampleTeam.ERP_Creator_in_Charge__c)){                 
                    if(gatekeeperMap.size() > 0 && !gatekeeper2Set.contains(null)){             
                        sampleNewTeam2 = new CustomerRequestTeam__c();
                        sampleNewTeam2.Member__c = gatekeeperMap.get(objSampleTeam.ERP_Creator_in_Charge__c).Gatekeeper2__c;
                        sampleNewTeam2.Role__c =  Label.CL00098;
                        sampleNewTeam2.Access__c =   Label.CL00071;
                        sampleNewTeam2.CustomerRequestForm__c = objSampleTeam.Id;
                        insertSampleTeamMap2.put(sampleNewTeam2.Id, sampleNewTeam2);
                        
                        sampleShare2 =  new Customer_Request_Form__share();
                        sampleShare2.ParentId = objSampleTeam.Id;               
                        sampleShare2.UserOrGroupId = gatekeeperMap.get(objSampleTeam.ERP_Creator_in_Charge__c).Gatekeeper2__c;         
                        // Set the access level
                        sampleShare2.AccessLevel = Label.CL00071; 
                        insertSampleShare2.put(sampleShare2.Id,sampleShare2);                   
                    }
                    if(gatekeeperMap.size() > 0 && !gatekeeper3Set.contains(null)){              
                        sampleNewTeam3 = new CustomerRequestTeam__c();
                        sampleNewTeam3.Member__c = gatekeeperMap.get(objSampleTeam.ERP_Creator_in_Charge__c).Gatekeeper3__c;
                        sampleNewTeam3.Role__c =  Label.CL00098;
                        sampleNewTeam3.Access__c =   Label.CL00071;             
                        sampleNewTeam3.CustomerRequestForm__c = objSampleTeam.Id;
                        insertSampleTeamMap3.put(sampleNewTeam3.Id, sampleNewTeam3);
                        
                        sampleShare3 =  new Customer_Request_Form__share();
                        sampleShare3.ParentId = objSampleTeam.Id;               
                        sampleShare3.UserOrGroupId = gatekeeperMap.get(objSampleTeam.ERP_Creator_in_Charge__c).Gatekeeper3__c;          
                        // Set the access level
                        sampleShare3.AccessLevel =  Label.CL00071; 
                        insertSampleShare3.put(sampleShare3.Id,sampleShare3);   
                    }
                    if(gatekeeperMap.size() > 0 && !gatekeeper4Set.contains(null)){              
                        sampleNewTeam4 = new CustomerRequestTeam__c();
                        sampleNewTeam4.Member__c = gatekeeperMap.get(objSampleTeam.ERP_Creator_in_Charge__c).Gatekeeper4__c;
                        sampleNewTeam4.Role__c =   Label.CL00098;
                        sampleNewTeam4.Access__c =   Label.CL00071;     
                        sampleNewTeam4.CustomerRequestForm__c = objSampleTeam.Id;
                        insertSampleTeamMap4.put(sampleNewTeam4.Id, sampleNewTeam4);
                        
                        sampleShare4 =  new Customer_Request_Form__share();
                        sampleShare4.ParentId = objSampleTeam.Id;               
                        sampleShare4.UserOrGroupId = gatekeeperMap.get(objSampleTeam.ERP_Creator_in_Charge__c).Gatekeeper4__c;          
                        // Set the access level
                        sampleShare4.AccessLevel =  Label.CL00071; 
                        insertSampleShare4.put(sampleShare4.Id,sampleShare4);   
                    }
                    
                    if(objSampleTeam.ERP_Creator_in_Charge__c!=null){
                        
                        sampleNewTeamGk = new CustomerRequestTeam__c();
                        sampleNewTeamGk.Member__c = objSampleTeam.ERP_Creator_in_Charge__c;
                        sampleNewTeamGk.Role__c =   Label.CL00098;
                        sampleNewTeamGk.Access__c =   Label.CL00071;     
                        sampleNewTeamGk.CustomerRequestForm__c = objSampleTeam.Id;
                        insertSampleTeamGK.put(sampleNewTeamGk.Id, sampleNewTeamGk);
                        
                        
                        sampleShareGK =  new Customer_Request_Form__share();
                        sampleShareGK.ParentId = objSampleTeam.Id;               
                        sampleShareGK.UserOrGroupId = objSampleTeam.ERP_Creator_in_Charge__c;          
                        // Set the access level
                        sampleShareGK.AccessLevel =  Label.CL00071; 
                        insertSampleShareGK.put(sampleShareGK.Id,sampleShareGK);
                    }
                }
                if(!gatekeeperMap.containsKey(objSampleTeam.ERP_Creator_in_Charge__c)){
                    for(GatekeeperAssignment__c gateAssign:[SELECT Gatekeeper__c, Gatekeeper2__c, Gatekeeper3__c, Gatekeeper4__c
                                                            FROM GatekeeperAssignment__c WHERE Gatekeeper__c IN: gatekeeperMap.KeySet()
                                                            AND Id IN: gateRecordId
                                                            AND Process__c =: Label.CL00098
                                                            AND Object__c =: Label.CL00082]){
                                                                
                                                                if(gateAssign.Gatekeeper2__c!= null){                                
                                                                    sampleNewTeam2 = new CustomerRequestTeam__c();
                                                                    sampleNewTeam2.Member__c = gateAssign.Gatekeeper2__c;
                                                                    sampleNewTeam2.Role__c =   Label.CL00098;
                                                                    sampleNewTeam2.Access__c =   Label.CL00071;
                                                                    sampleNewTeam2.CustomerRequestForm__c = objSampleTeam.Id;
                                                                    insertSampleTeamMap2.put(sampleNewTeam2.Id, sampleNewTeam2);
                                                                    
                                                                    sampleShare2 =  new Customer_Request_Form__share();
                                                                    sampleShare2.ParentId = objSampleTeam.Id;               
                                                                    sampleShare2.UserOrGroupId = gateAssign.Gatekeeper2__c;         
                                                                    // Set the access level
                                                                    sampleShare2.AccessLevel = Label.CL00071; 
                                                                    insertSampleShare2.put(sampleShare2.Id,sampleShare2); 
                                                                }                                                   
                                                                if(gateAssign.Gatekeeper3__c!= null){       
                                                                    sampleNewTeam3 = new CustomerRequestTeam__c();
                                                                    sampleNewTeam3.Member__c = gateAssign.Gatekeeper3__c;
                                                                    sampleNewTeam3.Role__c =   Label.CL00098;
                                                                    sampleNewTeam3.Access__c =   Label.CL00071;             
                                                                    sampleNewTeam3.CustomerRequestForm__c = objSampleTeam.Id;
                                                                    insertSampleTeamMap3.put(sampleNewTeam3.Id, sampleNewTeam3);
                                                                    
                                                                    sampleShare3 =  new Customer_Request_Form__share();
                                                                    sampleShare3.ParentId = objSampleTeam.Id;               
                                                                    sampleShare3.UserOrGroupId = gateAssign.Gatekeeper3__c;          
                                                                    // Set the access level
                                                                    sampleShare3.AccessLevel =  Label.CL00071; 
                                                                    insertSampleShare3.put(sampleShare3.Id,sampleShare3); 
                                                                }
                                                                if(gateAssign.Gatekeeper4__c!= null){
                                                                    sampleNewTeam4 = new CustomerRequestTeam__c();
                                                                    sampleNewTeam4.Member__c = gateAssign.Gatekeeper4__c;
                                                                    sampleNewTeam4.Role__c =   Label.CL00098;
                                                                    sampleNewTeam4.Access__c =   Label.CL00071;     
                                                                    sampleNewTeam4.CustomerRequestForm__c = objSampleTeam.Id;
                                                                    insertSampleTeamMap4.put(sampleNewTeam4.Id, sampleNewTeam4);
                                                                    
                                                                    sampleShare4 =  new Customer_Request_Form__share();
                                                                    sampleShare4.ParentId = objSampleTeam.Id;               
                                                                    sampleShare4.UserOrGroupId = gateAssign.Gatekeeper4__c;          
                                                                    // Set the access level
                                                                    sampleShare4.AccessLevel =  Label.CL00071; 
                                                                    insertSampleShare4.put(sampleShare4.Id,sampleShare4); 
                                                                }
                                                                if(objSampleTeam.ERP_Creator_in_Charge__c!=null){
                                                                    
                                                                    sampleNewTeamGk = new CustomerRequestTeam__c();
                                                                    sampleNewTeamGk.Member__c = objSampleTeam.ERP_Creator_in_Charge__c;
                                                                    sampleNewTeamGk.Role__c =   Label.CL00098;
                                                                    sampleNewTeamGk.Access__c =   Label.CL00071;     
                                                                    sampleNewTeamGk.CustomerRequestForm__c = objSampleTeam.Id;
                                                                    insertSampleTeamGK.put(sampleNewTeamGk.Id, sampleNewTeamGk);
                                                                    
                                                                    
                                                                    sampleShareGK =  new Customer_Request_Form__share();
                                                                    sampleShareGK.ParentId = objSampleTeam.Id;               
                                                                    sampleShareGK.UserOrGroupId = objSampleTeam.ERP_Creator_in_Charge__c;          
                                                                    // Set the access level
                                                                    sampleShareGK.AccessLevel =  Label.CL00071; 
                                                                    insertSampleShareGK.put(sampleShareGK.Id,sampleShareGK);
                                                                }                        
                                                            }
                }
            }
            if(insertSampleTeamMap2.size() > 0){
                Database.insert(insertSampleTeamMap2.values(), false);
                Database.insert(insertSampleShare2.values(), false);
                system.debug('gk2 is'+insertSampleTeamMap2.values());
                
            }
            if(insertSampleTeamMap3.size() > 0){
                Database.insert(insertSampleTeamMap3.values(), false);
                Database.insert(insertSampleShare3.values(), false);
                
            }
            if(insertSampleTeamMap4.size() > 0){
                Database.insert(insertSampleTeamMap4.values(), false);
                Database.insert(insertSampleShare4.values(), false);
                
            }
            if(insertSampleShareAcctMang.size() > 0){
                //Database.insert(insertSampleShareAcctMang.values(), false);
                //Database.insert(insertSampleTeamAcctMang.values(), false);
                
            }
            if(insertSampleTeamGK.size() > 0){
                Database.insert(insertSampleTeamGK.values(),false);
                Database.insert(insertSampleShareGK.values(),false);
                system.debug('insertSampleTeamGK'+insertSampleTeamGK.values());
                
            }
            if(insertSampleCreatedBy.size() > 0){
                //Database.insert(insertSampleCreatedBy.values(), false);
                
            }
        }
        catch(Exception e){
            System.Debug('Error in assign customer service team '+ e);
            
        }                
    }


    
    
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 
*@Date modification 
*@param aNewList                    
*@return error message
*/  
    
    
    @future
    public static void addCustomerTeamMembers(set<String> aNewList) {
        List<Customer_Request_Form__c> customerNewList = new List<Customer_Request_Form__c>();
        List<Customer_Request_Form__c> customerOldList = new List<Customer_Request_Form__c>();
        Map<Id, Customer_Request_Form__share> insertSampleShareAcctMang = new Map<id, Customer_Request_Form__share>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamAcctMang = new Map<id,  CustomerRequestTeam__c>();
        CustomerRequestTeam__c sampleNewTeamAcctMang;
        Customer_Request_Form__share sampleShareAcctMang;
        Set<Id>sampleIdSet = new Set<Id>();
        Set<Id>accMangOldSet = new Set<Id>();
        Set<Id>accManNewSet = new Set<Id>();
        List <Customer_Request_Form__share> samShrsTeamList  =  new List<Customer_Request_Form__share>();
        Customer_Request_Form__share sampleShrTeam; 
        
        for(Customer_Request_Form__c samp : [select Id,Account_Manager__c from Customer_Request_Form__c where id in: aNewList]){
            customerNewList.add(samp);
        }
        
        for(Customer_Request_Form__c sam:customerNewList){
            sampleIdSet.add(sam.Id);
            accManNewSet.add(sam.Account_Manager__c);
        }
        
        Map<Id,CustomerRequestTeam__c> samTeamShare = new Map<Id, CustomerRequestTeam__c>([SELECT Id, Access__c, Member__c, CustomerRequestForm__c   
                                                                                           FROM CustomerRequestTeam__c 
                                                                                           WHERE CustomerRequestForm__c IN:sampleIdSet]);
        for(CustomerRequestTeam__c shr: samTeamShare.values()){
            
            for(Customer_Request_Form__c samApp : customerNewList){  
                
                sampleShrTeam = new Customer_Request_Form__share();
                sampleShrTeam.ParentId  = samApp.Id;
                sampleShrTeam.UserOrGroupId = shr.Member__c;          
                // Set the access level
                sampleShrTeam.AccessLevel = shr.Access__c;           
                // Add objects to list for insert               
                samShrsTeamList.add(sampleShrTeam);
            }       
        }
        
        
        if(samShrsTeamList.size() > 0){                               
            try{
                Database.upsert(samShrsTeamList, false);                  
            }
            catch(Exception e){
                system.Debug('Error in updateShareTeam' + e);
            }                   
            
        }   
    }
    
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 
*@Date modification 
*@param aNewList                    
*@return error message
*/  
    public static void updateAccountManager(List<Customer_Request_Form__c> aNewList, List<Customer_Request_Form__c> aOldList) {
        Map<Id, Customer_Request_Form__share> insertSampleShareAcctMang = new Map<id, Customer_Request_Form__share>();
        Map<Id, CustomerRequestTeam__c> insertSampleTeamAcctMang = new Map<id,  CustomerRequestTeam__c>();
        CustomerRequestTeam__c sampleNewTeamAcctMang;
        Customer_Request_Form__share sampleShareAcctMang;
        Set<Id>sampleIdSet = new Set<Id>();
        Set<Id>accMangOldSet = new Set<Id>();
        Set<Id>accManNewSet = new Set<Id>();
        List <Customer_Request_Form__share> samShrsTeamList  =  new List<Customer_Request_Form__share>();
        Customer_Request_Form__share sampleShrTeam; 
        
        for(Customer_Request_Form__c sam:aNewList){
            sampleIdSet.add(sam.Id);
            accManNewSet.add(sam.Account_Manager__c);
        }
        for(Customer_Request_Form__c samOld:aOldList){
            accMangOldSet.add(samOld.Account_Manager__c);
        }
        system.debug(accMangOldSet);
        system.debug(accManNewSet);
        
        if(accManNewSet!=accMangOldSet){        
            try{
                delete [select Id, UserOrGroupId FROM Customer_Request_Form__share 
                        WHERE UserOrGroupId IN:accMangOldSet
                        AND RowCause != 'Owner'
                        AND Rowcause = 'Manual'
                       ];
                
                delete [select Id, Member__c FROM CustomerRequestTeam__c WHERE CustomerRequestForm__c IN:sampleIdSet AND Role__c =: Label.CL00074
                        AND Member__c IN:accMangOldSet];
                
            }catch(DMLException e){
                system.Debug('Error in updateShareTeam' + e);
            }   
        }    
        
        for(Customer_Request_Form__c objSampleTeam : aNewList){
            system.debug('acct');
            if(objSampleTeam.Account_Manager__c!=null && accManNewSet!=accMangOldSet){
                sampleNewTeamAcctMang = new CustomerRequestTeam__c();
                sampleNewTeamAcctMang.Member__c = objSampleTeam.Account_Manager__c;
                sampleNewTeamAcctMang.Role__c =  Label.CL00074;
                sampleNewTeamAcctMang.Access__c =   Label.CL00071;     
                sampleNewTeamAcctMang.CustomerRequestForm__c = objSampleTeam.Id;
                insertSampleTeamAcctMang.put(sampleNewTeamAcctMang.Id, sampleNewTeamAcctMang);
                
                
                sampleShareAcctMang =  new Customer_Request_Form__share();
                sampleShareAcctMang.ParentId = objSampleTeam.Id;               
                sampleShareAcctMang.UserOrGroupId = objSampleTeam.Account_Manager__c;          
                // Set the access level
                sampleShareAcctMang.AccessLevel =  Label.CL00071; 
                insertSampleShareAcctMang.put(sampleShareAcctMang.Id,sampleShareAcctMang); 
            }               
        }
        
        if(insertSampleTeamAcctMang.size() > 0){                               
            try{
                Database.insert(insertSampleTeamAcctMang.values(), false);
                Database.insert(insertSampleShareAcctMang.values(), false);                  
            }
            catch(Exception e){
                system.Debug('Error in updateShareTeam' + e);
            }                   
            
        }       
    }
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 
*@Date modification 
*@param aNewList                      
*@return error message
*/  
    public static void fillRelationship(List<Customer_Request_Form__c> aNewList) {
        Set<String>businessAreaSet=new set<String>();
        Set<id>accountIdSet = new set<id>();
        list<Customer_Request_Form__c>samList =new list<Customer_Request_Form__c>();
        Map<Id, Relationship__c> rels = new Map<Id, Relationship__c>();
        for(Customer_Request_Form__c b:aNewList){
            if(b.Business_Area__c!=Null){
                businessAreaSet.add(b.Business_Area__c);
            }              
            rels.put(b.Tech_RelationshipInformation__c, null);
            accountIdSet.add(b.Ship_To__c);
            //lookup field to account
        }
        
        if(!businessAreaSet.IsEmpty()){
            list<Relationship__c>relList=[SELECT id,name, BusinessArea__c from Relationship__c 
                                          WHERE BusinessArea__c IN: businessAreaSet
                                          AND AccountName__c IN: accountIdSet LIMIT 1];                                       
            for(Relationship__c relDivName :relList){
                try{
                    for(Customer_Request_Form__c bd: aNewList){
                        bd.Tech_RelationshipInformation__c= relDivName.Id;
                        samList.add(bd);
                    }
                }
                catch(Exception  e){
                    System.Debug('Error in customer request form '+ e);
                }
            }
        }           
    }
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 
*@Date modification 
*@param aNewList                     
*@return error message
*/  
    public static void updateRelationship(List<Customer_Request_Form__c> aNewList) {
        Set<String>businessAreaSet=new set<String>();
        Set<id>accountIdSet = new set<id>();
        list<Customer_Request_Form__c>samList =new list<Customer_Request_Form__c>();
        Map<Id, Relationship__c> rels = new Map<Id, Relationship__c>();
        for(Customer_Request_Form__c b:aNewList){
            if(b.Business_Area__c!=Null){
                businessAreaSet.add(b.Business_Area__c);
            }              
            rels.put(b.Tech_RelationshipInformation__c, null);
            accountIdSet.add(b.Ship_To__c);
            //lookup field to opportunity on bid__c
        }
        
        if(!businessAreaSet.IsEmpty()){
            list<Relationship__c>relList=[SELECT id,name, BusinessArea__c from Relationship__c 
                                          WHERE BusinessArea__c IN: businessAreaSet
                                          AND AccountName__c IN: accountIdSet LIMIT 1]; 
            if(relList.size() == 0){                            
                try{
                    for(Customer_Request_Form__c bd: aNewList){
                        bd.Tech_RelationshipInformation__c= null;
                        samList.add(bd);
                        system.debug('bd' + samList);                       
                    }
                }
                catch(DMLException e){
                    System.Debug('Error in Sample '+ e);
                }
            }
            else{           
                for(Relationship__c relDivName :relList){
                    try{
                        for(Customer_Request_Form__c bd: aNewList){
                            bd.Tech_RelationshipInformation__c= relDivName.Id;
                            samList.add(bd);                      
                        }
                    }
                    catch(DMLException e){
                        System.Debug('Error in customer request fillRelationship '+ e);
                    }
                }
            }
        }           
    }
    
    
    
    
    
    
    
    
    
    
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 
*@Date modification 
*@param
*@ExcptionName                  
*@return method 
*/ 
    public override void afterinsert() {
        //Override method afterinsert from class Handler 
        createCustomerServiceTeam(trigger.new);
        createCreditControllerTeam(trigger.new);
        createERPCreatorinChargeTeam(trigger.new);
        
        Set<string> sampIds = new Set<string> ();
        
        for (Customer_Request_Form__c samp : [Select Id from Customer_Request_Form__c 
                                              where Id in :Trigger.newMap.keyset()]) { 
                                                  sampIds.add(samp.id); 
                                              }
        if(System.IsBatch() == false && System.isFuture() == false){ 
            
            createCreatedById(sampIds);
            
        }
        
    }
    
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 
*@Date modification 
*@param
*@ExcptionName                  
*@return method updateVisitReport with new values.
*/  
    public override void beforeinsert() {
        //Override method BeforeUpdate from class Handler 
        createGatekeeper(trigger.new);
        fillRelationship(trigger.new);
        
    }
    
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 
*@Date modification 
*@param
*@ExcptionName                  
*@return method updateVisitReport with new values.
*/  
    public override void beforeupdate() {
        //Override method BeforeUpdate from class Handler 
        system.debug('Trigger called');
        updateGatekeeper(trigger.new, trigger.old);
        updateRelationship(trigger.new);
        
    }
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 
*@Date modification 
*@param
*@ExcptionName                  
*@return method updateVisitReport with new values.
*/  
    public override void afterUpdate() {
        //Override method BeforeUpdate from class Handler 
        updateCustomerTeam(trigger.new,trigger.old);
        updateCreditControllerTeam(trigger.new,trigger.old);
        updateERPCreatorinChargeTeam(trigger.new,trigger.old);
        updateAccountManager(trigger.new,trigger.old);
        Set<string> sampIds = new Set<string> ();
        Set<string> sampOldIds = new Set<string> ();
        
        for (Customer_Request_Form__c samp : [Select Id from Customer_Request_Form__c 
                                              where Id in :Trigger.newMap.keyset()]) { 
                                                  sampIds.add(samp.id); 
                                              }
        for (Customer_Request_Form__c sampOld : [Select Id from Customer_Request_Form__c 
                                                 where Id in :Trigger.oldMap.keyset()]) { 
                                                     sampOldIds.add(sampOld.id); 
                                                 }
        if(System.IsBatch() == false && System.isFuture() == false){ 
            
            addCustomerTeamMembers(sampIds);
            
        }
        
    }
    
}