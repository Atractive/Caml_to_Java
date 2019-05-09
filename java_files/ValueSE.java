import java.util.*;

public class ValueSE extends StackElem {
	
	/* Fields */
    Value vv;
    
	/* Constructors */
    public ValueSE(Value v) {
        this.vv = v;
    }

    public Value get_valeur() {
        return this.vv;
    }
    
}