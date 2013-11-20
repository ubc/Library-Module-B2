package ca.ubc.ctlt.ubclibrary;

import java.net.URLEncoder;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.xml.bind.DatatypeConverter;

public class UBCLibrarySigService {

	public String generateSig(String consumerKey, String signatureMethod, String version,
			String puid, String timestamp, String nonce) {
		Mac mac;
		byte[] digest = null;
		
		UBCLibraryDao dao = new UBCLibraryDao();
		String secretKey = dao.getOption("secret_key");
		String url = dao.getOption("url");
		
		String baseString = "POST&" + url
			+ "&oauth_consumer_key=" + consumerKey 
			+ "&oauth_nonce=" + nonce
			+ "&oauth_signature_method=" + signatureMethod
			+ "&oauth_timestamp=" + timestamp
			+ "&oauth_version=" + version
			+ "&puid=" + puid;
		
		try {
			baseString = URLEncoder.encode(baseString, "UTF-8");
			mac = Mac.getInstance("HmacSHA1");
			SecretKeySpec secret = new SecretKeySpec(secretKey.getBytes(), mac.getAlgorithm());
			mac.init(secret);
			digest = mac.doFinal(baseString.getBytes());
		} catch (Exception e) {
		}
		return DatatypeConverter.printBase64Binary(digest);
	}
}
