
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
	(PairV(x,y),PrimInstr(UnOp(Fst))::c,st,fds) -> exec(x,c,st,fds) (* Fst *)
	| (PairV(x,y),PrimInstr(UnOp(Snd))::c,st,fds) -> exec(y,c,st,fds) (* Snd *)
	| (x,Cons::c,(Val y)::d,fds) -> exec(PairV(y,x),c,d,fds) (* Cons *)
	| (x,Push::c,d,fds) -> exec(x, c, (Val x)::d,fds) (* Push *)
	| (x,Swap::c,(Val y)::d,fds) -> exec(y,c,(Val x)::d,fds) (* Swap *)
	| (t,(Quote v)::c,d,fds) -> exec(v,c,d,fds) (* Quote *)
	| (x,(Cur c1)::c,d,fds) -> exec(ClosureV(c1,x),c,d,fds) (* Cur *)
	| (x,Return::c,(Cod cc)::d,fds) -> exec(x,cc,d,fds) (* Return *)
	| (PairV(ClosureV(x,y),z),(App::c),d,fds) -> exec(PairV(y,z),x,(Cod c)::d,fds) (* App *)
	| ((BoolV b),Branch(c1,c2)::c,(Val x)::d,fds) -> exec(x,(if b then c1 else c2),(Cod c)::d,fds) (* Branch *)
	(* Opérations *)
	| (PairV((IntV m), (IntV n)), PrimInstr(BinOp(BArith(BAadd)))::c, d, fds) -> exec(IntV (m + n), c, d, fds) (* + *)
	| (PairV((IntV m), (IntV n)), PrimInstr(BinOp(BArith(BAsub)))::c, d, fds) -> exec(IntV (m - n), c, d, fds) (* - *)
	| (PairV((IntV m), (IntV n)), PrimInstr(BinOp(BArith(BAmul)))::c, d, fds) -> exec(IntV (m * n), c, d, fds) (* * *)
	| (PairV((IntV m), (IntV n)), PrimInstr(BinOp(BArith(BAdiv)))::c, d, fds) -> exec(IntV (m / n), c, d, fds) (* / *)
	| (PairV((IntV m), (IntV n)), PrimInstr(BinOp(BArith(BAmod)))::c, d, fds) -> exec(IntV (m mod n), c, d, fds) (* mod *)
	| (PairV((IntV m), (IntV n)), PrimInstr(BinOp(BCompar(BCeq)))::c, d, fds) -> exec(BoolV (m == n), c, d, fds) (* == *)
	| (PairV((IntV m), (IntV n)), PrimInstr(BinOp(BCompar(BCge)))::c, d, fds) -> exec(BoolV (m >= n), c, d, fds) (* >= *)
	| (PairV((IntV m), (IntV n)), PrimInstr(BinOp(BCompar(BCgt)))::c, d, fds) -> exec(BoolV (m > n), c, d, fds) (* > *)
	| (PairV((IntV m), (IntV n)), PrimInstr(BinOp(BCompar(BCle)))::c, d, fds) -> exec(BoolV (m <= n), c, d, fds) (* <= *)
	| (PairV((IntV m), (IntV n)), PrimInstr(BinOp(BCompar(BClt)))::c, d, fds) -> exec(BoolV (m < n), c, d, fds) (* < *)
	| (PairV((IntV m), (IntV n)), PrimInstr(BinOp(BCompar(BCne)))::c, d, fds) -> exec(BoolV (m <> n), c, d, fds) (* <> *)
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
	|(env,Var(v)) -> access v env (* Var *)
	|(env,Fn(v,e)) -> [Cur((compile(EVar(v)::env, e))@[Return])]
	|(env,App(PrimOp(p),e)) -> compile(env,e)@[PrimInstr(p)]
	|(env,App(f,a)) -> [Push]@(compile(env,f))@[Swap]@(compile(env,a))@[Cons;App]
	|(env,Pair(e1,e2)) -> [Push]@(compile(env,e1))@[Swap]@(compile(env,e2))@[Cons]
	|(env,Cond(i,t,e)) -> [Push]@compile(env,i)@[Branch(compile(env,t)@[Return],compile(env,e)@[Return])]
	(* Appels récursifs *)
	|(env,Fix(defs,e)) -> let dc = (compileBody (defs) (EDef((addNameFunction defs))::env) (compile)) in 
								let ec = compile(EDef((addNameFunction defs))::env,e) in 
									[AddDefs dc] @ ec @ [RmDefs (List.length dc)];;

let compile = function
	Prog(t,exp) -> compile_aux([],exp);;

(* ****************************** *)
