/**
*@author Geerutsing Govind Kumar
*@Date Creation 10/12/2017
*@description Change owner for record type shipment/preparation
*description Grant CS Account Manager Read/Write Access
*Date Modification 1/25/2018-Store gatekeeper read and write access when status is changed to customer evaluation/Closed
*Date Modification 30/04/2018-Backup gatekeeper and outoffice field is checked/unchecked
*/
public without sharing class AP01_SampleTriggerHandler extends TriggerHandler {   
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 10/12/2017
*@Date modification 30/4/2018
*@param aNewList to pass update records.                      
*@return 
*/  
    public static void createSampleGateKeeper(List<Sample__c> aNewList){
        Set<String> businessArea = new Set<String>();
        Set<String> plantSample = new Set<String>();
        Set<Id> OwnerIdSet = new Set<Id>();
        Set<Id> KeeperId = new Set<Id>();
        Set<Id> userBackup = new Set<Id>();
        Set<String> outOfOfficeGatekeeper = new Set<String>();
        Set<String> outOfOfficeBackup = new Set<String>();
        Set<String> outOfOfficeCurrentGk = new Set<String>();
        List<Sample__c> sampleList = New list <Sample__c>();
        Set<String> currentGK = new Set<String>();
        Set<String> currentGatekeeper = new Set<String>();
        Integer usersPlant;
        Integer usersAllPlants;
        DateTime date1 = Date.today();
                 
        for(Sample__c obj : aNewList){
            //If (obj.Division__c != null){
                //businessArea.add(obj.BusinessArea__c);
            //}
            //else{
                //businessArea.add(obj.RelatedDivision__c);
            //}
            plantSample.add(obj.DispatchSiteLookup__c); 
            ownerIdSet.add(obj.OwnerId); 
            currentGatekeeper.add(obj.GateKeeper__c);
                        
        }
        
        if(plantSample !=Null && !plantSample.Contains(Label.CL00043)){   
            for(GatekeeperAssignment__c gate : [SELECT Gatekeeper__c 
                                                  FROM GatekeeperAssignment__c 
                                                  WHERE Imerys_Site_Dispatch__c IN: plantSample
                                                  AND AllPlants__c =: false
                                                  AND Object__c =: Label.CL00040
                                                  ORDER BY Id DESC]){                                             
                keeperId.add(gate.GateKeeper__c);
            }            
            usersPlant = [SELECT COUNT()
                            FROM GatekeeperAssignment__c                                                                         
                            WHERE Imerys_Site_Dispatch__c IN: plantSample
                            AND AllPlants__c =: false
                            AND Object__c =: 'Sample']; 
                                               
            if(usersPlant > 0){         
                for(OutOfOffice userGate :[SELECT StartDate, EndDate, IsEnabled, Message
                                    FROM OutOfOffice
                                    WHERE UserId IN: keeperId                                   
                                    AND StartDate <=: date1                                                                      
                                    AND EndDate >=: date1   	                                 
                                    ]){
                                       
                    outOfOfficeGatekeeper.add(userGate.Message);
                }
            }                   
            for(OutOfOffice userCurrent :[SELECT StartDate, Enddate, IsEnabled, Message
                                       FROM OutOfOffice WHERE UserId IN: currentGatekeeper
                                       AND StartDate <=: date1                                                                      
                                       AND EndDate >=: date1                                    
                                      ]){
                                       
                outOfOfficeCurrentGk.add(userCurrent.Message);
            }
               
            if(keeperId.IsEmpty() && !currentGatekeeper.IsEmpty() && outOfOfficeCurrentGk.IsEmpty()){
                try{
                    for(user currentUser:[SELECT id FROM user WHERE Id IN: currentGatekeeper]){                 
                        for(sample__c obj2 : aNewList){ 
                            obj2.GateKeeper__c = currentUser.Id;
                            obj2.OutOfOffice__c = false;
                            sampleList.add(obj2);
                        }
                    } 

                }
                catch(DMLException e){
                    System.Debug('Error in assign owner '+ e);
                } 
            }
           
            if(keeperId.IsEmpty() && !currentGatekeeper.IsEmpty() && !outOfOfficeCurrentGk.IsEmpty()){
                try{
                   for(user currentUser:[SELECT id FROM user WHERE Id IN: currentGatekeeper]){                 
                        for(sample__c obj2 : aNewList){ 
                            obj2.GateKeeper__c = currentUser.Id;
                            obj2.OutOfOffice__c = true;
                            sampleList.add(obj2);
                        }
                    }  
                }
                catch(DMLException e){
                    System.Debug('Error in assign owner '+ e);
                } 
            }       
                                        
            if(!outOfOfficeGatekeeper.IsEmpty()){
                    
                for(User userBack: [SELECT Id, BackupSample__c
                                        FROM User WHERE Id IN: keeperId]){
                        
                    //outOfOfficeBackup.add(userBack.outOfOfficeMessage);
                    userBackup.add(userBack.BackupSample__c);                
                }
                
                for(OutOfOffice userBackOutOfOffice: [SELECT StartDate, Enddate, IsEnabled, Message
                                               FROM OutOfOffice 
                                               WHERE UserId IN: userBackup
                                               AND StartDate <=: date1                                                                      
                                               AND EndDate >=: date1                                    
                                              ]){
                    outOfOfficeBackup.add(userBackOutOfOffice.Message);                 
                }
                    
                if(!outOfOfficeGatekeeper.IsEmpty() && outOfOfficeBackup.IsEmpty()){
                    try{
                        for(user currentUser:[SELECT id FROM user WHERE Id IN: userBackup]){
                            for(sample__c obj2 : aNewList){ 
                                obj2.GateKeeper__c = currentUser.Id;
                                obj2.OutOfOffice__c = false;
                                sampleList.add(obj2);
                            }
                        } 

                    }
                    catch(DMLException e){
                        System.Debug('Error in assign owner '+ e);
                    }
                }
                if(!outOfOfficeGatekeeper.IsEmpty() && userBackup.contains(null)){
                    try{
                        system.debug('test8' + keeperId); 
                        for(user userGatekeeper:[SELECT id FROM user WHERE Id IN: keeperId]){
                            for(sample__c obj2 : aNewList){ 
                                obj2.GateKeeper__c = userGatekeeper.Id;
                                obj2.OutOfOffice__c = true;
                                sampleList.add(obj2);
                            }
                        }

                    }
                    catch(DMLException e){
                        System.Debug('Error in assign owner '+ e);
                    }
                }
                   
                if(!outOfOfficeGatekeeper.IsEmpty() && !outOfOfficeBackup.IsEmpty()){  
                    try{
                        for(user currentUser:[SELECT id FROM user WHERE Id IN: userBackup]){
                            for(sample__c obj2 : aNewList){ 
                                obj2.GateKeeper__c = currentUser.Id;
                                obj2.OutOfOffice__c = true;
                                sampleList.add(obj2);
                            }
                        }

                    }
                    catch(DMLException e){
                        System.Debug('Error in assign owner '+ e);
                    }
                }                                                          
               
            }
            else{
                try{
                    for(user userGatekeeper:[SELECT id FROM user WHERE Id IN: keeperId]){
                        for(sample__c obj2 : aNewList){ 
                            obj2.GateKeeper__c = userGatekeeper.Id;
                            obj2.OutOfOffice__c = false;
                            sampleList.add(obj2);
                        }
                    }

                }
                catch(DMLException e){
                    System.Debug('Error in assign owner '+ e);
                }
            }
        }   
    
    if(usersPlant == 0){   
        system.debug('Allplants');
        
        for(GatekeeperAssignment__c gate2 : [SELECT Gatekeeper__c 
                                            FROM GatekeeperAssignment__c 
                                            WHERE AllPlants__c =: true
                                            AND Object__c =:Label.CL00040
                                            ORDER BY Id DESC]){
                                                  
            keeperId.add(gate2.gatekeeper__c);
        }
    
        for(OutOfOffice userGate :[SELECT StartDate, EndDate, IsEnabled, Message
                                    FROM OutOfOffice
                                    WHERE UserId IN: keeperId
                                    AND StartDate <=: date1                                                                     
                                    AND EndDate >=: date1                                   
                                      ]){
                                       
            outOfOfficeGatekeeper.add(userGate.Message);
        }
                   
        for(OutOfOffice userCurrent :[SELECT StartDate, Enddate, IsEnabled, Message
                                       FROM OutOfOffice 
                                       WHERE UserId IN: currentGatekeeper
                                       AND StartDate <=: date1                                                                      
                                       AND EndDate >=: date1                                    
                                      ]){
                                          
            outOfOfficeCurrentGk.add(userCurrent.Message);
        }
          
        if(keeperId.IsEmpty() && !currentGatekeeper.IsEmpty() && outOfOfficeCurrentGk.IsEmpty()){
            try{
                for(user currentUser:[SELECT id FROM user WHERE Id IN: currentGatekeeper]){                 
                    for(sample__c obj2 : aNewList){ 
                        obj2.GateKeeper__c = currentUser.Id;
                        obj2.OutOfOffice__c = false;
                        sampleList.add(obj2);
                    }
                }

            }
            catch(DMLException e){
                    System.Debug('Error in assign owner '+ e);
           } 
        }
        if(keeperId.IsEmpty() && !currentGatekeeper.IsEmpty() && !outOfOfficeCurrentGk.IsEmpty()){
            try{
                for(user currentUser:[SELECT id FROM user WHERE Id IN: currentGatekeeper]){                 
                    for(sample__c obj2 : aNewList){ 
                        obj2.GateKeeper__c = currentUser.Id;
                        obj2.OutOfOffice__c = true;
                        sampleList.add(obj2);
                    }
                }

            }
            catch(DMLException e){
                System.Debug('Error in assign owner '+ e);
                } 
            }                 
                                        
        if(!outOfOfficeGatekeeper.IsEmpty()){
                    
            for(User userBack: [SELECT Id, BackupSample__c
                                        FROM User WHERE Id IN: keeperId]){
                        
                    //outOfOfficeBackup.add(userBack.outOfOfficeMessage);
                userBackup.add(userBack.BackupSample__c);                       
            }           
                
            for(OutOfOffice userBackOutOfOffice: [SELECT StartDate, Enddate, IsEnabled, Message
                                                   FROM OutOfOffice 
                                                   WHERE UserId IN: userBackup
                                                   AND StartDate <=: date1                                                                      
                                                   AND EndDate >=: date1                                    
                                                   ]){
                            
                outOfOfficeBackup.add(userBackOutOfOffice.Message);                 
            }
                        
            if(!outOfOfficeGatekeeper.IsEmpty() && outOfOfficeBackup.IsEmpty()){
                try{
                    for(user currentUser:[SELECT id FROM user WHERE Id IN: userBackup]){
                        for(sample__c obj2 : aNewList){ 
                            obj2.GateKeeper__c = currentUser.Id;
                            obj2.OutOfOffice__c = false;
                            sampleList.add(obj2);
                        }
                    }

                }
                catch(DMLException e){
                    System.Debug('Error in assign owner '+ e);
                }
            } 
            if(!outOfOfficeGatekeeper.IsEmpty() && !outOfOfficeBackup.IsEmpty()){  
                system.debug('outOfOfficeBackup' + outOfOfficeBackup);
                system.debug('outOfOfficeGatekeeper' + outOfOfficeGatekeeper);
                try{
                    for(user currentUser:[SELECT id FROM user WHERE Id IN: userBackup]){
                        for(sample__c obj2 : aNewList){ 
                            obj2.GateKeeper__c = currentUser.Id;
                            obj2.OutOfOffice__c = true;
                            sampleList.add(obj2);
                        }
                    }
     
                }
                catch(DMLException e){
                    System.Debug('Error in assign owner '+ e);
                }
            }
            if(!outOfOfficeGatekeeper.isEmpty() && userBackup.contains(null)){
                try{
                    for(user userGatekeeper:[SELECT id FROM user WHERE Id IN: keeperId]){
                        for(sample__c obj2 : aNewList){ 
                            obj2.GateKeeper__c = userGatekeeper.Id;
                            obj2.OutOfOffice__c = true;
                            sampleList.add(obj2);
                        }
                    }

                }
                catch(DMLException e){
                    System.Debug('Error in assign owner '+ e);
                }
            }                   
                                                 
        }
        else{
            try{
                for(user userGatekeeper:[SELECT id FROM user WHERE Id IN: keeperId]){
                    for(sample__c obj2 : aNewList){ 
                        obj2.GateKeeper__c = userGatekeeper.Id;
                        obj2.OutOfOffice__c = false;
                        sampleList.add(obj2);
                    }
                }

            }
            catch(DMLException e){
                System.Debug('Error in assign owner '+ e);
            }
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
    public static void createSampleTeam(List<Sample__c> aNewList){
        Set<String> plantSample = new Set<String>();
        Set<Id> gatekeeper2Set = new Set<Id>();
        Set<Id> gatekeeper3Set = new Set<Id>();
        Set<Id> gatekeeper4Set = new Set<Id>();
        Set<Id> recordId = new Set<Id>();
        Map<Id,GatekeeperAssignment__c> gatekeeperMap = new Map<Id,GatekeeperAssignment__c>();
        Map<Id, SampleTeam__c> insertSampleTeamMap2 = new Map<id, SampleTeam__c>();
        Map<Id, SampleTeam__c> insertSampleTeamMap3 = new Map<id, SampleTeam__c>();
        Map<Id, SampleTeam__c> insertSampleTeamMap4 = new Map<id, SampleTeam__c>();
        Map<Id, Sample__Share> insertSampleShare2 = new Map<id, Sample__Share>();
        Map<Id, Sample__Share> insertSampleShare3 = new Map<id, Sample__Share>();
        Map<Id, Sample__Share> insertSampleShare4 = new Map<id, Sample__Share>();
        SampleTeam__c sampleNewTeam2;
        SampleTeam__c sampleNewTeam3;
        SampleTeam__c sampleNewTeam4;
        Sample__Share sampleShare2;
        Sample__Share sampleShare3;
        Sample__Share sampleShare4;
        Integer usersPlant;
        
        for(Sample__c obj : aNewList){
            plantSample.add(obj.DispatchSiteLookup__c); 
            system.debug('DispatchSiteLookup is '+obj.DispatchSiteLookup__c);
            
        }       
        usersPlant = [SELECT COUNT()
                      FROM GatekeeperAssignment__c                                                                         
                      WHERE Imerys_Site_Dispatch__c IN: plantSample
                      AND AllPlants__c =: false
                      AND Object__c =: Label.CL00040];
        system.debug('Plant Sample is' +plantSample );
        system.debug('UserPlant is' +usersPlant );
        
        if(plantSample !=Null && !plantSample.Contains(Label.CL00043)){   
            for(GatekeeperAssignment__c gate : [SELECT Gatekeeper__c, Gatekeeper2__c, Gatekeeper3__c, Gatekeeper4__c
                                                FROM GatekeeperAssignment__c 
                                                WHERE Imerys_Site_Dispatch__c IN: plantSample
                                                AND AllPlants__c =: false
                                                AND Object__c =: Label.CL00040
                                                ORDER BY Id DESC]){                                             
                                                    gatekeeperMap.put(gate.GateKeeper__c, gate);
                                                    gatekeeper2Set.add(gate.Gatekeeper2__c);
                                                    gatekeeper3Set.add(gate.Gatekeeper3__c);
                                                    gatekeeper4Set.add(gate.Gatekeeper4__c);
                                                    recordId.add(gate.Id);
                                                }
        }            
        
        if(usersPlant == 0){   
            system.debug('0 records');
            for(GatekeeperAssignment__c gate2 : [SELECT Gatekeeper__c, Gatekeeper2__c, Gatekeeper3__c, Gatekeeper4__c
                                                 FROM GatekeeperAssignment__c 
                                                 WHERE AllPlants__c =: true
                                                 AND Object__c =:Label.CL00040
                                                 ORDER BY Id DESC]){
                                                     
                                                     gatekeeperMap.put(gate2.GateKeeper__c, gate2);
                                                     gatekeeper2Set.add(gate2.Gatekeeper2__c);
                                                     gatekeeper3Set.add(gate2.Gatekeeper3__c);
                                                     gatekeeper4Set.add(gate2.Gatekeeper4__c);
                                                     recordId.add(gate2.Id);
                                                 }                                     
        }
        
        for(Sample__c objSampleTeam: aNewList){
            if(gatekeeperMap.containsKey(objSampleTeam.Gatekeeper__c)){
                system.debug(' records and GK Present');
                if(gatekeeperMap.size() > 0 && !gatekeeper2Set.contains(null)){              
                    sampleNewTeam2 = new SampleTeam__c();
                    sampleNewTeam2.Member__c = gatekeeperMap.get(objSampleTeam.Gatekeeper__c).Gatekeeper2__c;
                    sampleNewTeam2.Role__c =   Label.CL00070;
                    sampleNewTeam2.Access__c =   Label.CL00071;
                    sampleNewTeam2.Sample__c = objSampleTeam.Id;
                    insertSampleTeamMap2.put(sampleNewTeam2.Id, sampleNewTeam2);
                    
                    sampleShare2 =  new Sample__Share();
                    sampleShare2.ParentId = objSampleTeam.Id;               
                    sampleShare2.UserOrGroupId = gatekeeperMap.get(objSampleTeam.Gatekeeper__c).Gatekeeper2__c;         
                    // Set the access level
                    sampleShare2.AccessLevel = 'edit'; 
                    insertSampleShare2.put(sampleShare2.Id,sampleShare2);
                    system.debug('Share created for GK2');
                    
                }
                if(gatekeeperMap.size() > 0 && !gatekeeper3Set.contains(null)){              
                    sampleNewTeam3 = new SampleTeam__c();
                    sampleNewTeam3.Member__c = gatekeeperMap.get(objSampleTeam.Gatekeeper__c).Gatekeeper3__c;
                    sampleNewTeam3.Role__c =   Label.CL00070;
                    sampleNewTeam3.Access__c =   Label.CL00071;             
                    sampleNewTeam3.Sample__c = objSampleTeam.Id;
                    insertSampleTeamMap3.put(sampleNewTeam3.Id, sampleNewTeam3);
                    
                    sampleShare3 =  new Sample__Share();
                    sampleShare3.ParentId = objSampleTeam.Id;               
                    sampleShare3.UserOrGroupId = gatekeeperMap.get(objSampleTeam.Gatekeeper__c).Gatekeeper3__c;          
                    // Set the access level
                    sampleShare3.AccessLevel =  Label.CL00071; 
                    insertSampleShare3.put(sampleShare3.Id,sampleShare3);   
                }
                if(gatekeeperMap.size() > 0 && !gatekeeper4Set.contains(null)){              
                    sampleNewTeam4 = new SampleTeam__c();
                    sampleNewTeam4.Member__c = gatekeeperMap.get(objSampleTeam.Gatekeeper__c).Gatekeeper4__c;
                    sampleNewTeam4.Role__c =   Label.CL00070;
                    sampleNewTeam4.Access__c =   Label.CL00071;     
                    sampleNewTeam4.Sample__c = objSampleTeam.Id;
                    insertSampleTeamMap4.put(sampleNewTeam4.Id, sampleNewTeam4);
                    
                    sampleShare4 =  new Sample__Share();
                    sampleShare4.ParentId = objSampleTeam.Id;               
                    sampleShare4.UserOrGroupId = gatekeeperMap.get(objSampleTeam.Gatekeeper__c).Gatekeeper4__c;          
                    // Set the access level
                    sampleShare4.AccessLevel =  Label.CL00071; 
                    insertSampleShare4.put(sampleShare4.Id,sampleShare4);   
                }
            }
            if(!gatekeeperMap.containsKey(objSampleTeam.Gatekeeper__c)){
                for(GatekeeperAssignment__c gateAssign:[SELECT Gatekeeper__c, Gatekeeper2__c, Gatekeeper3__c, Gatekeeper4__c
                                                        FROM GatekeeperAssignment__c WHERE Gatekeeper__c IN: gatekeeperMap.KeySet()
                                                        AND Object__c =: Label.CL00040
                                                        AND Id IN: recordId]){
                                                            
                                                            if(gateAssign.Gatekeeper2__c!= null){
                                                                sampleNewTeam2 = new SampleTeam__c();
                                                                sampleNewTeam2.Member__c = gateAssign.Gatekeeper2__c;
                                                                sampleNewTeam2.Role__c =   Label.CL00070;
                                                                sampleNewTeam2.Access__c =   Label.CL00071;
                                                                sampleNewTeam2.Sample__c = objSampleTeam.Id;
                                                                insertSampleTeamMap2.put(sampleNewTeam2.Id, sampleNewTeam2);
                                                                
                                                                sampleShare2 =  new Sample__Share();
                                                                sampleShare2.ParentId = objSampleTeam.Id;               
                                                                sampleShare2.UserOrGroupId = gateAssign.Gatekeeper2__c;         
                                                                // Set the access level
                                                                sampleShare2.AccessLevel = 'edit'; 
                                                                insertSampleShare2.put(sampleShare2.Id,sampleShare2);   
                                                            }
                                                            if(gateAssign.Gatekeeper3__c!= null){
                                                                sampleNewTeam3 = new SampleTeam__c();
                                                                sampleNewTeam3.Member__c = gateAssign.Gatekeeper3__c;
                                                                sampleNewTeam3.Role__c =   Label.CL00070;
                                                                sampleNewTeam3.Access__c =   Label.CL00071;             
                                                                sampleNewTeam3.Sample__c = objSampleTeam.Id;
                                                                insertSampleTeamMap3.put(sampleNewTeam3.Id, sampleNewTeam3);
                                                                
                                                                sampleShare3 =  new Sample__Share();
                                                                sampleShare3.ParentId = objSampleTeam.Id;               
                                                                sampleShare3.UserOrGroupId = gateAssign.Gatekeeper3__c;          
                                                                // Set the access level
                                                                sampleShare3.AccessLevel =  Label.CL00071; 
                                                                insertSampleShare3.put(sampleShare3.Id,sampleShare3);   
                                                            }
                                                            if(gateAssign.Gatekeeper4__c!= null){
                                                                sampleNewTeam4 = new SampleTeam__c();
                                                                sampleNewTeam4.Member__c = gateAssign.Gatekeeper4__c;
                                                                sampleNewTeam4.Role__c =   Label.CL00070;
                                                                sampleNewTeam4.Access__c =   Label.CL00071;     
                                                                sampleNewTeam4.Sample__c = objSampleTeam.Id;
                                                                insertSampleTeamMap4.put(sampleNewTeam4.Id, sampleNewTeam4);
                                                                
                                                                sampleShare4 =  new Sample__Share();
                                                                sampleShare4.ParentId = objSampleTeam.Id;               
                                                                sampleShare4.UserOrGroupId = gateAssign.Gatekeeper4__c;          
                                                                // Set the access level
                                                                sampleShare4.AccessLevel =  Label.CL00071; 
                                                                insertSampleShare4.put(sampleShare4.Id,sampleShare4);   
                                                            }
                                                        }
            }       
            
        }
        try{
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
        }
        catch(DMLException e){
            System.Debug('Error in assign owner '+ e);
        }   
        
    }
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 18/10/2017
*@Date modification 30/4/2018
*@param aNewList to pass update records.                      
*@return
*/  
    public static void updateSampleTeam(List<Sample__c> aNewList, List<Sample__c> aOldList){
        Set<String> plantSample = new Set<String>();
        Set<Id> gatekeeperNewSet = new Set<Id>();
        Set<Id> recordIdSet = new Set<Id>();
        Set<Id> gatekeeperOldSet = new Set<Id>();
        Set<Id> gatekeeper2Set = new Set<Id>();
        Set<Id> gatekeeper3Set = new Set<Id>();
        Set<Id> gatekeeper4Set = new Set<Id>();
        Set<String> productOld = new Set<String>();
        Set<String> productNew = new Set<String>();
        Set<String> dispatchOld = new Set<String>();
        Map<Id,GatekeeperAssignment__c> gatekeeperMap = new Map<Id,GatekeeperAssignment__c>();
        Map<Id, SampleTeam__c> insertSampleTeamMap2 = new Map<id, SampleTeam__c>();
        Map<Id, SampleTeam__c> insertSampleTeamMap3 = new Map<id, SampleTeam__c>();
        Map<Id, SampleTeam__c> insertSampleTeamMap4 = new Map<id, SampleTeam__c>();
        Map<Id, Sample__Share> insertSampleShare2 = new Map<id, Sample__Share>();
        Map<Id, Sample__Share> insertSampleShare3 = new Map<id, Sample__Share>();
        Map<Id, Sample__Share> insertSampleShare4 = new Map<id, Sample__Share>();
        SampleTeam__c sampleNewTeam2;
        SampleTeam__c sampleNewTeam3;
        SampleTeam__c sampleNewTeam4;
        Sample__Share sampleShare2;
        Sample__Share sampleShare3;
        Sample__Share sampleShare4;
        Integer usersPlant;
        Set<Id> recordId = new Set<Id>();
        
        for(sample__c objOld : aOldList){
            dispatchOld.add(objOld.DispatchSiteLookup__c); 
            productOld.add(objOld.ProductName__c);
            gatekeeperOldSet.add(objOld.GateKeeper__c);
            recordIdSet.add(objOld.Id);
            
        }
        
        for(Sample__c obj : aNewList){
            
            plantSample.add(obj.DispatchSiteLookup__c);
            productNew.add(obj.ProductName__c);
            gatekeeperNewSet.add(obj.GateKeeper__c);
            
        }
        usersPlant = [SELECT COUNT()
                      FROM GatekeeperAssignment__c                                                                         
                      WHERE Imerys_Site_Dispatch__c IN: plantSample
                      AND AllPlants__c =: false
                      AND Object__c =:Label.CL00040]; 
        
        
        if(gatekeeperNewSet!=gatekeeperOldSet){
            
            try{
                
                delete [select Id, UserOrGroupId FROM Sample__Share 
                        WHERE ParentId IN:recordIdSet
                        AND RowCause != 'Owner'
                        AND Rowcause = 'Manual'];
                
                delete [select Id, Member__c FROM SampleTeam__c WHERE Sample__c IN:recordIdSet];
                
            }catch(DMLException e){
                system.Debug('Error in updateShareTeam' + e);
            }   
        }                
        
        if (plantSample !=null && dispatchOld!=plantSample && !plantSample.Contains(Label.CL00043) && usersPlant!=0 ||
            plantSample !=null && productOld!=productNew && !plantSample.Contains(Label.CL00043) && usersPlant!=0){   
                
                for(GatekeeperAssignment__c gate : [SELECT Gatekeeper__c, Gatekeeper2__c, Gatekeeper3__c, Gatekeeper4__c  
                                                    FROM GatekeeperAssignment__c
                                                    WHERE Imerys_Site_Dispatch__c IN: plantSample
                                                    AND AllPlants__c =: false
                                                    AND Object__c =:Label.CL00040
                                                    ORDER BY Id DESC]){                                             
                                                        
                                                        gatekeeperMap.put(gate.GateKeeper__c, gate);
                                                        gatekeeper2Set.add(gate.Gatekeeper2__c);
                                                        gatekeeper3Set.add(gate.Gatekeeper3__c);
                                                        gatekeeper4Set.add(gate.Gatekeeper4__c);
                                                        recordId.add(gate.Id);
                                                    }
            }                            
        if(usersPlant == 0 && productOld!=productNew){   
            
            for(GatekeeperAssignment__c gate2 : [SELECT Gatekeeper__c, Gatekeeper2__c, Gatekeeper3__c, Gatekeeper4__c 
                                                 FROM GatekeeperAssignment__c 
                                                 WHERE AllPlants__c =: true
                                                 AND Object__c =: Label.CL00040
                                                 ORDER BY Id DESC]){
                                                     
                                                     gatekeeperMap.put(gate2.GateKeeper__c, gate2);
                                                     gatekeeper2Set.add(gate2.Gatekeeper2__c);
                                                     gatekeeper3Set.add(gate2.Gatekeeper3__c);
                                                     gatekeeper4Set.add(gate2.Gatekeeper4__c);
                                                     recordId.add(gate2.Id);
                                                 }                                     
        }
        
        for(Sample__c objSampleTeam: aNewList){
            if(gatekeeperMap.containsKey(objSampleTeam.Gatekeeper__c)){ 
                if(gatekeeperMap.size() > 0 && !gatekeeper2Set.contains(null)){              
                    sampleNewTeam2 = new SampleTeam__c();
                    sampleNewTeam2.Member__c = gatekeeperMap.get(objSampleTeam.Gatekeeper__c).Gatekeeper2__c;
                    sampleNewTeam2.Role__c =   Label.CL00070;
                    sampleNewTeam2.Access__c =   Label.CL00071;     
                    sampleNewTeam2.Sample__c = objSampleTeam.Id;
                    insertSampleTeamMap2.put(sampleNewTeam2.Id, sampleNewTeam2);
                    
                    sampleShare2 =  new Sample__Share();
                    sampleShare2.ParentId = objSampleTeam.Id;               
                    sampleShare2.UserOrGroupId = gatekeeperMap.get(objSampleTeam.Gatekeeper__c).Gatekeeper2__c;         
                    // Set the access level
                    sampleShare2.AccessLevel = 'edit'; 
                    insertSampleShare2.put(sampleShare2.Id,sampleShare2);                   
                }
                if(gatekeeperMap.size() > 0 && !gatekeeper3Set.contains(null)){              
                    sampleNewTeam3 = new SampleTeam__c();
                    sampleNewTeam3.Member__c = gatekeeperMap.get(objSampleTeam.Gatekeeper__c).Gatekeeper3__c;
                    sampleNewTeam3.Role__c =   Label.CL00070;
                    sampleNewTeam3.Access__c =   Label.CL00071;     
                    sampleNewTeam3.Sample__c = objSampleTeam.Id;
                    insertSampleTeamMap3.put(sampleNewTeam3.Id, sampleNewTeam3);
                    
                    sampleShare3 =  new Sample__Share();
                    sampleShare3.ParentId = objSampleTeam.Id;               
                    sampleShare3.UserOrGroupId = gatekeeperMap.get(objSampleTeam.Gatekeeper__c).Gatekeeper3__c;          
                    // Set the access level
                    sampleShare3.AccessLevel =  Label.CL00071; 
                    insertSampleShare3.put(sampleShare3.Id,sampleShare3);   
                }
                if(gatekeeperMap.size() > 0 && !gatekeeper4Set.contains(null)){              
                    sampleNewTeam4 = new SampleTeam__c();
                    sampleNewTeam4.Member__c = gatekeeperMap.get(objSampleTeam.Gatekeeper__c).Gatekeeper4__c;
                    sampleNewTeam4.Role__c =   Label.CL00070;
                    sampleNewTeam4.Access__c =   Label.CL00071;     
                    sampleNewTeam4.Sample__c = objSampleTeam.Id;
                    insertSampleTeamMap4.put(sampleNewTeam4.Id, sampleNewTeam4);
                    
                    sampleShare4 =  new Sample__Share();
                    sampleShare4.ParentId = objSampleTeam.Id;               
                    sampleShare4.UserOrGroupId = gatekeeperMap.get(objSampleTeam.Gatekeeper__c).Gatekeeper4__c;          
                    // Set the access level
                    sampleShare4.AccessLevel =  Label.CL00071; 
                    insertSampleShare4.put(sampleShare4.Id,sampleShare4);   
                }
            }
            if(!gatekeeperMap.containsKey(objSampleTeam.Gatekeeper__c)){
                for(GatekeeperAssignment__c gateAssign:[SELECT Gatekeeper__c, Gatekeeper2__c, Gatekeeper3__c, Gatekeeper4__c
                                                        FROM GatekeeperAssignment__c WHERE Gatekeeper__c IN: gatekeeperMap.KeySet()
                                                        AND Object__c =: Label.CL00040
                                                        AND Id IN: recordId]){
                                                            
                                                            if(gateAssign.Gatekeeper2__c!= null){
                                                                sampleNewTeam2 = new SampleTeam__c();
                                                                sampleNewTeam2.Member__c = gateAssign.Gatekeeper2__c;
                                                                sampleNewTeam2.Role__c =   Label.CL00070;
                                                                sampleNewTeam2.Access__c =   Label.CL00071;
                                                                sampleNewTeam2.Sample__c = objSampleTeam.Id;
                                                                insertSampleTeamMap2.put(sampleNewTeam2.Id, sampleNewTeam2);
                                                                
                                                                sampleShare2 =  new Sample__Share();
                                                                sampleShare2.ParentId = objSampleTeam.Id;               
                                                                sampleShare2.UserOrGroupId = gateAssign.Gatekeeper2__c;         
                                                                // Set the access level
                                                                sampleShare2.AccessLevel = 'edit'; 
                                                                insertSampleShare2.put(sampleShare2.Id,sampleShare2);   
                                                            }
                                                            if(gateAssign.Gatekeeper3__c!= null){
                                                                sampleNewTeam3 = new SampleTeam__c();
                                                                sampleNewTeam3.Member__c = gateAssign.Gatekeeper3__c;
                                                                sampleNewTeam3.Role__c =   Label.CL00070;
                                                                sampleNewTeam3.Access__c =   Label.CL00071;             
                                                                sampleNewTeam3.Sample__c = objSampleTeam.Id;
                                                                insertSampleTeamMap3.put(sampleNewTeam3.Id, sampleNewTeam3);
                                                                
                                                                sampleShare3 =  new Sample__Share();
                                                                sampleShare3.ParentId = objSampleTeam.Id;               
                                                                sampleShare3.UserOrGroupId = gateAssign.Gatekeeper3__c;          
                                                                // Set the access level
                                                                sampleShare3.AccessLevel =  Label.CL00071; 
                                                                insertSampleShare3.put(sampleShare3.Id,sampleShare3);   
                                                            }
                                                            if(gateAssign.Gatekeeper4__c!= null){
                                                                sampleNewTeam4 = new SampleTeam__c();
                                                                sampleNewTeam4.Member__c = gateAssign.Gatekeeper4__c;
                                                                sampleNewTeam4.Role__c =   Label.CL00070;
                                                                sampleNewTeam4.Access__c =   Label.CL00071;     
                                                                sampleNewTeam4.Sample__c = objSampleTeam.Id;
                                                                insertSampleTeamMap4.put(sampleNewTeam4.Id, sampleNewTeam4);
                                                                
                                                                sampleShare4 =  new Sample__Share();
                                                                sampleShare4.ParentId = objSampleTeam.Id;               
                                                                sampleShare4.UserOrGroupId = gateAssign.Gatekeeper4__c;          
                                                                // Set the access level
                                                                sampleShare4.AccessLevel =  Label.CL00071; 
                                                                insertSampleShare4.put(sampleShare4.Id,sampleShare4);   
                                                            }
                                                        }
            }
        }
        try{
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
            
        }
        catch(DMLException e){
            System.Debug('Error in assign owner '+ e);
        }
    }       
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 10/12/2017
*@Date modification 30/4/2018
*@param aNewList to pass update records.                      
*@return 
*/  
    public static void updateSampleGateKeeper(List<Sample__c> aNewList, List<Sample__c> aOldList) {
    Set<String> businessArea = new Set<String>();
    Set<String> businessAreaOld = new Set<String>();
    Set<String> plantSample = new Set<String>();
    Set<String> dispatchOld = new Set<String>();
    Set<Id> OwnerIdSet = new Set<Id>();
    Set<Id> KeeperId = new Set<Id>();
    Set<Id> userBackup = new Set<Id>();
    Set<String> outOfOfficeGatekeeper = new Set<String>();
    Set<String> outOfOfficeBackup = new Set<String>();
    Set<String> outOfOfficeCurrentGk = new Set<String>();
    Set<String> outOfOfficeCurrent = new Set<String>();
    List<Sample__c> sampleList = New list <Sample__c>();
    Set<String> currentGK = new Set<String>();
    Set<String> currentGatekeeper = new Set<String>();
    Set<String> productOld = new Set<String>();
    Set<String> productNew = new Set<String>();
    Integer usersPlant;
    Integer usersAllPlants;
    DateTime date1 = Date.today();
    
    for(sample__c objOld : aOldList){
        dispatchOld.add(objOld.DispatchSiteLookup__c); 
        productOld.add(objOld.ProductName__c);
    }
    
    for(Sample__c obj : aNewList){
        //If (obj.Division__c != null){
        //businessArea.add(obj.BusinessArea__c);
        //}
        //else{
            //businessArea.add(obj.RelatedDivision__c);
        //}
        plantSample.add(obj.DispatchSiteLookup__c);
        ownerIdSet.add(obj.OwnerId); 
        currentGatekeeper.add(obj.GateKeeper__c);
        productNew.add(obj.ProductName__c);     
        
    }
    
    if (plantSample !=null && dispatchOld!=plantSample && !plantSample.Contains(Label.CL00043)  ||
        plantSample !=null && productOld!=productNew && !plantSample.Contains(Label.CL00043)){   
       
         for(GatekeeperAssignment__c gate : [SELECT Gatekeeper__c 
                                                  FROM GatekeeperAssignment__c 
                                                  WHERE Imerys_Site_Dispatch__c IN: plantSample
                                                  AND AllPlants__c =: false
                                                  AND Object__c =:Label.CL00040
                                                  ORDER BY Id DESC]){                                             
                keeperId.add(gate.GateKeeper__c);
            }
            
            usersPlant = [SELECT COUNT()
                            FROM GatekeeperAssignment__c                                                                         
                            WHERE Imerys_Site_Dispatch__c IN: plantSample
                            AND AllPlants__c =: false
                            AND Object__c =: 'Sample']; 
                                   
            
            if(usersPlant > 0){         
                for(OutOfOffice userGate :[SELECT StartDate, EndDate, IsEnabled, Message
                                    FROM OutOfOffice
                                    WHERE UserId IN: keeperId                                   
                                    AND StartDate <=: date1                                                                      
                                    AND EndDate >=: date1                                    
                                    ]){
                                       
                        outOfOfficeGatekeeper.add(userGate.Message);
                }
            }                   
                for(OutOfOffice userCurrent :[SELECT StartDate, Enddate, IsEnabled, Message
                                       FROM OutOfOffice WHERE UserId IN: currentGatekeeper
                                       AND StartDate <=: date1                                                                      
                                       AND EndDate >=: date1                                    
                                      ]){
                                       
                        outOfOfficeCurrentGk.add(userCurrent.Message);
                }
               
            if(keeperId.IsEmpty() && !currentGatekeeper.IsEmpty() && outOfOfficeCurrentGk.IsEmpty()){
                try{
                    for(user currentUser:[SELECT id FROM user WHERE Id IN: currentGatekeeper]){                 
                        for(sample__c obj2 : aNewList){ 
                            obj2.GateKeeper__c = currentUser.Id;
                            obj2.OutOfOffice__c = false;
                            sampleList.add(obj2);
                        }
                    }

                }
                catch(DMLException e){
                    System.Debug('Error in assign owner '+ e);
                } 
            }
           
            if(keeperId.IsEmpty() && !currentGatekeeper.IsEmpty() && !outOfOfficeCurrentGk.IsEmpty()){
                try{
                    for(user currentUser:[SELECT id FROM user WHERE Id IN: currentGatekeeper]){                 
                        for(sample__c obj2 : aNewList){ 
                            obj2.GateKeeper__c = currentUser.Id;
                            obj2.OutOfOffice__c = true;
                            sampleList.add(obj2);
                        }
                    }  
                }
                catch(DMLException e){
                    System.Debug('Error in assign owner '+ e);
                } 
            }       
                                        
            if(!outOfOfficeGatekeeper.IsEmpty()){
                    
                for(User userBack: [SELECT Id, BackupSample__c
                                        FROM User WHERE Id IN: keeperId]){
                        
                    //outOfOfficeBackup.add(userBack.outOfOfficeMessage);
                    userBackup.add(userBack.BackupSample__c);                
                }
                
                for(OutOfOffice userBackOutOfOffice: [SELECT StartDate, Enddate, IsEnabled, Message
                                               FROM OutOfOffice 
                                               WHERE UserId IN: userBackup
                                               AND StartDate <=: date1                                                                      
                                               AND EndDate >=: date1                                    
                                              ]){
                    outOfOfficeBackup.add(userBackOutOfOffice.Message);                  
                }
                    
                if(!outOfOfficeGatekeeper.IsEmpty() && outOfOfficeBackup.IsEmpty()){
                    try{
                        for(user currentUser:[SELECT id FROM user WHERE Id IN: userBackup]){
                            for(sample__c obj2 : aNewList){ 
                                obj2.GateKeeper__c = currentUser.Id;
                                obj2.OutOfOffice__c = false;
                                sampleList.add(obj2);
                            }
                        } 

                    }
                    catch(DMLException e){
                        System.Debug('Error in assign owner '+ e);
                    }
                }
                if(!outOfOfficeGatekeeper.IsEmpty() && userBackup.contains(null)){
                    try{
                        system.debug('test8' + keeperId); 
                        for(user userGatekeeper:[SELECT id FROM user WHERE Id IN: keeperId]){
                            for(sample__c obj2 : aNewList){ 
                                obj2.GateKeeper__c = userGatekeeper.Id;
                                obj2.OutOfOffice__c = true;
                                sampleList.add(obj2);
                            }
                        }

                    }
                    catch(DMLException e){
                        System.Debug('Error in assign owner '+ e);
                    }
                }
                   
                if(!outOfOfficeGatekeeper.IsEmpty() && !outOfOfficeBackup.IsEmpty()){  
                    try{
                        for(user currentUser:[SELECT id FROM user WHERE Id IN: userBackup]){
                            for(sample__c obj2 : aNewList){ 
                                obj2.GateKeeper__c = currentUser.Id;
                                obj2.OutOfOffice__c = true;
                                sampleList.add(obj2);
                            }
                        }

                    }
                    catch(DMLException e){
                        System.Debug('Error in assign owner '+ e);
                    }
                }                                                          
               
            }
            else{
                try{
                    for(user userGatekeeper:[SELECT id FROM user WHERE Id IN: keeperId]){
                        for(sample__c obj2 : aNewList){ 
                            obj2.GateKeeper__c = userGatekeeper.Id;
                            obj2.OutOfOffice__c = false;
                            sampleList.add(obj2);
                        }
                    }

                }
                catch(DMLException e){
                    System.Debug('Error in assign owner '+ e);
                }
            }
        }   
    if(usersPlant == 0 && productOld!=productNew){   
        system.debug('Allplants');
        for(GatekeeperAssignment__c gate2 : [SELECT Gatekeeper__c 
                                              FROM GatekeeperAssignment__c 
                                              WHERE AllPlants__c =: true
                                              AND Object__c =: Label.CL00040
                                              ORDER BY Id DESC]){
                                                  
            keeperId.add(gate2.gatekeeper__c);
        }
    
            for(OutOfOffice userGate :[SELECT StartDate, EndDate, IsEnabled, Message
                                    FROM OutOfOffice
                                    WHERE UserId IN: keeperId
                                    AND StartDate <=: date1                                                                     
                                    AND EndDate >=: date1                                   
                                      ]){
                                       
                        outOfOfficeGatekeeper.add(userGate.Message);
                }
                   
                for(OutOfOffice userCurrent :[SELECT StartDate, Enddate, IsEnabled, Message
                                       FROM OutOfOffice 
                                       WHERE UserId IN: currentGatekeeper
                                       AND StartDate <=: date1                                                                      
                                       AND EndDate >=: date1                                    
                                      ]){
                                          
                        outOfOfficeCurrentGk.add(userCurrent.Message);
                }
                
            if(keeperId.IsEmpty() && !currentGatekeeper.IsEmpty() && outOfOfficeCurrentGk.IsEmpty()){
                try{
                    for(user currentUser:[SELECT id FROM user WHERE Id IN: currentGatekeeper]){                 
                        for(sample__c obj2 : aNewList){ 
                            obj2.GateKeeper__c = currentUser.Id;
                            obj2.OutOfOffice__c = false;
                            sampleList.add(obj2);
                        }
                    }

                }
                catch(DMLException e){
                    System.Debug('Error in assign owner '+ e);
                } 
            }
            if(keeperId.IsEmpty() && !currentGatekeeper.IsEmpty() && !outOfOfficeCurrentGk.IsEmpty()){
                try{
                    for(user currentUser:[SELECT id FROM user WHERE Id IN: currentGatekeeper]){                 
                        for(sample__c obj2 : aNewList){ 
                            obj2.GateKeeper__c = currentUser.Id;
                            obj2.OutOfOffice__c = true;
                            sampleList.add(obj2);
                        }
                    }

                }
                catch(DMLException e){
                    System.Debug('Error in assign owner '+ e);
                } 
            }                 
                                        
            if(!outOfOfficeGatekeeper.IsEmpty()){
                    
                for(User userBack: [SELECT Id, BackupSample__c
                                        FROM User WHERE Id IN: keeperId]){
                        
                    //outOfOfficeBackup.add(userBack.outOfOfficeMessage);
                    userBackup.add(userBack.BackupSample__c);   
                                       
                }           
                
                for(OutOfOffice userBackOutOfOffice: [SELECT StartDate, Enddate, IsEnabled, Message
                                               FROM OutOfOffice 
                                               WHERE UserId IN: userBackup
                                               AND StartDate <=: date1                                                                      
                                               AND EndDate >=: date1                                    
                                               ]){
                        
                    outOfOfficeBackup.add(userBackOutOfOffice.Message); 
                              
                }
                    
                if(!outOfOfficeGatekeeper.IsEmpty() && outOfOfficeBackup.IsEmpty()){
                    try{
                        for(user currentUser:[SELECT id FROM user WHERE Id IN: userBackup]){
                            for(sample__c obj2 : aNewList){ 
                                obj2.GateKeeper__c = currentUser.Id;
                                obj2.OutOfOffice__c = false;
                                sampleList.add(obj2);
                            }
                        }

                    }
                    catch(DMLException e){
                        System.Debug('Error in assign owner '+ e);
                    }
                }               
                if(!outOfOfficeGatekeeper.IsEmpty() && !outOfOfficeBackup.IsEmpty()){  
                    system.debug('outOfOfficeBackup' + outOfOfficeBackup);
                    system.debug('outOfOfficeGatekeeper' + outOfOfficeGatekeeper);
                    try{
                        for(user currentUser:[SELECT id FROM user WHERE Id IN: userBackup]){
                            for(sample__c obj2 : aNewList){ 
                                obj2.GateKeeper__c = currentUser.Id;
                                obj2.OutOfOffice__c = true;
                                sampleList.add(obj2);
                            }
                        }

                    }
                    catch(DMLException e){
                        System.Debug('Error in assign owner '+ e);
                    }
                }
                if(!outOfOfficeGatekeeper.isEmpty() && userBackup.contains(null)){
                    try{
                        for(user userGatekeeper:[SELECT id FROM user WHERE Id IN: keeperId]){
                            for(sample__c obj2 : aNewList){ 
                                obj2.GateKeeper__c = userGatekeeper.Id;
                                obj2.OutOfOffice__c = true;
                                sampleList.add(obj2);
                            }
                        }
                    }
                    catch(DMLException e){
                        System.Debug('Error in assign owner '+ e);
                    }
                }                   
                                             
            }
        else{
            try{
                for(user userGatekeeper:[SELECT id FROM user WHERE Id IN: keeperId]){
                    for(sample__c obj2 : aNewList){ 
                        obj2.GateKeeper__c = userGatekeeper.Id;
                        obj2.OutOfOffice__c = false;
                        sampleList.add(obj2);
                    }
                }

            }
            catch(DMLException e){
                System.Debug('Error in assign owner '+ e);
            }
        }       
    }
    for(OutOfOffice userCurrent :[SELECT StartDate, Enddate, IsEnabled, Message
                                       FROM OutOfOffice WHERE UserId IN: currentGatekeeper
                                       AND StartDate <=: date1                                                                      
                                       AND EndDate >=: date1                                    
                                      ]){
                                       
        outOfOfficeCurrent.add(userCurrent.Message);
   }
   if(!outOfOfficeCurrent.IsEmpty()){                      
        try{
            for(user currentUser:[SELECT id FROM user WHERE Id IN: currentGatekeeper]){
                for(sample__c obj2 : aNewList){ 
                    obj2.OutOfOffice__c = true;
                    sampleList.add(obj2);
                }
           } 
        }
        catch(DMLException e){
            System.Debug('Error in assign owner '+ e);
        }
    }
    else{
        try{
            for(user currentUser:[SELECT id FROM user WHERE Id IN: currentGatekeeper]){
                for(sample__c obj2 : aNewList){ 
                    obj2.OutOfOffice__c = false;
                    sampleList.add(obj2);
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
*@Date Creation 17/10/2017
*@Date modification
*@param aNewList to insert new record.
*@ExcptionName                   
*@return.
*/  
    public static void createSampleShare(List<Sample__c> aNewList) {      
        Set<id> csAccountManager = new set<id>();
        Id currentUserId = userinfo.getUserId();
        List<Sample__Share> sampShrsGatekeeper  = new List<Sample__Share>();
        Map<id,Sample__Share> sampMapGatekeeper = new Map<id,Sample__Share>();
        
        if(!aNewList.isEmpty()){
            // Create a new list of sharing objects for sample
            List<Sample__Share> sampleShrs  = new List<Sample__Share>();       
            // Declare variables for sample sharing
            Sample__Share sampleShr;            
            // Instantiate the sharing objects             
            
            for(Sample__c sam : aNewList){
                
                sampleShr = new sample__Share(); 
                
                csAccountManager.add(sam.CSAccountManager__c);             
                if(sam.CSAccountManager__c!= null){   
                    sampleShr.ParentId = sam.Id;
                    
                    sampleShr.UserOrGroupId = sam.CSAccountManager__c;          
                    // Set the access level
                    sampleShr.AccessLevel = 'edit';           
                    // Add objects to list for insert               
                    sampleShrs.add(sampleShr);
                }
            }         
            if(csAccountManager!=null && !csAccountManager.contains(currentUserId)){ 
                try{
                    Database.SaveResult[] lsr = Database.insert(sampleShrs,True);
                }
                catch(DMLException e){
                    System.Debug('Error in createShare '+ e);
                }
            }
            
            sample__Share sampleShrGate;  
            
            for(Sample__c sampGatekeeper : aNewList){
                
                sampleShrGate = new Sample__Share();
                
                if(sampGatekeeper.GateKeeper__c!=null){   
                    
                    sampleShrGate.ParentId  = sampGatekeeper.Id;
                    sampleShrGate.UserOrGroupId = sampGatekeeper.GateKeeper__c;          
                    // Set the access level
                    sampleShrGate.AccessLevel = 'edit';           
                    // Add objects to list for insert               
                    sampShrsGatekeeper.add(sampleShrGate);
                }
            }
            
            sampMapGatekeeper.putall(sampShrsGatekeeper);
            
            if(sampMapGatekeeper.size() > 0){                               
                try{
                    upsert sampMapGatekeeper.values();                  
                }
                catch(DMLException e){
                    System.Debug('Error in createGatekeeper' + e);
                }                   
                
            }   
        }
    }    
    
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 10/17/2017
*@Date modification 1/25/2018
*@param aNewList to update new record.
*@ExcptionName                      
*@return 
*/  
    public static void updateSampleShare(List<Sample__c> aoldList, List<Sample__c> aNewList) {      
        set<id> recordId = new set<id>();
        set<id> groupId = new set<id>();
        set<id> csAccountManager = new set<id>();
        set<id> ownerId = new set<id>();
        set<string> statusOld = new set<string>();
        set<string> statusNew = new set<string>();
        set<id> gatekeeperNew = new set<id>();
        Set<Id> gateKeeperOld = new Set<Id>();
        id gate;
        set<id> sampleId = new set<id>();
        map<id,Sample__Share> samMapCreatedBy = new map<id,Sample__Share>();
        map<id,Sample__Share> samMapAcctMang = new map<id,Sample__Share>();
        map<id,Sample__Share> samMapDelGatekeeper = new map<id,Sample__Share>();
        map<id,Sample__Share> samMapInsGatekeeper = new map<id,Sample__Share>();
        List<Sample__Share> samShrsOwnerCreated  = new List<Sample__Share>();
        List<Sample__Share> samShrsGatekeeperList  = new List<Sample__Share>();
        
        if(!aoldList.isEmpty()){
            for(Sample__c samp: aoldList){
                recordId.add(samp.Id);
                groupId.add(samp.CSAccountManager__c);
                ownerId.add(samp.OwnerId);
                statusOld.add(samp.Status__c);
                gatekeeperOld.add(samp.GateKeeper__c);
                gate = samp.gatekeeper__c;
                sampleId.add(samp.Id);
            }
        }
        for(sample__c samUpd : aNewList){
            csAccountManager.add(samUpd.CSAccountManager__c); 
            statusNew.add(samUpd.Status__c);
            gatekeeperNew.add(samUpd.gatekeeper__c);
        }   
        // Create a new list of sharing objects for Sample
        List<Sample__Share> SampleShrs  = new List<Sample__Share>();       
        // Declare variables for sample sharing   
        
        Sample__Share[] sampleShare = [SELECT Id, UserOrGroupId, AccessLevel, 
                                       RowCause FROM Sample__share 
                                       WHERE ParentId IN : recordId 
                                       AND UserOrGroupId IN:groupId];
        
        if(ownerId!= csAccountManager && ownerId!=groupId){
            if(sampleShare.size() > 0){
                try{
                    Database.delete(sampleshare,True);
                }
                catch(DMLException e){
                    System.Debug('Error in updatesampleshare delete '+ e);
                }       
            }
        }
        Sample__share[] sampDelShareGkeeper = [SELECT Id, UserOrGroupId, AccessLevel, 
                                               RowCause FROM Sample__share WHERE ParentId IN:recordId
                                               AND UserOrGroupId IN:gateKeeperOld
                                               AND AccessLevel ='Edit'];
        
        
        if(ownerId!=gateKeeperOld && !gateKeeperOld.IsEmpty()){
            if(sampDelShareGkeeper.size() > 0 ){ 
                try{
                    Database.DeleteResult[] drListdelGateKeeper = Database.delete(sampDelShareGkeeper, true); 
                }
                catch(DMLException e){
                    System.Debug('Error in delete gat ' + e);
                }                        
            }
        }
        
        List<Sample__Share> sampleShareList = New List<Sample__Share>(); 
        
        Sample__Share sampleShr;
        sample__Share samShrOwnerCreatedRecord;
        sample__Share sampleShrGatekeeper;
        
        for(sample__c samUpd : aNewList){
            samShrOwnerCreatedRecord = new Sample__Share();  
            csAccountManager.add(samUpd.CSAccountManager__c);             
            if(samUpd.CSAccountManager__c!= null){    
                // Instantiate the sharing objects
                sampleShr = new Sample__Share();                  
                // Set the ID of record being shared
                sampleShr.ParentId = samUpd.Id;    
                // Set the ID of user or group being granted access
                sampleShr.UserOrGroupId = samUpd.CSAccountManager__c;          
                // Set the access level
                sampleShr.AccessLevel = 'edit';           
                // Add objects to list for insert             
                sampleShrs.add(sampleShr);
            }
            
            // if(OwnerId!=gatekeeperOld && gate!=null){
            // system.debug('test error');
            // sampleShrGatekeeper = new Sample__Share();                  
            // // Set the ID of record being shared
            // sampleShrGatekeeper.ParentId = samUpd.Id;    
            // // Set the ID of user or group being granted access
            // sampleShrGatekeeper.UserOrGroupId = gate;          
            // // Set the access level
            // sampleShrGatekeeper.AccessLevel = 'edit';           
            // // Add objects to list for insert             
            // samShrsGatekeeperList.add(sampleShrGatekeeper);
            // }
            samShrOwnerCreatedRecord.ParentId = samUpd.Id;
            samShrOwnerCreatedRecord.UserOrGroupId = samUpd.createdById;          
            // Set the access level
            samShrOwnerCreatedRecord.AccessLevel = 'edit';
            samShrsOwnerCreated.add(samShrOwnerCreatedRecord); 
            
        }
        sample__Share sampleShrGate;  
        
        for(Sample__c sampGatekeeper : aNewList){
            
            sampleShrGate = new Sample__Share();
            
            if(sampGatekeeper.GateKeeper__c!=null){   
                
                sampleShrGate.ParentId  = sampGatekeeper.Id;
                sampleShrGate.UserOrGroupId = sampGatekeeper.GateKeeper__c;          
                // Set the access level
                sampleShrGate.AccessLevel = 'edit';           
                // Add objects to list for insert               
                samShrsGatekeeperList.add(sampleShrGate);
            }
        }
        
        samMapInsGatekeeper.putall(samShrsGatekeeperList);
        
        if(samMapInsGatekeeper.size() > 0){                               
            try{
                upsert samMapInsGatekeeper.values();                  
            }
            catch(DMLException e){
                System.Debug('Error in createGatekeeper' + e);
            }                   
            
        }   
        
        samMapAcctMang.putall(sampleshrs);
        samMapCreatedBy.putall(samShrsOwnerCreated);
        
        if(samMapAcctMang.size()>0){            
            //if(ownerId!=csAccountManager){   
            // Insert sharing records and capture save result 
            try{
                Database.SaveResult[] lsr = Database.insert(samMapAcctMang.values(),True);
            }
            catch(DMLException e){
                System.Debug('Error in updatesampleshare insert '+ e);
            }   
            //}
        }
        if(samMapCreatedBy.size() > 0){
            try{
                upsert samMapCreatedBy.Values();
            }
            catch(DMLException e){
                System.Debug('Error in updatesampleshare upsert '+ e);
            }   
        }
        // samMapInsGatekeeper.putall(samShrsGatekeeperList);
        
        // if(samMapInsGatekeeper.size() > 0){
        // try{
        // system.debug('insert' + samMapInsGatekeeper.values());
        // Database.insert(samMapInsGatekeeper.values(), true);          
        // }
        // catch(DMLException e){
        // System.Debug('Error in updatesampleshare insert gatekeeper '+ e);
        // }
        // }
        
    }
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 10/17/2017
*@Date modification 
*@param aoldList to delete sample record.
*@ExcptionName                      
*@return 
*/  
    public static void deleteSampleShare(List<Sample__c> aDeleteList){
        Set<id> csAccountManager = new set<id>(); 
        Set<id> recordId = new set<id>();
        Set<id> ownerId = new set<id>();
        
        if(!aDeleteList.isEmpty()){
            List<Sample__Share> sampleShrs = New List<Sample__Share>(); 
            
            Sample__Share sampleShr;  
            
            for(Sample__c samDel: aDeleteList){
                csAccountManager.add(samDel.CSAccountManager__c); 
                // Instantiate the sharing objects
                recordId.add(samDel.Id); 
                ownerId.add(samDel.OwnerId);
                // Set the ID of user or group being granted access
            }
            
            if(csAccountManager!=null && ownerId!=csAccountManager){
                
                Sample__Share[] samShare = [SELECT Id, AccessLevel, UserOrGroupId FROM Sample__Share
                                            WHERE UserOrGroupId IN:csAccountManager AND AccessLevel ='Edit' AND ParentId IN: recordId];
                
                Database.DeleteResult[] drList = Database.delete(samShare, true);  
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
    public static void FillRelationship(List<Sample__c> aNewList) {
        Set<String>businessAreaSet=new set<String>();
        Set<id>accountIdSet = new set<id>();
        list<Sample__c>samList =new list<Sample__c>();
        Map<Id, Relationship__c> rels = new Map<Id, Relationship__c>();
        For(Sample__c b:aNewList){
            if(b.BusinessArea__c!=Null){
                businessAreaSet.add(b.BusinessArea__c);
            }
            if(b.RelatedDivision__c!=null){
                businessAreaSet.add(b.RelatedDivision__c);
            }               
            rels.put(b.Tech_RelationshipInformation__c, null);
            accountIdSet.add(b.AccountName__c);
            //lookup field to opportunity on bid__c
        }
        
        if(!businessAreaSet.IsEmpty()){
            list<Relationship__c>relList=[SELECT id,name, BusinessArea__c from Relationship__c 
                                          WHERE BusinessArea__c IN: businessAreaSet
                                          AND AccountName__c IN: accountIdSet LIMIT 1];                                       
            for(Relationship__c relDivName :relList){
                try{
                    for(Sample__c bd: aNewList){
                        bd.Tech_RelationshipInformation__c= relDivName.Id;
                        samList.add(bd);
                        system.debug('bd' + samList);                       
                    }
                }
                catch(DMLException e){
                    System.Debug('Error in Sample '+ e);
                }
            }
        }           
    }
    /**
*@author Pritam Yadav
*@Date Creation 18/11/2021
*@Date modification 
*@param aNewList to fill Account manager and CS and Technical support                  
*@return error message
*/
    public static void fillAccountMgrAndCs(List<Sample__c> aNewList) 
    {
        Set<id>relationshipInfoIdSet = new Set<id>();
        Set<id>accMgrIdSet = new Set<id>();
        Set<id> ownerIdSet = new set<id>();
        Set<id> customerServiceSet = new set<id>();
        set<id> TechSupportSet=new set<id>();
        
        //Get the Relationship , Account Manager and CS on sample
        For(Sample__c s:aNewList){
            
            if(s.Tech_RelationshipInformation__c != null){
                relationshipInfoIdSet.add(s.Tech_RelationshipInformation__c);
            }
            
            if(s.CSAccountManager__c != null){accMgrIdSet.add(s.CSAccountManager__c);}            
            ownerIdSet.add(s.OwnerId);
            if(s.CustomerService__c != null){ customerServiceSet.add(s.CustomerService__c);}
            if(s.TechnicalSupport__c != null){TechSupportSet.add(s.TechnicalSupport__c);}
        }    
        
        if(!relationshipInfoIdSet.isEmpty()){
            
            List<Relationship__c> relList = new List<Relationship__c>([Select name,accountManager__c,MarketSegmentation__c,NewMarketL1__c,NewMarketL2__c
                                                                       from relationship__c 
                                                                       where id IN: relationshipInfoIdSet  ]);
            
            //Fill Account Manager
            //Idea : If user does not fill Account Manager, take Account Manager from relationship.
            //If user fill Account Manager, do nothing.
            if(accMgrIdSet.isEmpty()){
                for(Sample__c s : aNewList){
                    s.CSAccountManager__c = relList[0].accountManager__c;
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
                for(Sample__c s:aNewList){
                    s.CustomerService__c = custServiceOwner[0].id;
                }
            }
        }
        //If customer Service field is filled, we don't do anything
        // If customer service is not filled, we check if the Owner is of type Customer Service & Sales Administration, if true we auto fill the CS with owner, otherwise we leave blank.
        if(TechSupportSet.isEmpty()){
            
            //CL00090 - Customer Technical Support
            List<User> CustTechSup = new List<User>([Select id from User where id IN: ownerIdSet and Job_Department__c =: Label.CL00090 ]);
            system.debug('custServiceOwner-->'+CustTechSup);
            
            if(CustTechSup.size() > 0){
                for(Sample__c s:aNewList){
                    s.TechnicalSupport__c = CustTechSup[0].id;
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
    public static void UpdateRelationship(List<Sample__c> aNewList) {
        Set<String>businessAreaSet=new set<String>();
        Set<id>accountIdSet = new set<id>();
        list<Sample__c>samList =new list<Sample__c>();
        Map<Id, Relationship__c> rels = new Map<Id, Relationship__c>();
        for(Sample__c b:aNewList){
            if(b.BusinessArea__c!=Null){
                businessAreaSet.add(b.BusinessArea__c);
            }
            //if(b.RelatedDivision__c!=null){
            //businessAreaSet.add(b.RelatedDivision__c);
            //}               
            rels.put(b.Tech_RelationshipInformation__c, null);
            accountIdSet.add(b.AccountName__c);
            //lookup field to opportunity on bid__c
        }
        
        if(!businessAreaSet.IsEmpty()){
            list<Relationship__c>relList=[SELECT id,name, BusinessArea__c from Relationship__c 
                                          WHERE BusinessArea__c IN: businessAreaSet
                                          AND AccountName__c IN: accountIdSet LIMIT 1]; 
            if(relList.size() == 0){                            
                try{
                    for(Sample__c bd: aNewList){
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
                        for(Sample__c bd: aNewList){
                            bd.Tech_RelationshipInformation__c= relDivName.Id;
                            samList.add(bd);
                            system.debug('bd' + samList);                       
                        }
                    }
                    catch(DMLException e){
                        System.Debug('Error in Sample '+ e);
                    }
                }
            }
        }           
    }       
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 2/8/2018
*@Date modification 
*@param aNewList to grant edit access for approver.                      
*@return error message
*/  
    @future
    public static void sampleApproverShr(set<String> aNewList) {
        Set<Boolean>approvedSet=new set<Boolean>();
        Set<String>statusSet = new set<String>();
        Set<Id>sampleIdSet = new set<Id>();
        set<Id>processIdSet = new set<Id>();
        set<Id>userSet = new set<Id>();
        List<Sample__c> samNewList = new List<Sample__c>();
        List<Sample__c> samAppList = New List<Sample__c>(); 
        List <Sample__Share> samShrsTeamList  =  new List<Sample__Share>();
        sample__Share sampleShrTeam; 
        
        for(Sample__c samp : [select Id, Tech_ApprovalAccess__c from Sample__c where id in: aNewList]){
            samNewList.add(samp);
        }
        
        for(Sample__c sam:samNewList){
            approvedSet.add(sam.Tech_ApprovalAccess__c);
            sampleIdSet.add(sam.Id);
        }
        system.debug('approverAccess' + approvedSet );
        if(approvedSet.contains(true)){
            
            for(ProcessInstance ins: [SELECT Id, TargetObject.Name, TargetObjectID, TargetObject.Type
                                      FROM ProcessInstance  
                                      WHERE Status = 'Pending' 
                                      AND IsDeleted = False
                                      AND TargetObjectID IN: sampleIdSet]){
                                          processIdSet.add(ins.Id);
                                          
                                      }
            system.debug('process' + processIdSet);
            
            for(ProcessInstanceWorkitem wrkItems:[SELECT Id, Actor.email, Actor.Id FROM ProcessInstanceWorkitem
                                                  WHERE ProcessInstanceId IN: processIdSet
                                                 ]){ 
                                                     //statusSet.add(ins.Status);
                                                     userSet.add(wrkItems.ActorId);
                                                 }                                                           
            List<Sample__Share> sampleApproveList = New List<Sample__Share>(); 
            
            Sample__Share sampleApproverShr;
            for(User us:[SELECT Id FROM User WHERE Id IN: userSet]){            
                for(sample__c samApp : samNewList){            
                    if(!userSet.IsEmpty()){     
                        // Instantiate the sharing objects
                        sampleApproverShr = new Sample__Share();                  
                        // Set the ID of record being shared
                        sampleApproverShr.ParentId = samApp.Id;    
                        // Set the ID of user or group being granted access
                        sampleApproverShr.UserOrGroupId = us.Id;          
                        // Set the access level
                        sampleApproverShr.AccessLevel = 'edit';           
                        // Add objects to list for insert             
                        sampleApproveList.add(sampleApproverShr);
                        
                        samApp.Tech_ApproverName__c = us.Id;
                        //samApp.ByPassPB98__c = true;
                        samAppList.add(samApp);
                    } 
                }   
            }
            if(sampleApproveList.size() > 0){
                try{
                    system.debug('approve' + sampleApproveList);
                    Database.insert(sampleApproveList, true);          
                }
                catch(DMLException e){
                    System.Debug('Error in updatesampleshare approver '+ e);
                }
            }
            if(samAppList.size() > 0){
                if(triggerhandler.runOnce())
                {
                    try{
                        Database.update(samAppList, true);          
                    }
                    catch(DMLException e){
                        system.Debug('Error in updatesampleshare'+ e);
                    }
                }
            }       
            
        }
        Map<Id,SampleTeam__c> samTeamShare = new Map<Id, SampleTeam__c>([SELECT Id, Access__c, Member__c, Sample__c   
                                                                         FROM SampleTeam__c 
                                                                         WHERE Sample__c IN:sampleIdSet]);
        for(SampleTeam__c shr: samTeamShare.values()){
            
            for(sample__c samApp : samNewList){  
                
                sampleShrTeam = new Sample__Share();
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
            catch(DMLException e){
                system.Debug('Error in updateShareTeam' + e);
            }                   
            
        }   
    }   
    /**
*@author Jaunbocus Muhammad Irshaad
*@Date Creation 26/10/2021              
*@Date modification 
*@param aNewList to fill relationship.                      
*@return error message
*/  
    public static void fillMarketSegment(List<Sample__c> aNewList) {
        Set<id>relationshipInfoIdSet = new Set<id>();
        Set<id>marketSegmentationIdSet = new set<id>();
        
        //Get the Relationship , Market Segmentation on the Sample
        For(Sample__c b:aNewList){
            
            if(b.Tech_RelationshipInformation__c != null){
                relationshipInfoIdSet.add(b.Tech_RelationshipInformation__c);
            }
            
            if(b.MarketSegmentation__c != null){ marketSegmentationIdSet.add(b.MarketSegmentation__c);}
            
        }
        
        if(!relationshipInfoIdSet.isEmpty()){
            
            List<Relationship__c> relList = new List<Relationship__c>([Select name,accountManager__c,MarketSegmentation__c,NewMarketL1__c,NewMarketL2__c
                                                                       from relationship__c 
                                                                       where id IN: relationshipInfoIdSet  ]);
            
            
            
            //Fill market segmentation
            //Idea : If user does not fill Market segmentation, take Market segmentation from relationship.
            //If user fill market segmentation, do nothing.
            if(marketSegmentationIdSet.isEmpty()){
                for(Sample__c c : aNewList){
                    c.MarketSegmentation__c = relList[0].MarketSegmentation__c;
                    c.NewMarketL1__c = relList[0].NewMarketL1__c;
                    c.NewMarketL2__c = relList[0].NewMarketL2__c;
                }
            }
            
            
        }
    }
    
    
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 10/17/2017
*@Date modification
*@param
*@ExcptionName                  
*@return method createSampleGatekeeper with new values.
*/  
    public override void BeforeInsert() {
        //Override method BeforeInsert from class Handler to create new sample record.
        FillRelationship(Trigger.new);
        fillMarketSegment(Trigger.new);
        createSampleGatekeeper(Trigger.new);
        fillAccountMgrAndCs(trigger.new);//method to populate Account manager and Customer Service user for sample//modified to populate technical support user
    }   
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 10/17/2017
*@Date modification
*@param
*@ExcptionName                  
*@return method createSampleShare with new values.
*/  
    public override void AfterInsert() {
        //Override method BeforeInsert from class Handler to create new sample record.
        createSampleShare(Trigger.new);
        createSampleTeam(trigger.new); 
    }
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 10/17/2017
*@Date modification
*@param
*@ExcptionName                  
*@return method createSampleShare with new values.
*/  
    public override void beforeUpdate() {
        //Override method BeforeInsert from class Handler to create new sample record.
        updateSampleGateKeeper(Trigger.new, Trigger.old);
        UpdateRelationship(Trigger.new);
        
        Set<string> sampId = new Set<string> (); 
        
        for (Sample__c samp : [Select Id from Sample__c 
                               where Id in :Trigger.newMap.keyset()]) { 
                                   sampId.add(samp.id); 
                               }      
        
    }   
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 10/17/2017
*@Date modification 
*@param
*@ExcptionName                  
*@return method updateSampleShare with new values.
*/  
    public override void AfterUpdate(){
        //Override method BeforeUpdate from class Handler to update sample record.
        updateSampleShare(Trigger.old, Trigger.new);
        Set<string> sampIds = new Set<string> (); 
        
        for (Sample__c samp : [Select Id from Sample__c 
                               where Id in :Trigger.newMap.keyset()]) { 
                                   sampIds.add(samp.id); 
                               }
        if(System.IsBatch() == false && System.isFuture() == false){ 
            
            sampleApproverShr(sampIds);
            
        }
        updateSampleTeam(trigger.new, trigger.old);     
    } 
    /**
*@author Geerutsing Govind Kumar
*@Date Creation 10/17/2017
*@Date modification 10/17/2017
*@param
*@ExcptionName                  
*@return method deleteSampleShare with old values.
*/      
    public override void AfterDelete() {
        //Override method AfterDelete from class Handler.
        deleteSampleShare(Trigger.old);
    }      
}