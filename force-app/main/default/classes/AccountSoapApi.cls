global class AccountSoapApi {
    webservice static Id CreateAccount(String name){
        Account acc=new Account(Name=name);
        insert acc;
        return acc.Id;
    }
}