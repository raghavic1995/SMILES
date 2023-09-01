({
	getParameterByName: function(component, event, name, url) {
    	var recordTypeId = component.get("v.pageReference").state.recordTypeId;
        component.set("v.selectedRecordId", recordTypeId);
        console.log(' In Helpter Record Id --->', component.get('v.selectedRecordId'));
         
        //get action name edit/new
        var actionName = component.get("v.pageReference").attributes.actionName;
        console.log('actionName-' + actionName);
         
        //get object API name
        var objectApiName = component.get("v.pageReference").attributes.objectApiName;
        console.log('objectApiName-' + objectApiName);
        
        var pageRef = component.get("v.pageReference");	       
        
        console.log(JSON.stringify(pageRef));	       
        
        var state = pageRef.state; // state holds any query params	       
        
        console.log('state = '+JSON.stringify(state));	       
        
       /* var base64Context = state.inContextOfRef;	       
        
        console.log('base64Context = '+base64Context);	       
        
        if (base64Context.startsWith("1\.")) {	          
        
            base64Context = base64Context.substring(2);	        
            
            console.log('base64Context = '+base64Context);	       
        }	   
        
        var addressableContext = JSON.parse(window.atob(base64Context));	  
        
        console.log('addressableContext = '+JSON.stringify(addressableContext));	      
        
        component.set("v.parentId", addressableContext.attributes.recordId);
        */
    }
})