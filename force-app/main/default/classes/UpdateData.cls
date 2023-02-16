/**
 * @description       : 
 * @author            : Santhosh V
 * @group             : 
 * @last modified on  : 02-06-2023
 * @last modified by  : Santhosh V
**/
public with sharing class UpdateData {
    @AuraEnabled
    public static string updateRecord(List<SObject> data)
    {
       // string success='SUCCESS';
        //string failure='FAILURE';
        //system.debug(objName);
        system.debug(data);
        system.debug('success -failure');
        
        List<Contact> ToUpdateRec=(List<Contact>) json.deserialize(json.serialize(data),List<Contact>.class);
        system.debug(ToUpdateRec);
        
        if(ToUpdateRec.size()>0)
        {
            system.debug('Entered if Condition');
            update ToUpdateRec;
            return 'success';
        }
        return 'failure';
    }
}