import java.util.*;

public class Branch extends Instr {
	
    private LinkedList<Instr> cc1;
	private LinkedList<Instr> cc2;

    /* Constructors */
    public Branch(LinkedList<Instr> c1, LinkedList<Instr> c2) {
        this.cc1 = c1;
		this.cc2 = c2;
    }
	    
    LinkedList<Instr> getCode1() {
        return this.cc1;
    }

    LinkedList<Instr> getCode2() {
        return this.cc2;
    }
	
    void exec_instr(Config cfg) {
        cfg.getCode().pop();
    }
	
}