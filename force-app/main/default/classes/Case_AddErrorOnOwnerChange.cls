public class Case_AddErrorOnOwnerChange extends TriggerHandler {
   // @InvocableMethod(label='Case_AddErrorOnOwnerChange')
    public static void addError(List<Case> oldList, List<Case> newList){
        Id oldOwner;
        Id newOwner;
        Id caseId ;
        
        for(Case c:newList){
            newOwner=c.ownerId;
            caseId= c.id;
        }
        
        for(Case c:oldList){
            oldOwner=c.ownerId;
        }
        
        Id userid= UserInfo.getUserId();
        List<CaseShare> cs=[select id from CaseShare where CaseId =:caseId and CaseAccessLevel='Read' and UserOrGroupId =:userid];
        List<CaseShare> cs1=[select id from CaseShare where CaseId =:caseId and CaseAccessLevel='Edit' and UserOrGroupId =:userid];
        
        for(Case c:newList){
        	if(oldOwner!=newOwner){
            	if(cs.size()>0 && cs1.size()==0){
                    c.addError('Insufficient Access');
                }
            
        	}
            
        }
       
    }
    public override void beforeUpdate() { 
        addError(Trigger.old,Trigger.new);
    }   

}