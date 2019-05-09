import java.util.*;

public class Push extends Instr {
	
    void exec_instr(Config cfg) {
		
		//On met à jour le terme et on l'ajoute
		ValueSE x = new ValueSE(cf.getValue());
		cfg.getStack().addFirst(x);
		
		//On dépile
		cfg.getCode().pop();
		
    }
	
}