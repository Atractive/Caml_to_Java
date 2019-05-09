import java.util.*;

class Config extends Object {
	
    private Value vv;
    private LinkedList<Instr> cc;
    private LinkedList<StackElem> ss;
	private Map<String,LinkedList<Instr>> fds;
	
	/* Constructors */
    public Config (Value v, LinkedList<Instr> c, LinkedList<StackElem> s, Map<String,LinkedList<Instr>> f) {
        this.vv = v;
        this.cc = c;
        this.ss = s;
		this.fds = f;
    }
	
	/* ********************* */
	/* Set */
	/* ********************* */
	
	void setValue(Value v) {
        this.vv = v;
    }
	
    void setCode(LinkedList<Instr> c) {
        this.cc = c;
    }
	
    void getStack(LinkedList<StackElem> s) {
        this.ss = s;
    }
	
	void setFds(Map<String,LinkedList<Instr>> f) {
		this.fds = f;
	}
	
	/* ********************* */
	/* Get */
	/* ********************* */

    Value getValue() {
        return this.vv;
    }
	
    LinkedList<Instr> getCode() {
        return this.cc;
    }
	
    LinkedList<StackElem> getStack() {
        return this.ss;
    }
	
	Map<String,LinkedList<Instr>> getFds() {
		return this.fds;
	}
	
	/* ********************* */
	/* exec */
	/* ********************* */

    // one-step execution 
    boolean exec_step() {
        if (c.isEmpty()) {return false;} 
		else {return true;}
    }

    // run to completion
    void exec() {
        while (exec_step()) {}
    }

    // run for n steps
    void step(int n) {
        System.out.print(n);
    }
    
}