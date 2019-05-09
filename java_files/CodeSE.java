import java.util.*;

public class CodeSE extends StackElem {
	
	/* Fields */
    LinkedList<Instr> cc;
	
	/* Constructors */
    public CodeSE(LinkedList<Instr> c) {
        this.cc = c;
    }

    public LinkedList<Instr> get_code() {
        return this.cc;
    }  
    
}