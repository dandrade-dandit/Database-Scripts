CREATE OR REPLACE JAVA SOURCE NAMED "Fibonacci" AS
  public class Fibonacci {
  static int t;
  static String txt;
  static String txt2;
  public static String fib (int n) {
     txt = "Inicio!";
     txt += "\nA sequencia eh -> ".concat(Integer.toString(n));
     for (int i=1;i<=n;i++){
     	t = fib2(i);
     	if (i==1) {
     		txt2 = Integer.toString(t);
     	} else {
     		txt2 += ", " + t ;
     	}
     }
     txt += "\nO Resultado eh -> " ;
     txt += txt2;
     txt += "\nO Resultado inverso eh -> "; 
     txt += reverseIt(txt2);
     txt += "\nFim!"; 
     return txt;
  }
  public static int fib2 (int n) {
    if (n == 1 || n == 2)
      return 1;
    else {
      return fib2(n - 1) + fib2(n - 2);
    }
  }
  public static String reverseIt (String s) {
  	StringBuffer sb = new StringBuffer();
  	for (int i = s.length() -1; i >= 0; i--)
  		sb.append(s.charAt(i));
  	return sb.toString();
  }
}
/

CREATE OR REPLACE JAVA SOURCE NAMED "Fibonacci" AS
  public class Fibonacci {
  public static int fib (int n) {
    if (n == 1 || n == 2)
      return 1;
    else 
      return fib(n - 1) + fib(n - 2);
  }
}
/

CREATE OR REPLACE FUNCTION fib (n NUMBER) RETURN NUMBER
AS LANGUAGE JAVA
NAME 'Fibonacci.fib(int) return int';
/

VARIABLE n NUMBER
VARIABLE f NUMBER
EXECUTE :n := 21;

CALL fib(:n) INTO :f;

PRINT f

-----------------------------------------------------------------------------------
CREATE OR REPLACE JAVA SOURCE NAMED "Hello" AS
   public class Hello {
      public static String hello() {
         return "Hello World";   } };
/


CREATE OR REPLACE FUNCTION Hello1 RETURN STRING
AS LANGUAGE JAVA
NAME 'Hello.hello() return String';
/

variable x varchar2(100)

call Hello1() into :x;

print x

-------------------------------------------------------------------------------
CREATE OR REPLACE JAVA SOURCE NAMED "Del" AS
import java.sql.*;
import oracle.jdbc.driver.*;
 
public class Deleter {
  public static void main (String[] args) throws SQLException { 
    Connection conn =
      DriverManager.getConnection("jdbc:default:connection:");
    String sql = "DELETE FROM " + args[0];
    if (args.length > 1) sql += " WHERE " + args[1];
    try {
      Statement stmt = conn.createStatement();
      stmt.executeUpdate(sql);
      stmt.close();
    } catch (SQLException e) {System.err.println(e.getMessage());}
  }
}
/

CREATE OR REPLACE PACKAGE pkg AS
  PROCEDURE delete_rows (table_name VARCHAR2);
  PROCEDURE delete_rows (table_name VARCHAR2, condition VARCHAR2);
END;
/

CREATE OR REPLACE PACKAGE BODY pkg AS
  PROCEDURE delete_rows (table_name VARCHAR2)
  AS LANGUAGE JAVA
  NAME 'Deleter.main(java.lang.String[])';

  PROCEDURE delete_rows (table_name VARCHAR2, condition VARCHAR2) 
  AS LANGUAGE JAVA
  NAME 'Deleter.main(java.lang.String[])';
END;
/



CALL pkg.delete_rows('sysman.teste', 'campo = 1');

CALL pkg.delete_rows('sysman.teste');

SELECT * FROM TESTe;



-------------------------------------------------------------------------------------------
CREATE OR REPLACE JAVA SOURCE NAMED "Cocota" AS
   public class Pergunta {
      public static String seria() {
         return "Cocota tu é, né ?";   } };
/


CREATE OR REPLACE FUNCTION PerguntaSeria RETURN STRING
AS LANGUAGE JAVA
NAME 'Pergunta.seria() return String';
/

variable x varchar2(15)

call PerguntaSeria() into :x;

print x


-----------------------------------------------------------------------------------
CREATE OR REPLACE JAVA SOURCE NAMED "QuadradoCubo" AS
public class QuadradoCubo
{
	public static void main (String z[])
	{
		System.out.println("Numero \tQuadrado \tCubo");
		for (int i = 0; i<= 9; i++)
		{
			System.out.print("" + i + "\t" + i*i + "\t\t" + i*i*i+"\n");
		}
			
		System.exit(0);	
	}	
}
/

CREATE OR REPLACE FUNCTION QuadCudo RETURN varchar2
AS LANGUAGE JAVA
NAME 'QuadradoCubo()';
/

VARIABLE n NUMBER
VARIABLE f NUMBER
EXECUTE :n := 21;

CALL fib(:n) INTO :f;

PRINT f

-----------------------------------------------------------------------------------