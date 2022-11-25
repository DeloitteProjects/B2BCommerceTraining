/**
 * Created by aketa on 11/4/2022.
 */

public with sharing class ccProductFinder {

    public static void findProductWithGivenSearchAttribute(){

        Map<String, Object> productFinderMap = new Map<String, Object>{
                ccrz.ccApi.API_VERSION => ccrz.ccApi.CURRENT_VERSION,
                ccrz.ccAPIProduct.PRODUCTIDLIST => new Set<String> {
                        'a1M7Q000000xAZTUA2'
                },
                ccrz.ccAPIProduct.PARAM_INCLUDE_PRICING => true
        };

        Map<String, Object> productFinderResponse = new Map<String, Object>();

        try{
            productFinderResponse = (Map<String, Object>) ccrz.ccAPIProduct.fetch(productFinderMap);
        }catch(Exception exc){
            System.debug(exc);
            return;
        }

        List<Map<String, Object>> products = (List<Map<String,Object>>) productFinderResponse.get(ccrz.ccAPIProduct.PRODUCTLIST);
        System.debug('---------Retrieved Products--------------');
        System.debug(products);
        System.debug(products[0].get('brand'));
        System.debug(products[0].get('shortDesc'));

    }
}