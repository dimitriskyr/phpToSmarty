module mine::EvaluateExpressions

import mine::Smarty;
import IO;
import lang::php::util::Utils;
import lang::php::ast::AbstractSyntax;
import mine::EvaluateNonLiteral;
import lang::php::pp::PrettyPrinter;


public void evaluateExpression(Expr combinedExpr,map[str,str] moles){
	if (scalar(string(literal)) := combinedExpr){
		appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, " <literal> " );
		println("it is print or echo literal");
	}
	else if (var(name(name(X))) := combinedExpr) {
					if (pp(var(name(name(X)))) in moles)
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, " {$<moles[pp(var(name(name(X))))]>} ");
				}
	else {
		evaluateNonLiteral(combinedExpr,moles);
	}	
}