%token EOL_COMMENT COMMA SC INT_TYPE FLOAT_TYPE CHAR_TYPE STRING_TYPE BOOL_TYPE LOGIC_IDENTIFIER IF ELSE TRUE FALSE WHILE RETURN BREAK VOID READ_TEMP READ_HUM READ_AIR_PRESSURE READ_AIR_QUALITY READ_LIGHT READ_SOUND READ_TIMER SET_SWITCH1 SET_SWITCH2 SET_SWITCH3 SET_SWITCH4 SET_SWITCH5 SET_SWITCH6 SET_SWITCH7 SET_SWITCH8 SET_SWITCH9 SET_SWITCH10 GET_SWITCH1 GET_SWITCH2 GET_SWITCH3 GET_SWITCH4 GET_SWITCH5 GET_SWITCH6 GET_SWITCH7 GET_SWITCH8 GET_SWITCH9 GET_SWITCH10 CONNECT_URL SEND_INT RECEIVE_INT AND_OP OR_OP EQ NEQ LT LTE GT GTE LP RP LCB RCB ASSIGN_OP PLU_OP MIN_OP MUL_OP DIV_OP CHAR INT FLOAT IDENTIFIER STRING
%%
program: stmt_list {printf("Input program is valid.\n"); return 0;}

stmt_list: stmt
	| stmt stmt_list
	;

stmt: declaration_stmt 
	| assign_stmt 
	| conditional_stmt 
	| loop_stmt
	| break_stmt
	| func_def_stmt
	| func_call_stmt
	| comment
	;

comment: EOL_COMMENT;

declaration_stmt: data_type var_name SC 
	| data_type assign_stmt
	| data_type logic_identifier SC
	;

data_type: INT_TYPE
     	| FLOAT_TYPE
     	| CHAR_TYPE
     	| STRING_TYPE
     	| BOOL_TYPE
	;

var_name: IDENTIFIER;

assign_stmt: var_name ASSIGN_OP expression SC 
	| var_name ASSIGN_OP func_call_stmt
	| logic_identifier ASSIGN_OP logic_expression SC
	| logic_identifier ASSIGN_OP func_call_stmt
	| var_name ASSIGN_OP STRING SC 
	| var_name ASSIGN_OP CHAR SC 
	;

expression: arithmetic_expression 
	| logic_expression
	;

arithmetic_expression: arithmetic_expression PLU_OP arithmetic_term 
	| arithmetic_expression MIN_OP arithmetic_term 
	| arithmetic_term
	;

arithmetic_term: arithmetic_term DIV_OP arithmetic_factor 
	| arithmetic_term MUL_OP arithmetic_factor 
	| arithmetic_factor
	;

arithmetic_factor: LP arithmetic_expression RP 
	| INT 
 	| FLOAT 
  	| var_name
	;

logic_expression: logic_expression OR_OP logic_term
	| logic_term
	;

logic_term: logic_term AND_OP logic_factor
	| logic_factor
	;

logic_factor: LP logic_expression RP
	| comparison_expression
	| logic_val
	| logic_identifier
	;

logic_identifier: LOGIC_IDENTIFIER

comparison_expression: arithmetic_expression comparison_op arithmetic_expression;

logic_val: TRUE 
    	| FALSE
	;

comparison_op: EQ 
    	| NEQ
    	| LT 
    	| LTE 
    	| GT 
    	| GTE
	;

conditional_stmt: if_stmt 
	| if_else_stmt
	;

if_stmt: IF LP logic_expression RP LCB non_func_def_stmt_list RCB 
	| IF LP logic_expression RP LCB RCB
	;

if_else_stmt: if_stmt ELSE LCB non_func_def_stmt_list RCB
	| if_stmt ELSE LCB RCB
	;

non_func_def_stmt_list: non_func_def_stmt  
	| non_func_def_stmt non_func_def_stmt_list
	;

non_func_def_stmt: declaration_stmt 
  	| assign_stmt 
 	| conditional_stmt 
  	| loop_stmt
  	| break_stmt
  	| func_call_stmt
  	| comment
	;

loop_stmt: while_loop;

