public class ValidationsOnProduct_UOMHandler {
    
    
    public static Map<id,List<Product_UOM__c>> getRecords(List<Product_UOM__c> records)
    {
        Set<id> ProductUOMids=new Set<id>();//To Avoid Duplicate Ids
        
        for(Product_UOM__c getIds:records)
        {
            ProductUOMids.add(getIds.Product__c);
        }
        
      Map<id,List<Product_UOM__c>> sizeCheck=new Map<id,List<Product_UOM__c>>();
        
      List<Product2> getRecords=[select id,(select id,UOM_Name__c,Conversion_Factor__c,UOM_Number__c,Product__c from Product_UOM__r) from Product2 where id in:ProductUOMids];  
        
        for(Product2 getc:getRecords)
        {
            sizeCheck.put(getc.id,getc.Product_UOM__r);
        }
        return sizeCheck;
    }
    
    
    
  
        

    public static void orderWiseUomCheckInsert(List<Product_UOM__c> ProductUOMdata)
    {

        List<Product_UOM__c> insertRecords=new List<Product_UOM__c>();//After checking insert records
        
        List<Product_UOM__c> getProductUomRecord = new List<Product_UOM__c>();//store query of Product_UOM__c
        
       Map<id,List<Product_UOM__c>> sizeCheck=ValidationsOnProduct_UOMHandler.getRecords(ProductUOMdata); //get Records
        
        /*List<Product2> getRecords=[select id,(select id,UOM_Name__c,Conversion_Factor__c,UOM_Number__c,Product__c from Product_UOM__r) from Product2];  
        
        for(Product2 getc:getRecords)
        {
            sizeCheck.put(getc.id,getc.Product_UOM__r);
        }*/
        
        //sizecheck=ValidationsOnProduct_UOMHandler.getRecords(ProductUOMdata);
        
        
        for(Product_UOM__c getData:ProductUOMdata)
        { 
           //sizeCheck= ValidationsOnProduct_UOMHandler.getRecords(getData.Product__c);
            
            getProductUomRecord=sizeCheck.get(getData.Product__c);
                        
            integer size = getProductUomRecord.size();
            
            if(getData.UOM_Number__c=='UOM-1') //check for UOM-Number is 1 or not
            {
               
             //getProductUomRecord=[select id from Product_UOM__c where Product__c=:getData.Product__c];   //get Records
            //system.debug(getProductUomRecord);
             if(size==0)   //check whether size of the query is 0 or not 
            {
            insertRecords.add(getData);   //insert records in list
            }
            else
            {
               getData.addError('Sorry UOM-1 is already Present'); //throw error message if condition Fails
            }
           
        }
             else if(getdata.UOM_Number__c=='UOM-2') //check for UOM-Number is 2 or not
            {
              //integer size2 = sizeCheck.get(getData.Product__c).size();
              //getProductUomRecord=[select id,Conversion_Factor__c from Product_UOM__c where Product__c=:getData.Product__c];
                
                if(size==1)   
            {
                    if(getProductUomRecord[0].UOM_Number__c=='UOM-1')
                    {   
                
                if(getdata.Conversion_Factor__c>getProductUomRecord[0].Conversion_Factor__c)
                {
                    insertRecords.add(getData);
                }
                else
                {
                   getdata.addError('Conversion_Factor__c must be greater than UOM-1'); 
                }
            
            }
            }
                else if(size==0)
                {
                    getData.addError('Sorry first create UOM-1 for the product');
                }
            else
            {
               getData.addError('Sorry UOM-2 is Already Present for the product'); 
            }
            }
              
            
            
            else if(getdata.UOM_Number__c=='UOM-3') //check for UOM-Number is 3 or not
            {
              //integer size3= sizeCheck.get(getData.Product__c).size();
              //getProductUomRecord=[select id,Conversion_Factor__c from Product_UOM__c where Product__c=:getData.Product__c];
                
                if(size==2)   
            {
                    if(getProductUomRecord[1].UOM_Number__c=='UOM-2')
                    {
                system.debug(sizeCheck.get(getData.Product__c)[0].Conversion_Factor__c);
                system.debug(sizeCheck.get(getData.Product__c)[1].Conversion_Factor__c);
            if(getdata.Conversion_Factor__c > getProductUomRecord[1].Conversion_Factor__c) //check whether the Conversion_Factor__c is greater than UOM-1
                {
                    insertRecords.add(getData);
                }
                else
                {
                   getdata.addError('Conversion_Factor__c must be greater than UOM-2'); //throw error message if it is not greater than UOM-1
                }
            }
            }
                else if(size==0)
                {
                    getData.addError('Sorry first create UOM-1 for the product');
                }
           else if(size==1)
            {
               getData.addError('Sorry first create UOM-2 for the product'); 
            }
            else
            {
               getData.addError('Sorry UOM-3 is Already Present for the product'); 
            } 
            }
    }
        
}
    
    
    public static void orderWiseUomCheckUpdate(List<Product_UOM__c> data,Map<id,Product_UOM__c> oldMapProductUOMData)
    {
        
        
        Map<id,List<Product_UOM__c>> queriedRecords= ValidationsOnProduct_UOMHandler.getRecords(data);//get records from Backend using getRecords method
        
        List<Product_UOM__c> getPrevUOMNumberData=new List<Product_UOM__c>(); //to store previous UOM Numbered Data
        
        List<Product_UOM__c> updateProductUOM=new List<Product_UOM__c>(); //For Storing Update Records
        
          for(Product_UOM__c getData:data)
        {
               
            //queriedRecords=ValidationsOnProduct_UOMHandler.getRecords(getData.Product__c);
             integer size= queriedRecords.get(getData.Product__c).size();//get size of records under product
                 system.debug(size);
            getPrevUOMNumberData=queriedRecords.get(getData.Product__c); //get Data from Map store in list
            
             if(oldMapProductUOMData.containsKey(getData.Id)) //Check Whether id Is present or Not
             {
                 Product_UOM__c oldRecord=oldMapProductUOMData.get(getData.Id); //Get Before Updation Record
                  /*oldRecord[0].Product__c != getData.Product__c && oldRecord[0].UOM_Number__c != getData.UOM_Number__c*/ 
                if(oldRecord.Conversion_Factor__c != getData.Conversion_Factor__c)
                {
                  if(getData.UOM_Number__c=='UOM-2')
                  {
                      if(size==2)
                      {
                    if(getPrevUOMNumberData[0].UOM_Number__c=='UOM-1')
                    {
                      
                      if(getData.Conversion_Factor__c > getPrevUOMNumberData[0].Conversion_Factor__c)  //compare that updated value is greater or not
                      {
                        
                          updateProductUOM.add(getData);
                      }
                        else
                        {
                           getData.adderror('Conversion Factor value will be greater than UOM-1'); 
                        }
                    }
                      }
                      else if(size==3)
                      {
                            if(getPrevUOMNumberData[2].UOM_Number__c=='UOM-3' && getPrevUOMNumberData[0].UOM_Number__c=='UOM-1')
                    {
                      
                      if(getData.Conversion_Factor__c < getPrevUOMNumberData[2].Conversion_Factor__c && getData.Conversion_Factor__c > getPrevUOMNumberData[0].Conversion_Factor__c)  //compare that updated value is greater or not
                      {
                        
                          updateProductUOM.add(getData);
                      }
                        else
                        {
                            getData.adderror('Conversion Factor value will be less than UOM-3 and greater than UOM-2');
                        }
                      }
                  }
                       
                    }
                  
                  
                  
                    else if(getData.UOM_Number__c=='UOM-3')
                    {
                      system.debug(getPrevUOMNumberData[0].Conversion_Factor__c);
                      system.debug(getPrevUOMNumberData[1].Conversion_Factor__c);
                        if(getPrevUOMNumberData[1].UOM_Number__c=='UOM-2') //check previous conversion factor is UOM-2 or 
                        {
                      if(getData.Conversion_Factor__c > getPrevUOMNumberData[1].Conversion_Factor__c)
                      {
                          updateProductUOM.add(getData);
                      }
                      else
                      {
                          getData.adderror('Conversion Factor value Must be Greater than UOM-2');
                      }
                    }
                    }
                    
                    else if(getData.UOM_Number__c=='UOM-1')
                    {
                     //integer size= queriedRecords.get(getData.Product__c).size();                     
                       if(size==1)
                      {
                          updateProductUOM.add(getData);
                      }
                        
                      else if(size>1)
                      {
                          system.debug('entered1');
                            if(getPrevUOMNumberData[1].UOM_Number__c=='UOM-2') //check previous conversion factor is UOM-2 or 
                        {
                            system.debug('entered');
                      if(getData.Conversion_Factor__c < getPrevUOMNumberData[1].Conversion_Factor__c)
                      {
                           updateProductUOM.add(getData);
                      }
                            else
                            {
                                 getData.adderror('Conversion Factor value will be less than UOM-2');
                            }
                        }
                      }
                          
                        }
                }
             
                      
                 
            
                  if(oldRecord.Product__c != getData.Product__c && oldRecord.UOM_Number__c != getData.UOM_Number__c || oldRecord.Product__c != getData.Product__c )
                 {
                     List<Product_UOM__c> passRecordsToInsertMethod=new List<Product_UOM__c>();
                     passRecordsToInsertMethod.add(getData);
                     ValidationsOnProduct_UOMHandler.orderWiseUomCheckInsert(passRecordsToInsertMethod);
                 }
                 else if(oldRecord.UOM_Number__c != getData.UOM_Number__c)
                  {
                      
                      getData.adderror('UOM NUmber Cannot Change');
                  }
                       
        }
    }
    }
    
        
    
    
   
