package ca.ubc.ctlt.ubclibrary;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import blackboard.db.BbDatabase;
import blackboard.db.ConnectionManager;

public class UBCLibraryDao {

	public String getOption(String pk1) {
		ConnectionManager cManager = null;
	    Connection conn = null;
	    PreparedStatement selectQuery = null;
	    String optvalue = "";
	    
	    try {
			
			cManager = BbDatabase.getDefaultInstance().getConnectionManager();
		    conn = cManager.getConnection();
		
		    String queryString = "SELECT optvalue FROM ubc_libraryconfig WHERE PK1 = ?";
		    selectQuery = conn.prepareStatement(queryString, ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
		    selectQuery.setString(1, pk1);
		    ResultSet rSet = selectQuery.executeQuery();
		    while(rSet.next()){
		    	optvalue = rSet.getString(1);
		    }
		    
		    rSet.close();
		    
		    selectQuery.close();
		
		} catch (Exception e){
			e.printStackTrace();
		} finally {
		    if(conn != null){
		        cManager.releaseConnection(conn);
		    }
		}
	    return optvalue;
	}
	
	public void setOption(String pk1, String optvalue) {
        ConnectionManager cManager = null;
        Connection conn = null;
        PreparedStatement selectQuery = null;

        try {
        	boolean insert = false;
            cManager = BbDatabase.getDefaultInstance().getConnectionManager();
            conn = cManager.getConnection();

            String queryString = "SELECT count(optvalue) FROM ubc_libraryconfig WHERE PK1 = ?";
            
		    selectQuery = conn.prepareStatement(queryString, ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
		    selectQuery.setString(1, pk1);
		    ResultSet rSet = selectQuery.executeQuery();
		    while(rSet.next()){
		    	if (rSet.getString(1).equals("0")) {
		    		insert = true;
		    	}
		    }
		    rSet.close();
		    selectQuery.close();
		    
            queryString = insert ? "INSERT INTO ubc_libraryconfig (optvalue, PK1) VALUES (?,?)" :
            	"UPDATE ubc_libraryconfig SET optvalue = ? WHERE PK1 = ?";


            PreparedStatement insertQuery = conn.prepareStatement(queryString.toString());
            insertQuery.setString(1, optvalue);
            insertQuery.setString(2, pk1);

            insertQuery.executeUpdate();
            insertQuery.close();

        } catch (Exception e){
        } finally {
            if(conn != null){
                cManager.releaseConnection(conn);
            }
        }
	}
}
