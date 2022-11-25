public class PushTopicTest {
    public static void createPushTopic(){
        PushTopic pushTopic=new PushTopic();
        pushTopic.Name='AccountUpdates';
        pushTopic.Query='Select Id, Name from Account';
        pushTopic.ApiVersion=51.0;
        pushTopic.NotifyForFields='Referenced';
        pushTopic.NotifyForOperationUpdate=true;
        insert pushTopic;
    }
}