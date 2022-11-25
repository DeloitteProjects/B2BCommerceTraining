/**
 * Created by aketa on 10/28/2021.
 */

import { LightningElement,wire,api,track } from 'lwc';
 import getPicklistTypeValue from '@salesforce/apex/OpportunityProductWizard.getPicklistTypeValue';
 import getSelectedCollections from '@salesforce/apex/OpportunityProductWizard.getSelectedCollections';
  import getRelatedProducts from '@salesforce/apex/OpportunityProductWizard.getRelatedProducts';

 import {refreshApex} from '@salesforce/apex'



   const columns = [
       { label: 'Collection Name', fieldName: 'name', },
       {label: 'Collection Category',fieldName: 'category',},
       { label: 'Collection Status', fieldName: 'status',},
       {label:'Active', fieldName:'isActive', },

   ];
    const columns1 = [
          { label: 'Name', fieldName: 'name', },
          {label: 'Price',fieldName: 'price',},
          { label: 'PriceBookName', fieldName: 'priceBookName',},


      ];

export default class OpportunityProductWizard extends LightningElement {
@api recordId;
myValue;
Id;
columns1=columns1;
@track selectedIds=[];
@track categories=[];
        @wire(getPicklistTypeValue)
        picklistValues;
        @wire(getSelectedCollections, { name: '$myValue', category:'$categories'})
           orderItem;
        @wire(getRelatedProducts,{ids:'$selectedIds'}) products;
          handleKeyChange(event) {
               this.myValue=event.target.value;
               console.log(this.myValue);
           }
          handleClick(event){
              if(event.target.checked === true){
                  this.categories.push(event.target.label);
              }else{
                    this.categories.splice(this.categories.indexOf(event.target.label),1);
              }
            this.categories=JSON.parse(JSON.stringify(this.categories));
          }

          handleClickTable(event){

              var el = this.template.querySelector('lightning-datatable');
                     var selected = el.getSelectedRows();
                      console.log(selected[0].id);
                      for(let i=0;i<selected.length;i++){
                          this.selectedIds.push(selected[i].id);
                      }
                                  this.selectedIds=JSON.parse(JSON.stringify(this.selectedIds));

                    console.log('Selected Ids: '+this.selectedIds);
                      console.log(selected);
          }

       columns = columns;
}