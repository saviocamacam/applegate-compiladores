package br.com.saviocamacam.lexicalanalyzer.tpp;

import java_cup.runtime.*;

%%

%{


private TppToken createToken(String name, String value) {
    return new TppToken( name, value, yyline, yycolumn);
}

%}

%public
%class LexicalAnalyzer
%type TppToken
%line
%column

BRANCO = [\n| |\t|\r]
ID = [_|a-z|A-Z][a-z|A-Z|0-9|_]*

OP = [([)]+*-<>:=<>=,]

INTEIRO = 0|[1-9][0-9]*

program = "program"

%%

"inteiro" { return createToken("PR", yytext()); }
"principal" { return createToken("PR", yytext()); }
"se" { return createToken("PR", yytext()); }
"entao" { return createToken("PR", yytext()); }
"senao" { return createToken("PR", yytext()); }
"fim" { return createToken("PR", yytext()); }
"repita" { return createToken("PR", yytext()); }
"flutuante" { return createToken("PR", yytext()); }
"retorna" { return createToken("PR", yytext()); }
"ate" { return createToken("PR", yytext()); }
"leia" { return createToken("PR", yytext()); }
"escreve" { return createToken("PR", yytext()); }

{INTEIRO} { return createToken("inteiro", yytext()); }
{ID} { return createToken("id", yytext()); }
{OP} { return createToken("SB", yytext()); }
{program} { return createToken(yytext(), ""); } 
{BRANCO} { /**/ }

. { throw new RuntimeException("Caractere inválido " + yytext() + " na linha " + yyline + ", coluna " +yycolumn); }