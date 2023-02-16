/**
 * @description       : 
 * @author            : Santhosh V
 * @group             : 
 * @last modified on  : 01-09-2023
 * @last modified by  : Santhosh V
**/
public with sharing class FilterRecords {
    @AuraEnabled(cacheable=true)
    
    public static List<Contact> filteringRecords(string NameFilter,string IndustryFilter,string TypeFilter)
    {
        system.debug('Name :' + NameFilter+'  '+'Industry :' + IndustryFilter + '  '+'Type :'+ TypeFilter);
        List<contact> getFilteredRecords=new  List<contact>();
        string NameToFilter=NameFilter + '%';
        if(NameFilter!='' && IndustryFilter!='' && TypeFilter!='')
        {
       
        getFilteredRecords=[select id,firstName,Email,Department,LeadSource,Level__c,Account.Industry,Account.Type from Contact where firstName like :NameToFilter and Account.Industry=:IndustryFilter and Account.Type=:TypeFilter];
       system.debug(getFilteredRecords);
       system.debug('log');
       
       }
       else if(NameFilter!='' && IndustryFilter=='' && TypeFilter=='')
       {
       //string NameToFilter=NameFilter + '%';
       getFilteredRecords=[select id,firstName,Email,Department,LeadSource,Level__c,Account.Industry,Account.Type from Contact where firstName like :NameToFilter];
      system.debug(getFilteredRecords);
      system.debug('log');
      
      }
      else if(NameFilter=='' && IndustryFilter!='' && TypeFilter=='')
       {
       //string NameToFilter=NameFilter + '%';
       getFilteredRecords=[select id,firstName,Email,Department,LeadSource,Level__c,Account.Industry,Account.Type from Contact where Account.Industry=:IndustryFilter];
      system.debug(getFilteredRecords);
      system.debug('log');
      
      }
      else if(NameFilter=='' && IndustryFilter=='' && TypeFilter!='')
       {
       //string NameToFilter=NameFilter + '%';
       getFilteredRecords=[select id,firstName,Email,Department,LeadSource,Level__c,Account.Industry,Account.Type from Contact where Account.Type=:TypeFilter];
      system.debug(getFilteredRecords);
      system.debug('log');
      
      }
      else if(NameFilter!='' && IndustryFilter!='' && TypeFilter=='')
       {
       //string NameToFilter=NameFilter + '%';
       getFilteredRecords=[select id,firstName,Email,Department,LeadSource,Level__c,Account.Industry,Account.Type from Contact where firstName like :NameToFilter and Account.Industry=:IndustryFilter ];
      system.debug(getFilteredRecords);
      system.debug('log');
      
      }
      else if(NameFilter=='' && IndustryFilter!='' && TypeFilter!='')
       {
       //string NameToFilter=NameFilter + '%';
       getFilteredRecords=[select id,firstName,Email,Department,LeadSource,Level__c,Account.Industry,Account.Type from Contact where Account.Industry=:IndustryFilter and Account.Type=:TypeFilter];
      system.debug(getFilteredRecords);
      system.debug('log');
      
      }
      else if(NameFilter!='' && IndustryFilter=='' && TypeFilter!='')
       {
       //string NameToFilter=NameFilter + '%';
       getFilteredRecords=[select id,firstName,Email,Department,LeadSource,Level__c,Account.Industry,Account.Type from Contact where firstName like :NameToFilter and Account.Type=:TypeFilter];
      system.debug(getFilteredRecords);
      system.debug('log');
      
      }
      return getFilteredRecords;
    }
     
    

}