%{
%}
identifier [a-zA-Z][a-zA-Z0-9]*
%%
"//".* {printf("Single Line comment %s",yytext);}
"/*"([^*]|\*+[^*/])*\*+"/" { printf("Multiline comment '%s'",yytext);}
"/*"([^*]|\*+[^*/])*\* {printf("Error comment '%s'",yytext);}
#.* {printf("\n%s is a preprocessor directive",yytext);}
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
goto {printf("\n\t%s is a keyword",yytext);}
{identifier}\( {printf("\nUser defined function:\n\t%s",yytext);}
{identifier}(\[[0-9]*\])? { printf("\n %s is an identifier:",yytext);}

[0-9]+ {printf("%s is a Integer Constant\n",yytext);};

\)(\:)? {printf("\n\t");ECHO;printf("\n");}
\( ECHO;
= {printf("\n\t %s is an assignment operator",yytext);}
\<= |
\>= |
\< |
== |
\> |
!= { printf("\n\t%s is a relational operator",yytext);}
\{  {printf("\n %s Indentation",yytext);}
\}  {printf("Indentation %s",yytext);}
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
\%= {printf("%s is an arithemetic operator",yytext);}
\&& |
\! |
\& |
\| |
\<< |
\>> |
\~ |
\^ | {printf("%s is a comparative operator",yytext);}
%%
int main(int argc, char **argv)
{
FILE *file;
file=fopen("omp1.c","r");
if(!file)
{
printf("could not open the file");
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
