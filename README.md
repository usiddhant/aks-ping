
// ======Transforming request/response=====
import groovy.json.JsonSlurper;
import groovy.json.JsonOutput;


exc?.log.info "-->Request URI Original: " + exc?.request?.uri;
originalUri = exc?.request?.uri;


if( originalUri?.contains("login") )
{
  exc?.request?.setUri("/am/json/authenticate");
}
else{
  
  exc?.request?.setUri(originalUri+"/live");
}


def bodyStr = exc?.response?.body?.content;

exc.log.info "-->Response Body1:: "+ bodyStr;

if(exc?.response && exc?.response?.statusCode == 200)

{

def bodyStr1 = new String(bodyStr);
exc.log.info "-->Response Body2:: "+ bodyStr1;  

//bodyStr1 = bodyStr1.add("mobile", "1234567891");

//exc?.response?.setBodyContent(bodyStr1.getBytes());

  def json = new JsonSlurper().parseText(bodyStr1)
  json.newField = "addedValue"; //add new field
  json.header = "Login"    //update field
  json.remove("authId")    //remove field
  
  exc.log.info "-->Json Body:: "+ json; 
  
  def newString = JsonOutput.toJson(json);
  
  exc.log.info "-->Json Body Updated:: "+ newString; 
  
  exc?.response?.setBodyContent(newString.getBytes());
  
}



/*
if(exc?.response) {
  
//def bodyStr = new String(test);

//bodyStr = bodyStr.add("mobile", "1234567891");
exc.log.info "-->Response Body3:: "+ exc?.response?.body  

//exc?.response?.setBodyContent("It looks good".getBytes());
    
}*/

pass()
