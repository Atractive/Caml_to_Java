
(* Instructions of the CAM *)

open Miniml;;

type instr =
	PrimInstr of primop
	| Cons
	| Push
	| Swap
	| Return
	| Quote of value
	| Cur of code
	| App
	| Branch of code * code
	| Call of var
	| AddDefs of (var * code) list
	| RmDefs of int

and value =
	NullV 
	| VarV of Miniml.var
	| IntV of int
	| BoolV of bool
	| PairV of value * value
	| ClosureV of code * value

and code = 
	instr list
  
type stackelem = Val of value | Cod of code

(* ****************************** *)

(* Exercice 1 - Fonction exec *)

let rec chop n fds = match n,fds with
	(1,a::fds) -> fds
	| (n,fds) -> chop (n-1) (fds);;

let rec exec_aux = function
	(* Divers *)
	(PairV(x,y),PrimInstr(UnOp(Fst))::c,st,fds) -> exec_aux(x,c,st,fds) (* Fst *)
	| (PairV(x,y),PrimInstr(UnOp(Snd))::c,st,fds) -> exec_aux(y,c,st,fds) (* Snd *)
	| (x,Cons::c,(Val y)::d,fds) -> exec_aux(PairV(y,x),c,d,fds) (* Cons *)
	| (x,Push::c,d,fds) -> exec_aux(x, c, (Val x)::d,fds) (* Push *)
	| (x,Swap::c,(Val y)::d,fds) -> exec_aux(y,c,(Val x)::d,fds) (* Swap *)
	| (t,(Quote v)::c,d,fds) -> exec_aux(v,c,d,fds) (* Quote *)
	| (x,(Cur c1)::c,d,fds) -> exec_aux(ClosureV(c1,x),c,d,fds) (* Cur *)
	| (x,Return::c,(Cod cc)::d,fds) -> exec_aux(x,cc,d,fds) (* Return *)
	| (PairV(ClosureV(x,y),z),(App::c),d,fds) -> exec_aux(PairV(y,z),x,(Cod c)::d,fds) (* App *)
	| ((BoolV b),Branch(c1,c2)::c,(Val x)::d,fds) -> exec_aux(x,(if b then c1 else c2),(Cod c)::d,fds) (* Branch *)
	(* Opérations *)
	| (PairV((IntV m), (IntV n)), PrimInstr(BinOp(BArith(BAadd)))::c, d, fds) -> exec_aux(IntV (m + n), c, d, fds) (* + *)
	| (PairV((IntV m), (IntV n)), PrimInstr(BinOp(BArith(BAsub)))::c, d, fds) -> exec_aux(IntV (m - n), c, d, fds) (* - *)
	| (PairV((IntV m), (IntV n)), PrimInstr(BinOp(BArith(BAmul)))::c, d, fds) -> exec_aux(IntV (m * n), c, d, fds) (* * *)
	| (PairV((IntV m), (IntV n)), PrimInstr(BinOp(BArith(BAdiv)))::c, d, fds) -> exec_aux(IntV (m / n), c, d, fds) (* / *)
	| (PairV((IntV m), (IntV n)), PrimInstr(BinOp(BArith(BAmod)))::c, d, fds) -> exec_aux(IntV (m mod n), c, d, fds) (* mod *)
	| (PairV((IntV m), (IntV n)), PrimInstr(BinOp(BCompar(BCeq)))::c, d, fds) -> exec_aux(BoolV (m == n), c, d, fds) (* == *)
	| (PairV((IntV m), (IntV n)), PrimInstr(BinOp(BCompar(BCge)))::c, d, fds) -> exec_aux(BoolV (m >= n), c, d, fds) (* >= *)
	| (PairV((IntV m), (IntV n)), PrimInstr(BinOp(BCompar(BCgt)))::c, d, fds) -> exec_aux(BoolV (m > n), c, d, fds) (* > *)
	| (PairV((IntV m), (IntV n)), PrimInstr(BinOp(BCompar(BCle)))::c, d, fds) -> exec_aux(BoolV (m <= n), c, d, fds) (* <= *)
	| (PairV((IntV m), (IntV n)), PrimInstr(BinOp(BCompar(BClt)))::c, d, fds) -> exec_aux(BoolV (m < n), c, d, fds) (* < *)
	| (PairV((IntV m), (IntV n)), PrimInstr(BinOp(BCompar(BCne)))::c, d, fds) -> exec_aux(BoolV (m <> n), c, d, fds) (* <> *)
	(* Appels récursifs *)
	| (t,Call(f)::c,st,fds) -> (t,(List.assoc f fds)@c,st,fds) (* Call *)
	| (t,AddDefs(defs)::c,st,fds) -> (t,c,st,defs@fds) (* AddDefs *)
	| (t,RmDefs(n)::c,st,fds) -> (t,c,st,chop n fds) (* RmDefs *)
	(* Cas de base *)
	| cfg -> cfg ;;
	
let exec = function
	config -> exec_aux(NullV,config,[],[]) ;;

(* Exercice 2 *)

(*
#trace exec
*)
	
(* ****************************** *)

(* Compile *)

let rec compile_aux = function
	|(env,Bool(b)) -> [Quote(BoolV(b))] (* Bool *)
	|(env,Int(i)) -> [Quote(IntV(i))] (* Int *)
	|(env,Var(v)) -> [Quote(VarV(v))] (* Var *)
	|(env,Fn(v,e)) -> [Cur((compile_aux(VarV(v)::env, e))@[Return])]
	|(env,App(PrimOp(p),e)) -> compile_aux(env,e)@[PrimInstr(p)]
	|(env,App(f,a)) -> [Push]@(compile_aux(env,f))@[Swap]@(compile_aux(env,a))@[Cons;App]
	|(env,Pair(e1,e2)) -> [Push]@(compile_aux(env,e1))@[Swap]@(compile_aux(env,e2))@[Cons]
	|(env,Cond(i,t,e)) -> [Push]@compile_aux(env,i)@[Branch(compile_aux(env,t)@[Return],compile_aux(env,e)@[Return])]
	(* Appels récursifs *)
	(* ... *)
	
