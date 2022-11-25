/**
 * Created by aketa on 10/29/2021.
 */

public with sharing class SendEmailParticipationScheduler implements Schedulable {

    public void execute(SchedulableContext param1) {
        Database.executeBatch(new SendEmailParticipation());
    }
}