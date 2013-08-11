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
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|, " <X> ");
				}
				case var(name(name(X))) : {
					if (pp(var(name(name(X)))) in moles)
					println(pp(var(name(name(X)))));
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|, " $<moles[pp(var(name(name(X))))]> ");
				}
				
				case fetchArrayDim(var,dim) : {
					if (pp(var) in moles && someExpr(scalar(string(dimension))) := dim)
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|, " {$<moles[pp(var)]>.<dimension>} ");			
					elseif (pp(var) in moles && someExpr(scalar(integer(dimension))) := dim)
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|, " {$<moles[pp(var)]>.<dimension>} ");
					/*elseif(pp(var) in moles && pp(dim) in moles)
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|, " {$<moles[pp(var)]>.$<moles[pp(dim)]>} ");*/
				}
			}
		}
}