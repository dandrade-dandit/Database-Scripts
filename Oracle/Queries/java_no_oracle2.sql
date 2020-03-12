CREATE OR REPLACE JAVA SOURCE NAMED "SqlComOracle" AS
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class SqlComOracle {
   public static int conecta( String nome )
	{
		Connection bancoconecta = null;

		int contagem = 0;
		
		try
		{
			Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
			bancoconecta = DriverManager.getConnection("jdbc:microsoft:sqlserver://10.160.130.76:1433","infraero","infraero");
		}
		catch (ClassNotFoundException e)
		{
			contagem = 0;
		}
		catch (SQLException e)
		{
			contagem = 0;
		}

		java.sql.Statement stm = null;
	
		try 
		{
			stm = bancoconecta.createStatement();
		} 
		catch (NullPointerException e)
		{
			contagem = 10;
		}
		catch (SQLException e) 
		{
			contagem = 0;
		}

		boolean resultado = false;
		
		try 
		{
		  	resultado = stm.execute("insert INFRAERO..pedro values ( "+nome+" ) ");
		  	contagem = stm.getUpdateCount();
		}
		catch (NullPointerException e)
		{
			contagem = 10;
		}
		catch (SQLException e) 
		{
			contagem = 0;
		}

		return contagem;
		
	}
}
/

CREATE OR REPLACE FUNCTION Fun_SqlComOracle (s varchar2) RETURN NUMBER
AS LANGUAGE JAVA
NAME 'SqlComOracle.conecta(java.lang.String) return int';
/

VARIABLE n varchar2(100)
VARIABLE f NUMBER
EXECUTE :n := 't';

CALL Fun_SqlComOracle(:n) INTO :f;

PRINT f
