@istest
public class testPublishLogs {

    @istest
    public static void testmmethod()
    {
        /*integer value1=10;
        integer value2=1;
        try {
            value1<value2
        } catch(testPublishLogs me) {
            System.debug('Message: ' + me.getMessage());    
            System.debug('Cause: ' + me.getCause());    
            System.debug('Line number: ' + me.getLineNumber());    
            System.debug('Stack trace: ' + me.getStackTraceString());    
        }*/
         
 test.startTest();
        
LogManagement.start('ClassName', 'MethodName');
LogManagement.addquery('query', 10);
LogManagement.addDML('insert', 'objectname',10);
LogManagement.debug('debug');
LogManagement.addError('information');
LogManagement.end('ClassName', 'MethodName');
LogManagement.createLog('ClassName', 'MethodName');         
 test.stopTest();
    }
}