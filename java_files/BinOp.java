import java.util.*;

public class BinOp extends Instr {
	
    enum operateur{Add,Sub,Mult,Div,Mod,Eq,Ge,Gt,Le,Lt,Ne};
    operateur o;
    
    public BinOp(operateur op) {
        this.o = oper;
    }
    
    public void exec_instr(Config cf) {
		
		PairV p = ((PairV)(cf.get_value()));
		Value v = null;
		
        switch(op){
            case Add: 	v = new IntV(operArith((IntV)(p.getValue1())),(IntV)(p.getValue2()));
            case Sub: 	v = new IntV(operArith((IntV)(p.getValue1())),(IntV)(p.getValue2()));
            case Mult: 	v = new IntV(operArith((IntV)(p.getValue1())),(IntV)(p.getValue2()));
			case Mod: 	v = new IntV(operArith((IntV)(p.getValue1())),(IntV)(p.getValue2()));
            case Div: 	v = new IntV(operArith((IntV)(p.getValue1())),(IntV)(p.getValue2()));
			case Eq:	v = new BoolV(operComp((IntV)(pair.getValue1())),(IntV)(pair.getValue2()));
			case Ge:	v = new BoolV(operComp((IntV)(pair.getValue1())),(IntV)(pair.getValue2()));
			case Gt:	v = new BoolV(operComp((IntV)(pair.getValue1())),(IntV)(pair.getValue2()));
			case Le:	v = new BoolV(operComp((IntV)(pair.getValue1())),(IntV)(pair.getValue2()));
			case Lt:	v = new BoolV(operComp((IntV)(pair.getValue1())),(IntV)(pair.getValue2()));
			case Ne:	v = new BoolV(operComp((IntV)(pair.getValue1())),(IntV)(pair.getValue2()));
        }
		
		cf.set_value(v);
		cf.get_code().pop();
		
    }
    
    public int operArith(IntV a, IntV b) {
		
        switch(op){
            case Add:
                return a.get_int() + b.get_int();
            case Sub:
                return a.get_int() - b.get_int();
            case Mult:
                return a.get_int() * b.get_int();
            case Div:
                return a.get_int() / b.get_int();
			case Mod:
				return a.get_int() % b.get_int();
            default: 
                return 0;
        }
		
    }
	
	public boolean operComp(IntV a, IntV b) {
		
        switch(op){
            case Eq:
                return a.get_int() == b.get_int();
            case Ge:
                return a.get_int() >= b.get_int();
            case Gt:
                return a.get_int() > b.get_int();
            case Le:
                return a.get_int() <= b.get_int();
			case Lt:
				return a.get_int() < b.get_int();
			case Ne:
				return a.get_int() != b.get_int();
            default: 
                return false;
        }
		
    }
	
}

