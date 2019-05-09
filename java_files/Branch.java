import java.util.*;

public class Branch extends Instr {
	
    private LinkedList<Instr> cc1;
	private LinkedList<Instr> cc2;

    /* Constructors */
    public Branch(LinkedList<Instr> c1, LinkedList<Instr> c2) {
        this.cc1 = c1;
		this.cc2 = c2;
    }
	    
    LinkedList<Instr> getCode1() {
        return this.cc1;
    }

    LinkedList<Instr> getCode2() {
        return this.cc2;
    }
	
    void exec_instr(Config cfg) {
		
		//On dépile
        cf.getCode().pop();
		
		//On récupère le booleen
		BoolV b = (BoolV) cf.getValue();
		
		//On dépile la pile
		ValueSE x = (ValueSE) cf.getStack().pop();
		
		//On donne la valeur de x dans le terme de la config
		cf.setValue(x.getValue());
		
		//On ajoute le reste du code dans la pile
		cf.getStack().addFirst(new CodeSE(cf.getCode()));
		
		//On execute un code différent selon le booleen
		//Ici, on copie la liste pour éviter les problèmes évoqués dans le sujet
		if (b.getBoolean()) {
			cf.setCode(new LinkedList<Instr> (code1));
		} else {
			cf.setCode(new LinkedList<Instr> (code2));
		}
    
    }
	
}