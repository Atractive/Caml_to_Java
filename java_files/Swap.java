import java.util.*;

public class Swap extends Instr {
	
    void exec_instr(Config cfg) {
		
		//On met à jour le terme et on l'ajoute
		ValueSE y = ((ValueSE)(cfg.getStack().pop()));
		ValueSE x = new ValueSE(cfg.getValue());
		cfg.setValue(y.getValue());
		cfg.getStack().add(x);
		
		//On dépile
        cfg.getCode().pop();
    }
	
}