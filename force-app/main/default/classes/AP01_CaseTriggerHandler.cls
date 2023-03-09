/**
*@author Geerutsing Govind Kumar
*@Date Creation 24/7/2017
*@Date modification 23/10/2017 - Remove techplant
*@Date modification 30/4/2018 - Backup gatekeeper and oufofoffice field check and uncheck
*@Date modification 19/6/2018 - Grant gatekeeper Read/Write access on creation of remark.
*@Date modification 3/7/2018 - Grant received by Read/Write access on creation of remark.
*@description Change owner for status registration and grant CS Account Manager/Customer Service Read/Write Access
*/
public without sharing class AP01_CaseTriggerHandler extends TriggerHandler {    
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 18/10/2017
*@Date modification 30/4/2018
*@param aNewList to pass update records.                      
*@return
*/  
public static void createCaseGatekeeper(List<Case> aNewList) {
        Set<String> businessArea = new set<String>();
        Set<String> plantCase = new Set<String>();
        Set<Id> productSet = new Set<Id>();
        Set<Id> keeperId = new Set<Id>();
        Set<Id> keeper2Id = new Set<Id>();
        Set<Id> keeper3Id = new Set<Id>();
        Set<Id> keeper4Id = new Set<Id>();
        Set<Id> userBackup = new Set<Id>();
        Set<Id> recordTypeId = new Set<Id>();
        Set<Id> accountManager = new Set<Id>();
        Set<String> outOfOfficeGatekeeper = new Set<String>();
        Set<String> outOfOfficeBackup = new Set<String>();
        Set<String> outOfOfficeCurrentGk = new Set<String>();
        Set<String> currentGK = new Set<String>();
        Set<String> currentGatekeeper = new Set<String>();
        Set<String> countryUserGatekeeper = new Set<String>();
        Set<String> countryGatekeeper = new Set<String>();
        Set<String> status = new Set<String>();
        List<case> caseList = New list <case>();    
        Integer usersPlant;
        Integer usersAllPlants;
        DateTime date1 = Date.today();
        
        for(Case obj : aNewList){
            ///businessArea.add(obj.BusinessArea__c);
            plantCase.add(obj.Imerys_Manufacturing_Plant__c);
            currentGatekeeper.add(obj.GateKeeper__c);
            productSet.add(obj.ProductName__c);
            recordTypeId.add(obj.recordTypeId);
            accountManager.add(obj.CSAccountManager__c);
            status.add(obj.Status);
        }
        
        String recordTypeComplaint = Label.CL00008;//CSE_Complaint
        
        RecordType complaint = [SELECT Id, DeveloperName 
                                FROM RecordType 
                                WHERE SObjectType =:Label.CL00036 //Case
                                AND DeveloperName =:recordTypeComplaint]; 
        
        Id recordTypeComplaintId = complaint.Id;
        
   
        
        Map<Id, Product2> caseMap = new Map<Id,Product2>([SELECT Id, New_Product_Type_2__c from Product2 WHERE 
                                                          Id IN:productSet AND New_Product_Type_2__c IN(:Label.CL00037,:Label.CL00039)]); //CL00037 - Calderys ; CL00039 - 3rd Party	
        system.debug('caseMap' + caseMap);
        system.debug('ProductSet' + productSet);
        
        if(plantCase !=Null && caseMap.size()== 0 && !plantCase.contains(Label.CL00043)){   
            system.debug('regis');
            for(GatekeeperAssignment__c gate : [SELECT Gatekeeper__c ,Gatekeeper2__c,Gatekeeper3__c,Gatekeeper4__c
                                                FROM GatekeeperAssignment__c 
                                                WHERE ImerysManufacturingPlant__c IN:plantCase
                                                AND AllPlants__c =: false
                                                AND Object__c =: Label.CL00038
                                                ORDER BY Id DESC]){
                                                    keeperId.add(gate.GateKeeper__c);
                                                    keeper2Id.add(gate.Gatekeeper2__c);
                                                    keeper3Id.add(gate.Gatekeeper3__c);
                                                    keeper4Id.add(gate.Gatekeeper4__c);
                                                    system.debug('gate' + gate);
                                                }                     
            usersPlant = [SELECT COUNT()
                          FROM GatekeeperAssignment__c 
                          WHERE ImerysManufacturingPlant__c IN: plantCase
                          AND Object__c =: Label.CL00038
                          AND AllPlants__c =: false];
            system.debug('users' + usersPlant);
            

            try{
                for(user userGatekeeper:[SELECT id FROM user WHERE Id IN: keeperId]){
                    for(Case obj2 : aNewList){ 
                        obj2.GateKeeper__c = userGatekeeper.Id;
                        //obj2.OutOfOffice__c = false;
                        caseList.add(obj2);
                        system.debug('test9' + userGatekeeper.Id);
                    }
                }
                
            }
            catch(Exception e){
                System.Debug('Error in assign owner '+ e);
            }
              
            try{
                for(user userGatekeeper2:[SELECT id FROM user WHERE Id IN: keeper2Id]){
                    for(Case obj3 : aNewList){ 
                        obj3.Gatekeeper2__c = userGatekeeper2.Id;
                        //obj2.OutOfOffice__c = false;
                        caseList.add(obj3);
                        system.debug('test userGatekeeper2' + userGatekeeper2.Id);
                    	}
                	}
            	}
            catch(Exception e){
                System.Debug('Error in assign owner '+ e);
            }
                
            try{
                for(user userGatekeeper3:[SELECT id FROM user WHERE Id IN: keeper3Id]){
                    for(Case obj4 : aNewList){ 
                        obj4.Gatekeeper3__c = userGatekeeper3.Id;
                        //obj2.OutOfOffice__c = false;
                        caseList.add(obj4);
                        system.debug('test userGatekeeper3' + userGatekeeper3.Id);
                    }
                }
            }
            catch(Exception e){
                System.Debug('Error in assign owner '+ e);
            }
                
            try{
                for(user userGatekeeper4:[SELECT id FROM user WHERE Id IN: keeper4Id]){
                    for(Case obj5 : aNewList){ 
                        obj5.Gatekeeper4__c = userGatekeeper4.Id;
                        //obj2.OutOfOffice__c = false;
                        caseList.add(obj5);
                        system.debug('test userGatekeeper4' + userGatekeeper4.Id);
                    }
                }
                
            }
            catch(Exception e){
                System.Debug('Error in assign owner '+ e);
            }
            //}
        }
        
        if(usersPlant == 0 && caseMap.size() == 0)
        {   
            system.debug('regis');
            for(GatekeeperAssignment__c gate2 : [SELECT Gatekeeper__c,Gatekeeper2__c,Gatekeeper3__c,Gatekeeper4__c
                                                 FROM GatekeeperAssignment__c 
                                                 WHERE AllPlants__c =: true
                                                 AND Object__c =:Label.CL00038 //Complaint
                                                 ORDER BY Id DESC]){
                                                     
                                                     keeperId.add(gate2.gatekeeper__c);
                                                     keeper2Id.add(gate2.Gatekeeper2__c);
                                                     keeper3Id.add(gate2.Gatekeeper3__c);
                                                     keeper4Id.add(gate2.Gatekeeper4__c);
                                                 }

            try{
                for(user userGatekeeper:[SELECT id FROM user WHERE Id IN: keeperId]){
                    for(case obj2 : aNewList){ 
                        obj2.GateKeeper__c = userGatekeeper.Id;
                        //obj2.OutOfOffice__c = false;
                        caseList.add(obj2);
                        system.debug('test9' + userGatekeeper.Id);
                    }
                }
            }
            catch(DMLException e){
                System.Debug('Error in assign owner '+ e);
            }
                
            try{
                for(user userGatekeeper2:[SELECT id FROM user WHERE Id IN: keeper2Id]){
                    for(case obj3 : aNewList){ 
                        obj3.GateKeeper2__c = userGatekeeper2.Id;
                        //obj2.OutOfOffice__c = false;
                        caseList.add(obj3);
                        system.debug('test10' + userGatekeeper2.Id);
                    }
                }
                
            }
            catch(DMLException e){
                System.Debug('Error in assign owner '+ e);
            }
            
            try{
                for(user userGatekeeper3:[SELECT id FROM user WHERE Id IN: keeper3Id]){
                    for(case obj4 : aNewList){ 
                        obj4.GateKeeper3__c = userGatekeeper3.Id;
                        //obj2.OutOfOffice__c = false;
                        caseList.add(obj4);
                        system.debug('test10' + userGatekeeper3.Id);
                    }
                }
                
            }
            catch(DMLException e){
                System.Debug('Error in assign owner '+ e);
            }
            
           try{
                for(user userGatekeeper4:[SELECT id FROM user WHERE Id IN: keeper4Id]){
                    for(case obj5 : aNewList){ 
                        obj5.GateKeeper4__c = userGatekeeper4.Id;
                        //obj2.OutOfOffice__c = false;
                        caseList.add(obj5);
                        system.debug('test10' + userGatekeeper4.Id);
                    }
                }
                
            }
            catch(DMLException e){
                System.Debug('Error in assign owner '+ e);
            }
            //}           
        }
        
        
        if(accountManager !=null && caseMap.size() > 0){   
            for(User userGate : [SELECT CountryforGatekeeper__c 
                                 FROM User 
                                 Where Id IN: accountManager
                                 ORDER BY Id DESC]){
                                     
                                     countryUserGatekeeper.add(userGate.CountryforGatekeeper__c);
                                     system.debug('countryforGatekeeper' + userGate);
                                 }                     
            for(GatekeeperAssignment__c gatekeeperCalderys : [SELECT CountryforGatekeeper__c, Gatekeeper__c,Gatekeeper2__c,Gatekeeper3__c,Gatekeeper4__c
                                                              FROM GatekeeperAssignment__c
                                                              WHERE CountryforGatekeeper__c IN:countryUserGatekeeper
                                                              AND Object__c =: Label.CL00038
                                                              ORDER BY Id DESC]){
                                                                  
                                                                  countryGatekeeper.add(gatekeeperCalderys.CountryforGatekeeper__c);
                                                                  keeperId.add(gatekeeperCalderys.Gatekeeper__c);
                                                                  keeper2Id.add(gatekeeperCalderys.Gatekeeper2__c);
                                                                  keeper3Id.add(gatekeeperCalderys.Gatekeeper3__c);
                                                                  keeper4Id.add(gatekeeperCalderys.Gatekeeper4__c);
                                                                  system.debug('gatekeeperCalderys' + gatekeeperCalderys.Gatekeeper__c);
                                                              }                
            

            try{
                for(user userGatekeeper:[SELECT id FROM user WHERE Id IN: keeperId]){
                    for(Case obj2 : aNewList){ 
                        obj2.GateKeeper__c = userGatekeeper.Id;
                        //obj2.OutOfOffice__c = false;
                        caseList.add(obj2);
                        system.debug('test9' + userGatekeeper.Id);
                    	}
                	}
               }
            	catch(DMLException e){
                System.Debug('Error in assign owner '+ e);
            	}
                
            try{
                for(user userGatekeeper2:[SELECT id FROM user WHERE Id IN: keeper2Id]){
                    for(Case obj3 : aNewList){ 
                        obj3.GateKeeper2__c = userGatekeeper2.Id;
                        //obj2.OutOfOffice__c = false;
                        caseList.add(obj3);
                        system.debug('test10' + userGatekeeper2.Id);
                    }
                }
            }
            catch(DMLException e){
                System.Debug('Error in assign owner '+ e);
            	}
            
            try{
                for(user userGatekeeper3:[SELECT id FROM user WHERE Id IN: keeper3Id]){
                    for(Case obj4 : aNewList){ 
                        obj4.GateKeeper3__c = userGatekeeper3.Id;
                        //obj2.OutOfOffice__c = false;
                        caseList.add(obj4);
                        system.debug('test10' + userGatekeeper3.Id);
                    }
                }
            }
            catch(DMLException e){
                System.Debug('Error in assign owner '+ e);
            	}
            
           try{
                for(user userGatekeeper4:[SELECT id FROM user WHERE Id IN: keeper4Id]){
                    for(Case obj5 : aNewList){ 
                        obj5.GateKeeper4__c = userGatekeeper4.Id;
                        //obj2.OutOfOffice__c = false;
                        caseList.add(obj5);
                        system.debug('test10' + userGatekeeper4.Id);
                    }
                }
            }
            catch(DMLException e){
                System.Debug('Error in assign owner '+ e);
            	}
            
        	}       
    }
    
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 18/10/2017
*@Date modification 30/4/2018
*@param aNewList to pass update records.                      
*@return
*/  
    public static void createCaseTeam(List<Case> aNewList){
        Set<String> plantCase = new Set<String>();
        Set<Id> productSet = new Set<Id>();
        Set<Id> accountManager = new Set<Id>();
        Set<String> countryUserGatekeeper = new Set<String>();
        Map<Id,GatekeeperAssignment__c> gatekeeperMap = new Map<Id,GatekeeperAssignment__c>();
        Map<Id, CaseTeamMember> insertCaseTeamMap2 = new Map<id, CaseTeamMember>();
        Map<Id, CaseTeamMember> insertCaseTeamMap3 = new Map<id, CaseTeamMember>();
        Map<Id, CaseTeamMember> insertCaseTeamMap4 = new Map<id, CaseTeamMember>();
        CaseTeamRole role = [select Id from CaseTeamRole where Name = :Label.CL00069 limit 1];
        Set<Id> gatekeeperSet = new Set<Id>();
        Set<Id> recordId = new Set<Id>();
        Set<Id> gatekeeper2Set = new Set<Id>();
        Set<Id> gatekeeper3Set = new Set<Id>();
        Set<Id> gatekeeper4Set = new Set<Id>();
        CaseTeamMember caseNewTeam2;
        CaseTeamMember caseNewTeam3;
        CaseTeamMember caseNewTeam4;
        Integer usersPlant;
        
        for(Case obj : aNewList){
            plantCase.add(obj.Imerys_Manufacturing_Plant__c);           
            productSet.add(obj.ProductName__c);
            accountManager.add(obj.CSAccountManager__c);
            
        }
        
        system.debug('Inside create case team');
        
        String recordTypeComplaint = Label.CL00008;
        
        RecordType complaint = [SELECT Id, DeveloperName 
                                FROM RecordType 
                                WHERE SObjectType =:Label.CL00036
                                AND DeveloperName =:recordTypeComplaint]; 
        usersPlant = [SELECT COUNT()
                      FROM GatekeeperAssignment__c 
                      WHERE ImerysManufacturingPlant__c IN: plantCase
                      AND Object__c =: Label.CL00038
                      AND AllPlants__c =: false];                         
        
            Id recordTypeComplaintId = complaint.Id;
        
        Map<Id, Product2> caseMap = new Map<Id,Product2>([SELECT Id, New_Product_Type_2__c from Product2 WHERE 
                                                          Id IN:productSet AND New_Product_Type_2__c IN(:Label.CL00037,:Label.CL00039)]);
        system.debug('caseMap' + caseMap);
        system.debug('ProductSet' + productSet);
        
        if(plantCase !=Null && caseMap.size()== 0 && !plantCase.contains(Label.CL00043)){   
            system.debug('regis');
            for(GatekeeperAssignment__c gate : [SELECT Gatekeeper__c, Gatekeeper2__c, Gatekeeper3__c, Gatekeeper4__c
                                                FROM GatekeeperAssignment__c 
                                                WHERE ImerysManufacturingPlant__c IN:plantCase
                                                AND AllPlants__c =: false
                                                AND Object__c =: Label.CL00038
                                                ORDER BY Id DESC]){
                                                    
                                                    gatekeeperMap.put(gate.Gatekeeper__c, gate);
                                                    gatekeeper2Set.add(gate.Gatekeeper2__c);
                                                    gatekeeper3Set.add(gate.Gatekeeper3__c);
                                                    gatekeeper4Set.add(gate.Gatekeeper4__c);
                                                    recordId.add(gate.Id);
                                                }
            
            
            
        }       
        if(usersPlant == 0 && caseMap.size() == 0){   
            for(GatekeeperAssignment__c gate2 : [SELECT Gatekeeper__c, Gatekeeper2__c, Gatekeeper3__c, Gatekeeper4__c  
                                                 FROM GatekeeperAssignment__c 
                                                 WHERE AllPlants__c =: true
                                                 AND Object__c =:Label.CL00038
                                                 ORDER BY Id DESC]){
                                                     gatekeeperMap.put(gate2.Gatekeeper__c, gate2);
                                                     gatekeeper2Set.add(gate2.Gatekeeper2__c);
                                                     gatekeeper3Set.add(gate2.Gatekeeper3__c);
                                                     gatekeeper4Set.add(gate2.Gatekeeper4__c);
                                                     recordId.add(gate2.Id);
                                                     
                                                 }
            
            
            
        }
        if(accountManager !=null && caseMap.size() > 0){   
            for(User userGate : [SELECT CountryforGatekeeper__c 
                                 FROM User 
                                 Where Id IN: accountManager
                                 ORDER BY Id DESC]){
                                     
                                     countryUserGatekeeper.add(userGate.CountryforGatekeeper__c);
                                     system.debug('countryforGatekeeper' + userGate);
                                 }                     
            for(GatekeeperAssignment__c gatekeeperCalderys : [SELECT CountryforGatekeeper__c, Gatekeeper__c, Gatekeeper2__c, Gatekeeper3__c, Gatekeeper4__c  
                                                              FROM GatekeeperAssignment__c
                                                              WHERE CountryforGatekeeper__c IN:countryUserGatekeeper
                                                              AND Object__c =: Label.CL00038
                                                              ORDER BY Id DESC]){
                                                                  
                                                                  gatekeeperMap.put(gatekeeperCalderys.Gatekeeper__c, gatekeeperCalderys);
                                                                  gatekeeper2Set.add(gatekeeperCalderys.Gatekeeper2__c);
                                                                  gatekeeper3Set.add(gatekeeperCalderys.Gatekeeper3__c);
                                                                  gatekeeper4Set.add(gatekeeperCalderys.Gatekeeper4__c);
                                                                  recordId.add(gatekeeperCalderys.Id);
                                                                  
                                                              }
        }
        try{
            for(Case objCaseTeam: aNewList){  
                if(gatekeeperMap.containsKey(objCaseTeam.Gatekeeper__c)){
                    system.debug('Inside 1');
                    if(gatekeeperMap.size() > 0 && !gatekeeper2Set.contains(null)){
                        system.debug('Inside 1.1');
                        caseNewTeam2 = new caseTeamMember();
                        caseNewTeam2.MemberId = gatekeeperMap.get(objCaseTeam.Gatekeeper__c).Gatekeeper2__c;
                        caseNewTeam2.ParentId = objCaseTeam.Id;
                        caseNewTeam2.TeamRoleId = role.Id;
                        insertCaseTeamMap2.put(caseNewTeam2.Id, caseNewTeam2);
                    }
                    if(gatekeeperMap.size() > 0 && !gatekeeper3Set.contains(null)){ 
                        system.debug('Inside 1.2');
                        caseNewTeam3 = new caseTeamMember();
                        caseNewTeam3.MemberId = gatekeeperMap.get(objCaseTeam.Gatekeeper__c).Gatekeeper3__c;
                        caseNewTeam3.ParentId = objCaseTeam.Id;
                        caseNewTeam3.TeamRoleId = role.Id;
                        insertCaseTeamMap3.put(caseNewTeam3.Id, caseNewTeam3);
                    }
                    if(gatekeeperMap.size() > 0 && !gatekeeper4Set.contains(null)){ 
                        system.debug('Inside 1.3');
                        caseNewTeam4 = new caseTeamMember();
                        caseNewTeam4.MemberId = gatekeeperMap.get(objCaseTeam.Gatekeeper__c).Gatekeeper4__c;
                        caseNewTeam4.ParentId = objCaseTeam.Id;
                        caseNewTeam4.TeamRoleId = role.Id;
                        insertCaseTeamMap4.put(caseNewTeam4.Id, caseNewTeam4);
                    }
                }
                if(!gatekeeperMap.containsKey(objCaseTeam.Gatekeeper__c)){
                    system.debug('Inside 2');
                    for(GatekeeperAssignment__c gateAssign:[SELECT Gatekeeper__c, Gatekeeper2__c, Gatekeeper3__c, Gatekeeper4__c
                                                            FROM GatekeeperAssignment__c WHERE Gatekeeper__c IN: gatekeeperMap.KeySet()
                                                            AND Object__c =: Label.CL00038
                                                            AND Id IN: recordId]){
                                                                
                                                                if(gateAssign.Gatekeeper2__c!= null){
                                                                    caseNewTeam2 = new caseTeamMember();
                                                                    caseNewTeam2.MemberId = gateAssign.Gatekeeper2__c;
                                                                    caseNewTeam2.ParentId = objCaseTeam.Id;
                                                                    caseNewTeam2.TeamRoleId = role.Id;
                                                                    insertCaseTeamMap2.put(caseNewTeam2.Id, caseNewTeam2);
                                                                }
                                                                if(gateAssign.Gatekeeper3__c!= null){
                                                                    caseNewTeam3 = new caseTeamMember();
                                                                    caseNewTeam3.MemberId = gateAssign.Gatekeeper3__c;
                                                                    caseNewTeam3.ParentId = objCaseTeam.Id;
                                                                    caseNewTeam3.TeamRoleId = role.Id;
                                                                    insertCaseTeamMap3.put(caseNewTeam3.Id, caseNewTeam3);
                                                                }
                                                                if(gateAssign.Gatekeeper4__c!= null){
                                                                    caseNewTeam4 = new caseTeamMember();
                                                                    caseNewTeam4.MemberId = gateAssign.Gatekeeper4__c;
                                                                    caseNewTeam4.ParentId = objCaseTeam.Id;
                                                                    caseNewTeam4.TeamRoleId = role.Id;
                                                                    insertCaseTeamMap4.put(caseNewTeam4.Id, caseNewTeam4);
                                                                }
                                                            }
                }       
                
            }           
            
            if(insertCaseTeamMap2.size() > 0){
                Database.insert(insertCaseTeamMap2.values(), false);
                
            }
            if(insertCaseTeamMap3.size() > 0){
                Database.insert(insertCaseTeamMap3.values(), false);
                
            }
            if(insertCaseTeamMap4.size() > 0){
                Database.insert(insertCaseTeamMap4.values(), false);
                
            }
        }
        catch(DMLException e){
            System.Debug('Error in assign owner '+ e);
        }           
        
    }
    
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 29/7/2020
*@Date modification 
*@param aNewList to pass update records.                      
*@return
*/
    
    public static void updateCaseTeam(List<Case> aNewList, List<Case> aOldList){
        Set<String> plantCase = new Set<String>();
        Set<String> productOld = new Set<String>();
        Set<String> productNew = new Set<String>();
        Set<Id> accountManagerOld = new Set<Id>();
        Set<Id> accountManagerNew = new Set<Id>();
        Set<Id> gatekeeperOld = new Set<Id>();
        Set<Id> recordId = new Set<Id>();
        Set<String> countryUserGatekeeper = new Set<String>();
        Map<Id,GatekeeperAssignment__c> gatekeeperMap = new Map<Id,GatekeeperAssignment__c>();
        Set<Id> gatekeeperSet = new Set<Id>();
        Set<Id> gatekeeper2Set = new Set<Id>();
        Set<Id> gatekeeper3Set = new Set<Id>();
        Set<Id> gatekeeper4Set = new Set<Id>();     
        Map<Id, CaseTeamMember> insertCaseTeamMap2 = new Map<id, CaseTeamMember>();
        Map<Id, CaseTeamMember> insertCaseTeamMap3 = new Map<id, CaseTeamMember>();
        Map<Id, CaseTeamMember> insertCaseTeamMap4 = new Map<id, CaseTeamMember>();
        CaseTeamRole role = [select Id from CaseTeamRole where Name = :Label.CL00069 limit 1];
        CaseTeamMember caseNewTeam2;
        CaseTeamMember caseNewTeam3;
        CaseTeamMember caseNewTeam4;
        Integer usersPlant;
        Set<Id> gateRecordId = new Set<Id>();
        
        
        for(case objOldCase : aOldList){
            productOld.add(objOldCase.ProductName__c);  
            accountManagerOld.add(objOldCase.CSAccountManager__c);
            recordId.add(objOldCase.Id);
            gatekeeperOld.add(objOldCase.GateKeeper__c);            
        }           
        
        for(Case objNew : aNewList){ 
            plantCase.add(objNew.Imerys_Manufacturing_Plant__c);
            productNew.add(objNew.ProductName__c); 
            accountManagerNew.add(objNew.CSAccountManager__c);
            gatekeeperSet.add(objNew.GateKeeper__c);
        }
        
        if(gatekeeperSet!=gatekeeperOld && productOld!=productNew){
            try{
                
                delete [select Id,MemberId FROM CaseTeamMember WHERE ParentId IN:recordId];
            }
            
            catch(DMLException e){
                System.Debug('Error in delete case team' + e);
            }    
        }
        
        String recordTypeComplaint = Label.CL00008;
        
        RecordType complaint = [SELECT Id, DeveloperName 
                                FROM RecordType 
                                WHERE SObjectType =:Label.CL00036
                                AND DeveloperName =:recordTypeComplaint]; 
        
        
        Id recordTypeComplaintId = complaint.Id;
        
        usersPlant = [SELECT COUNT()
                      FROM GatekeeperAssignment__c 
                      WHERE ImerysManufacturingPlant__c IN: plantCase
                      AND Object__c =:Label.CL00038
                      AND AllPlants__c =: false];
        system.debug('users' + usersPlant);     
        
        Map<Id, Product2> caseMap = new Map<Id,Product2>([SELECT Id, New_Product_Type_2__c from Product2 WHERE 
                                                          Id IN:productNew AND New_Product_Type_2__c IN(:Label.CL00037,:Label.CL00039)]);
        
        if(plantcase !=Null && productOld!=productNew && caseMap.size() ==0 && usersPlant!=0 && !plantCase.contains(Label.CL00043)){
            //||businessArea != Null && plantcase !=Null && businessAreaOld!=businessArea && caseMap.size() ==0){      
            
            system.debug('regis');
            
            for(GatekeeperAssignment__c gate : [SELECT Gatekeeper__c, Gatekeeper2__c, Gatekeeper3__c, Gatekeeper4__c  
                                                FROM GatekeeperAssignment__c 
                                                WHERE ImerysManufacturingPlant__c IN: plantCase
                                                AND AllPlants__c =: false
                                                AND Object__c =: Label.CL00038
                                                AND GateKeeper__c IN: gatekeeperSet
                                                ORDER BY Id DESC]){
                                                    
                                                    gatekeeperMap.put(gate.Gatekeeper__c, gate);
                                                    gatekeeper2Set.add(gate.Gatekeeper2__c);
                                                    gatekeeper3Set.add(gate.Gatekeeper3__c);
                                                    gatekeeper4Set.add(gate.Gatekeeper4__c);
                                                    gateRecordId.add(gate.Id);
                                                }
            
            
        }       
        if (usersPlant == 0 && productOld!=productNew && caseMap.size() == 0){
            
            for(GatekeeperAssignment__c gate2 : [SELECT Gatekeeper__c, Gatekeeper2__c, Gatekeeper3__c, Gatekeeper4__c   
                                                 FROM GatekeeperAssignment__c 
                                                 WHERE AllPlants__c =: true
                                                 AND Object__c =:Label.CL00038
                                                 AND GateKeeper__c IN: gatekeeperSet
                                                 ORDER BY CreatedDate DESC]){
                                                     
                                                     gatekeeperMap.put(gate2.Gatekeeper__c, gate2);
                                                     gatekeeper2Set.add(gate2.Gatekeeper2__c);
                                                     gatekeeper3Set.add(gate2.Gatekeeper3__c);
                                                     gatekeeper4Set.add(gate2.Gatekeeper4__c);
                                                     gateRecordId.add(gate2.Id);
                                                     
                                                 }
            system.debug('gate2' + gatekeeper2Set+gatekeeper3Set+gatekeeper4Set);
        }
        if(accountManagerOld!=accountManagerNew && caseMap.size() > 0){
            //businessAreaOld!=businessArea && businessArea != null && caseMap.size() > 0||    
            
            system.debug('update Calderys');
            
            for(User userCountryGate : [SELECT CountryforGatekeeper__c 
                                        FROM User 
                                        Where Id IN: accountManagerNew
                                        ORDER BY Id DESC]){
                                            
                                            countryUserGatekeeper.add(userCountryGate.CountryforGatekeeper__c);
                                            system.debug('countryforGatekeeper' + userCountryGate);
                                        }                     
            for(GatekeeperAssignment__c gatekeeperCalderys : [SELECT CountryforGatekeeper__c, Gatekeeper__c, Gatekeeper2__c, Gatekeeper3__c, Gatekeeper4__c  
                                                              FROM GatekeeperAssignment__c
                                                              WHERE CountryforGatekeeper__c IN: countryUserGatekeeper
                                                              AND Object__c =: Label.CL00038
                                                              AND GateKeeper__c IN: gatekeeperSet
                                                              ORDER BY Id DESC]){
                                                                  
                                                                  gatekeeperMap.put(gatekeeperCalderys.Gatekeeper__c, gatekeeperCalderys);
                                                                  gatekeeper2Set.add(gatekeeperCalderys.Gatekeeper2__c);
                                                                  gatekeeper3Set.add(gatekeeperCalderys.Gatekeeper3__c);
                                                                  gatekeeper4Set.add(gatekeeperCalderys.Gatekeeper4__c);
                                                                  gateRecordId.add(gatekeeperCalderys.Id);
                                                                  
                                                              }
            system.debug('gate3' + gatekeeper2Set+gatekeeper3Set+gatekeeper4Set);
        }           
        try{
            
            for(Case objCaseTeam: aNewList){ 
                if(gatekeeperMap.containsKey(objCaseTeam.Gatekeeper__c)){   
                    if(gatekeeperMap.size() > 0 && !gatekeeper2Set.contains(null)){              
                        caseNewTeam2 = new caseTeamMember();
                        caseNewTeam2.MemberId = gatekeeperMap.get(objCaseTeam.Gatekeeper__c).Gatekeeper2__c;
                        caseNewTeam2.ParentId = objCaseTeam.Id;
                        caseNewTeam2.TeamRoleId = role.Id;
                        insertCaseTeamMap2.put(caseNewTeam2.Id, caseNewTeam2);
                    }
                    if(gatekeeperMap.size() > 0 && !gatekeeper3Set.contains(null)){              
                        caseNewTeam3 = new caseTeamMember();
                        caseNewTeam3.MemberId = gatekeeperMap.get(objCaseTeam.Gatekeeper__c).Gatekeeper3__c;
                        caseNewTeam3.ParentId = objCaseTeam.Id;
                        caseNewTeam3.TeamRoleId = role.Id;
                        insertCaseTeamMap3.put(caseNewTeam3.Id, caseNewTeam3);
                    }
                    if(gatekeeperMap.size() > 0 && !gatekeeper4Set.contains(null)){
                        system.debug('gate4' + gatekeeper4Set);                 
                        caseNewTeam4 = new caseTeamMember();
                        caseNewTeam4.MemberId = gatekeeperMap.get(objCaseTeam.Gatekeeper__c).Gatekeeper4__c;
                        caseNewTeam4.ParentId = objCaseTeam.Id;
                        
                        caseNewTeam4.TeamRoleId = role.Id;
                        insertCaseTeamMap4.put(caseNewTeam4.Id, caseNewTeam4);
                    }
                }
                /* if(!gatekeeperMap.containsKey(objCaseTeam.Gatekeeper__c)){	
                    
                    for(GatekeeperAssignment__c gateAssign:[SELECT Gatekeeper__c, Gatekeeper2__c, Gatekeeper3__c, Gatekeeper4__c
                                                            FROM GatekeeperAssignment__c WHERE Gatekeeper__c IN: gatekeeperMap.KeySet()
                                                            AND Object__c =: Label.CL00038
                                                            AND Id IN: gateRecordId]){
                                                                
                                                                if(gateAssign.Gatekeeper2__c!= null){
                                                                    caseNewTeam2 = new caseTeamMember();
                                                                    caseNewTeam2.MemberId = gateAssign.Gatekeeper2__c;
                                                                    caseNewTeam2.ParentId = objCaseTeam.Id;
                                                                    caseNewTeam2.TeamRoleId = role.Id;
                                                                    insertCaseTeamMap2.put(caseNewTeam2.Id, caseNewTeam2);
                                                                }
                                                                if(gateAssign.Gatekeeper3__c!= null){
                                                                    caseNewTeam3 = new caseTeamMember();
                                                                    caseNewTeam3.MemberId = gateAssign.Gatekeeper3__c;
                                                                    caseNewTeam3.ParentId = objCaseTeam.Id;
                                                                    caseNewTeam3.TeamRoleId = role.Id;
                                                                    insertCaseTeamMap3.put(caseNewTeam3.Id, caseNewTeam3);
                                                                }
                                                                if(gateAssign.Gatekeeper4__c!= null){
                                                                    caseNewTeam4 = new caseTeamMember();
                                                                    caseNewTeam4.MemberId = gateAssign.Gatekeeper4__c;
                                                                    caseNewTeam4.ParentId = objCaseTeam.Id;
                                                                    caseNewTeam4.TeamRoleId = role.Id;
                                                                    insertCaseTeamMap4.put(caseNewTeam4.Id, caseNewTeam4);
                                                                }
                                                            }
                }*/

               
            }
            
            
            if(insertCaseTeamMap2.size() > 0){
                Database.insert(insertCaseTeamMap2.values(), false);
                
            }
            if(insertCaseTeamMap3.size() > 0){
                Database.insert(insertCaseTeamMap3.values(), false);
                
            }
            if(insertCaseTeamMap4.size() > 0){
                Database.insert(insertCaseTeamMap4.values(),false);
                
            }
        }
        catch(DMLException e){
            System.Debug('Error' + e);
        }          
    }
    
    /** 
*@author Geerutsing Govind Kumar
*@Date Creation 18/10/2017
*@Date modification 30/4/2018
*@param aNewList to pass update records.                      
*@return
*/  
    public static void updateCaseGatekeeper(List<Case> aNewList, List<Case> aOldList) {
        Set<String> businessArea = new set<String>();
        Set<String> businessAreaOld = new set<String>();
        Set<String> plantCase = new set<String>();
        Set<String> recordTypeName = new set<String>();
        set<String> status = new set<String>();
        Set<String> productOld = new Set<String>();
        Set<String> productNew = new Set<String>();
        Set<Id> createdById = new Set<Id>();
        Set<Id> keeperId = new Set<Id>();
        Set<Id> keeper2Id = new Set<Id>();
        Set<Id> keeper3Id = new Set<Id>();
        Set<Id> keeper4Id = new Set<Id>();
        Set<Id> userBackup = new Set<Id>();
        Set<Id> accountManagerOld = new Set<Id>();
        Set<Id> accountManagerNew = new Set<Id>();
        Set<String> outOfOfficeGatekeeper = new Set<String>();
        Set<String> outOfOfficeBackup = new Set<String>();
        Set<String> outOfOfficeCurrentGk = new Set<String>();
        Set<String> outOfOfficeCurrent = new Set<String>();
        Set<String> currentGK = new Set<String>();
        Set<String> currentGatekeeper = new Set<String>();
        Set<String> countryUserGatekeeper = new Set<String>();
        Set<String> countryGatekeeper = new Set<String>();
        Set<Id> recordTypeId = new Set<Id>();
        
        List<case> caseList = New list <case>();    
        Integer usersPlant;
        Integer usersAllPlants;
        DateTime date1 = Date.today();
        
        String recordTypeComplaint = Label.CL00008;
        
        RecordType complaint = [SELECT Id, DeveloperName 
                                FROM RecordType 
                                WHERE SObjectType =: Label.CL00036
                                AND DeveloperName =:recordTypeComplaint]; 
        
        Id recordTypeComplaintId = complaint.Id;
        
        for(case objOld : aOldList){
            productOld.add(objOld.ProductName__c); 
            //businessAreaOld.add(objOld.BusinessArea__c);
            createdById.add(objOld.createdById);  
            accountManagerOld.add(objOld.CSAccountManager__c);          
        }   
        for(Case obj : aNewList){
            //businessArea.add(obj.BusinessArea__c);
            plantCase.add(obj.Imerys_Manufacturing_Plant__c);
            status.add(obj.Status);
            productNew.add(obj.ProductName__c);
            currentGatekeeper.add(obj.GateKeeper__c);
            recordTypeId.add(obj.RecordTypeId); 
            accountManagerNew.add(obj.CSAccountManager__c);         
        }
        Map<Id, Product2> caseMap = new Map<Id,Product2>([SELECT Id, New_Product_Type_2__c from Product2 WHERE 
                                                          Id IN:productNew AND New_Product_Type_2__c IN(:Label.CL00037,:Label.CL00039)]);
        
        system.debug('plantcase is '+plantcase);
        system.debug('productOld is '+productOld);
        system.debug('productNew is '+productNew);
        system.debug('caseMap is '+caseMap.size());
        
        if(plantcase !=Null && productOld!=productNew && caseMap.size() ==0 && !plantCase.contains(Label.CL00043)){
            //||businessArea != Null && plantcase !=Null && businessAreaOld!=businessArea && caseMap.size() ==0){      
            
            system.debug('regis');
            
            for(GatekeeperAssignment__c gate : [SELECT Gatekeeper__c,Gatekeeper2__c,Gatekeeper3__c,Gatekeeper4__c 
                                                FROM GatekeeperAssignment__c 
                                                WHERE ImerysManufacturingPlant__c IN: plantCase
                                                AND AllPlants__c =: false
                                                AND Object__c =: Label.CL00038
                                                ORDER BY Id DESC]){
                                                    keeperId.add(gate.GateKeeper__c);
                                                    keeper2Id.add(gate.Gatekeeper2__c);
                                                    keeper3Id.add(gate.Gatekeeper3__c);
                                                    keeper4Id.add(gate.Gatekeeper4__c);
                                                    system.debug('gate' + gate);
                                                }           
            
            usersPlant = [SELECT COUNT()
                          FROM GatekeeperAssignment__c 
                          WHERE ImerysManufacturingPlant__c IN: plantCase
                          AND Object__c =: 'Complaint'
                          AND AllPlants__c =: false];
            system.debug('users' + usersPlant);
            
            
            try{
                for(user userGatekeeper:[SELECT id FROM user WHERE Id IN: keeperId]){
                    for(Case obj2 : aNewList){ 
                        obj2.GateKeeper__c = userGatekeeper.Id;
                        //obj2.OutOfOffice__c = false;
                        caseList.add(obj2);
                        system.debug('test9' + userGatekeeper.Id);
                    }
                }
            }
            catch(DMLException e){
                System.Debug('Error in assign owner '+ e);
            }
                        try{
                for(user userGatekeeper2:[SELECT id FROM user WHERE Id IN: keeper2Id]){
                    for(Case obj3 : aNewList){ 
                        obj3.Gatekeeper2__c = userGatekeeper2.Id;
                        //obj2.OutOfOffice__c = false;
                        caseList.add(obj3);
                        system.debug('test userGatekeeper2' + userGatekeeper2.Id);
                    	}
                	}
            	}
            catch(Exception e){
                System.Debug('Error in assign owner '+ e);
            }
                
            try{
                for(user userGatekeeper3:[SELECT id FROM user WHERE Id IN: keeper3Id]){
                    for(Case obj4 : aNewList){ 
                        obj4.Gatekeeper3__c = userGatekeeper3.Id;
                        //obj2.OutOfOffice__c = false;
                        caseList.add(obj4);
                        system.debug('test userGatekeeper3' + userGatekeeper3.Id);
                    }
                }
            }
            catch(Exception e){
                System.Debug('Error in assign owner '+ e);
            }
                
            try{
                for(user userGatekeeper4:[SELECT id FROM user WHERE Id IN: keeper4Id]){
                    for(Case obj5 : aNewList){ 
                        obj5.Gatekeeper4__c = userGatekeeper4.Id;
                        //obj2.OutOfOffice__c = false;
                        caseList.add(obj5);
                        system.debug('test userGatekeeper4' + userGatekeeper4.Id);
                    }
                }
                
            }
            catch(Exception e){
                System.Debug('Error in assign owner '+ e);
            }
        }   
        if (usersPlant == 0 && productOld!=productNew && caseMap.size() == 0){
            //|| businessArea != Null && usersPlant == 0 && businessArea!=businessAreaOld && caseMap.size() == 0)  {
            
            system.debug('regis');
            for(GatekeeperAssignment__c gate2 : [SELECT Gatekeeper__c,Gatekeeper2__c,Gatekeeper3__c,Gatekeeper4__c 
                                                 FROM GatekeeperAssignment__c 
                                                 WHERE AllPlants__c =: true
                                                 AND Object__c =:Label.CL00038
                                                 ORDER BY Id DESC]){
                                                     
                                                     keeperId.add(gate2.gatekeeper__c);
                                                 }
           
            try{
                for(user userGatekeeper:[SELECT id FROM user WHERE Id IN: keeperId]){
                    for(case obj2 : aNewList){ 
                        obj2.GateKeeper__c = userGatekeeper.Id;
                        //obj2.OutOfOffice__c = false;
                        caseList.add(obj2);
                        system.debug('test9' + userGatekeeper.Id);
                    }
                }
                
            }
            catch(DMLException e){
                System.Debug('Error in assign owner '+ e);
            }
            
            try{
                for(user userGatekeeper2:[SELECT id FROM user WHERE Id IN: keeper2Id]){
                    for(Case obj3 : aNewList){ 
                        obj3.Gatekeeper2__c = userGatekeeper2.Id;
                        //obj2.OutOfOffice__c = false;
                        caseList.add(obj3);
                        system.debug('test userGatekeeper2' + userGatekeeper2.Id);
                    	}
                	}
            	}
            catch(Exception e){
                System.Debug('Error in assign owner '+ e);
            }
                
            try{
                for(user userGatekeeper3:[SELECT id FROM user WHERE Id IN: keeper3Id]){
                    for(Case obj4 : aNewList){ 
                        obj4.Gatekeeper3__c = userGatekeeper3.Id;
                        //obj2.OutOfOffice__c = false;
                        caseList.add(obj4);
                        system.debug('test userGatekeeper3' + userGatekeeper3.Id);
                    }
                }
            }
            catch(Exception e){
                System.Debug('Error in assign owner '+ e);
            }
                
            try{
                for(user userGatekeeper4:[SELECT id FROM user WHERE Id IN: keeper4Id]){
                    for(Case obj5 : aNewList){ 
                        obj5.Gatekeeper4__c = userGatekeeper4.Id;
                        //obj2.OutOfOffice__c = false;
                        caseList.add(obj5);
                        system.debug('test userGatekeeper4' + userGatekeeper4.Id);
                    }
                }
                
            }
            catch(Exception e){
                System.Debug('Error in assign owner '+ e);
            }
        }
        if(accountManagerOld!=accountManagerNew && caseMap.size() > 0){
            //businessAreaOld!=businessArea && businessArea != null && caseMap.size() > 0||    
            
            system.debug('update Calderys');
            
            for(User userCountryGate : [SELECT CountryforGatekeeper__c 
                                        FROM User 
                                        Where Id IN: accountManagerNew
                                        ORDER BY Id DESC]){
                                            
                                            countryUserGatekeeper.add(userCountryGate.CountryforGatekeeper__c);
                                            system.debug('countryforGatekeeper' + userCountryGate);
                                        }                     
            for(GatekeeperAssignment__c gatekeeperCalderys : [SELECT CountryforGatekeeper__c, Gatekeeper__c,Gatekeeper2__c,Gatekeeper3__c,Gatekeeper4__c
                                                              FROM GatekeeperAssignment__c
                                                              WHERE CountryforGatekeeper__c IN: countryUserGatekeeper
                                                              AND Object__c =: Label.CL00038
                                                              ORDER BY Id DESC]){
                                                                  
                                                                  countryGatekeeper.add(gatekeeperCalderys.CountryforGatekeeper__c);
                                                                  keeperId.add(gatekeeperCalderys.Gatekeeper__c);
                                                                  keeper2Id.add(gatekeeperCalderys.Gatekeeper2__c);
                                                                  keeper3Id.add(gatekeeperCalderys.Gatekeeper3__c);
                                                                  keeper4Id.add(gatekeeperCalderys.Gatekeeper4__c);
                                                                  system.debug('gatekeeperCalderys' + gatekeeperCalderys.Gatekeeper__c);
                                                              }        
            
            try{
                for(user currentUser:[SELECT id FROM user WHERE Id IN: keeperId]){
                    for(Case obj2 : aNewList){ 
                        //obj2.OutOfOffice__c = false;
                        caseList.add(obj2);
                    }
                }
                
            }
            catch(DMLException e){
                System.Debug('Error in assign owner '+ e);
            }
            try{
                for(user userGatekeeper2:[SELECT id FROM user WHERE Id IN: keeper2Id]){
                    for(Case obj3 : aNewList){ 
                        obj3.GateKeeper2__c = userGatekeeper2.Id;
                        //obj2.OutOfOffice__c = false;
                        caseList.add(obj3);
                        system.debug('test10' + userGatekeeper2.Id);
                    }
                }
            }
            catch(DMLException e){
                System.Debug('Error in assign owner '+ e);
            }
            
            try{
                for(user userGatekeeper3:[SELECT id FROM user WHERE Id IN: keeper3Id]){
                    for(Case obj4 : aNewList){ 
                        obj4.GateKeeper3__c = userGatekeeper3.Id;
                        //obj2.OutOfOffice__c = false;
                        caseList.add(obj4);
                        system.debug('test10' + userGatekeeper3.Id);
                    }
                }
            }
            catch(DMLException e){
                System.Debug('Error in assign owner '+ e);
            }
            
            try{
                for(user userGatekeeper4:[SELECT id FROM user WHERE Id IN: keeper4Id]){
                    for(Case obj5 : aNewList){ 
                        obj5.GateKeeper4__c = userGatekeeper4.Id;
                        //obj2.OutOfOffice__c = false;
                        caseList.add(obj5);
                        system.debug('test10' + userGatekeeper4.Id);
                    }
                }
            }
            catch(DMLException e){
                System.Debug('Error in assign owner '+ e);
            }         
            
        }
    }        
    
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 19/6/2018
*@Date modification 7/3/2018
*@param aNewList to insert new record.
*@ExcptionName                   
*@return.
*/  
    public static void createCaseShare(List<case> aNewList) {      
        //Set<id> customerService = new set<id>();
        Id recordType;
        Set<Id>recordTypeId = new Set<Id>();
        Set<Id>csAccountManager = new Set<Id>();
        Id currentUserId = userinfo.getUserId();
        List<caseShare> caseShrsGatekeeper  = new List<caseShare>();
        Map<id,caseShare> caseMapGatekeeper = new Map<id,caseShare>();
        Map<id,caseShare> caseMapAccountManag = new Map<id,caseShare>();
        Map<id,caseShare> caseMapReceivedBy = new Map<id,caseShare>();
        
        if(!aNewList.isEmpty()){
            // Create a new list of sharing objects for case
            List<caseShare> caseShrsAccountManag  = new List<caseShare>();
            List<caseShare> caseShrsReceivedList  = new List<caseShare>();
            
            // Declare variables for case sharing
            
            caseShare caseShrReceivedBy;
            caseShare caseShrAccount;
            
            // Instantiate the sharing objects                      
            for(case cas : aNewList){
                
                caseShrReceivedBy = new caseShare();
                caseShrAccount = new CaseShare();
                recordTypeId.add(cas.RecordTypeId);
                //accountManager = cas.AccountManager__c;
                csAccountManager.add(cas.csAccountManager__c);
                //customerService.add(cas.CustomerService__c);    
                
                if(cas.CSAccountManager__c!=null){   
                    caseShrAccount.CaseId = cas.Id;
                    caseShrAccount.UserOrGroupId = cas.CSAccountManager__c;          
                    // Set the access level
                    caseShrAccount.CaseAccessLevel = 'edit';           
                    // Add objects to list for insert               
                    caseShrsAccountManag.add(caseShrAccount);
                }
                
                if(cas.Receiver__c!=null){                    
                    caseShrReceivedBy.CaseId = cas.Id;
                    caseShrReceivedBy.UserOrGroupId = cas.Receiver__c;          
                    // Set the access level
                    caseShrReceivedBy.CaseAccessLevel = 'edit';           
                    // Add objects to list for insert               
                    caseShrsReceivedList.add(caseShrReceivedBy);
                }
            }
            
            caseMapAccountManag.putall(caseShrsAccountManag);
            caseMapReceivedBy.putall(caseShrsReceivedList);
            
            if(caseMapAccountManag.size() > 0){
                if(!csAccountManager.contains(currentUserId)){
                    try{
                        //Database.SaveResult[] lsr = Database.insert(CaseShrs,True);
                        upsert caseMapAccountManag.values();
                    }
                    catch(DMLException e){
                        System.Debug('Error in createCaseShareA/CManager ' + e);
                    }  
                }
            }
            if(caseMapReceivedBy.size() > 0){ 
                try{            
                    upsert caseMapReceivedBy.values();
                }
                catch(DMLException e){
                    System.Debug('Error in createCaseShareReceivedBy ' + e);
                }  
            }   
            RecordType recordName = [SELECT Id, DeveloperName 
                                     FROM RecordType 
                                     WHERE SObjectType = 'Case'
                                     AND DeveloperName = 'CSE_Remark']; 
            
            recordType = recordName.Id;
            
            //if(recordTypeId.contains(recordType)){
            
            caseShare caseShrGate;  
            
            for(case casGatekeeper : aNewList){
                
                caseShrGate = new CaseShare();
                
                if(casGatekeeper.GateKeeper__c!=null){   
                    
                    caseShrGate.CaseId = casGatekeeper.Id;
                    caseShrGate.UserOrGroupId = casGatekeeper.GateKeeper__c;          
                    // Set the access level
                    caseShrGate.CaseAccessLevel = 'edit';           
                    // Add objects to list for insert               
                    caseShrsGatekeeper.add(caseShrGate);
                }
            }
            
            caseMapGatekeeper.putall(caseShrsGatekeeper);
            
            if(caseMapGatekeeper.size() > 0){                               
                try{
                    upsert caseMapGatekeeper.values();                  
                }
                catch(DMLException e){
                    System.Debug('Error in createCaseShareA/CManager ' + e);
                }                   
                
            }   
            //}   
        }   
    }
    
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 10/17/2017
*@Date modification 
*@param aNewList to update new record.
*@ExcptionName                      
*@return 
*/  
    public static void updateCaseShare(List<case> aoldList,List<case> aNewList) {
        Id recordType;      
        Set<Id> recordId = new Set<Id>();
        Set<Id> gateKeeperOld = new Set<Id>();
        Set<Id> oldreceivedBySet = new Set<Id>();
        List<caseShare> caseShrsGatekeeper  = new List<caseShare>();
        Map<Id,caseShare> caseMapGatekeeper = new Map<Id,caseShare>();
        //set<id> groupIdcustomerService = new set<id>();
        Set<Id> groupIdAccountManager = new Set<Id>();
        Set<Id>recordTypeId = new Set<Id>();
        //set<id> customerService = new set<id>();
        Set<Id> csAccountManager = new Set<Id>();
        Set<Id> newreceivedBySet = new Set<Id>();
        Set<id> ownerId = new Set<id>();
        Set<id> newAccountManager = new Set<id>();
        //set<id> newCustomerService = new set<id>();
        Set<id> createdById = new Set<id>();
        Set<id> caseId = new Set<id>();
        
        Map<id,caseShare> caseMapAccountManag = new Map<id,caseShare>();
        //map<id,caseShare> caseMapCusServ = new map<id,caseShare>();
        Map<id,caseShare> caseMapCreatedBy = new Map<id,caseShare>();
        Map<id,caseShare> caseMapReceivedBy = new Map<id,caseShare>();
        List<caseShare> caseShrsAccountManag  = new List<caseShare>();
        //List<caseShare> caseShrsCusServ  = new List<caseShare>();
        List<caseShare> caseShrsOwnerCreated  = new List<caseShare>();
        List<caseShare> caseShrsReceivedList  = new List<caseShare>();
        
        if(!aoldList.isEmpty()){
            for(case camp: aoldList){
                recordId.add(camp.Id);
                ownerId.add(camp.ownerId);
                groupIdAccountManager.add(camp.CSAccountManager__c); 
                //groupIdcustomerService.add(camp.customerService__c); 
                createdById.add(camp.OwnerId);
                gateKeeperOld.add(camp.gatekeeper__c);
                oldreceivedBySet.add(camp.Receiver__c);
            }
        }
        for(case campNew: aNewList){
            recordTypeId.add(campNew.RecordTypeId);
            newAccountManager.add(campNew.CSAccountManager__c);
            system.debug('newsales' + newAccountManager);
            //newCustomerService.add(campNew.customerService__c);
            caseId.add(campNew.Id);
        }          
        // Create a new list of sharing objects for Sample      
        // Declare variables for case sharing
        List<caseShare> caseShareAccountMang = [SELECT CaseId, UserOrGroupId, caseAccessLevel, 
                                                RowCause FROM caseShare
                                                WHERE UserOrGroupId IN:groupIdAccountManager
                                                AND CaseId IN: recordId
                                                AND CaseAccessLevel ='Edit' LIMIT 100];
        
        system.debug('sales' + caseShareAccountMang );
        //caseShare[] caseShareCusService = [SELECT CaseId, UserOrGroupId, caseAccessLevel, 
        //RowCause FROM caseShare 
        //WHERE UserOrGroupId IN :groupIdcustomerService
        //AND CaseId IN: recordId
        //AND CaseAccessLevel ='Edit'];
        
        //system.debug('cust' + caseShareCusService);
        If(ownerId!=groupIdAccountManager && !groupIdAccountManager.IsEmpty()){
            if(caseShareAccountMang.size() > 0 ){ 
                system.debug('delsal');
                //Database.delete(caseShareSalesMang,True);
                try{
                    Database.DeleteResult[] drListdelAccountManag = Database.delete(caseShareAccountMang, true); 
                }
                catch(DMLException e){
                    System.Debug('Error in delete sal ' + e);
                }                        
            }
        }
        List<caseShare> caseShareGatekeeper = [SELECT CaseId, UserOrGroupId, caseAccessLevel, 
                                               RowCause FROM caseShare
                                               WHERE UserOrGroupId IN:gateKeeperOld
                                               AND CaseId IN: recordId
                                               AND CaseAccessLevel ='Edit' LIMIT 100];
        
        system.debug('gate' + gateKeeperOld );
        //caseShare[] caseShareCusService = [SELECT CaseId, UserOrGroupId, caseAccessLevel, 
        //RowCause FROM caseShare 
        //WHERE UserOrGroupId IN :groupIdcustomerService
        //AND CaseId IN: recordId
        //AND CaseAccessLevel ='Edit'];
        
        //system.debug('cust' + caseShareCusService);
        If(ownerId!=gateKeeperOld && !gateKeeperOld.IsEmpty()){
            if(caseShareGatekeeper.size() > 0 ){ 
                system.debug('delsal');
                //Database.delete(caseShareSalesMang,True);
                try{
                    Database.DeleteResult[] drListdelGateKeeper = Database.delete(caseShareGatekeeper, true); 
                }
                catch(DMLException e){
                    System.Debug('Error in delete gat ' + e);
                }                        
            }
        }
        List<caseShare> caseShareReceiverByList = [SELECT CaseId, UserOrGroupId, caseAccessLevel, 
                                                   RowCause FROM caseShare
                                                   WHERE UserOrGroupId IN:oldreceivedBySet
                                                   AND CaseId IN: recordId
                                                   AND CaseAccessLevel ='Edit' LIMIT 100];
        
        system.debug('receive' + oldreceivedBySet );
        
        If(ownerId!=oldreceivedBySet && !oldreceivedBySet.IsEmpty()){
            if(caseShareReceiverByList.size() > 0 ){ 
                system.debug('delsal');
                //Database.delete(caseShareSalesMang,True);
                try{
                    Database.DeleteResult[] drListdelReceiver = Database.delete(caseShareReceiverByList, true); 
                }
                catch(DMLException e){
                    System.Debug('Error in delete receiver ' + e);
                }                        
            }
        }           
        //If(ownerId!=groupIdcustomerService && !groupIdcustomerService.IsEmpty() && groupIdSalesManager!=groupIdcustomerService){
        //if(caseShareCusService.size() > 0 ){
        //system.debug('delcust');        
        //Database.delete(caseShareCusService ,True);
        //try{
        //Database.DeleteResult[] drListdelCustServ = Database.delete(caseShareCusService, true); 
        //}
        //catch(DMLException e){
        //System.Debug('Error in delete cus ' + e);
        //}
        //} 
        //}
        List<caseShare> caseShareList = New List<caseShare>(); 
        
        //caseShare caseShrCus;
        caseShare caseShrAccount;
        caseShare caseShrOwnerCreatedRecord;
        caseShare caseShrReceivedBy;
        
        for(case caseUpd : aNewList){
            //accountManager = caseUpd.AccountManager__c; 
            csAccountManager.add(caseUpd.CSAccountManager__c);
            newreceivedBySet.add(caseUpd.Receiver__c);
            //caseShrCus = new caseShare();
            caseShrAccount = new CaseShare();
            caseShrOwnerCreatedRecord = new caseShare();  
            caseShrReceivedBy = new caseShare();
            
            If(caseUpd.CSAccountManager__c!= null){    
                // Instantiate the sharing objects                 
                // Set the ID of record being shared
                caseShrAccount.CaseId = caseUpd.Id;    
                // Set the ID of user or group being granted access
                caseShrAccount.UserOrGroupId = caseUpd.CSAccountManager__c;          
                // Set the access level
                caseShrAccount.CaseAccessLevel = 'edit';           
                // Add objects to list for insert             
                caseShrsAccountManag.add(caseShrAccount);
            }
            //If(caseUpd.customerService__c!= null){    
            // Instantiate the sharing objects                 
            // Set the ID of record being shared
            //caseShrCus.CaseId = caseUpd.Id;    
            // Set the ID of user or group being granted access
            //caseShrCus.UserOrGroupId = caseUpd.customerService__c;          
            // Set the access level
            //caseShrCus.CaseAccessLevel = 'edit';           
            // Add objects to list for insert             
            //caseShrsCusServ.add(caseShrCus);
            //}
            
            caseShrOwnerCreatedRecord.CaseId = CaseUpd.Id;
            caseShrOwnerCreatedRecord.UserOrGroupId = CaseUpd.createdById;          
            // Set the access level
            caseShrOwnerCreatedRecord.CaseAccessLevel = 'edit';
            caseShrsOwnerCreated.add(caseShrOwnerCreatedRecord); 
            
            If(caseUpd.Receiver__c!= null){
                caseShrReceivedBy.CaseId = CaseUpd.Id;
                caseShrReceivedBy.UserOrGroupId = CaseUpd.Receiver__c;          
                // Set the access level
                caseShrReceivedBy.CaseAccessLevel = 'edit';
                caseShrsReceivedList.add(caseShrReceivedBy); 
            }
        }
        caseMapAccountManag.putall(caseShrsAccountManag);
        //caseMapCusServ.putall(caseShrsCusServ);
        caseMapCreatedBy.putall(caseshrsOwnerCreated);
        caseMapReceivedBy.putall(caseShrsReceivedList);
        
        if(caseMapAccountManag.size() > 0){
            // if(ownerId!=csAccountManager){ 
            system.debug('testinsertMap' + caseMapAccountManag.Values()); 
            try{
                upsert caseMapAccountManag.values();
            }
            catch(DMLException e){
                System.Debug('Error in updateCaseShare AccountMang '+ e);
            }       
            //}
        }
        If(caseMapReceivedBy.size() > 0){
            //if(OwnerId!=newreceivedBySet){            
            try{
                upsert caseMapReceivedBy.values();
            }
            catch(DMLException e){
                System.Debug('Error in updateCaseShare receivedBy'+ e);
            }
            //}   
        }
        //List<CaseShare> caseChkCreatedId =[SELECT ID FROM CaseShare 
        // WHERE CaseId IN: CaseId
        //AND UserOrGroupId IN: createdById
        //AND (CaseAccessLevel = 'Edit'
        //OR CaseAccessLevel = 'All')];      
        If(caseMapCreatedBy.size() > 0){
            //If(caseChkCreatedId.size() == 0){
            try{
                upsert caseMapCreatedBy.Values();
            }
            catch(DMLException e){
                System.Debug('Error in updateCaseShare upsert '+ e);
                // }
            }
        }
        RecordType recordName = [SELECT Id, DeveloperName 
                                 FROM RecordType 
                                 WHERE SObjectType = 'Case'
                                 AND DeveloperName = 'CSE_Remark']; 
        
        recordType = recordName.Id;
        
        //if(recordTypeId.contains(recordType)){
        
        caseShare caseShrGate;  
        
        for(case casGatekeeper : aNewList){
            
            caseShrGate = new CaseShare();
            
            if(casGatekeeper.GateKeeper__c!=null){   
                
                caseShrGate.CaseId = casGatekeeper.Id;
                caseShrGate.UserOrGroupId = casGatekeeper.GateKeeper__c;          
                //Set the access level
                caseShrGate.CaseAccessLevel = 'edit';           
                // Add objects to list for insert               
                caseShrsGatekeeper.add(caseShrGate);
                system.debug('Update gatekeeper');
            }
        }
        
        caseMapGatekeeper.putall(caseShrsGatekeeper);
        
        if(caseMapGatekeeper.size() > 0){                               
            try{
                upsert caseMapGatekeeper.values();                  
            }
            catch(DMLException e){
                System.Debug('Error in updateCaseGatekeeper ' + e);
            }                   
            
        }   
        //}
    }
    
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 10/17/2017
*@Date modification 
*@param aoldList to delete sample record.
*@ExcptionName                      
*@return 
*/  
    public static void deleteCaseShare(List<case> aDeleteList) {
        //set<id> customerService = new set<id>(); 
        Set<id> recordId = new Set<id>();
        Set<id> csAccountManager = new Set<id>();
        Set<id> ownerId = new Set<id>();
        
        if(!aDeleteList.isEmpty()){
            List<caseShare> caseShareList = New List<caseShare>(); 
            
            caseShare caseShr;  
            List<caseShare> caseShrs  = new List<caseShare>(); 
            
            for(case caseDel: aDeleteList){
                csAccountManager.add(caseDel.CSAccountManager__c); 
                //customerService.add(caseDel.customerService__c);
                recordId.add(caseDel.Id);
                OwnerId.add(caseDel.OwnerId);
                // Set the ID of user or group being granted access              
                caseShrs.add(caseShr);
            }
            
            if(!csAccountManager.isEmpty() && ownerId!=csAccountManager){
                
                caseShare[] casShare = [SELECT Id, CaseAccessLevel, UserOrGroupId 
                                        FROM CaseShare
                                        WHERE UserOrGroupId IN:csAccountManager 
                                        AND CaseAccessLevel ='Edit'
                                        AND CaseId IN:recordId ];
                
                Database.DeleteResult[] drList = Database.delete(casShare, true);  
            }
            //if(!customerService.isEmpty() && ownerId!=customerService){
            
            //caseShare[] casShare = [SELECT Id, CaseAccessLevel, UserOrGroupId 
            //FROM CaseShare
            //WHERE UserOrGroupId IN: customerService
            //AND CaseAccessLevel ='Edit'
            //AND CaseId IN:recordId ];
            
            //Database.DeleteResult[] drList2 = Database.delete(casShare, true);  //delete
            //}  
        }
    }
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 2/9/2018
*@Date modification 
*@param aNewList to fill relationship.                      
*@return error message
*/  
    public static void fillRelationship(List<Case> aNewList) {
        Set<String>businessAreaSet=new Set<String>();
        Set<id>accountIdSet = new Set<id>();
        list<Case>caseList =new List<Case>();
        Map<Id, Relationship__c> rels = new Map<Id, Relationship__c>();
        For(Case b:aNewList){
            if(b.BusinessArea__c!=Null){
                businessAreaSet.add(b.BusinessArea__c);
            }               
            rels.put(b.Tech_RelationshipInformation__c, null);
            accountIdSet.add(b.AccountId);
            //lookup field to opportunity on bid__c
        }
        if(!businessAreaSet.IsEmpty()){
            list<Relationship__c>relList=[SELECT id,name, BusinessArea__c from Relationship__c 
                                          WHERE BusinessArea__c IN: businessAreaSet
                                          AND AccountName__c IN: accountIdSet LIMIT 1];                                       
            for(Relationship__c relDivName :relList){
                try{
                    for(Case bd: aNewList){
                        bd.Tech_RelationshipInformation__c= relDivName.Id;
                        caseList.add(bd);
                        system.debug('bd' + caseList);                       
                    }
                }
                catch(DMLException e){
                    System.Debug('Error in case '+ e);
                }
            }
        }           
    }
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 2/9/2018
*@Date modification 
*@param aNewList to fill relationship.                      
*@return error message
*/  
    public static void updateRelationship(List<Case> aNewList) {
        Set<String>businessAreaSet=new Set<String>();
        Set<id>accountIdSet = new Set<id>();
        list<Case>caseList =new List<Case>();
        Map<Id, Relationship__c> rels = new Map<Id, Relationship__c>();
        For(Case b:aNewList){
            if(b.BusinessArea__c!=Null){
                businessAreaSet.add(b.BusinessArea__c);
            }               
            rels.put(b.Tech_RelationshipInformation__c, null);
            accountIdSet.add(b.AccountId);
            //lookup field to opportunity on bid__c
        }
        if(!businessAreaSet.IsEmpty()){
            list<Relationship__c>relList=[SELECT id,name,BusinessArea__c from Relationship__c 
                                          WHERE BusinessArea__c IN: businessAreaSet
                                          AND AccountName__c IN: accountIdSet LIMIT 1]; 
            
            if(relList.size() == 0){                           
                try{
                    for(Case bd: aNewList){
                        bd.Tech_RelationshipInformation__c= null;
                        caseList.add(bd);
                        system.debug('bd' + caseList);                       
                    }
                }
                catch(DMLException e){
                    System.Debug('Error in case '+ e);
                }
            }
            else{           
                for(Relationship__c relDivName :relList){
                    try{
                        for(Case bd: aNewList){
                            bd.Tech_RelationshipInformation__c= relDivName.Id;
                            caseList.add(bd);
                            system.debug('bd' + caseList);                       
                        }
                    }
                    catch(DMLException e){
                        System.Debug('Error in case '+ e);
                    }
                }
            }
        }           
    }
    
   /**
*@author Jaunbocus Muhammad Irshaad
*@Date Creation 02/08/2021
*@param aNewList                     
*@return error message
*@Descriptopm This method changes the owner Id when user sets type to 'New Order	' On creation
*/  
    public static void updateOwnerIdonCreation(List<Case> aNewList) {
        set<String> businessAreaList = new set<string>();
        set<String> customerServiceDeptList = new set<string>();
        set<String> csTeamInChargeList = new set<string>();
        List<id> queueIdList = new List<id>();
        
        for(case a : aNewList){
            
            businessAreaList.add(a.BusinessArea__c);
            csTeamInChargeList.add(a.CSTeamInCharge__c);
        }
        
                  
            List<GatekeeperAssignment__c> RequestList = new List<GatekeeperAssignment__c>(
                [Select Request_Queue__c From GatekeeperAssignment__c
                 Where Object__c =: Label.CL00081 //Request
                 And BusinessArea__c IN: businessAreaList 
                 AND csTeamInCharge__c IN: csTeamInChargeList
                ]);
            
            //Request_Queue__c is a picklist field on object GatekeeperAssignment
            //Ensure that Field Request_Queue__c Picklist API values are similar to Queue(group object)
            
            if(RequestList.size()>0){
                system.debug('RequestList------->'+RequestList);
                system.debug('RequestList Val --->'+RequestList[0].Request_Queue__c);
                
                String RequestListApi = RequestList[0].Request_Queue__c;
                
                //get id of queue based on API
                List<group> groupId = new list<group>([Select id from group where developername =: RequestListApi]);
                for(group g : groupId){
                    queueIdList.add(g.id);
                }
                
                system.debug('queueIdList--->'+queueIdList);
                if(queueIdList.size()>0){
                    
                    for (Case b : aNewList){
                        b.OwnerId = queueIdList[0];
                    }
                }
            }
        }
    
    /**
*@author Jaunbocus Muhammad Irshaad
*@Date Creation 02/08/2021
*@param aNewList                     
*@return error message
*@Descriptopm This method changes the owner Id when sets User type to 'New Order' On Update
*/  
    public static void updateOwnerIdonUpdate(List<Case> aOldList , List<Case> aNewList) {
        
        set<String> oldBusinessAreaList = new set<string>();
        set<String> oldCustomerServiceDeptList = new set<string>();
        set<String> oldCsTeamInChargeList = new set<string>();
        set<String> newBusinessAreaList = new set<string>();
        set<String> newCustomerServiceDeptList = new set<string>();
        set<String> newCsTeamInChargeList = new set<string>();
        List<id> queueIdList = new List<id>();
        
        for(Case old : aOldList){
           
            oldBusinessAreaList.add(old.BusinessArea__c);
            oldCsTeamInChargeList.add(old.CSTeamInCharge__c);
        }
        
        for(Case n : aNewList){
            newBusinessAreaList.add(n.BusinessArea__c);
            newCsTeamInChargeList.add(n.CSTeamInCharge__c);
        }
        
        system.debug('Test Update');
        
        //If Business Area is changed OR If Customer Service Department is changed 
        //Re calculate the Queue 
        if(!newCsTeamInChargeList.equals(oldCsTeamInChargeList) || !newBusinessAreaList.equals(oldBusinessAreaList)  ){
           	 List<GatekeeperAssignment__c> RequestList = new List<GatekeeperAssignment__c>(
                [Select Request_Queue__c From GatekeeperAssignment__c
                 Where Object__c =: Label.CL00081 //Request
                 And BusinessArea__c IN: newBusinessAreaList
                 AND csTeamInCharge__c IN: newCsTeamInChargeList
                
                ]);
            
            	if(RequestList.size()>0){
                    system.debug('RequestList------->'+RequestList);
                    system.debug('RequestList Val --->'+RequestList[0].Request_Queue__c);
                    
                    String RequestListApi = RequestList[0].Request_Queue__c;
                    
                    //get id of queue based on API
                    List<group> groupId = new list<group>([Select id from group where developername =: RequestListApi]);
                    for(group g : groupId){
                        queueIdList.add(g.id);
                    }
                    
                    system.debug('queueIdList--->'+queueIdList);
                    if(queueIdList.size()>0){
                        
                        for (Case b : aNewList){
                            b.OwnerId = queueIdList[0];
                        }
                    }
      			}
        }
        /*else{
            for (Case b : aNewList){
                b.OwnerId = b.CreatedById;
            	}
            }*/
    }
        
 
    
    /**
*@author Jaunbocus Muhammad Irshaad
*@Date Creation 03/08/2021
*@param aNewList                     
*@return error message
*@Descriptopm This method Creates Case Team Members (For Request) whenever a request is created.
//If Owner is a queue , add all the members of the queue as Team Member
//If Owner is creator, add creator as Team Member 
*/     
public static void createCaseTeamRequest(List<Case> aNewList){
    	set<String> typeList = new set<string>();
        set<String> businessAreaList = new set<string>();
        set<String> customerServiceDeptList = new set<string>();
        Set<String> countryUserGatekeeper = new Set<String>();
    	List <CaseTeamMember> CaseTeamLst = new List<CaseTeamMember>();
    	Set<Id> recordIdSet = new Set<Id>();
    	Set<id> ownerIdSet  = new Set<Id>();
    	Set<Id> recordTypeId = new Set<Id>();
	    Integer usersPlant;
   		CaseTeamRole role = [select Id from CaseTeamRole where Name = :Label.CL00069 limit 1];	
        
        for(Case obj : aNewList){
            typeList.add(obj.Imerys_Manufacturing_Plant__c);           
            businessAreaList.add(obj.ProductName__c);
            customerServiceDeptList.add(obj.CSAccountManager__c);
            recordTypeId.add(obj.RecordTypeId);
            ownerIdSet.add(obj.OwnerId);
            recordIdSet.add(obj.id);
            
        }
    //get record Id of object
    id recordId = new list<id>(recordIdSet)[0];
        
    system.debug('obj recordTypeId--'+recordTypeId);
    
    String recordTypeRequest = Label.CL00081;
    
    RecordType Request = [Select id,developername
                         From RecordType
                         where SobjectType =:  Label.CL00036
                         and DeveloperName =: recordTypeRequest];
    
    system.debug('Request--'+Request);
    system.debug('Owner Id Set--'+OwnerIdSet);    
    Id recordTypeRequestId = Request.id;
    
    system.debug('recordTypeRequestId--'+recordTypeRequestId);
    
    //if Request
    if(recordTypeId.contains(recordTypeRequestId)){
        
        Id ownerId = new list<id>(ownerIdSet)[0];
        String ownerIdStr = String.valueOf(ownerId);
        
        //if owner is a queue
        if( ownerIdStr.IndexOf('00G')!= -1){
            
            Integer CountMembers = [Select COUNT()
                                   FROM GroupMember
                                   Where GroupId =: ownerId];
            
            system.debug('Count Members---:' + CountMembers);
            
            List <GroupMember> groupMemberLst = [Select UserOrGroupId From GroupMember Where GroupId =: ownerId];
            
            system.debug('groupMemberLst--'+groupMemberLst);
            
            
            For(GroupMember a : groupMemberLst){
                CaseTeamMember caseNewTeam = new CaseTeamMember();
                caseNewTeam.MemberId = a.UserOrGroupId;
                caseNewTeam.ParentId = recordId;
                CaseNewTeam.TeamRoleId = role.id;
                
                CaseTeamLst.add(CaseNewTeam);
            }
            
            system.debug('CaseTeamLst -->'+CaseTeamLst);
            if(CaseTeamLst.size() > 0){
                try{
                    database.insert(CaseTeamLst);
                }
                catch(DMLException e){
           			 System.Debug('Error' + e);
        		}
            }
        }
        
        //owner = creator
        else{
            system.debug('Inside creator');
            CaseTeamMember caseNewTeam = new CaseTeamMember();
            CaseNewTeam.MemberId = ownerId;
            CaseNewTeam.ParentId = recordId;
            CaseNewTeam.TeamRoleId = role.id;
            
            CaseTeamLst.add(CaseNewTeam);
             if(CaseTeamLst.size() > 0){
                try{
                    database.insert(CaseTeamLst);
                }
                catch(DMLException e){
           			 System.Debug('Error' + e);
        		}
            }
        }
        
        
           
    }
    
    
    
}
    
    /**
*@author Jaunbocus Muhammad Irshaad
*@Date Creation 14/6/2021                
*@Date modification 
*@param aNewList to fill relationship.                      
*@return error message
*/  
    public static void fillMarketSegmentAndAcctMgr(List<Case> aNewList) {
        Set<id>relationshipInfoIdSet = new Set<id>();
        Set<id>accMgrIdSet = new Set<id>();
        Set<id>marketSegmentationIdSet = new set<id>();
        Set<id> ownerIdSet = new set<id>();
        Set<id> customerServiceSet = new set<id>();
        
        //Get the Relationship , Account Manager and Market Segmentation on the Case
        For(Case b:aNewList){
            
            if(b.Tech_RelationshipInformation__c != null){
                relationshipInfoIdSet.add(b.Tech_RelationshipInformation__c);
            }
           // else{
            //    b.addError('There is No Relationship with Business Area on the Account');
            //}
            
            if(b.CSAccountManager__c != null){accMgrIdSet.add(b.CSAccountManager__c);}
            if(b.MarketSegmentationNew__c != null){ marketSegmentationIdSet.add(b.MarketSegmentationNew__c);}
            ownerIdSet.add(b.OwnerId);
            if(b.CustomerService2__c != null){ customerServiceSet.add(b.CustomerService2__c);}
        }
        
        if(!relationshipInfoIdSet.isEmpty()){
            
            List<Relationship__c> relList = new List<Relationship__c>([Select name,accountManager__c,MarketSegmentation__c,NewMarketL1__c,NewMarketL2__c
                                                                       from relationship__c 
                                                                       where id IN: relationshipInfoIdSet  ]);
            
             
            
            //Fill market segmentation
            //Idea : If user does not fill Market segmentation, take Market segmentation from relationship.
            //If user fill market segmentation, do nothing.
            if(marketSegmentationIdSet.isEmpty()){
                for(case c : aNewList){
                    c.MarketSegmentationNew__c = relList[0].MarketSegmentation__c;
                    c.NewMarketL1__c = relList[0].NewMarketL1__c;
                    c.NewMarketL2__c = relList[0].NewMarketL2__c;
                }
            }
			
            
            //Fill Account Manager
            //Idea : If user does not fill Account Manager, take Account Manager from relationship.
            //If user fill Account Manager, do nothing.
            if(accMgrIdSet.isEmpty()){
                for(case c : aNewList){
                    c.CSAccountManager__c = relList[0].accountManager__c;
                }
            }
            
        }
        
        
       
         
        //If customer Service field is filled, we don't do anything
        // If customer service is not filled, we check if the Owner is of type Customer Service & Sales Administration, if true we auto fill the CS with owner, otherwise we leave blank.
        if(customerServiceSet.isEmpty()){

		//CL00078 - Customer Service & Sales Administration
			List<User> custServiceOwner = new List<User>([Select id from User where id IN: ownerIdSet and Job_Department__c =: Label.CL00078 ]);
            
            system.debug('custServiceOwner-->'+custServiceOwner);
            
            if(custServiceOwner.size() > 0){
                for(case b:aNewList){
                    b.CustomerService2__c = custServiceOwner[0].id;
                }
            }
		}

		
    }
    
    /**
*@author Pritam Yadav
*@Date Creation 17/12/2021
*@Date modification 
*@param aNewList to get inserted case ids                     
*@return
*/
    public static list<id> getCaseIdList(List<Case> aNewList){
        list<id> CaseId2=new list<id>();
        for (Case c:aNewList)
        {
            CaseId2.add(c.Id);
        }
        return CaseId2;
    }
    /**
*@author Pritam Yadav
*@Date Creation 17/12/2021
*@Date modification 
*@param aNewList to pass inserted records                      
*@return
*/
public static void DecideCaseOwnerBasedOnAccountGateKeeper(List<id> aNewCaseIdlst){
    list<Case> aNewList=[SELECT Id, Origin, Subject, OwnerId, AccountId, RecordTypeId FROM Case where id in:aNewCaseIdlst];
    id ownerIdOriginal ;
    list<RecordType> requestRecType=[SELECT Id, Name, DeveloperName, IsActive, SobjectType FROM RecordType where SobjectType='Case' and DeveloperName='Request'];
    list<Case> caseList= new list<Case>();
	for(Case c : aNewList)
        {	
            OwnerIdOriginal = c.OwnerId;
            if(c.RecordTypeId==requestRecType[0].id &&c.Origin=='Email Automated' &&c.AccountId!=null)
            {	

                list<GatekeeperAssignment__c> GateKeeperAssignment=[SELECT Id, Name, Gatekeeper__c, GatekeeperAccount__r.name FROM GatekeeperAssignment__c where GatekeeperAccount__c=:c.AccountId limit 1];
                if(GateKeeperAssignment.size()>0){
                    c.OwnerId=GateKeeperAssignment[0].Gatekeeper__c;
                }
                else{//take owner defined from email to case
                    c.OwnerId = OwnerIdOriginal;
                }
                
                caseList.add(c);
            }
        }
    database.update(caseList);
}

    
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 10/17/2017
*@Date modification 10/30/2017
*@param
*@ExcptionName                  
*@return method createCaseGatekeeper with new values.
*/
    public override void beforeInsert() {
        //Override method BeforeUpdate from class Handler to create new Account Team record.
        fillRelationship(Trigger.new); 
        fillMarketSegmentAndAcctMgr(Trigger.new);
        updateOwnerIdonCreation(Trigger.new);
        createCaseGatekeeper(Trigger.new);
    }   
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 10/17/2017
*@Date modification 10/30/2017
*@param
*@ExcptionName                  
*@return method updateCase with new values.
*/
    
    public override void beforeUpdate() {      
        updateCaseGatekeeper(Trigger.new, trigger.old); 
        updateRelationship(Trigger.new); 
        updateOwnerIdonUpdate(Trigger.old,Trigger.new);
    }   
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 10/17/2017
*@Date modification  10/30/2017
*@param
*@ExcptionName                  
*@return method createCaseShare with new values.
*/  
    public override void AfterInsert() {
        //Override method BeforeInsert from class Handler to create new sample record.
        createCaseShare(Trigger.new);
        Set<Id> caseIds = new Set<Id>(); 
        createCaseTeam(trigger.new); 
        createCaseTeamRequest(Trigger.new);
        list<id> CaseIdlst=getCaseIdList(Trigger.new);
        DecideCaseOwnerBasedOnAccountGateKeeper(CaseIdlst);
        
    } 
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 10/17/2017
*@Date modification 10/30/2017
*@param
*@ExcptionName                  
*@return method updateCaseShare with new and old values.
*/  
    public override void AfterUpdate() {
        //Override method BeforeUpdate from class Handler to update sample record.
        updateCaseShare(Trigger.old, Trigger.new);
        updateCaseTeam(trigger.new, trigger.old);
    } 
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 10/17/2017
*@Date modification 10/30/2017
*@param
*@ExcptionName                  
*@return method deleteCaseShare with old values.
*/      
    public override void AfterDelete() {
        //Override method AfterDelete from class Handler.
        deleteCaseShare(Trigger.old);
    }      
}