import java.util.*;

public class Push extends Instr {
	
    void exec_instr(Config cfg) {
		ValueSE x = new ValueSE(cf.get_value());
		cfg.get_stack().addFirst(x);
		cfg.get_code().pop();
    }
	
}