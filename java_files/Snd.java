import java.util.*;

public class Snd extends Instr {
	
	void exec_inst(Config cfg){
		cfg.set_value(((PairV)(cf.get_value())).getValueSnd());
		cfg.get_code().pop();
	}
	
}