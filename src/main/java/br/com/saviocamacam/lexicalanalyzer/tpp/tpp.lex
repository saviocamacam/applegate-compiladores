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

PR = (se|ent�o|sen�o|fim|repita|flutuante|retorna|at�|leia|escreva|inteiro)
DIGITO = [0-9]
LETRA = [a-zA-Z������������������������\_]
ID = {LETRA}({LETRA}|{DIGITO})*
NUMERO = [0-9]*\.?[0-9]+([eE][-+][0-9]+)?
BRANCO = [\n| |\t|\r]+
SB = (:=|:|>|<|\(|\)|\*|=|\-|\+|\/|<=|>=|\[|\])
CT = \{[^}]*\}
ERROR_CT = [{}]
ERROR = .

%%
{PR} { return createToken("PR", yytext()); }
{ID} { return createToken("ID", yytext()); }
{SB} { return createToken("SB", yytext()); }
{BRANCO} { /**/ }
{NUMERO} {return createToken("NUM", yytext()); }
{ERROR_CT} {System.out.println("Erro com coment�rio" + " na linha " + yyline + ", coluna " +yycolumn); }
{ERROR} {System.out.println("Caractere inv�lido " + yytext() + " na linha " + yyline + ", coluna " +yycolumn);}
{CT} { /**/ }

. { throw new RuntimeException("Caractere inv�lido " + yytext() + " na linha " + yyline + ", coluna " +yycolumn); }