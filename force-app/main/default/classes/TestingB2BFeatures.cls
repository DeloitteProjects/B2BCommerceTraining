/**
 * Created by aketa on 10/21/2022.
 */

public with sharing class TestingB2BFeatures {

    public static void createAccount() {
        Map<String, Object> acc = new Map<String, Object>{
                'billingAddress' => new Map<String, Object>{
                        'address1' => 'T',
                        'city' => 'T',
                        'country' => 'Al',
                        'postalCode' => '123456',
                        'state' => 'al'
                },
                'firstName' => 'Ajedt',
                'lastName' => 'Ketda',
                'primaryPhone' => '1234567890',
                'shippingAddress' => new Map<String, Object>{
                        'address1' => 'T',
                        'city' => 'T',
                        'country' => 'Al',
                        'postalCode' => '123456',
                        'state' => 'al'
                },
                'taxExemptFlag' => true,
                'userName' => 'aketa1'
        };


        Map<String, Object> inputData = new Map<String, Object>{
                ccrz.ccApi.API_VERSION => ccrz.ccApi.CURRENT_VERSION,
                ccrz.ccApiAccount.Name => 'AjetKeta',
                ccrz.ccApi.SIZING => new Map<String, Object>{
                        ccrz.ccApiAccount.ENTITYNAME => new Map<String, Object>{
                                ccrz.ccApi.SZ_REFETCH => TRUE,
                                ccrz.ccApi.SZ_DATA => ccrz.ccApi.SZ_L
                        }
                }
        };

//        try {
//        Map<String, Object> outputData = ccrz.ccApiAccount.createAccount(inputData);
        Map<String, Object> outputData = ccrz.ccApiAccount.fetch(inputData);
        if (outputData.get(ccrz.ccApiAccount.ACCOUNTS) != null) {
            // THIS IS THE REFETCHED ACCOUNT
            // The cast to List<Map<String, Object>> is necessary...
            List<Map<String, Object>> accounts = (List<Map<String, Object>>) outputData.get(ccrz.ccApiAccount.ACCOUNTS);
            // DO SOMETHING WITH THE DATA.
            System.debug(accounts);
        }


//        } catch (Exception e) {
//            System.debug('Error sucker!....');
//        }
    }
}