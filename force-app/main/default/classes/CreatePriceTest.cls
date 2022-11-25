@IsTest
public with sharing class CreatePriceTest {
   @IsTest
   public static void parseTest(){
       String json='{"extId":"web002","price":102,"currencyCode":"EUR"}';

        Test.startTest();
        CreatePrice cp=CreatePrice.parse(json);
        Test.stopTest();

        System.assertNotEquals(null,cp);
        System.assertEquals('web002',cp.extId);
        System.assertEquals(102,cp.price);
        System.assertEquals('EUR',cp.currencyCode);

   }
}