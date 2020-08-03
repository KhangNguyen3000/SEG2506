import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class Devoir3 {

	private static String fileName = "input1.txt";
	
	
	private static Scanner scanner;
	private static String token;

	public static void getNextToken() {
		token = scanner.nextLine();
	}

	public static boolean program() {
		if (token.equals("{")) {
			getNextToken();
			return statementList();
		}
		return false;
	}

	public static boolean statementList() {
		if (statement() == true) {
			if(token.equals(";")) {
				getNextToken();
				return statementListPrime();
			}
		}
		return false;
	}

	public static boolean statementListPrime() {
		if (token.equals("}")) {
			getNextToken();
			return true;
		} else {
			return statementList();
		}
	}

	public static boolean statement() {
		if (token.equals("call")) {
			getNextToken();
			if (token.equals(":")) {
				getNextToken();
				return procedureCall();
			}
		} else {
			if (token.equals("compute")) {
				getNextToken();
				if (token.equals(":")) {
					getNextToken();
					return expression();
				}
			}
		}
		return false;
	}

	public static boolean procedureCall() {
		if (token.equals("id")) {
			getNextToken();
			if (token.equals("(")) {
				getNextToken();
				return parameters();
			}
		}
		return false;
	}

	public static boolean parameters() {
		if (factor() == true) {
			return parametersPrime();
		}
		return false;
	}

	public static boolean parametersPrime() {
		if (token.equals(",")) {
			getNextToken();
			if (parameters() == true) {
				return true;
			}
		} else {
			if (token.equals(")")) {
				getNextToken();
				return true;
			}
		}
		return false;
	}

	public static boolean expression() {
		if (token.equals("id")) {
			getNextToken();
			if (token.equals("=")) {
				getNextToken();
				if (factor() == true) {
					return expressionPrime();
				}
			}
		}
		return false;
	}

	public static boolean expressionPrime() {
		if (token.equals("+")) {
			getNextToken();
			return factor();
		} else {
			if (token.equals("-")) {
				getNextToken();
				return factor();
			} else {
				return token.equals(";");
			}
		}
	}

	public static boolean factor() {
		if (token.equals("id")) {
			getNextToken();
			return true;
		} else {
			if (token.equals("num")) {
				getNextToken();
				return true;
			} else {
				return false;
			}
		}
	}

	public static void main(String args[]) throws FileNotFoundException {
		System.out.println("File being ran is "+fileName+" inside of project base");
		File file = new File(fileName);
		scanner = new Scanner(file);
		getNextToken();
		if (program() == false || !token.equals("$")) {
			System.out.println("ERROR");
		} else {
			System.out.println("OK");
		}
	}

}
