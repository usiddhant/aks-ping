
// ======Transforming request/response=====

exc?.log.info "-->Request URI Original: " + exc?.request?.uri;
originalUri = exc?.request?.uri;


if( originalUri?.contains("login") )
{
  exc?.request?.setUri("/am/json/authenticate");
}
else{
  
  exc?.request?.setUri(originalUri+"/live");
}





if(exc?.response) {
  
//def bodyStr = new String(test);

//bodyStr = bodyStr.add("mobile", "1234567891");
exc.log.info "-->Response Body:: "+ exc?.response?.body  

//exc?.response?.setBodyContent("It looks good".getBytes());
    
}

pass()
