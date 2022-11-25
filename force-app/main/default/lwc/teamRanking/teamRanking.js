/**
 * Created by aketa on 10/29/2021.
 */

import { LightningElement,api,track,wire } from 'lwc';
import getTeams from '@salesforce/apex/TeamRankingComponent.getTeams';
import getTeamsByName from '@salesforce/apex/TeamRankingComponent.getTeamsByName';
import getEmployees from '@salesforce/apex/TeamRankingComponent.getEmployees';



   const columns = [
       { label: 'Position', fieldName: 'position', },
       {label: 'Team Name',fieldName: 'name',},
       { label: 'Number of Employees', fieldName: 'numberOfEmployees',},
       {label:'Total Points', fieldName:'totalPoints', },

   ];
    const columns1 = [
          { label: 'Employee Name', fieldName: 'empName', },
          {label: 'Number of Participated Events',fieldName: 'amountOfParticipatedEvents',},
          { label: 'Total Points', fieldName: 'empTotalPoints',},
          {label:'Teams', fieldName: 'teamNames'}


      ];

export default class TeamRanking extends LightningElement {
@api recordId;
myValue='';
columns1=columns1;
numberOfElementsPerPage=10;
currentPage=1;
kushti=false;
showNext=false;
showPrevious=false;
directions='';
numberOfPages=0;
teams=[];
sliceTeams=[];
pageNumber=[];
@track selectedIds=[];

        @wire(getTeamsByName, { name: '$myValue'})
         wiredAccount({ error, data }) {
                 if (data) {
                     this.teams=data;
                     this.numberOfPages=data.length/this.numberOfElementsPerPage;
                     this.numberOfPages=Math.ceil(this.numberOfPages);
                     this.pageNumber.splice(0,this.pageNumber.length);
                     for(let i=0;i<this.numberOfPages;i++){
                         this.pageNumber.push(i+1);
                     }
                     if(data.length>this.numberOfElementsPerPage){
                     this.sliceTeams=data.slice(0,this.numberOfElementsPerPage);
                     this.showNext=true;
                     }else{
                         this.sliceTeams=data.slice(0,data.length);
                         this.showNext=false;
                     }
                     this.showPrevious=false;
                     this.currentPage=1;
                     this.directions='Page 1 of '+this.numberOfPages+' pages!';
                 } else if (error) {
                     this.error = error;
                     this.record = undefined;
                 }
             }
        @wire(getEmployees,{teamId:'$selectedIds'}) employees;


          handleKeyChange(event) {
               this.myValue=event.target.value;
           }
          handleClickTable(event){

              this.selectedIds.splice(0,this.selectedIds.length);
              this.kushti=false;
              this.selectedIds.length=0;
               this.selectedIds=JSON.parse(JSON.stringify(this.selectedIds));
                  var el = this.template.querySelector('lightning-datatable');
                     var selected = el.getSelectedRows();
                      for(let i=0;i<selected.length;i++){
                          this.selectedIds.push(selected[i].id);
                      }
                                  this.selectedIds=JSON.parse(JSON.stringify(this.selectedIds));
                    if(this.selectedIds.length>0){
                        this.kushti=true;
                    }
          }

       columns = columns;

        handleClick(event){
            if(event.target.label=='Next'){
                this.currentPage++;
                if(this.teams.length>this.currentPage*this.numberOfElementsPerPage){
                    this.sliceTeams=this.teams.slice((this.currentPage-1)*this.numberOfElementsPerPage, this.currentPage*this.numberOfElementsPerPage);
                    this.showNext=true;
                }else{
                    this.sliceTeams=this.teams.slice((this.currentPage-1)*this.numberOfElementsPerPage,this.teams.length);
                    this.showNext=false;
                }
                this.showPrevious=true;
            }else if(event.target.label=='Previous'){
                this.currentPage--;
                if(this.currentPage==1){
                    this.showPrevious=false;
                }
                this.showNext=true;
                this.sliceTeams=this.teams.slice((this.currentPage-1)*this.numberOfElementsPerPage,this.currentPage*this.numberOfElementsPerPage);
            }
           this.directions='Page '+ this.currentPage+' of '+this.numberOfPages+' pages!';

        }
        pageSet(event){
            this.currentPage=event.target.label;
             if(this.currentPage==this.numberOfPages){
                 this.sliceTeams=this.teams.slice((this.currentPage-1)* this.numberOfElementsPerPage,this.teams.length)
                this.showNext=false;
                if(this.numberOfPages==1){
                    this.showPrevious=false;
                }else{
                this.showPrevious=true;
                }
            }
            else{
                if(this.currentPage==1 && this.numberOfPages==1){
                    this.showPrevious=false;
                    this.showNext=false;
                }else if(this.currentPage==1){
                    this.showPrevious=false;
                    this.showNext=true;
                }else{
                this.showNext=true;
                this.showPrevious=true;
                }
                this.sliceTeams=this.teams.slice((this.currentPage-1)* this.numberOfElementsPerPage,this.currentPage* this.numberOfElementsPerPage)

            }
           this.directions='Page '+ this.currentPage+' of '+this.numberOfPages+' pages!';

        }
}