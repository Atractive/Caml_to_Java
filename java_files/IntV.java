import java.util.*;

public class IntV extends Value {
	
    /* Fields */
    int iv;

    /* Constructors */
    public IntV (int i) {
		this.iv = i;
    }
	
	void set_int (int i) {
        this.iv = i;
    }

    int get_int () {
        return this.iv;
    }

    void print_value() {
        System.out.print(this.iv);
    }
	
}