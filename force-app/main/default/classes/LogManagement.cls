/**
 * @description       : 
 * @author            : Santhosh V
 * @group             : 
 * @last modified on  : 07-18-2022
 * @last modified by  : Santhosh V
 **/
public class LogManagement {

    static List < string > traceLogManagement = new List < string > (); //list to store logtrace
    static integer stack = 0;
    static string status = 'Success';
    static datetime startTime = null;
    static {
        startTime = system.now();
    }
    /**
     * @description - this method is used to start the logs of the method you opened
     * @author Santhosh V | 07-18-2022 
     * @param string ClassName 
     * @param string MethodName 
     **/
    public static void start(string className, string methodName) {


        string startTimetostring = string.valueOfGmt(startTime);
        string logTraceCurrentTime = '[' + startTimetostring + ']';
        string logTraceEntry = '[entry]';
        stack = stack + 1;
        string converStackToString = string.valueOf(stack);
        string logTraceStack = '[stack :' + converStackToString + ']';
        string classAndMethod = 'ClassName :' + ClassName + '-' + 'MethodName :' + MethodName;
        string totalString = logTraceCurrentTime + '|' + logTraceEntry + '|' + logTraceStack + classAndMethod;
        traceLogManagement.add(totalString);
    }

    /**
     * @description -this method is used to print debug logs in log trace field
     * @author Santhosh V | 07-18-2022 
     * @param string information 
     **/
    public static void debug(string information) {


        string logTraceCurrentTime = LogManagement.getTime();
        string logtraceinfo = '[info]';
        string totalString = logTraceCurrentTime + '|' + logtraceinfo + '|' + information;
        traceLogManagement.add(totalString);
    }

    /**
     * @description - this method is used to get the current time
     * @author Santhosh V | 07-18-2022 
     * @return String 
     **/
    public static String getTime() {
        datetime currenttime = system.now();
        string startTimetostring = string.valueOfGmt(currenttime);
        string logTraceCurrentTime = '[' + startTimetostring + ']';
        return logTraceCurrentTime;
    }

    /**
     * @description - this method is used to add query in trace log
     * @author Santhosh V | 07-18-2022 
     * @param string query 
     * @param integer noofrecords 
     **/
    public static void addquery(string query, integer noofrecords) {


        string logTraceCurrentTime = LogManagement.getTime();
        string logTraceQuery = '[query]';
        string convertNoOfRecordsToString = string.valueOf(noofrecords);
        string totalString = logTraceCurrentTime + '|' + logTraceQuery + '|' + query + convertNoOfRecordsToString;
        traceLogManagement.add(totalString);
    }

    /**
     * @description - this method is used to print or store the dml in the trace log
     * @author Santhosh V | 07-18-2022 
     * @param string DMLtype 
     * @param string objectname 
     * @param integer noofrecords 
     **/
    public static void addDML(string DMLtype, string objectname, integer noofrecords) {


        string logTraceCurrentTime = LogManagement.getTime();
        string logTraceDml = '[DML]';
        string convertNoOfRecordsToString = string.valueOf(noofrecords);
        string totalString = logTraceCurrentTime + '|' + logTraceDml + '|' + DMLtype + objectname + convertNoOfRecordsToString;
        traceLogManagement.add(totalString);
    }

    /**
     * @description - this method is used to store the error information in trace log
     * @author Santhosh V | 07-18-2022 
     * @param string information 
     **/
    public static void addError(string information) {

        string logTraceCurrentTime = LogManagement.getTime();
        string logtraceerror = '[Error]';
        string totalString = logTraceCurrentTime + '|' + logtraceerror + '|' + information;
        traceLogManagement.add(totalString);
        status = 'Failure';
    }

    /**
     * @description - this method is used to store the method which was ended in trace log
     * @author Santhosh V | 07-18-2022 
     * @param string ClassName 
     * @param string MethodName 
     **/
    public static void end(string ClassName, string MethodName) {

        string logTraceCurrentTime = LogManagement.getTime();
        string logtraceerror = '[Exit]';
        string converStackToString = string.valueOf(stack);
        string logTraceStack = '[stack :' + converStackToString + ']';
        string classAndMethod = 'ClassName :' + ClassName + '-' + 'MethodName :' + MethodName;
        string totalString = logTraceCurrentTime + '|' + logtraceerror + '|' + logTraceStack + classAndMethod;
        traceLogManagement.add(totalString);
        stack = stack - 1;
    }

