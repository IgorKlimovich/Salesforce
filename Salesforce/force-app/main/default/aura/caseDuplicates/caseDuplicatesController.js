({
    handleChange :function(component, event, helper){
        var options = event.getParam('value');
        var recordId=  component.get("v.recordId");
        var action = component.get("c.getDuplicatesCases");
        action.setParams({ "caseId": recordId,"options": options});
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                if(response.getReturnValue().length===0){
                    component.set("v.isEmptyCases", true);
                }
                else{
                    component.set("v.isEmptyCases", false);
                }
                component.set("v.cases", response.getReturnValue());
            }
        });
        $A.enqueueAction(action)
    }
})