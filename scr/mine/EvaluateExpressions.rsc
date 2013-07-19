module mine::EvaluateExpressions

import mine::Smarty;
import IO;
import lang::php::util::Utils;
import lang::php::ast::AbstractSyntax;
import mine::EvaluateNonLiteral;

public void evaluateExpression(Expr combinedExpr,map[str,str] moles){
	if (scalar(string(literal)) := combinedExpr){
		appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, " <literal> " );
		println("it is print or echo literal");
	}
	else {
		evaluateNonLiteral(combinedExpr,moles);
	}	
}