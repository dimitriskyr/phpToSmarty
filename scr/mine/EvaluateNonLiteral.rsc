module mine::EvaluateNonLiteral

import IO;
import lang::php::util::Utils;
import lang::php::ast::AbstractSyntax;
import lang::php::pp::PrettyPrinter;
import mine::EncapsedCase;
import mine::BinaryLeft;
import mine::BinaryRight;
import mine::UnaryCase;

	public void evaluateNonLiteral(Expr combinedExpr,map[str,str] moles){
	
	switch (combinedExpr) {
	
		case scalar(encapsed(expressions)) : {
			encapsedCase(expressions,moles);
			}
			
		case binaryOperation(leftExpr,rightExpr,op) : {
				binaryLeft(leftExpr,rightExpr,op,moles);
				binaryRight(leftExpr,rightExpr,op,moles);
			}
			
		case unaryOperation(operand,operation) : {
			unaryCase(operand,operation,moles);
		}
	}
}