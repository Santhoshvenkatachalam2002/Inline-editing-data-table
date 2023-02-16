@istest
public class testlogplatformeventtrigger {

  @istest
    
    public static void testplatformevent()
    {
        Platform_Log__e log=new Platform_Log__e();
        log.Class_Name__c='santhosh';
        log.Method_Name__c='position';
        log.Log_Trace__c='add';
        
        Test.startTest();
        
        database.SaveResult platformeventstatus=eventbus.publish(log);
        
        Test.stopTest();
        
        system.assertEquals(true,platformeventstatus.isSuccess());
        
        if(platformeventstatus.isSuccess()==true)
        {
            Log__c insertrecord =new Log__c();
            insertrecord.Class_Name__c=log.Class_Name__c;
            insertrecord.Method_Name__c=log.Method_Name__c;
            insertrecord.Long_Trace__c=log.Log_Trace__c;
            insert insertrecord;
        }
        
    }
    
}