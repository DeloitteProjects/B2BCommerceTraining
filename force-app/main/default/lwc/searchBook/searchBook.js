/**
 * Created by aketa on 10/27/2021.
 */
/*
import { LightningElement,track,wire } from 'lwc';
import getBookTittles from '@salesforce/apex/GetBookTittles.getBookTittles';
const columns = [
    { label: 'Order Name', fieldName: 'Order.Name' },
    { label: 'Order Start Date', fieldName: 'Order.CreatedDate' },
    { label: 'Order Status', fieldName: 'Order.Status' },
    { label: 'Quantity', fieldName: 'Quantity'},

];
export default class SearchBook extends LightningElement {
@track myValue='Search a book....';
  @wire(getBookTittles,{title: 'a'}) orderItem;

   handleChange(evt) {
       console.log(evt.target.value);
             this.myValue = evt.target.value;
   }

   */
  import { LightningElement,track,wire } from 'lwc';
  import getBookTittles from '@salesforce/apex/GetBookTittles.getBookTittles';



   const columns = [
       { label: 'Order Name', fieldName: 'orderName' },
       {
           label: 'Order Start Date',
           fieldName: 'orderCreatedDate',
           type: 'date',

       },
       { label: 'Order Status', fieldName: 'orderStatus'},
       {label:'Quantity', fieldName:'quantity', sortable: true,
                                                          cellAttributes: { alignment: 'left' },},
       {label:'Name', fieldName:'name'}
   ];

   export default class DemoApp extends LightningElement {
        myValue;
        @wire(getBookTittles, { title: '$myValue' })
           orderItem;
          handleKeyChange(event) {
               this.myValue=event.target.value;
               console.log(this.myValue);
           }

       columns = columns;
       defaultSortDirection = 'asc';
       sortDirection = 'asc';
       sortedBy;

       // Used to sort the 'Age' column
       sortBy(field, reverse, primer) {
           const key = primer
               ? function (x) {
                     return primer(x[field]);
                 }
               : function (x) {
                     return x[field];
                 };

           return function (a, b) {
               a = key(a);
               b = key(b);
               return reverse * ((a > b) - (b > a));
           };
       }

       onHandleSort(event) {
           const { fieldName: sortedBy, sortDirection } = event.detail;
           console.log("sortBy: "+sortedBy);
           console.log("sortDirection:" +sortDirection);
           const cloneData = [this.orderItem];
           console.log("cloneDate: "+JSON.stringify(this.cloneData));
           //cloneData.sort(this.sortBy(sortedBy, sortDirection === 'asc' ? 1 : -1));
           this.sortThemOut(this.cloneData,sortDirection === 'asc' ? 1 : -1,sortedBy);
           console.log("cloneDate after sorting "+ JSON.stringify(cloneData));
           this.orderItem = cloneData;
           console.log("orderItem after sorting "+ JSON.stringify(this.orderItem));

           this.sortDirection = sortDirection;
           this.sortedBy = sortedBy;
       }
       sortThemOut(items,number,fieldName){
           console.log(JSON.stringify(items));
           if(number==1){
               for(let i=0;i<items.length;i++){
                   for(let j=0;j<items.length;j++){
                       if(items[j].quantity>items[j+1].quantity){
                           let hold=items[j];
                           items[j]=items[j+1];
                           items[j+1]=hold;
                       }
                   }
               }
           }else if(number==-1){
                                for(let i=0;i<items.length;i++){
                                    for(let j=0;j<items.length;j++){
                                        if(items[j].quantity<items[j+1].quantity){
                                            let hold=items[j];
                                            items[j]=items[j+1];
                                            items[j+1]=hold;
                                        }
                                    }
                                }
                            }
                            return items;
       }
   }