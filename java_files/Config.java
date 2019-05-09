import java.util.*;

class Config extends Object {
	
    Value vv;
    LinkedList<Instr> cc;
    LinkedList<StackElem> ss;
	Map<String,LinkedList<Instr>> fds;
	
	/* Constructors */
    public Config (Value v, LinkedList<Instr> c, LinkedList<StackElem> s, Map<String,LinkedList<Instr>> f) {
        vv = v;
        cc = c;
        ss = s;
		fds = f;
    }
	
	/* Set */
	
	void set_value(Value v) {
        this.vv = v;
    }
	
    void set_code(LinkedList<Instr> c) {
        this.cc = c;
    }
	
    void get_stack(LinkedList<StackElem> s) {
        this.ss = s;
    }
	
	void set_fds(Map<String,LinkedList<Instr>> f) {
		this.fds = f;
	}
	
	/* Get */

    Value get_value() {
        return this.vv;
    }
	
    LinkedList<Instr> get_code() {
        return this.cc;
    }
	
    LinkedList<StackElem> get_stack() {
        return this.ss;
    }
	
	Map<String,LinkedList<Instr>> get_fds() {
		return this.fds;
	}
	
	/* exec */

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