    /**
     * @description - this method is used to create a successful log in the trace log
     * @author Santhosh V | 07-18-2022 
     * @param String ClassName 
     * @param String MethodName 
     **/
    public static void createLog(String ClassName, String MethodName) {

        LogManagement.createExceptionLog(ClassName, MethodName, null);
        /*Platform_Log__e instanceOfPlatformEvent=new Platform_Log__e();
        datetime endtime=system.now();
        long duration=endtime.getTime()-startTime.getTime(); //get time in milliseconds
        instanceOfPlatformEvent.Duration__c=duration;
        instanceOfPlatformEvent.Class_Name__c=ClassName;
        instanceOfPlatformEvent.Method_Name__c=MethodName;
        ;
        instanceOfPlatformEvent.Current_User__c=userinfo.getUserId();
        instanceOfPlatformEvent.Limit_Information__c=LogManagement.getlimit();   
        instanceOfPlatformEvent.Log_Trace__c=LogManagement.getTraceLog();
        instanceOfPlatformEvent.Status__c=status;
        Quiddity quiditityValue = System.Request.getCurrent().getQuiddity();
        string convertquidditytostring=string.valueOf(quiditityValue);
        if(convertquidditytostring=='TRIGGER' || convertquidditytostring=='BATCH' || convertquidditytostring=='API' || convertquidditytostring=='LWC')
        {
           instanceOfPlatformEvent.Log_Type__c=convertquidditytostring;  
        }
       
        
        // publish the log in the platform event 
        eventbus.publish(instanceOfPlatformEvent); */
    }

    public static String getLimit() {
        string totalquerylimit = string.valueOf(Limits.getLimitQueries());
        string totalqueryused = string.valueOf(Limits.getQueries());
        string querylimit = 'SOQL Queries :' + totalqueryused + '/' + totalquerylimit;
        string totaldmlrowslimit = string.valueOf(Limits.getLimitDMLRows());
        string totaldmlrowsused = string.valueOf(Limits.getDMLRows());
        string rowslimit = 'DML rows :' + totaldmlrowsused + '/' + totaldmlrowslimit;
        string totaldmlstatementslimit = string.valueOf(Limits.getLimitDMLStatements());
        string totaldmlstatementsused = string.valueOf(Limits.getDMLStatements());
        string statementslimit = 'DML Statements :' + totaldmlstatementsused + '/' + totaldmlstatementslimit;
        string totalcpulimit = string.valueOf(Limits.getLimitCpuTime());
        string totalcpuusage = string.valueOf(Limits.getLimitCpuTime());
        string cpuusage = 'CPU usage :' + totalcpuusage + '/' + totalcpulimit;
        string totalmemorylimit = string.valueOf(Limits.getLimitHeapSize());
        string totalmemoryusage = string.valueOf(Limits.getHeapSize());
        string heapsize = 'Memory size :' + totalmemoryusage + '/' + totalmemorylimit;
        //List<string> limitdetailslist=new List<string>{querylimit,rowslimit,statementslimit,cpuusage,heapsize};
        string printlimits = querylimit + '\n' + rowslimit + '\n' + statementslimit + '\n' + cpuusage + '\n' + heapsize;
        return printlimits;
    }

    public static String getTraceLog() {
        String completeTrace;
        for (string getlogTrace: traceLogManagement) {
            completeTrace += getlogTrace + '\n';
        }
        return completeTrace;
    }

    public static String getexception(Exception exceptionn) {
        string getexception = exceptionn.getTypeName() + '\n' + exceptionn.getMessage() + '\n' + string.valueOf(exceptionn.getLineNumber());
        return getexception;
    }

    /**
     * @description -this method is used to store the failured log in the trace log
     * @author Santhosh V | 07-18-2022 
     * @param String ClassName 
     * @param String MethodName 
     * @param Exception exceptionn 
     **/
    public static void createExceptionLog(String ClassName, String MethodName, Exception exceptionn) {
        Platform_Log__e instanceOfPlatformEvent = new Platform_Log__e();
        datetime endtime = system.now();
        long duration = endtime.getTime() - startTime.getTime(); //get time in milliseconds
        instanceOfPlatformEvent.Duration__c = duration;
        instanceOfPlatformEvent.Class_Name__c = ClassName;
        instanceOfPlatformEvent.Method_Name__c = MethodName;

        instanceOfPlatformEvent.Limit_Information__c = LogManagement.getlimit();
        instanceOfPlatformEvent.Current_User__c = userinfo.getUserId();
        instanceOfPlatformEvent.Log_Trace__c = LogManagement.getTraceLog();
        if (exceptionn != null) {
            instanceOfPlatformEvent.Exception_Detail__c = LogManagement.getexception(exceptionn);
            instanceOfPlatformEvent.Status__c = 'failure';
        } else {

            instanceOfPlatformEvent.Status__c = 'Success';

        }


        Quiddity q = System.Request.getCurrent().getQuiddity();
        string convertquidditytostring = string.valueOf(q);
        if (convertquidditytostring == 'TRIGGER' || convertquidditytostring == 'BATCH' || convertquidditytostring == 'API' || convertquidditytostring == 'LWC') {
            instanceOfPlatformEvent.Log_Type__c = convertquidditytostring;
        }


        eventbus.publish(instanceOfPlatformEvent);

    }




}