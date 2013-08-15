module mine::UnaryCase

import IO;
import lang::php::util::Utils;
import lang::php::ast::AbstractSyntax;
import lang::php::pp::PrettyPrinter;

public void unaryCase(Expr operand, Op operation,map[str,str] moles,str tempName){
	switch (operand) {
		case scalar(string(oper)) :{
			if(operation == postDec() || operation == postInc())
				appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, "<oper><pp(operation)> ");
			else
				appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, "<pp(operation)><oper> ");
		}
		case var(name(name(metavliti))) :{
				if (pp(var(name(name(metavliti)))) in moles){
					if(operation == postDec() || operation == postInc())
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, " {$<moles[pp(var(name(name(metavliti))))]><pp(operation)>} ");
					else
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, " <pp(operation)>{$<moles[pp(var(name(name(metavliti))))]>} ");
				}
		}
		case fetchArrayDim(var,dim) : {
			if (pp(var) in moles && someExpr(scalar(string(dimension))) := dim){
				if(operation == postDec() || operation == postInc())
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, " {$<moles[pp(var)]>.<dimension>}<pp(operation)> ");
				else
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, " <pp(operation)>{$<moles[pp(var)]>.<dimension>} ");	
			}		
			elseif (pp(var) in moles && someExpr(scalar(integer(dimension))) := dim){
				if(operation == postDec() || operation == postInc())
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, " {$<moles[pp(var)]>.<dimension>}<pp(operation)> ");
				else
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, " <pp(operation)>{$<moles[pp(var)]>.<dimension>} ");
				}
			elseif (pp(var) in moles && pp(dim) in moles){ 
				if(operation == postDec() || operation == postInc())
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, " {$<moles[pp(var)]>.$<moles[pp(dim)]>}<pp(operation)> ");
				else
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, "<pp(operation)>{$<moles[pp(var)]>.$<moles[pp(dim)]>} ");
			}
		}
	}		
}