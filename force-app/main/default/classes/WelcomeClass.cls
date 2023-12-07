@RestResource(urlMapping='/v1/Welcome/')
global with sharing class WelcomeClass {
  global final static String STR1 = 'Welcome to Integration';
  global final string str2 = 'Non static Variable';

  //https://bct-5c-dev-ed.my.salesforce.com/services/apexRest/v1/Welcome/*

  @httpGet
  global static String getMessage() {
    // only one method per type @httGet
    return STR1;
  }

  @httpPost
  global static String postMessage() {
    // only one method per type @httGet
    return STR1;
  }
}