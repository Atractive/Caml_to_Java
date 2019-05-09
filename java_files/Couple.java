import java.util.*;

public class Couple<First,Second> {
	
    First fst;
    Second snd;
    
    public Couple(First f, Second s){
        this.fst = f;
        this.snd = s;
    }
    
    public First get_fst(){
		return fst;
	}
    
    public Second get_snd(){
		return snd;
	}
    
}