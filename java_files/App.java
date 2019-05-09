import java.util.*;

public class App extends Instr {
	
    void exec_instr(Config cfg) {
		cfg.get_code().pop();
		PairV p = ((PairV)(cfg.get_value()));
		ClosureV cl = ((ClosureV)(p.getValue1()));
		ValueSE y = new ValueSE (cl.get_val());
		ValueSE z = new ValueSE (p.getValue2());
		PairV new_p = new PairV(y.get_value(),z.get_value());
		cfg.set_value(new_p);
		cfg.get_stack().add(new CodeSE(cfg.get_code()));
		cfg.set_code(cl.get_code());
    }
	
}