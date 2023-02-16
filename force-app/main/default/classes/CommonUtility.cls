/**
 * @description       : 
 * @author            : Santhosh V
 * @group             : 
 * @last modified on  : 02-06-2023
 * @last modified by  : Santhosh V
**/
public with sharing class CommonUtility {
    @AuraEnabled(cacheable=true)
    public static List<ObjectDetailsWrapper> getListOfObjDetails() {
        Map<String, SObjectType> mapOfObjs = schema.getGlobalDescribe();
        if(mapOfObjs != null && mapOfObjs.keySet() != null) {
            List<ObjectDetailsWrapper> lstOfObjWrapper 
                                    = new List<ObjectDetailsWrapper>();

            for(String key: mapOfObjs.keySet()) {
                ObjectDetailsWrapper objWrapInst 
                                        = new ObjectDetailsWrapper();
                if(mapOfObjs.get(key) != null 
                        && mapOfObjs.get(key).getDescribe() != null)
                        objWrapInst.objLabel = mapOfObjs.get(key).getDescribe().getLabel();
                        objWrapInst.objAPI = key;

                lstOfObjWrapper.add(objWrapInst);
            }

            return lstOfObjWrapper;
        }
        return null;
    }

    public class ObjectDetailsWrapper {
        @AuraEnabled
        public String objLabel;
        @AuraEnabled
        public String objAPI;
        @AuraEnabled
        public String fieldLabel;
        @AuraEnabled
        public String fieldAPI;
        @AuraEnabled
        public String fieldType;
    }

 @AuraEnabled(cacheable=true)
    public static List<string> getFieldSetName(string objName)
    {
List<string> fieldSetNames=new List<string>();
Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
Schema.DescribeSObjectResult var=schemaMap.get(objName).getDescribe();
//system.debug(var);
Map<String, Schema.FieldSet> FsMap = var.FieldSets.getMap();
for(string key:FsMap.keyset())
{
   fieldSetNames.add(key);
}
   system.debug(fieldSetNames); 
    return fieldSetNames; 
          
    }


    @AuraEnabled(cacheable=true)
    public static List<ObjectDetailsWrapper> readFieldSet(String fieldSetName, String ObjectName)
{
    if(fieldSetName !=null && objectName !=null)
    {
   // string fieldApi;
    //string fieldLabel;
    List<ObjectDetailsWrapper> lstOfObjWrapper 
    = new List<ObjectDetailsWrapper>();
   // List<string> allFieldSetFields=new List<string>(); 
    Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe(); 
    Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(ObjectName);
    Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();

    Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetName); 
    for(Schema.FieldSetMember getlabel:fieldSetObj.getFields())
    {
        ObjectDetailsWrapper objWrapInst = new ObjectDetailsWrapper(); 
                                        
        objWrapInst.fieldAPI=getLabel.getFieldPath();
        objWrapInst.fieldLabel=getLabel.getLabel();
        objWrapInst.fieldType=String.valueOf(getLabel.getType());

        lstOfObjWrapper.add(objWrapInst); 
    }
    system.debug(lstOfObjWrapper);
   return lstOfObjWrapper;
}
return null;
}

@AuraEnabled(cacheable=true)
public static List<SObject> getRecords(string objectName,List<string> fieldName,string condition)
    {
      string fieldsNamesWithComma='';
        for(integer i=0;i<fieldName.size();i++)
        {
            if(i!=fieldName.size()-1)
            {
             fieldsNamesWithComma=  fieldName[i] + ',' + fieldsNamesWithComma;
        }
            else
            {
                 fieldsNamesWithComma=  fieldsNamesWithComma + fieldName[i];
            }
        }
        system.debug(fieldsNamesWithComma);
       
        
        if(objectName.length()>0 && fieldName.size()> 0 && condition.length()>0)
        {
        system.debug('enter if');
        string recordQuery='select' + ' '  + fieldsNamesWithComma + ' ' + 'From' + ' ' + objectName + ' ' + condition ;
        system.debug(recordQuery);
        List<SObject> queryStr=Database.query(recordQuery);
        return queryStr;
    }
else{
    system.debug('enter else');
    string recordQuery='select' + ' '  + fieldsNamesWithComma + ' ' + 'From' + ' ' + objectName ;
        system.debug(recordQuery);
        List<SObject> queryStr=Database.query(recordQuery);
          return queryStr;
}

}
    @AuraEnabled
    public static string updateRecord(object objName,List<Sobject> data)
    {
          string success='SUCCESS';
        string failure='FAILURE';
        system.debug(objName);
        system.debug(data);
        system.debug('success -failure');
        
        List<Sobject> ToUpdateRec=new List<Sobject>();
        for(Sobject getData:data)
        {
            ToUpdateRec.add(getData);            
        }
        
        system.debug(ToUpdateRec);
        
        if(ToUpdateRec.size()>0)
        {
            system.debug('Entered if Condition');
            update ToUpdateRec;
            return success;
        }
        return failure;
    }
}