while_loop: WHILE LP logic_expression RP LCB non_func_def_stmt_list RCB
	| WHILE LP logic_expression RP LCB RCB
	;

rtrn_stmt: RETURN expression SC;

break_stmt: BREAK SC;

func_def_stmt: non_void_func_def_stmt 
	| void_func_def_stmt
	;

non_void_func_def_stmt: data_type func_name LP param_list RP LCB func_stmt_list rtrn_stmt RCB
	| data_type func_name LP RP LCB func_stmt_list rtrn_stmt RCB
	;

func_name: IDENTIFIER;

void_func_def_stmt: VOID func_name LP param_list RP LCB func_stmt_list RCB 
	| VOID func_name LP RP LCB func_stmt_list RCB
	;

param_list: param 
	| param COMMA param_list
	;

param: data_type var_name;

func_stmt_list: func_stmt | func_stmt func_stmt_list;

func_stmt: declaration_stmt 
     	| assign_stmt 
     	| conditional_stmt 
    	| loop_stmt
     	| break_stmt
     	| func_call_stmt
     	| comment
	;

func_call_stmt: func_name LP input_list RP SC 
	| func_name LP RP SC
        | prim_func_stmt
	;

input_list: input 
 	| input COMMA input_list
	;

input: expression 
 	| STRING 
 	| func_call_stmt
	;

prim_func_stmt: read_temp
    	| read_hum
     	| read_air_pressure
     	| read_air_quality 
     	| read_light 
     	| read_sound
     	| read_timer
     	| connect_url
     	| send_int  
     	| receive_int
	| set_switch
	| get_switch
	;

read_temp: READ_TEMP LP RP SC;
read_hum: READ_HUM LP RP SC;
read_air_pressure: READ_AIR_PRESSURE LP RP SC;
read_air_quality : READ_AIR_QUALITY LP RP SC;
read_light: READ_LIGHT LP RP SC;
read_sound: READ_SOUND LP RP SC ;
read_timer: READ_TIMER LP RP SC;

connect_url: CONNECT_URL LP STRING RP SC;
send_int: SEND_INT LP INT COMMA STRING RP SC;
receive_int: RECEIVE_INT LP STRING RP SC;

set_switch: set_switch1
	| set_switch2
	| set_switch3
	| set_switch4
	| set_switch5
	| set_switch6
	| set_switch7
	| set_switch8
	| set_switch9
	| set_switch10
	;

set_switch1: SET_SWITCH1 LP logic_expression RP SC;
set_switch2: SET_SWITCH2 LP logic_expression RP SC;
set_switch3: SET_SWITCH3 LP logic_expression RP SC;
set_switch4: SET_SWITCH4 LP logic_expression RP SC;
set_switch5: SET_SWITCH5 LP logic_expression RP SC;
set_switch6: SET_SWITCH6 LP logic_expression RP SC;
set_switch7: SET_SWITCH7 LP logic_expression RP SC;
set_switch8: SET_SWITCH8 LP logic_expression RP SC;
set_switch9: SET_SWITCH9 LP logic_expression RP SC;
set_switch10: SET_SWITCH10 LP logic_expression RP SC;

get_switch: get_switch1
	| get_switch2
	| get_switch3
	| get_switch4
	| get_switch5
	| get_switch6
	| get_switch7
	| get_switch8
	| get_switch9
	| get_switch10
	;

get_switch1: GET_SWITCH1 LP RP SC;
get_switch2: GET_SWITCH2 LP RP SC;
get_switch3: GET_SWITCH3 LP RP SC;
get_switch4: GET_SWITCH4 LP RP SC;
get_switch5: GET_SWITCH5 LP RP SC;
get_switch6: GET_SWITCH6 LP RP SC;
get_switch7: GET_SWITCH7 LP RP SC;
get_switch8: GET_SWITCH8 LP RP SC;
get_switch9: GET_SWITCH9 LP RP SC;
get_switch10: GET_SWITCH10 LP RP SC;

%%
#include "lex.yy.c"
int yyerror(char* s){
  fprintf(stderr, "%s on line %d\n",s, yylineno);
  return 1;
}
int main() {
yyparse();
return 0;
}