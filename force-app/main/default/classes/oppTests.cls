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

    @isTest
    static void testOppNamingConventionOnInsert_Bulk() {

    Account a = new Account();
        a.Name = 'Test';
    insert a;

    Contact c = new Contact();
        c.FirstName = 'test';
        c.LastName = 'Test';
        c.AccountId = a.Id;
    
    insert c;
    
    a.Default_Billing_Contact__c = c.Id;
    update a;

    List<Opportunity> newOpps = new List<Opportunity>();
    for(Integer i=0; i<201; i++){
        Opportunity o = new Opportunity();
        o.Name='fuhefu';
        o.Type='New Customer';
        o.CloseDate = Date.newInstance(2025, 10, 5);
        o.StageName = 'Prospecting';
        o.AccountId = a.Id;
        newOpps.add(o);
    }   

    Test.startTest();
    insert newOpps;
    Test.stopTest();

    List<Opportunity> retOpps = [SELECT ID FROM Opportunity WHERE AccountId = :a.Id];
    System.assertEquals(201, retOpps.size(), 'Incoorect number of opps created');

    }

    @isTest
    static void testOppNamingConventionOnUpdate() {

    Account a = new Account();
        a.Name = 'Test';
    
    insert a;

    Opportunity o = new Opportunity();
        o.Name='fuhefu';
        o.Type='New Customer';
        o.CloseDate = Date.newInstance(2025, 10, 5);
        o.StageName = 'Prospecting';
        o.AccountId = a.Id;

      insert o;



      Test.startTest();
      a.Name = 'Changed';
      update a;

     System.Debug('*Account');
     System.Debug(a);

     Opportunity retOpp = [SELECT ID,Name FROM Opportunity WHERE AccountId = :a.Id LIMIT 1];
     System.Debug('*Opportuntity Returned');
     System.Debug(retOpp);
     String oppName = 'Changed - New Customer - 2025/10';
     System.Debug(retOpp.Name);
     System.Debug(oppName);
     
     System.assertEquals(oppName, retOpp.Name, 'Opportunity has a name not compliant with convention');

    }

    @isTest
    static void testOppNamingConventionOnUpdate_Bulk() {

    Account a = new Account();
        a.Name = 'Test';
    
    insert a;

    List<Opportunity> newOpps = new List<Opportunity>();
    for(Integer i=0; i<201; i++){
        Opportunity o = new Opportunity();
        o.Name='fuhefu';
        o.Type='New Customer';
        o.CloseDate = Date.newInstance(2025, 10, 5);
        o.StageName = 'Prospecting';
        o.AccountId = a.Id;
        newOpps.add(o);
    }   
    insert newOpps;



      Test.startTest();
      a.Name = 'Changed';
      update a;

 

    }
}