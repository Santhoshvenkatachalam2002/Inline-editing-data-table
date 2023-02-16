import { wire, LightningElement,track,api} from 'lwc';
//import readFieldSet from '@salesforce/apex/CommonUtility.readFieldSet';
import getRecords from '@salesforce/apex/CommonUtility.getRecords';
import updateRecords from '@salesforce/apex/CommonUtility.updateRecord';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class DisplayRecords extends LightningElement {

    //@track fieldnames;
    @track columns=[];
    @track recorddata=[];
    @track objName;
    //@track GetFieldSetFields=[];
    @track fieldNamesforQuery=[];
    @track usercondition;
    @track draftValues=[];
    @track recordsize=5;//this is the size of the data to dispaly for each column
    @track totalPages;//this stores total pages when divided by total records/record size
    @track currentPageNumber=1;//this data comes via custom event 
    @track totalrecords;//to store data temporarily before slicing 
    @track pnDisplay=true;


/*@wire(getRecords, { fieldName:'$fieldNamesforQuery',objectName:'$objName',condition:'$usercondition' })
getRecordsFrombackend({data,error})
{
  console.log('data getted');

if(data)
{
    console.log('++entered++')
    console.log(data);
    this.totalrecords=data;
    this.totalPages = Math.ceil(data.length/this.recordsize);
    console.log("AfterMathSeil" + this.totalPages);
    this.recordSplit();
    //this.totalPageHandler();
    //this.recorddata=data;
    console.log(this.totalrecords);
       

} else if(error){
this.showtoast('error', 'error.body.message', 'error');
}
}*/

recordSplit()
{
  const start = (this.currentPageNumber-1)*this.recordsize;
  const end = this.recordsize*this.currentPageNumber;
  this.recorddata= this.totalrecords.slice(start, end);
  console.log("record After slice:" + this.recorddata);
}


PageNumberhandlerprevious(event)
{
  this.currentPageNumber=event.detail.PageNumber;
  console.log("CurentPagenumber:" + this.currentPageNumber);
  this.recordSplit();

}

PageNumberhandlerNext(event)
{
  this.currentPageNumber=event.detail.PageNumber;
  console.log("CurentPagenumber:" + this.currentPageNumber);
  this.recordSplit();

}

/*totalPageHandler()
{
  console.log("HIHIHI");
  console.log( this.totalPages);
  return this.totalPages;

}*/

    get columns()
    {
      return this.columns;
    }

    get recorddata()
    {
      return this.recorddata;
    }

    get bool()
    {
      console.log('boolboolbool');
      if(this.recorddata.length>0)
      {
        return true;
      }
      return false;
    }

    handlecleartable(event)
    {
        this.columns=[];
        this.totalPages=0;
        this.recorddata=[];
        //this.pnDisplay=false;
        //this.recorddata=[];
        //this.objName='';
        //this.usercondition='';
        //this.fieldNamesforQuery=[];
        //this.columns=[];
    }

    customeventhandler(event)
    {
      
      this.objName=event.detail.obj;
      console.log(this.objName);
      this.usercondition=event.detail.query;
      console.log(this.userquery);
      this.fieldNamesforQuery=event.detail.queryfields;
      console.log(this.fieldNamesforQuery);
      this.columns=event.detail.col;
      console.log(this.columns);
      getRecords({fieldName:this.fieldNamesforQuery,objectName:this.objName,condition:this.usercondition})
      .then(data=>{
    console.log('++entered++')
    console.log(data);
    this.totalrecords=data;
    this.totalPages = Math.ceil(data.length/this.recordsize);
    console.log("AfterMathSeil" + this.totalPages);
    this.currentPageNumber=1;
    this.recordSplit();
    //this.totalPageHandler();
    //this.recorddata=data;
    console.log(this.totalrecords);
      }).catch(error=>{
        this.showtoast('error', 'error.body.message', 'error');

      })

      /*this.fieldnames=event.detail.GetFieldSetFields;
      this.data=event.detail.recorddata;
      console.log('parent component')
      console.log(this.fieldnames);
      console.log('before loop')

      if(this.fieldnames)
      {
      for( let i of this.fieldnames)
      {
        console.log('for loop');
        console.log(i);
        this.columns=[...this.columns,{ label: i.label, fieldName: i.Api, type: i.Type }];
        //console.log(this.columns);
      }
      console.log(this.columns);
      console.log('after loop');
    }*/
  }

  handleSave(event)
  {
    console.log('Entered into save Event');
    const values=event.detail.draftValues;
    console.log(values);

    updateRecords({objName:this.objName,data:values})
    .then(data=>{
      console.log('successs');
            this.showtoast('SUCCESS', 'Record Updated Successfully', 'success');
          })
    .catch(error=>{
      console.log('error');
      this.showtoast('error', error.body.message, 'error');
  })
  }

  showtoast(title,message,state)
{
    const showtoastevent=new ShowToastEvent({
        title:title,
        message:message,
        variant:state,
    });
    this.dispatchEvent(showtoastevent);
}
    }