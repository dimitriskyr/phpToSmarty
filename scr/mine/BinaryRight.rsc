module mine::BinaryRight

import IO;
import lang::php::util::Utils;
import lang::php::ast::AbstractSyntax;
import lang::php::pp::PrettyPrinter;
import mine::EncapsedCase;
import mine::UnaryCase;
import mine::BinaryLeft;

public void binaryRight (Expr leftExpr,Expr rightExpr,Op oper,map[str,str] moles,tempName){
	
	if (concat() != oper){
	appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, " <pp(oper)> ");
	}
	switch (rightExpr) {
			
			case scalar(string(leksi)) : {
				appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, "<leksi> ");
			}
			
			case scalar(integer(number)) : {
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, " <number> ");
			}
			
			case fetchArrayDim(var,dim) : {
					if (pp(var) in moles && someExpr(scalar(string(dimension))) := dim)
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, " {$<moles[pp(var)]>.<dimension>} ");			
					elseif (pp(var) in moles && someExpr(scalar(integer(dimension))) := dim)
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, " {$<moles[pp(var)]>.<dimension>} ");
					elseif (pp(var) in moles && pp(dim) in moles) 
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, " {$<moles[pp(var)]>.$<moles[pp(dim)]>} ");
			}
			
			case var(name(name(metavliti))) : {
				if (pp(var(name(name(metavliti)))) in moles){
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, " {$<moles[pp(var(name(name(metavliti))))]>} ");		
				}
			}
			
			case scalar(encapsed(expressions)) : {
				encapsedCase(expressions,moles,tempName);
			}
				
			case unaryOperation(operand,operation) :{
				unaryCase(operand,operation,moles,tempName);
			}
			
			case fetchConst(X) : {
				appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|,  pp(X) );
			}
			
			case assign(assignTo,assignExpr) :{
				if (var(name(name(metavliti))) := assignTo){
					if (pp(var(name(name(metavliti)))) in moles)
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, " $<moles[pp(var(name(name(metavliti))))]> = <pp(assignExpr)> ");
				}
			}
			
			case  binaryOperation(left,right,op)  : {
				binaryLeft(left,right,op,moles,tempName);
				binaryRight(left,right,op,moles,tempName);
			}
	}
}