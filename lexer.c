%option yylineno

%{
	#include<stdio.h>
	#include"y.tab.h"
	#include<math.h>
	#include "symboltable.h"
	
	entry_t** symbol_table;
  	entry_t** constant_table;
%}

%%
"#include"([ ]+)?((<(\\.|[^>])+>)|(\"(\\.|[^"])+\"))					                                    {insert(symbol_table,yytext,1);}
"#define"[ ]+[a-zA-z_][a-zA-z_0-9]* 																	    {insert(symbol_table,yytext,2);}
"auto"|"register"|"static"|"extern"|"typedef"																{insert(symbol_table,yytext,3);}
"void"|"char"|"short"|"int"|"long"|"float"|"double"|"signed"|"unsigned"										{insert(symbol_table,yytext,3);}	
"const"|"volatile"																							{insert(symbol_table,yytext,3);}
"enum"																										{insert(symbol_table,yytext,3);}
"case"																										{insert(symbol_table,yytext,3);}	
"default"																									{insert(symbol_table,yytext,3);}
"if"																										{insert(symbol_table,yytext,3);}
"switch"																									{insert(symbol_table,yytext,3);}
"else"																										{insert(symbol_table,yytext,3);}
"for"																										{insert(symbol_table,yytext,3);}
"do"																										{insert(symbol_table,yytext,3);}
"while"																										{insert(symbol_table,yytext,3);}
"goto"																										{insert(symbol_table,yytext,3);}
"continue"																									{insert(symbol_table,yytext,3);}
"break"																										{insert(symbol_table,yytext,3);}
"struct"|"union"																							{insert(symbol_table,yytext,3);}
"return"																									{insert(symbol_table,yytext,3);}
"sizeof"																									{insert(symbol_table,yytext,3);}
"||" 																										{}
"&&"																										{}
"..."																										{}
"=="|"!="																									{}
"<="|">="																									{}
">>"|"<<"																									{}
"++"|"--"																									{}
"->"																										{}
";"|"="|","|"{"|"}"|"("|")"|"["|"]"|"*"|"+"|"-"|"/"|"?"|":"|"&"|"|"|"^"|"!"|"~"|"%"|"<"|">"					{}
"*="|"/="|"+="|"%="|">>="|"-="|"<<="|"&="|"^="|"|="															{}
[0-9]+																									{insert(constant_table,yytext,1);}
[0-9]+"."[0-9]+																						{insert(constant_table,yytext,2);}	
"'"."'"																										{}
[a-zA-z_][a-zA-z_0-9]*			 																			{insert(symbol_table,yytext,15);}
\"(\\.|[^\"])*\"																							{insert(constant_table,yytext,3);}
"//"(\\.|[^\n])*[\n]																						;
[/][*]([^*]|[*]*[^*/])*[*]+[/]                                                                              ;
[ \t\n]																										;
%%

int yywrap(void)
{
    return 1;
}

int main(){
	yyin=fopen("gen.c","r");
	symbol_table=create_table();
  	constant_table=create_table();
  	yylex();
	printf("\n\tSymbol table");
  	display(symbol_table);
  	printf("\n\tConstants Table");
  	display(constant_table);
}