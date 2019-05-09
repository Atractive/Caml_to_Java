

public class App extends Instr {
	
    void exec_instr(Config cfg) {
		
		//On dépile
		cfg.getCode().pop();
		
		//On recupère le terme de la config
		PairV p = ((PairV)(cfg.getValue()));
		ClosureV cl = ((ClosureV)(p.getValueFst()));
		ValueSE y = new ValueSE (cl.getValue());
		ValueSE z = new ValueSE (p.getValueSnd());
		
		//On met à jour le terme et on l'ajoute
		PairV new_p = new PairV(y.getValue(),z.getValue());
		cfg.setValue(new_p);
		cfg.getStack().addFirst(new CodeSE(cfg.getCode()));
		cfg.setCode(new LinkedList<Instr>(cl.getCode()));
    }
	
}