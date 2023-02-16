import { LightningElement,track,wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import GetAllMethod from '@salesforce/apex/CommonUtility.getListOfObjDetails';
import GetFieldSet from '@salesforce/apex/CommonUtility.getFieldSetName';
import readFieldSet from '@salesforce/apex/CommonUtility.readFieldSet';
import { updateRecord } from "lightning/uiRecordApi";
import ID_FIELD from "@salesforce/schema/Account.Id";
import Email_FIELD from "@salesforce/schema/Account.SLAExpirationDate__c"; 

//import getRecords from '@salesforce/apex/CommonUtility.getRecords';
export default class ShowObjectDetails extends LightningElement {

    @track objectNames=[];
    @track selectedObject;
    @track fieldSetNames=[];
    @track selectedFieldSet;
    @track userQuery='';
    @track GetFieldSetFields=[];
    @track columnsdata=[];
    //@track recorddata=[];
    @track fieldNamesforQuery=[];
    @track firstDay;
    @track lastDay;
    @track dateValue;
    @track formattedDate;
    @track datepickerInitialized=false;

    @wire(GetAllMethod)
    objects({data, error}){
        if(data){
            data.forEach(element => {
                this.objectNames=[...this.objectNames,{label:element.objLabel ,value:element.objAPI}];
            });
        } else if(error){
            this.showtoast('ERROR', error.body.message, 'error');
        }
    }
    @wire(GetFieldSet, { objName: '$selectedObject' })
    fieldssetavailable({data,error})
    {

    if(data)
    {
        console.log(data);
        data.forEach(element => {
            console.log(element);
            this.fieldSetNames=[...this.fieldSetNames,{label:element,value:element}];
            console.log(this.fieldSetNames);
        });
   } else if(error){
    this.showtoast('ERROR', error.body.message, 'error');
   }
}

@wire(readFieldSet, { fieldSetName:'$selectedFieldSet',ObjectName:'$selectedObject' })
fieldssetfields({data,error})
{

if(data)
{
    console.log('entered')
    console.log(data);
    data.forEach(element => {
        console.log('entered loop in');
        this.GetFieldSetFields=[...this.GetFieldSetFields,{label:element.fieldLabel,Api:element.fieldAPI,Type:element.fieldType}];
        const val=element.fieldAPI;
        this.fieldNamesforQuery.push(val);
        //console.log('after looping in getfieldsetfields');
        console.log(this.fieldNamesforQuery);
    });
    if(this.GetFieldSetFields)
    {
    for( let i of this.GetFieldSetFields)
    {
      console.log('for loop');
      console.log(i);
      this.columnsdata=[...this.columnsdata,{ label: i.label, fieldName: i.Api, type: i.Type,editable:true }];
      //console.log(this.columns);
    }
}
    console.log(this.columnsdata);
    console.log('after looping in getfieldsetfields');
    console.log(this.GetFieldSetFields);
    console.log('fieldlabelalone');
    console.log(this.fieldNamesforQuery);

} else if(error){
this.showtoast('-Info-', 'Choose Fieldset buddy', 'info');
}
}

handleclearButtonClick()
{
    const getFieldDataEvent = new CustomEvent('cleardata');
    this.dispatchEvent(getFieldDataEvent);
}

handleFieldSetClick(event)
{
    this.GetFieldSetFields=[];
    this.fieldNamesforQuery=[];
    this.columnsdata=[];
    this.selectedFieldSet=event.detail.value;
    console.log(this.selectedFieldSet);
}

handleButtonClick(event)
{
    const obj=this.selectedObject;
    const query=this.userQuery;
    const col=this.columnsdata;
    const queryfields=this.fieldNamesforQuery;
    console.log(obj);
    console.log(query);
    console.log(col);
    console.log(queryfields);


    console.log('before ok');
    const getFieldDataEvent = new CustomEvent('fieldnames', {detail : {obj,query,col,queryfields}});
    this.dispatchEvent(getFieldDataEvent);
   
}


userQueryHandler(event)
{
   this.userQuery=event.detail.value;
   console.log('MINIMUM DATE:' + this.minDate);
}

handleObjectCLick(event)
{
            this.fieldSetNames=[];
        console.log(this.fieldSetNames);
        this.selectedObject=event.detail.value;
        console.log(this.selectedObject);
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

get minDate()
{
    console.log('Entered mindate');
    var d = new Date();
    this.firstDay=d.getFullYear() + '-' + (d.getMonth()+1) + '-' + '1';
    console.log(this.firstDay);
    return this.firstDay;
}

get maxDate()
{
    console.log('Entered maxdate');
    var d = new Date();
    const SecondD = new Date(d.getFullYear(), d.getMonth()+1, 0); 
    console.log(SecondD);
    this.lastDay=SecondD.toISOString(); 
    console.log(this.lastDay);
    return this.lastDay;
}

DateHandler(event)
{

    var datePicked=event.detail.value;

    this.formattedDateDisplay=datePicked;

    console.log(this.formattedDateDisplay);
   

        const fields = {};

    fields[ID_FIELD.fieldApiName] = '0015i00000BVlInAAL';
    fields[Email_FIELD.fieldApiName] =this.formattedDateDisplay;

    const recordInput = {
        fields: fields
      };

      updateRecord(recordInput).then((record) => {
        console.log('Record Updated:' + record.id);
      });

}

    }