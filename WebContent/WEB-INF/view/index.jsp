<%@page import="ca.ubc.ctlt.ubclibrary.UBCLibraryServlet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="bbNG" uri="/bbNG"%>

<bbNG:genericPage ctxId="ctx" >

<form action="<% out.print(request.getContextPath()); %>/setting" method="GET">
		URL: <input type="text" value="<% out.print(request.getAttribute("url").toString()); %>" size="50" name="url">
		<br> 
		<br> 
		Secret Key: <input type="text" value="<% out.print(request.getAttribute("secret_key").toString()); %>" size="30" name="secret_key">
		<br> 
		<br> 
		<input TYPE="SUBMIT" VALUE="Submit">
</form>
</bbNG:genericPage>
