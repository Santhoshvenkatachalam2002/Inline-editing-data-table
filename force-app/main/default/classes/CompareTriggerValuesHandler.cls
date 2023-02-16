public class CompareTriggerValuesHandler {

    public static void met(List<Product_UOM__c> afterUpdateList,Map<id,Product_UOM__c> beforeUpdateList)
    {
        for(Product_UOM__c acc:afterUpdateList)
        {
            system.debug(acc);
            Product_UOM__c getUpdatedRecord=beforeUpdateList.get(acc.id);
            
            if(getUpdatedRecord==acc)
            {
                system.debug('Equal');
            }
            else
            {
                                system.debug(' Not Equal');

            }
        }
    }
}