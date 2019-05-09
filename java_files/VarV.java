import java.util.*;

public class VarV extends Value {

    /* Fields */
    String vv;

    /* Constructors */
    public VarV (String v) {
		this.vv = v;
    }
	
	void set_var (String v) {
        this.vv = v;
    }

    String get_var () {
        return this.vv;
    }

    void print_value() {
        System.out.print(this.vv);
    }
	
}