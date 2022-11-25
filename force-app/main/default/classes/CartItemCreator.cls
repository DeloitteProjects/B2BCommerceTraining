/**
 * Created by aketa on 11/3/2022.
 */

public with sharing class CartItemCreator {

    private static final Set<String> productSkus = new Set<String>{
            'TM-COFMAC-001'
    };

    public static void addProductToCart() {
        Map<String, Object> queryableData = new Map<String, Object>{
                ccrz.ccApi.API_VERSION => ccrz.ccApi.CURRENT_VERSION
        };
        Map<String, Object> fetchedCartResponse = new Map<String, Object>();
        Map<String, Object> fetchedProductResponse = new Map<String, Object>();

        try {
            fetchedCartResponse = ccrz.ccApiCart.fetch(queryableData);
        } catch (Exception exc) {
            System.debug(exc);
            return;
        }

        try {
            Map<String, Object> productQueryableData = queryableData;
            productQueryableData.put(ccrz.ccApiProduct.PRODUCTSKULIST, productSkus);
            fetchedProductResponse = ccrz.ccAPIProduct.fetch(productQueryableData);
        } catch (Exception exc) {
            System.debug(exc);
            return;
        }

        List<Map<String, Object>> fetchedProducts = (List<Map<String, Object>>) fetchedProductResponse.get(ccrz.ccApiProduct.PRODUCTLIST);
        List<Map<String, Object>> fetchedCarts = (List<Map<String, Object>>) fetchedCartResponse.get(ccrz.ccApiCart.CART_OBJLIST);

        System.debug('Fetched Carts: ' + fetchedCarts);
        System.debug('Fetched Products: ' + fetchedProducts);

        try{
            Map<String, Object> addProductToCart = queryableData;
            addProductToCart.putAll(new Map<String, Object> {
                    ccrz.ccApiCart.CART_ID => 'a0N7Q000001CpDIUA0'
            });
            ccrz.ccApiCart.addTo(addProductToCart);
        }catch(Exception exc){
            System.debug(exc);
            return;
        }


    }
}