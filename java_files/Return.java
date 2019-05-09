import java.util.*;

public class Return extends Instr {
	
    void exec_instr(Config cfg) {
		cfg.get_code().pop();
		CodeSE c = ((CodeSE)(cfg.get_stack().pop()));
		cfg.set_code(c.get_code());
    }
	
}