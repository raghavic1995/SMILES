({
init : function (component) {
// Find the component whose aura:id is "flowData"
var flow = component.find("flowData");
// In that component, start your flow. Reference the flow’s Unique Name.
flow.startFlow("Flow_New_Case");
},
    
    handleStatusChange : function (component, event) {    
    //alert('event.getParam '+event.getParam('status'));
    if(event.getParam('status') === "FINISHED") {
        $A.get("e.force:closeQuickAction").fire();
    }        
}
})