import java.util.*;

class ClosureV extends Value {
	
    /* Fields */
    LinkedList<Instr> cc;
	Value vv;

    /* Constructors */
    public ClosureV (LinkedList<Instr> c, Value v) {
		this.cc = c;
		this.vv = v;
    }

    LinkedList<Instr> get_code () {
        return this.cc;
    }
	
    Value get_val () {
        return this.vv;
    }

    void print_value() {
        System.out.print(this.vv);
    }
	
}