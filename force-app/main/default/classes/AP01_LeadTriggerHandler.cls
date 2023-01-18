public without sharing class AP01_LeadTriggerHandler extends TriggerHandler {
    /*@author sipra Sahoo
*@Date Creation 07/01/2022
*@Date modification 
*@param aNewList to fill relationship.                      
*/  
    public static void populateOwnerFromGateKeeperAssignment(List<Lead> aNewList){
        String marketSegmentLead;
        String areaLead;
        for(Lead lead : aNewList)
        {
            marketSegmentLead = lead.MarketL1__c;
            areaLead = lead.Area__c;
        }
        
        system.debug('marketSegmentLead : '+ marketSegmentLead);
        system.debug('areaLead : '+ areaLead);
        
        //Fetch gatekeepers from gatekeeperAssignment object
        // Where Market Segment L1 and Area from Lead matches Market Segment L1 and Area from GK assignment
        
        list<GatekeeperAssignment__c> leadGateKeeperAssigned=[SELECT  Gatekeeper__c,MarketSegmentL1__c,Area__c
                                                              FROM GatekeeperAssignment__c 
                                                              WHERE object__c =:label.CL00097 //Lead
                                                              AND MarketSegmentL1__c =: marketSegmentLead
                                                              AND Area__c =: areaLead
                                                              limit 1]; 
        
        system.debug('leadGateKeeperAssigned size'+leadGateKeeperAssigned.size());
        
        if(leadGateKeeperAssigned.size() > 0){
            
            for(Lead led : aNewList)
                
            {
                system.debug('Owner+++'+led.OwnerId);
                led.OwnerId= leadGateKeeperAssigned[0].Gatekeeper__c;
                system.debug('Owner+++2'+led.OwnerId);
            }
        }
    }
    
    
    /**
*@author Sipra Sahoo
*@Date Creation 07/01/2022
*@param
*/  
    public static void populateLeadTeamFromGateKeeperAssignment(List<Lead> aNewList){
        Lead_Team__c leadTeam2;
        Lead_Team__c leadTeam3;
        Lead_Team__c leadTeam4;
        Lead_Team__c leadTeam5;
        Map<Id, Lead_Team__c> insertLeadTeamMap2 = new Map<id, Lead_Team__c>();
        Map<Id, Lead_Team__c> insertLeadTeamMap3 = new Map<id, Lead_Team__c>();
        Map<Id, Lead_Team__c> insertLeadTeamMap4 = new Map<id, Lead_Team__c>();
        Map<Id, Lead_Team__c> insertLeadTeamMap5 = new Map<id, Lead_Team__c>();
        String marketSegmentLead;
        String areaLead;
        for(Lead lead : aNewList)
        {
            marketSegmentLead = lead.MarketL1__c;
            areaLead = lead.Area__c;
            
        }
        list<GatekeeperAssignment__c> leadGateKeeperAssigned=[SELECT  Gatekeeper2__c,Gatekeeper3__c,Gatekeeper4__c,Gatekeeper5__c
                                                              FROM GatekeeperAssignment__c 
                                                              WHERE object__c =:label.CL00097 //Lead
                                                              AND MarketSegmentL1__c =: marketSegmentLead
                                                              AND Area__c =: areaLead
                                                              limit 1];
        
        If(leadGateKeeperAssigned.size()>0){
            
            for(Lead lead : aNewList)
            {
                if(leadGateKeeperAssigned[0].Gatekeeper2__c != null){
                    leadTeam2 = new Lead_Team__c();
                    leadTeam2.Member__c = leadGateKeeperAssigned[0].Gatekeeper2__c;
                    leadTeam2.Lead__c = lead.Id;
                    leadTeam2.Role__c = 'Backup';
                    insertLeadTeamMap2.put(leadTeam2.Id, leadTeam2);
                }
                if(leadGateKeeperAssigned[0].Gatekeeper3__c != null){
                    leadTeam3 = new Lead_Team__c();
                    leadTeam3.Member__c = leadGateKeeperAssigned[0].Gatekeeper3__c;
                    leadTeam3.Lead__c = lead.Id;
                    leadTeam3.Role__c = 'Backup';
                    insertLeadTeamMap3.put(leadTeam3.Id, leadTeam3);
                }
                if(leadGateKeeperAssigned[0].Gatekeeper4__c != null){
                    leadTeam4 = new Lead_Team__c();
                    leadTeam4.Member__c = leadGateKeeperAssigned[0].Gatekeeper4__c;
                    leadTeam4.Lead__c = lead.Id;
                    leadTeam4.Role__c = 'Backup';
                    insertLeadTeamMap4.put(leadTeam4.Id, leadTeam4);
                }
                if(leadGateKeeperAssigned[0].Gatekeeper5__c != null){
                    leadTeam5 = new Lead_Team__c();
                    leadTeam5.Member__c = leadGateKeeperAssigned[0].Gatekeeper5__c;
                    leadTeam5.Lead__c = lead.Id;
                    leadTeam5.Role__c = 'Backup';
                    insertLeadTeamMap5.put(leadTeam5.Id, leadTeam5);
                }
            }
            
            if(insertLeadTeamMap2.size() > 0){
                Database.insert(insertLeadTeamMap2.values(), false);
            }
            
            if(insertLeadTeamMap3.size() > 0){
                Database.insert(insertLeadTeamMap3.values(), false);
            }
            
            if(insertLeadTeamMap4.size() > 0){
                Database.insert(insertLeadTeamMap4.values(), false);
            }
            
            if(insertLeadTeamMap5.size() > 0){
                Database.insert(insertLeadTeamMap5.values(), false);
            }
            
        }
        
    }
    
    public override void beforeInsert() {
        populateOwnerFromGateKeeperAssignment(Trigger.new);
        
    }
    
    public override void afterInsert() {
        populateLeadTeamFromGateKeeperAssignment(Trigger.new);
        
    }
    
}