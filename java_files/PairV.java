import java.util.*;

public class PairV extends Value{
	
	/* Fields */
    Value fst;
	Value snd;
    
	/* Constructors */
    public PairV(Value f, Value s) {
        this.fst = f;
        this.snd = s;
    }
	
	public void setValueFst(Value f) {
		this.fst = f;
	}
	
    public void setValueSnd(Value nsnd) {
		this.snd = s;
	}
    
    public Value getValueFst() {
		return this.f;
	}
	
    public Value getValueSnd() {
		return this.s;
	}
	
	void print_value() {
        System.out.println(this.fst);
		System.out.println(this.snd);
    }
	
}