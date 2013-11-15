<%@page import="ca.ubc.ctlt.ubclibrary.UBCLibraryServlet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import = "java.util.Map" %>
<%@ taglib prefix="bbNG" uri="/bbNG"%>

<bbNG:genericPage ctxId="ctx" >

<form action="<% out.print(request.getContextPath()); %>/setting" method="GET">
	<input type="radio" name="encrypt" value="true" <% if (new UBCLibraryServlet().isSkipencrypt()) {
					out.print("checked=\"checked\"");   		
				} %> > Encrypt data<br>
	<input type="radio" name="encrypt" value="false" <% if (!new UBCLibraryServlet().isSkipencrypt()) {
					out.print("checked=\"checked\"");   		
				} %> > Do not encrypt data
		<br> 
		<br> 
		URL: <input type="text" value="<% out.print(new UBCLibraryServlet().getUrl()); %>" size="50" name="url">
		<br> 
		<br> 
		<input TYPE="SUBMIT" VALUE="Submit">
</form>
</bbNG:genericPage>
