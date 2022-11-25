public class HttpUtils {
final static Set<String> allowedMethods=new Set<String>{'GET', 'POST','PUT','DELETE','PATCH'};

   public static HttpResponse getHttpResponse(HttpRequest request){
       HttpResponse response=null;
       if(request==null){
           throw new HttpUtilsException('Request should not be null');
       }
       try{
       response=new Http().send(request);
       }catch(Exception exc){
        System.debug(exc.getMessage());
       }

       return response;
   }
   public static HttpRequest getHttpRequest(String method, String body, String endpoint, Integer timeout, Map<String,String> headers){
    if(String.isBlank(method) || !allowedMethods.contains(method)){
        throw new HttpUtilsException('The method you have inputed is wrong');
    } 
    if((method!='GET' && method!='DELETE') && String.isBlank(body)){
        throw new HttpUtilsException('Body should not be empty');
    }
    if(String.isBlank(endpoint)){
        throw new HttpUtilsException('Endpoint should not be empty');
    }
    if(timeout<=0){
        throw new HttpUtilsException('Timeout should be bigger than zero');
    }
    
    HttpRequest request=new HttpRequest();
       request.setEndpoint(endpoint);
       request.setMethod(method);
       request.setTimeout(timeout);
       
       if(method!='GET' && method!='DELETE'){
        request.setBody(body);
    }
       if(headers!=null){
           for(String key: headers.keySet()){
               request.setHeader(key,headers.get(key));
           }
       }
       return request;
   }
   class HttpUtilsException extends Exception{}
}