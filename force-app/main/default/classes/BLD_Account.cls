/**
 * Created by aketa on 4/22/2022.
 */

public with sharing class BLD_Account {
    private Account acc=new Account();

    public Account getRecord(){
        return this.acc;
    }

    public BLD_Account withRecordType(String recordTypeName){
        this.acc.RecordTypeId = GetRecordTypeId.GetInstance().getRecordTypeId(recordTypeName);
        return this;
    }

    public BLD_Account withRating(String rating){
       this.acc.Rating=rating;
        return this;
    }

    public BLD_Account withIndustry(String industry){
        this.acc.Industry = industry;
        return this;
    }

}