public class Chopstick {
	private int ID;
// hint: use a local variable to indicate whether the chopstick is free 
//                        (lying on the table), e.g.  private boolean free;
	private boolean free = true;

	Chopstick(int ID) {
		this.ID = ID;

	}

	synchronized boolean take() {
		if (!free) {
			try {
				wait(1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		if (!free) {
			return false;
		} else {
			free = false;
			return true;
		}
	}

	synchronized void release() {
		free = true;
		notify();
	}

	public int getID() {
		return (ID);
	}
}
