/*exc?.log.info "Display Headers: "
exc?.log.info "-->Request Headers"

reqHdrs = exc?.request?.header?.getAllHeaderFields()
reqLoop = reqHdrs?.iterator()
while (reqLoop?.hasNext()) {
  hdr = reqLoop?.next()
  exc.log.info "-->reqHeader  Name: "+hdr?.getHeaderName()?.toString()
  exc.log.info "-->reqHeader Value: "+ hdr?.getValue()
}
exc?.log.info "-->Response Headers"
exc?.log.debug "-->Response HTTP Status: "+ exc?.response?.statusCode
rspHdrs = exc?.response?.header?.getAllHeaderFields()
rspLoop = rspHdrs?.iterator()
while (rspLoop?.hasNext()) {
  hdr = rspLoop?.next ()
  exc.log.info "-->rspHeader  Name: "+ hdr?.getHeaderName()?.toString()
  exc.log.info "-->rspHeader Value: "+ hdr?.getValue()
}
exc?.log.info "Display Headers EOF: " */

// ======Transforming request/response=====
import groovy.json.JsonSlurper;
import groovy.json.JsonOutput;


exc?.log.info "-->Request URI Original: " + exc?.request?.uri;


originalUri = exc?.request?.uri;

def splitUri = originalUri?.split("\\?",2);

def queryString ="";
if (splitUri?.size() > 1) {
   queryString = splitUri[1]
   queryString = "?"+queryString;

   exc?.log.info "-->Request Query Original: " + queryString;
}



if( originalUri?.contains("login") )
{
  exc?.request?.setUri("/am/json/authenticate"+queryString);
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
