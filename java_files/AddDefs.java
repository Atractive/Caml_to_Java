import java.util.*;

class AddDefs extends Instr {
	
	LinkedList<Couple<String, LinkedList<Instr>>> defs;
	
	public AddDefs (LinkedList<Couple<String,LinkedList<Instr>>> d) {
		this.defs = d;
	}
	
	void exec_instr(Config cfgg) {
		cfg.get_code().pop();
		LinkedList<Couple<String,LinkedList<Instr>>> fds = cfg.get_fds();
		this.defs.addAll(fds);
		cfg.set_fds(defs);
    }
	
}