trigger TRG_CCCartItem on ccrz__E_CartItem__c (before insert, before update) {
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        CartItemCreator.addProductToCart();
    }

}