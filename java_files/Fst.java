import java.util.*;

public class Fst extends Instr {
	
    void exec_inst(Config cfg) {
		
		//On met à jour le terme et on l'ajoute
        cfg.setValue(((PairV)(cfg.getValue())).getValueFst());
		
		//On dépile
        cfg.getCode().pop();
    }
	
}