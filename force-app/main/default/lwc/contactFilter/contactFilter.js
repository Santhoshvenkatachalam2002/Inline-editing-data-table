import { LightningElement, wire,track } from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import LEADSOURCE from '@salesforce/schema/Contact.LeadSource';
import LEVEL from '@salesforce/schema/Contact.Level__c';
import Industry from '@salesforce/schema/Account.Industry';
import Type from '@salesforce/schema/Account.Type';
import filteringRecords from '@salesforce/apex/FilterRecords.filteringRecords';
export default class ContactFilter extends LightningElement {

@track NameToFilter='';
//@track LeadSourceToFilter;
//@track LevelToFilter;
@track TypeToFilter='';
@track IndustryToFilter='';

@wire(getPicklistValues,
    {
        recordTypeId: '012000000000000AAA',
        fieldApiName: LEADSOURCE
    }
)leadSourceValue;

@wire(getPicklistValues,
    {
        recordTypeId: '012000000000000AAA',
        fieldApiName: LEVEL
    }
)levelValue;

@wire(getPicklistValues,
    {
        recordTypeId: '012000000000000AAA',
        fieldApiName: Industry
    }
)industryValue;

@wire(getPicklistValues,
    {
        recordTypeId: '012000000000000AAA',
        fieldApiName: Type
    }
)typeValue;


ContactNameHandler(event)
{
   this.NameToFilter=event.detail.value;
   console.log(this.NameToFilter);
}

/*handleLeadSourceChange(event)
{
  this.LeadSourceToFilter=event.detail.value;
  console.log(this.LeadSourceToFilter);
}

handleLevelChange(event)
{
this.LevelToFilter=event.detail.value;
console.log(this.LevelToFilter);
}*/

handleInustryChange(event)
{
    this.IndustryToFilter=event.detail.value;
    console.log(this.IndustryToFilter);
}

handleTypeChange(event)
{
    this.TypeToFilter=event.detail.value;
    console.log(this.TypeToFilter);
}



@wire(filteringRecords,{NameFilter:'$NameToFilter',IndustryFilter:'$IndustryToFilter',TypeFilter:'$TypeToFilter'})
FilteredContactRecords({data,error})
{
    if(data)
    {
        console.log(data);
        const childComponent=this.template.querySelector('C-Contact-Filter-Record-Display');
        childComponent.recordDisplayTable(data);
    }
    else if(error)
    {
        console.error(error.body.message);
    }
}


}