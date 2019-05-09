import java.util.*;

public class Swap extends Instr {
	
    void exec_instr(Config cfg) {
		ValueSE y = ((ValueSE)(cfg.get_stack().pop()));
		ValueSE x = new ValueSE(cfg.get_value());
		cfg.set_value(y.get_value());
		cfg.get_stack().add(x);
        cfg.get_code().pop();
    }
	
}