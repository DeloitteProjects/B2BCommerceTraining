@IsTest
public with sharing class HttpUtilsTest {
   @IsTest
   public static void getHttpRequestTest(){
       Boolean methodNotGiven, wrongMethodGiven,endpointNotGiven, wrongTimeoutGiven, bodyNotGiven;
       HttpRequest request;
       Test.startTest();
      try{
       HttpUtils.getHttpRequest('', '', 'https://example.com', 1, null);
      }catch(Exception exc){
        methodNotGiven=true;
      }
      try{
        HttpUtils.getHttpRequest('Get', '', 'https://example.com', 1, null);
       }catch(Exception exc){
         wrongMethodGiven=true;
       }
       try{
        HttpUtils.getHttpRequest('GET', '', '', 1, null);
       }catch(Exception exc){
         endpointNotGiven=true;
       }
       try{
        HttpUtils.getHttpRequest('GET', '', 'https://example.com', -1, null);
       }catch(Exception exc){
         wrongTimeoutGiven=true;
       }
       try{
        HttpUtils.getHttpRequest('POST', '', 'https://example.com', 11, null);
       }catch(Exception exc){
         bodyNotGiven=true;
       }
      
       try{
           Map<String, String> header= new Map<String,String>();
           header.put('authentication','auoth');
         request= HttpUtils.getHttpRequest('POST', '{"extId":"web011", "price":120,"currencyCode":"EU"}', 'https://example.com', 11, header);
       }catch(Exception exc){

       }
       Test.stopTest();
       System.assert(bodyNotGiven);
       System.assert(methodNotGiven);
       System.assert(endpointNotGiven);
       System.assert(wrongMethodGiven);
       System.assert(wrongTimeoutGiven);
       System.assertNotEquals(null, request);

}
}