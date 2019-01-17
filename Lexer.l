%{
	int cmnt_strt =0;
%}

identifier (_|[a-zA-Z])([a-zA-Z0-9_]){0,31}
%x CMNT
ws  [ \t\r\f\v]+

%%
								
"/*"                              {cmnt_strt = yylineno; BEGIN CMNT;}
<CMNT>.|{ws}                      ;
<CMNT>\n                          {yylineno++;}
<CMNT>"*/"                        {BEGIN INITIAL;}
<CMNT>"/*"                        {printf("Line_no: %d\t Nested comments are not valid!\n",yylineno);}
<CMNT><<EOF>>                     {printf("Line_no: %d\tUnterminated comment\n", cmnt_strt); yyterminate();}

#define {printf("\nLine_no: %d\tThis is defintion for a variable %s\n",yylineno,yytext);}
"#include<" {printf("\nLine_no: %d\t%s is a preprocessor directive\n",yylineno,yytext);}
"#include<<" {printf("\nLine_no: %d\t%s is an invalid preprocessor directive\n",yylineno,yytext);}
"#include".[ ]*.[<].[ ]+ {printf("\nLine_no: %d\t%s is an invalid preprocessor directive\n",yylineno,yytext);}
"#include".[\n] {printf("\nLine_no: %d\tis an invalid preprocessor directive\n",yylineno);}
#.* {printf("\nLine_no: %d\t%s is a preprocessor directive\n",yylineno,yytext);}
[0-9]+[a-zA-z]+ {printf("\nLine_no: %d\tIllegal identifier %s\n",yylineno,yytext);}
\"[^\"\n]*\"     {

  if(yytext[yyleng-2]=='\\') /* check if it was an escaped quote */
  {
    yyless(yyleng-1);       /* push the quote back if it was escaped */
    yymore();
  }
  else
    printf("\nLine_no: %d\t%s is a string\n",yylineno,yytext);
}
\"[^\"\n]*$ {printf("Line %d: Unterminated string %s\n",yylineno,yytext);}

int |
float |
typedef |
char |
const |
union |
unsigned |
double |
while |
for |
static |
long |
register |
volatile |
sizeof |
do |
if |
break |
continue |
void |
switch |
return |
else |
struct |
main |
goto {printf("\nLine_no: %d\t\t%s is a keyword\n",yylineno,yytext);}
main\( {printf("\nLine_no: %d\tMain function:\n\t%s\n",yylineno,yytext);}
\".*\" {printf("\nLine_no: %d\t\t %s is a string",yylineno,yytext);}
{identifier}\( {printf("\nLine_no: %d\tUser defined function:\t%s\n",yylineno,yytext);}
{identifier}(\[[0-9]*\])? { printf("\nLine_no: %d\t %s is an identifier:",yylineno,yytext);}

[0-9]+ {printf("\nLine_no: %d\t%s is a Integer Constant\n",yylineno,yytext);};

\)(\:)? {printf("\nLine_no: %d\t\t",yylineno);ECHO;printf("\nLine_no: %d\t",yylineno);}
\( ECHO;
; {printf("\nLine_no: %d\t%s is a semi-colon\n",yylineno,yytext);}

= {printf("\nLine_no: %d\t\t %s is an assignment operator\n",yylineno,yytext);}
\<= |
\>= |
\< |
== |
\> |
!= { printf("\nLine_no: %d\t\t%s is a relational operator\n",yylineno,yytext);}
\{  {printf("\nLine_no: %d\t %s Indentation\n",yylineno,yytext);}
\}  {printf("\nLine no: %d\t Indentation %s\n",yylineno,yytext);}
\+ |
\* |
\/ |
\% |
\++ |
\-- |
\+= |
\-= |
\*= |
\/= |
\%= {printf("\nLine_no: %d\t%s is an arithemetic operator\n",yylineno,yytext);}
\&& |
\! |
\& |
\| |
\<< |
\>> |
\~ |
\^ | {printf("\nLine_no: %d\t%s is a comparative operator\n",yylineno,yytext);}

[\n] yylineno++;
%%

int main(int argc, char **argv)
{
    FILE *file;
    file=fopen("test.c","r");
    if(!file)
    {
    printf("Could not access the file");
    exit(0);
    }
    yyin=file;
    yylex();
    printf("\n");
    return(0);
}

int yywrap()
{
    return(1);
}
