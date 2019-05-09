import java.util.*;

public class Cons extends Instr {
	
    void exec_instr(Config cfg) {
		ValueSE y = ((ValueSE)(cfg.get_stack().pop()));
		Value x = cfg.get_value();
		PairV p = new PairV(y.get_value(),x);
		cfg.set_value(p);
		cfg.get_code().pop();
    }
	
}