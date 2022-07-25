({
    doInit : function(component, event, helper) {
        var recordId=  component.get("v.recordId");
        var action = component.get("c.getDuplicatesCases");
        action.setParams({ "caseId": recordId});
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                if(response.getReturnValue().length===0){
                    component.set("v.isEmptyCases", true);
                }
                component.set("v.cases", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }
})