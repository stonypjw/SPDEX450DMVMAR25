@isTest
private class oppTests {

    @isTest
    static void testOppNamingConventionOnInsert() {

    Account a = new Account();
        a.Name = 'Test';
    
    insert a;

    Opportunity o = new Opportunity();
        o.Name='fuhefu';
        o.Type='New Customer';
        o.CloseDate = Date.newInstance(2025, 10, 5);
        o.StageName = 'Prospecting';
        o.AccountId = a.Id;

    Test.startTest();
    insert o;
    Test.stopTest();

     System.Debug('*Account');
     System.Debug(a);
     System.Debug('*Opportuntity Inserted');
     System.Debug(o);


     Opportunity retOpp = [SELECT ID,Name FROM Opportunity WHERE AccountId = :a.Id LIMIT 1];
     System.Debug('*Opportuntity Returned');
     System.Debug(retOpp);
     String oppName = 'Test - New Customer - 2025/10';
     System.Debug(retOpp.Name);
     System.Debug(oppName);
     
     System.assertEquals(oppName, retOpp.Name, 'Opportunity has a name not compliant with convention');

    }
}