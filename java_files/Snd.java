import java.util.*;

public class Snd extends Instr {
	
	void exec_inst(Config cfg){
		
		//On met à jour le terme et on l'ajoute
		cfg.setValue(((PairV)(cf.getValue())).getValueSnd());
		
		//On dépile
		cfg.getCode().pop();
		
	}
	
}