    public static void orderWiseUomCheckDelete(list<Product_UOM__c> getBeforeDeleteRecords)
    {
        //List<Product_UOM__c> getRecordsAfterDelete=[select id from Product_UOM__c ]; //after Delete Query
        
        List<Product_UOM__c> deletedRecord=[select id,UOM_Number__c,Product__c from Product_UOM__c where id in:getBeforeDeleteRecords]; //get deleted Record
        system.debug(deletedRecord);
        // List<Product_UOM__c> getPreviousRecordsInMap=new List<Product_UOM__c>(); //store previous UOM Numbered Records
        
          List<Product_UOM__c> storeRecordsForDelete=new List<Product_UOM__c>();  //Store Records For Delete
        
         Map<id,List<Product_UOM__c>> getRecords= ValidationsOnProduct_UOMHandler.getRecords(getBeforeDeleteRecords); //get Records
        
        for(Product_UOM__c getRecord:deletedRecord)
        {
            //getRecords=ValidationsOnProduct_UOMHandler.getRecords(getRecord.Product__c);
            
            integer size=getRecords.get(getRecord.Product__c).size(); //store Records Size
            
            if(getRecord.UOM_Number__c=='UOM-2')
            {
                system.debug('first');
                
                if(size==2)
                {
                    system.debug('delete');
                    storeRecordsForDelete.add(getRecord);

                }
                 else{
                      system.debug('error');
                       getRecord.adderror('First Delete UOM-3');
                    }
                
               /*for(Product_UOM__c checkData:getPreviousRecordsInMap) 
               {
                   system.debug('second');
                   if(checkData.UOM_Number__c !='UOM-3')
                   {
                       system.debug('final');
                       storeRecordsForDelete.add(getRecord);
                   }
                   else{
                       getRecord.adderror('First Delete UOM-3');
                    }
               }*/
            }
            else if(getRecord.UOM_Number__c=='UOM-1')
            {
                
                   if(size==1)
                   {
                     storeRecordsForDelete.add(getRecord);
                   }
                   else{
                    getRecord.adderror('First Delete UOM-2');
                    }
               }
            }
        }
        
    }