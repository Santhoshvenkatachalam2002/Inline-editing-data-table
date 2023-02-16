import { LightningElement,track,api} from 'lwc';

export default class PaginationForDataTable extends LightningElement {


    @track currentPage=1;
    @track Pages;

    @api 
    
    set totalpage(data)
    {
        this.currentPage=1;
      console.log("Data from :" + data);
      this.Pages=data;
      console.log("totalPages:" + this.Pages);
    }

    get totalpage()
    {
        console.log("get method :" + this.Pages);
        return this.Pages;
    }


    previousHandler(event)
    {
       this.currentPage=this.currentPage - 1;
       let PageNumber= this.currentPage;

       let sendPageNumberEventPrevious=new CustomEvent('currentpagenumberprevious', {detail : {PageNumber}});
       this.dispatchEvent(sendPageNumberEventPrevious);
    }

    nextHandler(event)
    {
       this.currentPage=this.currentPage + 1;
       let PageNumber= this.currentPage;
       console.log(PageNumber);
       let sendPageNumberEventnext=new CustomEvent('currentpagenumbernext', {detail : {PageNumber}});
       this.dispatchEvent(sendPageNumberEventnext);
    }

   get disablePrevious()
    {
        if(this.Pages>0)
        {
        //this.currentPage=1;
        if(this.currentPage==1)
        {
            console.log(this.currentPage);
            return true;
          
        }
        else
        {

        console.log(this.currentPage);
        return false;
        }  
    }
    else{
    console.log("entered --");
    this.currentPage=0;
    return true;
    }
    }

   get disableNext()
    {
        if(this.Pages>0)
        {
        //this.currentPage=1;
        if(this.currentPage == this.Pages)
        {
            console.log(this.currentPage);
            return true;
        }
        console.log(this.currentPage);
        return false;
    }
    console.log("Entered++");
    this.currentPage=0;
    return true;   
    }
}