module mine::EvaluateNonLiteral

import IO;
import lang::php::util::Utils;
import lang::php::ast::AbstractSyntax;
import lang::php::pp::PrettyPrinter;
import mine::EncapsedCase;
import mine::BinaryLeft;
import mine::BinaryRight;
import mine::UnaryCase;

	public void evaluateNonLiteral(Expr combinedExpr,map[str,str] moles,str tempName){
	
	switch (combinedExpr) {
	
		case scalar(encapsed(expressions)) : {
			encapsedCase(expressions,moles,tempName);
			}
			
		case binaryOperation(leftExpr,rightExpr,op) : {
				binaryLeft(leftExpr,rightExpr,op,moles,tempName);
				binaryRight(leftExpr,rightExpr,op,moles,tempName);
			}
			
		case unaryOperation(operand,operation) : {
			unaryCase(operand,operation,moles,tempName);
		}
	}
}