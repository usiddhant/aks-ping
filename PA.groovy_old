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
else if (originalUri?.contains("health")){
  
  exc?.request?.setUri(originalUri+"/live");
}




def bodyStrByte = exc?.response?.body?.content;

//exc.log.info "-->Response Body from AM in Byte:: "+ bodyStrByte;



/*if(bodyStr?.contains("authId") && exc?.response?.statusCode == 200  )
{
  exc.log.info "-->Response Body String:: "+ bodyStr;
}*/

if(exc?.response?.statusCode == 200)

{

  def bodyStr = new String(bodyStrByte);
  exc.log.info "-->Response Body String:: "+ bodyStr;
  
  def json = new JsonSlurper().parseText(bodyStr)
  
  if(bodyStr?.contains("authId"))
  {
    
    //json.newField = "addedValue"; //add new field
    //json.realm = "Login"    //update field
    //json.remove("authId")    //remove field

    //exc.log.info "-->Json Body:: "+ json;
    
  }
  else
  {
    json.newField = "addedValue"; //add new field
    json.realm = "Login"    //update field
    json.remove("authId")    //remove field

    exc.log.info "-->Json Body:: "+ json;
  }
  
  def newString = JsonOutput.toJson(json);
  
  exc.log.info "-->Json Body Updated:: "+ newString; 
  
  exc?.response?.setBodyContent(newString.getBytes());
  
}
else if(exc?.response && exc?.response?.statusCode == 401)
{
  def bodyErrStr = new String(bodyStrByte);
  exc.log.info "-->Response Body2:: "+ bodyErrStr;  


  def jsonErr = new JsonSlurper().parseText(bodyErrStr)
  jsonErr.newField = "addedValue"; //add new field
  jsonErr.message = "Custom Error Msg"    //update field
  //jsonErr.remove("authId")    //remove field
 
  exc.log.info "-->Json Body:: "+ jsonErr; 
  
  def newErrString = JsonOutput.toJson(jsonErr);
  
  exc.log.info "-->Json Body Updated:: "+ newErrString; 
  
  exc?.response?.setBodyContent(newErrString.getBytes());
}  



pass()

