@IsTest
public with sharing class DoCalloutTest {
 @IsTest
 public static void callHttpUtilsTest(){
     StaticResourceCalloutMock mock =new StaticResourceCalloutMock();
     mock.setStaticResource('getCreatePrice');
     mock.setStatusCode(200);
     mock.setHeader('Content-Type','application/json;charset=UTF-8');
     System.debug(mock);
     Test.setMock(HttpCalloutMock.class, mock);
     Test.startTest();
     httpResponse response=DoCallout.callHttpUtils();
     Test.stopTest();
    
     System.assertNotEquals(null, response);
     System.assertEquals(200, response.getStatusCode());

    CreatePrice cp=CreatePrice.parse(response.getBody());

    System.debug(cp);
    System.assertNotEquals(null,cp);
        System.assertEquals('web011',cp.extId);
        System.assertEquals(120,cp.price);
        System.assertEquals('EU',cp.currencyCode);

 }
}