let compile = function
	Prog(t,exp) -> compile_aux([],exp);;

(* ****************************** *)

let rec print_instr = function
	(* Divers *)
	(PrimInstr(UnOp(Fst))::config) -> "\nLLE.add_elem(new Fst(),"^print_instr(config)^")" (* Fst *)
	|(PrimInstr(UnOp(Snd))::config) -> "\nLLE.add_elem(new Snd(),"^print_instr(config)^")" (* Snd *)
	|(Cons::config) -> "\nLLE.add_elem(new Cons()," ^ print_instr(config)^")" (* Cons *)
	|(Push::config) -> "\nLLE.add_elem(new Push()," ^ print_instr(config)^")" (* Push *)
	|(Swap::config) -> "\nLLE.add_elem(new Swap()," ^ print_instr(config)^")" (* Swap *)
	|((Quote v)::config) -> "\nLLE.add_elem(new Quote("^ print_value(v) ^"),"^print_instr(config)^")" (* Quote *)
	|((Cur c)::config) ->"\nLLE.add_elem(new Cur("^print_instr(c)^"),"^print_instr(config)^")" (* Cur *)
	|(Return::config) -> "\nLLE.add_elem(new Return(),"^print_instr(config)^")" (* Return *)
	|(App::config) -> "\nLLE.add_elem(new App(),"^print_instr(config)^")" (* App *)
	|(Branch(c1,c2) :: config) -> "\nLLE.add_elem(new Branch("^print_instr(c1)^","^print_instr(c2)^")," ^ print_instr(config)^")" (* Branch *)
	(* Opérations *)
	|(PrimInstr(BinOp(BArith(BAadd)))::config) -> "\nLLE.add_elem(new BinOp(BinOp.operateur.Add),"^print_instr(config)^")" (* + *)
	|(PrimInstr(BinOp(BArith(BAsub)))::config) -> "\nLLE.add_elem(new BinOp(BinOp.operateur.Sub),"^print_instr(config)^")" (* - *)
	|(PrimInstr(BinOp(BArith(BAmul)))::config) -> "\nLLE.add_elem(new BinOp(BinOp.operateur.Mult),"^print_instr(config)^")" (* * *)
	|(PrimInstr(BinOp(BArith(BAdiv)))::config) -> "\nLLE.add_elem(new BinOp(BinOp.operateur.Div),"^print_instr(config)^")" (* / *)
	|(PrimInstr(BinOp(BArith(BAmod)))::config) -> "\nLLE.add_elem(new BinOp(BinOp.operateur.Mod),"^print_instr(config)^")" (* mod *)
	|(PrimInstr(BinOp(BCompar(BCeq)))::config) -> "\nLLE.add_elem(new BinOp(BinOp.operateur.Eq),"^print_instr(config)^")" (* == *)
	|(PrimInstr(BinOp(BCompar(BCge)))::config) -> "\nLLE.add_elem(new BinOp(BinOp.operateur.Ge),"^print_instr(config)^")" (* >= *)
	|(PrimInstr(BinOp(BCompar(BCgt)))::config) -> "\nLLE.add_elem(new BinOp(BinOp.operateur.Gt),"^print_instr(config)^")" (* > *)
	|(PrimInstr(BinOp(BCompar(BCle)))::config) -> "\nLLE.add_elem(new BinOp(BinOp.operateur.Le),"^print_instr(config)^")" (* <= *)
	|(PrimInstr(BinOp(BCompar(BClt)))::config) -> "\nLLE.add_elem(new BinOp(BinOp.operateur.Lt),"^print_instr(config)^")" (* < *)
	|(PrimInstr(BinOp(BCompar(BCne)))::config) -> "\nLLE.add_elem(new BinOp(BinOp.operateur.Ne),"^print_instr(config)^")" (* <> *)
	(* Appels récursifs *)
	|((Call f)::config) -> "\nLLE.add_elem(new Call(\""^f^"\")," ^ print_instr(config) ^ ")"
	|((AddDefs defs)::config) -> "\nLLE.add_elem(new AddDefs("^ print_defs defs ^"),"^print_instr(config) ^")"
	|((RmDefs n)::config) -> "\nLLE.add_elem(new RmDefs("^string_of_int(n)^"),"^print_instr(config)^ ")"
	(* Cas de base *)
	|[] -> "LLE.empty()"

(*Partie représentant l'écriture des différentes Value*)
and print_value = function 
	  NullV -> "new NullV()"
	| IntV(v) -> "new IntV("^(string_of_int v)^")"
	| VarV(v) -> "new IntV("^v^")"
	| BoolV(b) -> "new BoolV("^(string_of_bool b)^")"
	| PairV(x,y) -> "new PairV("^print_value(x)^","^print_value(y)^")"
	| ClosureV(c,v) -> "new ClosureV("^print_instr(c)^","^print_value(v)^")"
	
(*Partie représentant l'écrire de lapile de définitions de fonctions en Java*)
and print_defs = function
	((name,body)::defs) -> "LLE.add_elem(new Couple(\""^name^"\","^(print_instr body)^"), "^(print_defs defs)^")"
    | [] -> "LLE.empty()";;

(*Fonction permettant d'écrire en Java le code compilé en Caml.*)
let print_gen_class_to_java = function 
	cfg -> "import java.util.*; \n" ^
			"public class Gen { \n" ^
			"public static LinkedList<Instr> code =" ^
				print_instr(cfg) ^"; \n}";;