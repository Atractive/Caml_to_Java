import java.util.*;

public class Fst extends Instr {
	
    void exec_inst(Config cfg) {
        cfg.set_value(((PairV)(cfg.get_value())).getValueFst());
        cfg.get_code().pop();
    }
	
}