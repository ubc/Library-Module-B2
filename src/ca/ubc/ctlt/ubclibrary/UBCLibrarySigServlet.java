package ca.ubc.ctlt.ubclibrary;

import java.io.IOException;
import java.net.URLEncoder;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.DatatypeConverter;

public class UBCLibrarySigServlet extends HttpServlet {

	
	private static final long serialVersionUID = -264235637218959513L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
			UBCLibraryDao dao = new UBCLibraryDao();
			String secretKey = dao.getOption("secret_key");
			response.setContentType("text/html");
			response.getWriter().write(generateSig(secretKey, request.getParameter("baseString")));  
	}

	public String generateSig(String key, String baseString) {
		Mac mac;
		byte[] digest = null;
		try {
			baseString = URLEncoder.encode(baseString, "UTF-8");
			mac = Mac.getInstance("HmacSHA1");
			SecretKeySpec secret = new SecretKeySpec(key.getBytes(), mac.getAlgorithm());
			mac.init(secret);
			digest = mac.doFinal(baseString.getBytes());
		} catch (Exception e) {
		}
		return DatatypeConverter.printBase64Binary(digest);
	}
}
