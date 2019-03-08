%option yylineno

%{
	#include<stdio.h>
	#include"y.tab.h"
	#include<math.h>
	#include "symbol_table.h"
	
	entry_t** stable;
  	entry_t** ctable;
%}

%%
"#include"([ ]+)?((<(\\.|[^>])+>)|(\"(\\.|[^"])+\"))					                                    {insert(stable,yytext,1);}
"#define"[ ]+[a-zA-z_][a-zA-z_0-9]* 																	    {insert(stable,yytext,2);}
"auto"|"register"|"static"|"extern"|"typedef"																{insert(stable,yytext,3);}
"void"|"char"|"short"|"int"|"long"|"float"|"double"|"signed"|"unsigned"										{insert(stable,yytext,3);}	
"const"|"volatile"																							{insert(stable,yytext,3);}
"enum"																										{insert(stable,yytext,3);}
"case"																										{insert(stable,yytext,3);}	
"default"																									{insert(stable,yytext,3);}
"if"																										{insert(stable,yytext,3);}
"switch"																									{insert(stable,yytext,3);}
"else"																										{insert(stable,yytext,3);}
"for"																										{insert(stable,yytext,3);}
"do"																										{insert(stable,yytext,3);}
"while"																										{insert(stable,yytext,3);}
"goto"																										{insert(stable,yytext,3);}
"continue"																									{insert(stable,yytext,3);}
"break"																										{insert(stable,yytext,3);}
"struct"|"union"																							{insert(stable,yytext,3);}
"return"																									{insert(stable,yytext,3);}
"sizeof"																									{insert(stable,yytext,3);}
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
[0-9]+																									{insert(ctable,yytext,1);}
[0-9]+"."[0-9]+																						{insert(ctable,yytext,2);}	
"'"."'"																										{}
[a-zA-z_][a-zA-z_0-9]*			 																			{insert(stable,yytext,15);}
\"(\\.|[^\"])*\"																							{insert(ctable,yytext,3);}
"//"(\\.|[^\n])*[\n]																						;
[/][*]([^*]|[*]*[^*/])*[*]+[/]                                                                              ;
[ \t\n]																										;
%%

int yywrap(void)
{
    return 1;
}

int main(){
	yyin=fopen("inp.c","r");
	stable=create_table();
  	ctable=create_table();
  	yylex();
	printf("\n\tSymbol table");
  	display(stable);
  	printf("\n\tConstants Table");
  	display(ctable);
}