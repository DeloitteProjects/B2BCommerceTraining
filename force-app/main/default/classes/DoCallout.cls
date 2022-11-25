public with sharing class DoCallout {
    public static HttpResponse callHttpUtils(){
       HttpRequest request= HttpUtils.getHttpRequest('GET',
                                                     '',
                                                     'https://calculateprice.getsandbox.com/calculatePrice/web001',
                                                     1000,
                                                     null
                                                     );
        
        HttpResponse response=HttpUtils.getHttpResponse(request);
        CreatePrice cp=CreatePrice.parse(response.getBody());
        return response;
}
}