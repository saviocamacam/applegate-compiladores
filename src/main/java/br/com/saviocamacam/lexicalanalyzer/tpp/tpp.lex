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

PR = (se|ent�o|sen�o|fim|repita|flutuante|retorna|at�|leia|escreve|inteiro)
DIGITO = [0-9]
SIGNAL = [-+]
INTEIRO = ({SIGNAL}?{DIGITO}+)
FLUTUANTE = {INTEIRO}+[.]{DIGITO}+
NUMBER_SN = {SIGNAL}?{DIGITO}*\.?{DIGITO}+([eE]{SIGNAL}?{DIGITO}+)
LETRA = [a-zA-Z�������������_]
ID = {LETRA}({LETRA}|{DIGITO})*
BRANCO = [\n| |\t|\r]+
SB = (:=|:|>|\(|\)|\*|=|\-|\+|<=|\[|\])
CT = \{(.|[\r\n])*?\}+
ERROR = [\x20-\x7F]

%%

{DIGITO} {return createToken("DIG", yytext()); }
{PR} { return createToken("PR", yytext()); }
{ID} { return createToken("ID", yytext()); }
{SB} { return createToken("SB", yytext()); }
{BRANCO} { /**/ }
{INTEIRO} { return createToken("NUM", yytext()); }
{NUMBER_SN} {return createToken("SN", yytext()); }
{FLUTUANTE} {return createToken("NUM", yytext()); }
{ERROR} {System.out.println("Caractere ou sequ�ncia inv�lidos." + " -> " + yytext());}
{CT} { /**/ }

. { throw new RuntimeException("Caractere inv�lido " + yytext() + " na linha " + yyline + ", coluna " +yycolumn); }