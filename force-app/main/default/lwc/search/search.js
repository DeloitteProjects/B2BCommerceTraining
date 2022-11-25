/**
 * Created by aketa on 10/21/2021.
 */

import { LightningElement } from 'lwc';

export default class Search extends LightningElement {
word='';
onChangeWord(event){
this.word=event.target.value;
}
websiteTravel(){

    window.open("http://www.google.com/search?q="+this.word, '_blank').focus();


}

}