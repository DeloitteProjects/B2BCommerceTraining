/**
 * Created by aketa on 10/28/2021.
 */

public with sharing class Discount10Percent implements Schedulable{

    public void execute(SchedulableContext param1) {
        Database.executeBatch(new Discount10PercentBatch());
    }
}