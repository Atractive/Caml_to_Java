import java.util.*;

public class BoolV extends Value {
	
    /* Fields */
    Boolean bv;

    /* Constructors */
    public BoolV (Boolean b) {
		this.bv = b;
    }
	
	void set_boolean (Boolean b) {
        this.bv = b;
    }

    Boolean get_boolean () {
        return this.bv;
    }

    void print_value() {
        System.out.print(this.bv);
    }
	
}