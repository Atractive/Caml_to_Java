import java.util.*;

public class Branch extends Instr {
	
    LinkedList<Instr> cc1;
	LinkedList<Instr> cc2;

    /* Constructors */
    public Branch(LinkedList<Instr> c1, LinkedList<Instr> c2) {
        this.cc1 = c1;
		this.cc2 = c2;
    }
	    
    LinkedList<Instr> get_code1() {
        return this.cc1;
    }

    LinkedList<Instr> get_code2() {
        return this.cc2;
    }
	
    void exec_instr(Config cfg) {
        cfg.get_code().pop();
    }
	
}