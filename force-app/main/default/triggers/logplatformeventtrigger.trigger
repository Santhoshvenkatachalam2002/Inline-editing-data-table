/**
 * @description       : 
 * @author            : Santhosh V
 * @group             : 
 * @last modified on  : 07-18-2022
 * @last modified by  : Santhosh V
 **/
trigger logplatformeventtrigger on Platform_Log__e(after insert) {

    List < Log__c > listOfLog = new List < Log__c > ();
    for (Platform_Log__e getrecord: Trigger.new) {
        Log__c insertlog = new Log__c();
        insertlog.Class_Name__c = getrecord.Class_Name__c;
        insertlog.Method_Name__c = getrecord.Method_Name__c;
        insertlog.Duration__c = getrecord.Duration__c;
        insertlog.Exception_Detail__c = getrecord.Exception_Detail__c;
        insertlog.Limit_Information__c = getrecord.Limit_Information__c;
        insertlog.Long_Trace__c = getrecord.Log_Trace__c;
        insertlog.Log_Created_By__c = getrecord.Current_User__c;
        insertlog.Status__c = getrecord.Status__c;
        insertlog.Log_Type__c = getrecord.Log_Type__c;
        listOfLog.add(insertlog);
    }
    insert listOfLog;
}