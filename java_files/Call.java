import java.util.*;

public class Call extends Instr {
	
	String ss;
	
	public Call (String s) {
		this.ss = s;
	}
	
	void exec_instr(Config cfgg) {
		cfg.get_code().pop();
		LinkedList<Couple<String, LinkedList<Instr>>> fds = cfg.get_fds();
		for (int i=0; i<fds.size(); i++){
			if (fds.get(i).get_fst().equals(v)){
				LinkedList<Instr> c = new LinkedList<Instr>(fds.get(i).get_snd());
				c.addAll(cfg.get_code());
				cfg.set_code(c);
				break;
			}
		}
	}
    
}