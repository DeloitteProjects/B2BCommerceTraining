/**
 * Created by aketa on 10/27/2021.
 */

import { LightningElement,wire,api } from 'lwc';
  import getProductLocation from '@salesforce/apex/GetLocation.getProductLocation';

export default class GetLocation extends LightningElement {
    @api recordId;
    listLocations=[];
@wire(getProductLocation,{productId: '$recordId'})
    wiredAccount({ error, data }) {
        if (data) {
            console.log("here we have got some data "+data[0].state);
            let location=new LocationDto(data.street,data.state,data.country,data.city,data.acountName);
          console.log(location);
          this.listLocations.push(location);
        } else if (error) {
            this.error = error;
            this.record = undefined;
        }
    }
  mapMarkers = [
        {
            location: {
                City: 'San Francisco',
                Country: 'USA',
                PostalCode: '94105',
                State: 'CA',
            },
            value: 'location001',
            title: 'The Landmark Building',
            description:
                'The Landmark is considered to be one of the city&#39;s most architecturally distinct and historic properties', //escape the apostrophe in the string using &#39;
            icon: 'standard:account',
        },
    ];

/*

  mapMarkers = [
      listLocations.forEach((location)=>{
        {
            location: {
                City: location.city,
                Country: location.country,
                PostalCode: location.postCode,
                State: location.state,
                Street: location.street,
            },
            value: location.accountName,
            title: location.accountName,

        },
        });

    ];*/

}
class LocationDto{
    constructor(street,state,country,city,accountName){
        this.street=street;
        this.state=state;
        this.country=country;
        this.city=city;

        this.accountName=accountName;
    }
}