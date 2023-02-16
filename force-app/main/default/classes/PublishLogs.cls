global class PublishLogs {
    
    static List<string> tracelogmanagement =new List<string>();
    static integer stack=0;
    static string status='Success';
    static datetime starttime=null;
    public static void start(string ClassName,string MethodName)
    {
        starttime=system.now();     
        string starttimetostring=string.valueOfGmt(starttime);
        string logtracecurrenttime='[' + starttimetostring + ']';
        string logtraceentry='[entry]';
        stack=stack+1;
        string converstacktostring=string.valueOf(stack);
        string logtracestack='[stack :' + converstacktostring + ']';
        string classandmethod='ClassName :' + ClassName +'-' + 'MethodName :' +  MethodName;
        string totalstring=logtracecurrenttime + '|' + logtraceentry + '|' + logtracestack + classandmethod;
        tracelogmanagement.add(totalstring);         
    }
    
    public static void debug(string information)
    {
        datetime currenttime=system.now();  
        string starttimetostring=string.valueOfGmt(currenttime);
        string logtracecurrenttime='[' + starttimetostring + ']';
        string logtraceinfo='[info]';
        string totalstring= logtracecurrenttime + '|' + logtraceinfo + '|' + information;
        tracelogmanagement.add(totalstring);
    }
    
    public static void addquery(string query,integer noofrecords)
    {
        datetime currenttime=system.now();  
        string starttimetostring=string.valueOfGmt(currenttime);
        string logtracecurrenttime='[' + starttimetostring + ']';
        string logtracequery='[query]';
        string convernoofrecordstostring=string.valueOf(noofrecords);
        string totalstring= logtracecurrenttime + '|' + logtracequery + '|' + query + convernoofrecordstostring ;
        tracelogmanagement.add(totalstring);
    }
    
    public static void addDML(string DMLtype,string objectname,integer noofrecords)
    {
        datetime currenttime=system.now();  
        string starttimetostring=string.valueOfGmt(currenttime);
        string logtracecurrenttime='[' + starttimetostring + ']';
        string logtracedml='[DML]';
        string convernoofrecordstostring=string.valueOf(noofrecords);
        string totalstring= logtracecurrenttime + '|' + logtracedml + '|' + DMLtype + objectname + convernoofrecordstostring ;
        tracelogmanagement.add(totalstring);
    }
    
    public static void addError(string information)
    {
        datetime currenttime=system.now();  
        string starttimetostring=string.valueOfGmt(currenttime);
        string logtracecurrenttime='[' + starttimetostring + ']';
        string logtraceerror='[Error]';
        string totalstring= logtracecurrenttime + '|' + logtraceerror + '|' + information;
        tracelogmanagement.add(totalstring);
        status='Failure';
    }
    
   public static void end(string ClassName,string MethodName)
    {
        datetime currenttime=system.now();  
        string starttimetostring=string.valueOfGmt(currenttime);
        string logtracecurrenttime='[' + starttimetostring + ']';
        string logtraceerror='[Exit]'; 
        string converstacktostring=string.valueOf(stack);
        string logtracestack='[stack :' + converstacktostring + ']';
        string classandmethod='ClassName :' + ClassName +'-' + 'MethodName :' +  MethodName;
        string totalstring=logtracecurrenttime + '|' + logtraceerror + '|' + logtracestack + classandmethod;
        tracelogmanagement.add(totalstring);
        stack=stack-1;
    }
    
    public static void createLog(String ClassName, String MethodName)
    {
       
        Platform_Log__e instanceofplatformevent=new Platform_Log__e();
        datetime endtime=system.now();
        long duration=endtime.getTime()-starttime.getTime(); //get time in milliseconds
        instanceofplatformevent.Duration__c=duration;
        instanceofplatformevent.Class_Name__c=ClassName;
        instanceofplatformevent.Method_Name__c=MethodName;
        string totalquerylimit=string.valueOf(Limits.getLimitQueries());
        string totalqueryused=string.valueOf(Limits.getQueries());
        string querylimit='SOQL Queries :' + totalqueryused + '/' + totalquerylimit;
        string totaldmlrowslimit=string.valueOf(Limits.getLimitDMLRows());
        string totaldmlrowsused=string.valueOf(Limits.getDMLRows());
        string rowslimit= 'DML rows :' + totaldmlrowsused +'/' + totaldmlrowslimit;
        string totaldmlstatementslimit=string.valueOf(Limits.getLimitDMLStatements());
        string totaldmlstatementsused=string.valueOf(Limits.getDMLStatements());
        string statementslimit= 'DML Statements :' + totaldmlstatementsused + '/' + totaldmlstatementslimit;
        string totalcpulimit=string.valueOf(Limits.getLimitCpuTime());
        string totalcpuusage=string.valueOf(Limits.getLimitCpuTime());
        string cpuusage='CPU usage :' + totalcpuusage + '/' + totalcpulimit;
        string totalmemorylimit=string.valueOf(Limits.getLimitHeapSize());
        string totalmemoryusage=string.valueOf(Limits.getHeapSize());
        string heapsize='Memory size :' + totalmemoryusage + '/' + totalmemorylimit;
        List<string> limitdetailslist=new List<string>{querylimit,rowslimit,statementslimit,cpuusage,heapsize};
        string printlimits=string.valueOf(limitdetailslist);
        instanceofplatformevent.Current_User__c=userinfo.getUserId();
        instanceofplatformevent.Limit_Information__c=printlimits;
        string stringtracelogmanagement=string.valueOf(tracelogmanagement);      
        instanceofplatformevent.Log_Trace__c=stringtracelogmanagement;
        instanceofplatformevent.Status__c=status;
        Quiddity q = System.Request.getCurrent().getQuiddity();
        string convertquidditytostring=string.valueOf(q);
        if(convertquidditytostring=='TRIGGER' || convertquidditytostring=='BATCH' || convertquidditytostring=='API' || convertquidditytostring=='LWC')
        {
           instanceofplatformevent.Log_Type__c=convertquidditytostring;  
        }
       
        

        eventbus.publish(instanceofplatformevent);
    }
    
     public static void createExceptionLog(String ClassName, String MethodName,Exception exceptionn)
     {
         Platform_Log__e instanceofplatformevent=new Platform_Log__e();
        datetime endtime=system.now();
        long duration=endtime.getTime()-starttime.getTime(); //get time in milliseconds
        instanceofplatformevent.Duration__c=duration;
        instanceofplatformevent.Class_Name__c=ClassName;
        instanceofplatformevent.Method_Name__c=MethodName;
        string totalquerylimit=string.valueOf(Limits.getLimitQueries());
        string totalqueryused=string.valueOf(Limits.getQueries());
        string querylimit='SOQL Queries :' + totalqueryused + '/' + totalquerylimit;
        string totaldmlrowslimit=string.valueOf(Limits.getLimitDMLRows());
        string totaldmlrowsused=string.valueOf(Limits.getDMLRows());
        string rowslimit= 'DML rows :' + totaldmlrowsused +'/' + totaldmlrowslimit;
        string totaldmlstatementslimit=string.valueOf(Limits.getLimitDMLStatements());
        string totaldmlstatementsused=string.valueOf(Limits.getDMLStatements());
        string statementslimit= 'DML Statements :' + totaldmlstatementsused + '/' + totaldmlstatementslimit;
        string totalcpulimit=string.valueOf(Limits.getLimitCpuTime());
        string totalcpuusage=string.valueOf(Limits.getLimitCpuTime());
        string cpuusage='CPU usage :' + totalcpuusage + '/' + totalcpulimit;
        string totalmemorylimit=string.valueOf(Limits.getLimitHeapSize());
        string totalmemoryusage=string.valueOf(Limits.getHeapSize());
        string heapsize='Memory size :' + totalmemoryusage + '/' + totalmemorylimit;
        List<string> limitdetailslist=new List<string>{querylimit,rowslimit,statementslimit,cpuusage,heapsize};
        string printlimits=string.valueOf(limitdetailslist);
         
        instanceofplatformevent.Limit_Information__c=printlimits;
        instanceofplatformevent.Current_User__c=userinfo.getUserId();
        string stringtracelogmanagement=string.valueOf(tracelogmanagement);      
        instanceofplatformevent.Log_Trace__c=stringtracelogmanagement;
        instanceofplatformevent.Status__c='Success';

        List<string> exceptionlist=new List<string>{exceptionn.getTypeName(),exceptionn.getMessage(),string.valueOf(exceptionn.getLineNumber())};
        string stringexceptionlist=string.valueOf(exceptionlist);
        instanceofplatformevent.Exception_Detail__c=stringexceptionlist;
        Quiddity q = System.Request.getCurrent().getQuiddity();
        string convertquidditytostring=string.valueOf(q);
        if(convertquidditytostring=='TRIGGER' || convertquidditytostring=='BATCH' || convertquidditytostring=='API' || convertquidditytostring=='LWC')
        {
           instanceofplatformevent.Log_Type__c=convertquidditytostring;  
        }
       
 
        eventbus.publish(instanceofplatformevent);
         
     }
   
    
    
        
}