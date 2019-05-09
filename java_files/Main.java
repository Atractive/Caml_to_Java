import java.util.*;

// compile with: javac *java
// run with: java Main
public class Main {
    
    public static void main(String[] args) {

        LinkedList<Integer> ll1, ll2;
        LinkedList<Instr> example_code ;
		LinkedList<Couple<String,LinkedList<Instr>>> fds;
        Config cfg;

        cfg = new Config(new NullV(),Gen.code,LLE<>.empty(),LLE<>.empty());
        cfg.exec();
        cfg.getValue().printValue();
        System.out.println();
        
    }

}