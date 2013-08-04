module mine::EncapsedCase2

import IO;
import lang::php::util::Utils;
import lang::php::ast::AbstractSyntax;
import lang::php::pp::PrettyPrinter;

public void encapsedCase2(list[Expr] expressions,map[str,str] moles){
		Expr mixed;
		for(mixed <- expressions){ 
			switch (mixed) {
				case scalar(string(X)) : {
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, " <X> ");
				}
				case var(name(name(X))) : {
					if (pp(var(name(name(X)))) in moles)
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, " $<moles[pp(var(name(name(X))))]> ");
				}
			}
		}
}