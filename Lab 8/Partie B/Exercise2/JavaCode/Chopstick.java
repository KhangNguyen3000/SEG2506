public class Chopstick {
	private int ID;
// hint: use a local variable to indicate whether the chopstick is free 
//                        (lying on the table), e.g.  private boolean free;
	private boolean free = true;

	Chopstick(int ID) {
		this.ID = ID;

	}

	synchronized void take() {
		if (!free) {
			try {
				wait();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		free = false;
	}

	synchronized void release() {
		free = true;
		notify();
	}

	public int getID() {
		return (ID);
	}
}
