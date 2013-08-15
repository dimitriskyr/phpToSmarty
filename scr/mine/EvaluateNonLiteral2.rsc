module mine::EvaluateNonLiteral2

import IO;
import lang::php::util::Utils;
import lang::php::ast::AbstractSyntax;
import lang::php::pp::PrettyPrinter;
import mine::EncapsedCase2;
import mine::BinaryLeft2;
import mine::BinaryRight2;
import mine::UnaryCase2;

	public void evaluateNonLiteral2(Expr combinedExpr,map[str,str] moles,str tempName){
	
	switch (combinedExpr) {
	
		case scalar(encapsed(expressions)) : {
			encapsedCase2(expressions,moles,tempName);
			}
			
		case binaryOperation(leftExpr,rightExpr,op) : {
				binaryLeft2(leftExpr,rightExpr,op,moles,tempName);
				binaryRight2(leftExpr,rightExpr,op,moles,tempName);
			}
			
		case unaryOperation(operand,operation) : {
			unaryCase2(operand,operation,moles,tempName);
		}
	}
}