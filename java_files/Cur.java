import java.util.*;

public class Cur extends Instr {
	
	LinkedList<Instr> cc;
	
	public Cur (LinkedList<Instr> c){
		this.cc = c;
	}
	
    void exec_instr(Config cfg) {
		ValueSE x = new ValueSE(cfg.get_value());
		ClosureV cl = new ClosureV(this.cc,x.get_value());
		cf.set_value(cl);
		cf.get_code().pop();
    }
	
}