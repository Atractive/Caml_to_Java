%{

open Miniml

let primop_of_token = function
  | ADD -> BinOp (BArith BAadd)
  | SUB -> BinOp (BArith BAsub)
  | MUL -> BinOp (BArith BAmul)
  | DIV -> BinOp (BArith BAdiv)
  | MOD -> BinOp (BArith BAmod)
  | EQ -> BinOp (BCompar BCeq)
  | GE -> BinOp (BCompar BCge)
  | GT -> BinOp (BCompar BCgt)
  | LE -> BinOp (BCompar BCle)
  | LT -> BinOp (BCompar BClt)
  | NE -> BinOp (BCompar BCne)
  | _ -> failwith "in primop_of_token: unknown token"

let binary_exp e1 oper e2 = App(PrimOp (primop_of_token oper), Pair(e1, e2))

%}

%token <string> IDENTIFIER
%token <bool> BCONSTANT
%token <int> INTCONSTANT
%token FST SND
%token ADD SUB MUL DIV MOD
%token EQ GE GT LE LT NE
%token BLAND BLOR
%token LPAREN RPAREN LBRACE RBRACE
%token COMMA SEMICOLON COLON QMARK
%token IF THEN ELSE WHILE FOR RETURN 
%token AND ARROW FUN IN LET REC TYPE
%token EOF

%right ELSE

%start start
%type <Miniml.prog> start

%%

start: prog { $1 }
;

prog:
  typedef mlexp end_marker_opt EOF
	{Prog ($1, $2) }
;

end_marker_opt:
  { }
| SEMICOLON SEMICOLON
	{ }
;

typedef:
  { None }
| TYPE IDENTIFIER
	{ Some ($2) }
;

mult_exp:
  primary_exp_list_as_mlexp
    { $1 }
| mult_exp MUL primary_exp_list_as_mlexp
    { binary_exp $1 MUL $3 }
| mult_exp DIV primary_exp_list_as_mlexp
    { binary_exp $1 DIV $3 }
| mult_exp MOD primary_exp_list_as_mlexp
    { binary_exp $1 MOD $3 }
;

unary_op:
  FST
	{ Fst }
| SND
	{ Snd }
;

primary_exp:
  IDENTIFIER
    { Var($1) }
| BCONSTANT
	{ Bool($1) }
| INTCONSTANT
	{ Int($1) }
| unary_op
    { PrimOp (UnOp($1)) }
| LPAREN mlexp RPAREN
    { $2 }
;

primary_exp_list:
  primary_exp
	{ [$1] }
| primary_exp primary_exp_list
    { $1 :: $2 }
;

primary_exp_list_as_mlexp:
  primary_exp_list
    { match $1 with
    | [e] -> e
    | e::r -> List.fold_left (fun x y -> App(x, y)) e r
    |  _ -> failwith "parser: empty list impossible"
    }
;

mlexp:
  pair_exp
    { $1 }
| IF mlexp THEN mlexp ELSE mlexp
    { Cond($2, $4, $6) }
| FUN IDENTIFIER ARROW mlexp
    { Fn ($2, $4) }
| LET REC let_binding_list IN mlexp
    { Fix ($3, $5) }
;

let_binding:
  IDENTIFIER EQ mlexp
  { ($1, $3) }
;

let_binding_list:
  let_binding
	{ [$1] }
| let_binding AND let_binding_list
    { $1 :: $3 }
;

/* ****************************** */

/* ADD, SUB */
add_exp:
  mult_exp
	{ $1 }
| add_exp ADD mult_exp
    { binary_exp $1 ADD $3 }
| add_exp SUB mult_exp
    { binary_exp $1 SUB $3 }
;

/* EQ, GE, GT, LE, LT, NE */
comp_exp:
  add_exp
	{ $1 }
| comp_exp EQ comp_exp
	{ binary_exp $1 EQ $3 }
| comp_exp GE comp_exp
	{ binary_exp $1 GE $3 }
| comp_exp GT comp_exp
	{ binary_exp $1 GT $3 }
| comp_exp LE comp_exp
	{ binary_exp $1 LE $3 }
| comp_exp LT comp_exp
	{ binary_exp $1 LT $3 }
| comp_exp NE comp_exp
	{ binary_exp $1 NE $3 }
;

/* BLAND */
and_exp:
  comp_exp
	{ $1 }
| and_exp BLAND and_exp
	{ Cond($1, $3, Bool(false)) }
;

/* BLOR */
or_exp:
  and_exp
	{ $1 }
| or_exp BLOR or_exp
	{ Cond($1, Bool(true), $3) }
;

/* LPAREN, RPAREN, COMMA */
pair_exp:
  or_exp
	{ $1 }
| LPAREN pair_exp COMMA pair_exp RPAREN
	{ Pair($2, $4) }
;
