<%@page import="ca.ubc.ctlt.ubclibrary.UBCLibraryServlet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import = "java.security.Key" %>
<%@ page import = "javax.crypto.Cipher" %>
<%@ page import = "javax.crypto.spec.SecretKeySpec" %>
<%@ page import = "javax.xml.bind.DatatypeConverter" %>
<%@ page import = "blackboard.platform.BbServiceManager" %>
<%@ page import = "blackboard.platform.session.BbSession" %>
<%@ taglib prefix="bbNG" uri="/bbNG"%>
<bbNG:genericPage ctxId="ctx" >

<% 
		String puid = ctx.getUser().getBatchUid();
%>		
<iframe id="theframe" style="width: 100%; height: 100%;">
</iframe>

<form method="POST" action="<% out.print(new UBCLibraryServlet().getParam("url")); %>" id="theform">
	<input type="hidden" value="ubclibrary" name="oauth_consumer_key" id="oauth_consumer_key">
	<input type="hidden" value="HMAC-SHA1" name="oauth_signature_method" id="oauth_signature_method">
	<input type="hidden" value="" name="oauth_timestamp" id="oauth_timestamp">
	<input type="hidden" value="" name="oauth_nonce" id="oauth_nonce">
	<input type="hidden" value="1.0" name="oauth_version" id="oauth_version">
	<input type="hidden" value="" name="oauth_signature" id="oauth_signature">
	<input type="hidden" value="<%out.print(puid);%>" name="puid" id="puid">
</form>

<script>
	var timestamp = new Date().getTime(); 
	var nonce = Math.random() * 100000000;
	document.getElementById("oauth_timestamp").value = timestamp;
	document.getElementById("oauth_nonce").value = nonce;

	var consumerKey = document.getElementById("oauth_consumer_key").value;
	var signatureMethod = document.getElementById("oauth_signature_method").value;
	var version = document.getElementById("oauth_version").value;
	var url = "<% out.print(new UBCLibraryServlet().getParam("url")); %>";
	var puid = "<%out.print(puid);%>";
	
	var baseString = "POST&" + url
	+ "&oauth_consumer_key=" + consumerKey 
	+ "&oauth_nonce=" + nonce
	+ "&oauth_signature_method=" + signatureMethod
	+ "&oauth_timestamp=" + timestamp
	+ "&oauth_version=" + version
	+ "&puid=" + puid;
		

	var options = { 
		    method: "get", 
		    parameters: {"baseString": baseString},
		    onComplete: submitForm 
		}; 
	new Ajax.Request('/webapps/ubc-library-module-BBLEARN//signature', options);
		
	function submitForm(resp) {
		document.getElementById("oauth_signature").value = resp.responseText;
		
		var theframe = document.getElementById("theframe");
		var frameContent = (theframe.contentDocument) ? theframe.contentDocument: theframe.contentWindow.document;
		var theform = document.getElementById("theform");
		
		frameContent.body.appendChild(theform);
		frameContent.getElementById("theform").submit();
	}	
</script>
</bbNG:genericPage>
