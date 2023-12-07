@RestResource(urlMapping='/v1/Welcome/s/')
global with sharing class ServeAccountToPostman {
  /*@httpGet
  global static List<Account> getAccount() {
    RestRequest req = RestContext.request;
    String reqUri = req.requestURI;

    Map<String, String> param = req.params;
    System.debug('param = ' + param);
    String id = param.get('id');

    // String key = getTrimmedId(reqUri, 'id');

    List<Account> acc = [
      SELECT id, Name, Phone
      FROM Account
      WHERE id = :id
      WITH SECURITY_ENFORCED
    ];

    return acc;
  }*/
  /*
  @httpGet
  global static AccountWrapper getRecords() {
    RestRequest req = RestContext.request;
    Map<String, String> accMap = req.params;
    String accIndustry = accMap.get('industry');
    Set<id> accId = new Set<id>();

    List<Account> accLis = [
      SELECT id, name, phone
      FROM Account
      WHERE industry = :accIndustry
      WITH SECURITY_ENFORCED
    ];

    for (Account a : accLis) {
      accId.add(a.id);
    }

    List<Contact> conLis = [
      SELECT id, LastName, phone
      FROM Contact
      WHERE accountId IN :accId
      WITH SECURITY_ENFORCED
    ];
    List<Case> casLis = [
      SELECT id, CaseNumber, subject, status
      FROM Case
      WHERE accountId IN :accId
      WITH SECURITY_ENFORCED
    ];

    AccountWrapper acc = new AccountWrapper();
    acc.aLis = accLis;
    acc.conLis = conLis;
    acc.casLis = casLis;

    return acc;
  }
*/

  global class AccountWrapper {
    global List<Account> aLis;
    global List<Contact> conLis;
    global List<Case> casLis;
  }
  /* @httpPost
  global static Account postAccount() {
    RestRequest req = RestContext.request;
    String body = req.requestBody.toString();

    Account acc = (Account) JSON.deserialize(body, Account.class);
    insert acc;
    return acc;
    //return accRec;
  }*/

  @httpPost
  global static List<Account> postAccount(WrapperComplex accountList) {
    //RestRequest req = RestContext.request;
    //String body = req.requestBody.toString();

    //String s =  AccountList.str;

    List<Account> accLis = accountList.aLis;

    return accLis;
  }

  global class WrapperComplex {
    //global String str {get;set;}
    global List<Account> aLis { get; set; }
  }

  /*@httpGet
  global static String getText(String name, String id) {
    String res = name + id;
    return res;
  }*/

  /*
  @httpPost
  global static void createAccount() {
    RestRequest req = RestContext.request;
    String body = req.requestBody.toString();

    System.debug('body = ' + body);
  }

  public static String getTrimmedId(String s, String searchKey) {
    System.debug('getTrimmedId = ' + s + ',' + searchKey);
    List<String> aLis = s.split('\\?');
    Map<String, String> mMap = new Map<String, String>();
    String e = aLis.get(1);
    aLis = e.split('\\&');

    for (String g : aLis) {
      List<String> d = new List<String>();
      d = g.split('=');
      mMap.put(d.get(0), d.get(1));
    }

    for (String c : mMap.keySet()) {
      if (c == searchKey) {
        return mMap.get(c);
      }
    }

    System.debug('Not found = ' + searchkey + ',' + s);
    return 'Not found';
  }
  */
}