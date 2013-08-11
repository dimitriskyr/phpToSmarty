module mine::EvaluateExpressions

import mine::Smarty;
import IO;
import lang::php::util::Utils;
import lang::php::ast::AbstractSyntax;
import mine::EvaluateNonLiteral;
import lang::php::pp::PrettyPrinter;


public void evaluateExpression(Expr combinedExpr,map[str,str] moles){
	println(combinedExpr);
	if (scalar(string(literal)) := combinedExpr){
		appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|, " <literal> " );
	}
	else if (var(name(name(X))) := combinedExpr) {
					if (pp(var(name(name(X)))) in moles)
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|, " {$<moles[pp(var(name(name(X))))]>} ");
	}
	else if (fetchArrayDim(var,dim)  := combinedExpr){
		if (pp(var) in moles && someExpr(scalar(string(dimension))) := dim)
			appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|, " {$<moles[pp(var)]>.<dimension>} ");			
		elseif (pp(var) in moles && someExpr(scalar(integer(dimension))) := dim)
			appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|, " {$<moles[pp(var)]>.<dimension>} ");
		}
	else if (fetchConst(X) := combinedExpr) {
		appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|,  pp(X) );
	}
	/*else if (call(expr(var(name(name(X))))(_)) := combinedExpr) {
		println(combinedExpr);
		println(pp(combinedExpr));
		println("provlima");
	}*/
		
	else {
		evaluateNonLiteral(combinedExpr,moles);
	}	
}