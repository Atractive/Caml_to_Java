import java.util.*;

public class Cur extends Instr {
	
	private LinkedList<Instr> cc;
	
	public Cur (LinkedList<Instr> c){
		this.cc = c;
	}
	
    void exec_instr(Config cfg) {
		
		//On met à jour le terme et on l'ajoute
		ValueSE x = new ValueSE(cfg.getValue());
		ClosureV cl = new ClosureV(this.cc,x.getValue());
		cf.setValue(cl);
		
		//On dépile
		cf.getCode().pop();
		
    }
	
}