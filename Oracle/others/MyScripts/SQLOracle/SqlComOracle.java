import java.sql.Connection;
import java.sql.DriverManager;
//import java.sql.ResultSet;
import java.sql.SQLException;
/**
 * 
 */
 

/**
 * @author GEAC_PEDRO
 *
 */
public class SqlComOracle {

	/**
	 * @param args
	 */
//	public static void main(String[] args) {
		// TODO Auto-generated method stub
//		conecta();
//	}
	
	public int conecta( String nome )
	{
		Connection bancoconecta = null;

		int contagem = 0;
		
		try
		{
			Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
			bancoconecta = DriverManager.getConnection("jdbc:microsoft:sqlserver://10.160.130.76:1433","usuario","senha");
		}
		catch (ClassNotFoundException e)
		{
			contagem = 0;
//			e.printStackTrace();
		}
		catch (SQLException e)
		{
			contagem = 0;
//			e.printStackTrace();
		}

		java.sql.Statement stm = null;
	
		try 
		{
			stm = bancoconecta.createStatement();
		} 
		catch (SQLException e) 
		{
			contagem = 0;
//			e.printStackTrace();
		}

		boolean resultado = false;
		
		try 
		{
		  	resultado = stm.execute("insert INFRAERO..pedro values ( "+nome+" ) ");
		  	contagem = stm.getUpdateCount();
		}
		catch (SQLException e) 
		{
			contagem = 0;
//			e.printStackTrace();
		}

		return contagem;
		
	}

}
