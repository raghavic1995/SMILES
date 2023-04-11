trigger CaseTrigger on Case (before insert,after insert, before update, after update, after delete) {
new AP01_CaseTriggerHandler().run();
    if(trigger.isUpdate){
        new Case_AddErrorOnOwnerChange().run();
    }
}