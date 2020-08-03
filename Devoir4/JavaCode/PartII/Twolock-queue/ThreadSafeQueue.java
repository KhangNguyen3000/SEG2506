import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

/**
 * A thread-safe Queue implementation. It grows without capacity, and returns
 * null when the queue is empty.
 *
 */
public class ThreadSafeQueue implements SimpleQueue {

	private QueueNode head = null;
	private QueueNode tail = null;
	private Lock headLock = new ReentrantLock();
	private Lock tailLock = new ReentrantLock();

	private static class QueueNode {
		private final Object data;
		private QueueNode next;

		public QueueNode(Object data) {
			this.data = data;
			next = null;
		}

		public QueueNode() {
			this.data = null;
		}
	}

	// returns null if the queue is empty
	public synchronized Object dequeue() {
		headLock.lock();
		QueueNode newHead = head.next;
		if (newHead != null) {
			Object retVal = newHead.data;
			head = newHead;
			headLock.unlock();
			return retVal;
		} else {
			headLock.unlock();
			return null;
		}
	}

	public synchronized void enqueue(Object arg) {
		assert (arg != null);
		QueueNode newNode = new QueueNode(arg);
		tailLock.lock();
		if(head == null) {
			head = tail = newNode;
		} else {
		tail.next = newNode;
		tail = newNode;
		}
		tailLock.unlock();
	}

}
