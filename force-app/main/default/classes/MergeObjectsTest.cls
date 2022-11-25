/**
 * Created by aketa on 10/14/2021.
 */
@IsTest
public with sharing class MergeObjectsTest {

    @IsTest
    public static void test(){
        Account account=new Account(Name='This is an account');
        Account account1=new Account(Name='This is a new Account',Description='This is a description');
        MergeObjects m=new MergeObjects();
        Account account3=m.mergeObjects();
        
    }
}