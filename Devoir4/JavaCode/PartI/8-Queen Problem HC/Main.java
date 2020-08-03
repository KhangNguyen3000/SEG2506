import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

public class Main {

	private final static int threadCount = 5;
	
	@SuppressWarnings({ "unchecked" })
	public static void main(String[] args) throws InterruptedException, ExecutionException {

		int n = 0;
		try (Scanner s = new Scanner(System.in)) {
			while (true) {
				System.out.println("Enter the number of Queens :");
				n = s.nextInt();
				if (n == 2 || n == 3) {
					System.out.println("No Solution possible for " + n + " Queens. Please enter another number");
				} else
					break;
			}
		}
		long timestamp1 = System.currentTimeMillis();

		System.out.println("Solution to " + n + " queens using hill climbing search:");

		ExecutorService group = Executors.newFixedThreadPool(threadCount);
		HillClimbingSearch runnable = new HillClimbingSearch(n);
		List<Future<NQueen[]>> list = new ArrayList<Future<NQueen[]>>(); //list of future returns
		for(int i = 0; i < threadCount; i++) {
			list.add(group.submit(runnable));//run each thread and add the future return to the list
		}
		
		boolean flag = true;
		while(flag) {
			for(int i = 0; i < threadCount; i++) {//check each thread
				if(list.get(i).isDone()) {//check if the future return is populated
					flag = false;
					runnable.printState(list.get(i).get());//print solution
					group.shutdownNow();//shutdown all threads
					break;
				}
			}
		}

		// Printing the solution
		long timestamp2 = System.currentTimeMillis();

		long timeDiff = timestamp2 - timestamp1;
		System.out.println("Execution Time: " + timeDiff + " ms");

	}
}