trigger ValidationsOnProduct_UOM on Product_UOM__c (before insert,before update,before delete) {

  
    if(Trigger.isInsert)
    {
          ValidationsOnProduct_UOMHandler.orderWiseUomCheckInsert(Trigger.new);
          
    }
    if(Trigger.isUpdate)
   {
       
       //ValidationsOnProduct_UOMHandler.orderWiseUomCheckUpdate(Trigger.New,Trigger.oldMap);
       CompareTriggerValuesHandler.met(Trigger.New,Trigger.oldmap);

    }
    
    if(Trigger.isDelete)
    {
       ValidationsOnProduct_UOMHandler.orderWiseUomCheckDelete(Trigger.old); 
    }
    
    
}