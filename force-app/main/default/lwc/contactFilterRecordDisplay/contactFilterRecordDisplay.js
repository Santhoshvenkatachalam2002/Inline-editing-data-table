import { LightningElement,api,track} from 'lwc';
import updateRecords from '@salesforce/apex/UpdateData.updateRecord';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class ContactFilterRecordDisplay extends LightningElement {

    @track RecordColumn=[];
    @track RecordData=[];
    draftValues=[];
    @api recordDisplayTable(Record)
    {
        console.log(Record);
        console.log(this.RecordData);
        this.RecordData=[];
         this.RecordColumn=[{ label: 'ContactId', fieldName: 'Id',editable:false },
                          {label:'Name',fieldName:'Name',type: 'url',editable:true,
                          typeAttributes: {label: { fieldName: 'ContactName' },target: '_blank'}},{label:'Industry',fieldName:'Industry',editable:true},{label:'Type',fieldName:'Type',editable:true}];

                          console.log(this.RecordColumn);

       Record.forEach(element => {
                 this.RecordData=[...this.RecordData,{Id:element.Id,ContactName:element.FirstName,Industry:element.Account.Industry,Type:element.Account.Type,Name:'/' + element.Id }];   
       });
       console.log(this.RecordData);
    }

    handleSave(event)
    {
      console.log('Entered into save Event');
      const values=event.detail.draftValues;
      console.log(values);
  
      updateRecords({data:values})
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