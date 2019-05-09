import java.util.*;

public class BinOp extends Instr {
	
    enum operateur{Add,Sub,Mult,Div,Mod,Eq,Ge,Gt,Le,Lt,Ne};
    private operateur o;
    
    public BinOp(operateur op) {
        this.o = oper;
    }
    
    public void exec_instr(Config cfg) {
		
		PairV p = ((PairV)(cfg.getValue()));
		Value v = null;
		
        switch(op){
            case Add: 	v = new IntV(operArith((IntV)(p.getValueFst())),((IntV)(p.getValueSnd())));
            case Sub: 	v = new IntV(operArith((IntV)(p.getValueFst())),((IntV)(p.getValueSnd())));
            case Mult: 	v = new IntV(operArith((IntV)(p.getValueFst())),((IntV)(p.getValueSnd())));
			case Mod: 	v = new IntV(operArith((IntV)(p.getValueFst())),((IntV)(p.getValueSnd())));
            case Div: 	v = new IntV(operArith((IntV)(p.getValueFst())),((IntV)(p.getValueSnd())));
			case Eq:	v = new BoolV(operComp((IntV)(p.getValueFst())),((IntV)(p.getValueSnd())));
			case Ge:	v = new BoolV(operComp((IntV)(p.getValueFst())),((IntV)(p.getValueSnd())));
			case Gt:	v = new BoolV(operComp((IntV)(p.getValueFst())),((IntV)(p.getValueSnd())));
			case Le:	v = new BoolV(operComp((IntV)(p.getValueFst())),((IntV)(p.getValueSnd())));
			case Lt:	v = new BoolV(operComp((IntV)(p.getValueFst())),((IntV)(p.getValueSnd())));
			case Ne:	v = new BoolV(operComp((IntV)(p.getValueFst())),((IntV)(p.getValueSnd())));
        }
		
		cfg.set_value(v);
		cfg.get_code().pop();
		
    }
    
    public int operArith(IntV x, IntV y) {
		
        switch(op){
            case Add:
                return x.getInt() + y.getInt();
            case Sub:
                return x.getInt() - y.getInt();
            case Mult:
                return x.getInt() * y.getInt();
            case Div:
                return x.getInt() / y.getInt();
			case Mod:
				return x.getInt() % y.getInt();
            default: 
                return 0;
        }
		
    }
	
	public boolean operComp(IntV x, IntV y) {
		
        switch(op){
            case Eq:
                return x.getInt() == y.getInt();
            case Ge:
                return x.getInt() >= y.getInt();
            case Gt:
                return x.getInt() > y.getInt();
            case Le:
                return x.getInt() <= y.getInt();
			case Lt:
				return x.getInt() < y.getInt();
			case Ne:
				return x.getInt() != y.getInt();
            default: 
                return false;
        }
		
    }
	
}

