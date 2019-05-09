import java.util.*;

public class RmDefs extends Instr {
	
	int nn;
	
	public RmDefs (int n){
		this.nn = n;
	}
	
	void exec_instr(Config cfg) {
		cfg.get_code().pop();
		LinkedList<Couple<String, LinkedList<Instr>>> fds = cfg.get_fds();
		for(int i=0;i<n;i++) {fds.pop();}
		cfg.set_fds(new LinkedList<Couple<String,LinkedList<Instr>>> (fds));
    }
	
}