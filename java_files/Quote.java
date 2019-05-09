import java.util.*;

public class Quote extends Instr {
	
	/* Fields */
    Value vv;
	
	/* Constructors */
    public Quote (Value v) {
        this.vv = v;
    }
	
	void set_value(Value v) {
        this.vv = v;
    }

    Value get_value() {
        return this.vv;
    }

    void exec_instr(Config cfg) {
        cfg.set_value(this.vv);
        cfg.get_code().pop();
    }
	
}