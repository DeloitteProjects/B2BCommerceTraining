public with sharing class TRH_CCCartItem {

    public static void checkValidation(List<ccrz__E_CartItem__c> newCartItems){

        Set<String> cartIds = new Set<String>();

        for(ccrz__E_CartItem__c cartItem: newCartItems){
            cartIds.add(cartItem.ccrz__Cart__c);
        }

        List<ccrz__E_Cart__c> carts = [
                SELECT ccrz__ValidationStatus__c, ccrz__TotalAmount__c
                FROM ccrz__E_Cart__c
                WHERE Id in :cartIds AND ccrz__TotalAmount__c>1000];

        if(carts.isEmpty()) return;

        for(ccrz__E_Cart__c cart: carts){
            System.debug(cart.ccrz__TotalAmount__c+' '+cart.ccrz__ValidationStatus__c);
            cart.ccrz__ValidationStatus__c = 'Not Validated';
        }

        update carts;
    }

    public static void updateStatus(List<ccrz__E_CartItem__c> cartItems){
        Set<String> cartIds = new Set<String>();

        for(ccrz__E_CartItem__c cartItem: CartItems){
            cartIds.add(cartItem.ccrz__Cart__c);
        }

        Map<String, Object> fetchedCartsResponse = ccrz.ccApiCart.fetch(new Map<String, Object>{
                ccrz.ccApi.API_VERSION => ccrz.ccApi.CURRENT_VERSION,
                ccrz.ccApiCart.CART_IDLIST => cartIds
        });

        List<Map<String, Object>> fetchedCarts = (List<Map<String, Object>>) fetchedCartsResponse.get(ccrz.ccApiCart.CART_OBJLIST);

        System.debug(fetchedCarts[0].get('validationStatus'));
        fetchedCarts[0].put('adjustmentAmount', 1234567);
        Map<String, Object> revisedFetchedCarts = new Map<String, Object>{
                ccrz.ccApi.API_VERSION => ccrz.ccApi.CURRENT_VERSION,
                ccrz.ccApiCart.CART_OBJLIST => fetchedCarts
        };

        ccrz.ccApiCart.revise(revisedFetchedCarts);

    }
}
