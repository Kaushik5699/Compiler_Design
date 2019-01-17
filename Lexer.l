%{
%}
identifier [a-zA-Z][a-zA-Z0-9]*
%%
"//".* {printf("Single Line comment %s\n",yytext);}
"/*"([^*]|\*+[^*/])*\*+"/" { printf("Multiline comment '%s'\n",yytext);}
"/*"([^*]|\*+[^*/])*\* {printf("Error comment '%s'\n",yytext);}
#define {printf("This is defintion for a variable %s\n",yytext);}
#.* {printf("\n%s is a preprocessor directive\n",yytext);}
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
goto {printf("\n\t%s is a keyword\n",yytext);}
main\( {printf("Main function:\n\t%s\n",yytext);}
\".*\" {printf("\n\t %s is a string",yytext);}
{identifier}\( {printf("\nUser defined function:\t%s\n",yytext);}
{identifier}(\[[0-9]*\])? { printf("\n %s is an identifier:",yytext);}

[0-9]+ {printf("%s is a Integer Constant\n",yytext);};

\)(\:)? {printf("\n\t");ECHO;printf("\n");}
\( ECHO;
= {printf("\n\t %s is an assignment operator\n",yytext);}
\<= |
\>= |
\< |
== |
\> |
!= { printf("\n\t%s is a relational operator\n",yytext);}
\{  {printf("\n %s Indentation\n",yytext);}
\}  {printf("Indentation %s\n",yytext);}
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
\%= {printf("%s is an arithemetic operator\n",yytext);}
\&& |
\! |
\& |
\| |
\<< |
\>> |
\~ |
\^ | {printf("%s is a comparative operator\n",yytext);}
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
