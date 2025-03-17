global class CreditCheckRequest {

    @InvocableMethod (label='Credit Check Request' description='USed to check credit worthiness of customer')
    global static void CreditCheck(List<String> accountIds){
  
            callCreditCheckAPI(accountIds[0]);
 
    }

    @future (callout=true)
    public static void callCreditCheckAPI(String AccountId){
        Account acct = [SELECT Id,Name, Owner.Name, Owner.Email FROM Account WHERE ID = :AccountId LIMIT 1];
        String url ='https://steve-wasula-splx201-dev-ed.my.salesforce-sites.com';

        url += '?name='+ EncodingUtil.urlEncode(acct.Name, 'UTF-8')
            +  '&email=' + acct.Owner.Email
            +  '&requestor=' + EncodingUtil.urlEncode(acct.Owner.Name, 'UTF-8');
        
        system.debug('Endpoint URL: '+url);

        Http h = new Http();

        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');

        HttpResponse res = h.send(req);

        System.Debug('HTTP Response: '+res.getBody());

    }
}