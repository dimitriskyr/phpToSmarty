module mine::UnaryCase

import IO;
import lang::php::util::Utils;
import lang::php::ast::AbstractSyntax;
import lang::php::pp::PrettyPrinter;

public void unaryCase(Expr operand, Op operation,map[str,str] moles){
	switch (operand) {
		case scalar(string(oper)) :{
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, "<pp(operation)><oper> ");
		}
		case var(name(name(metavliti))) :{
					if (pp(var(name(name(metavliti)))) in moles)
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, " <pp(operation)>{$<moles[pp(var(name(name(metavliti))))]>} ");
		}
	}		
}