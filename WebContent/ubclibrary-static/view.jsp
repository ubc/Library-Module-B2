<%@page import="ca.ubc.ctlt.ubclibrary.UBCLibrarySigService"%>
<%@page import="ca.ubc.ctlt.ubclibrary.UBCLibraryServlet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import = "java.util.Date" %>
<%@ page import = "blackboard.platform.BbServiceManager" %>
<%@ page import = "blackboard.platform.session.BbSession" %>
<%@ taglib prefix="bbNG" uri="/bbNG"%>
<bbNG:genericPage ctxId="ctx" >

<% 
	UBCLibrarySigService sigService = new UBCLibrarySigService();
	String consumerKey = "ubclibrary";
	String signatureMethod = "HMAC-SHA1";
	String version = "1.0";
	String timestamp = String.valueOf(new Date().getTime()); 
	String nonce = String.valueOf(Math.random() * 100000000);
	String user_id = ctx.getUser().getBatchUid();
	
	String signature = sigService.generateSig(consumerKey, signatureMethod, version, user_id, timestamp, nonce);
%>		
<iframe id="theframe" style="width: 100%; height: 100%;">
</iframe>

<form method="POST" action="<%= new UBCLibraryServlet().getParam("url") %>" id="theform">
	<input type="hidden" value="<%= consumerKey %>" name="oauth_consumer_key" id="oauth_consumer_key">
	<input type="hidden" value="<%= signatureMethod %>" name="oauth_signature_method" id="oauth_signature_method">
	<input type="hidden" value="<%= timestamp %>" name="oauth_timestamp" id="oauth_timestamp">
	<input type="hidden" value="<%= nonce %>" name="oauth_nonce" id="oauth_nonce">
	<input type="hidden" value="<%= version %>" name="oauth_version" id="oauth_version">
	<input type="hidden" value="<%= signature %>" name="oauth_signature" id="oauth_signature">
	<input type="hidden" value="<%= user_id %>" name="user_id" id="user_id">
</form>

<script>
	var theframe = document.getElementById("theframe");
	var frameContent = (theframe.contentDocument) ? theframe.contentDocument: theframe.contentWindow.document;
	var theform = document.getElementById("theform");
	
	frameContent.body.appendChild(theform);
	frameContent.getElementById("theform").submit();
</script>
</bbNG:genericPage>
