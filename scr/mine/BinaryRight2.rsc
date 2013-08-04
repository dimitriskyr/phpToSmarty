module mine::BinaryRight2

import IO;
import lang::php::util::Utils;
import lang::php::ast::AbstractSyntax;
import lang::php::pp::PrettyPrinter;
import mine::EncapsedCase2;
import mine::UnaryCase2;
import mine::BinaryLeft2;

public void binaryRight2 (Expr leftExpr,Expr rightExpr,Op oper,map[str,str] moles){
	
	if (concat() != oper){
	appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, " <pp(oper)> ");
	}
	switch (rightExpr) {
			
			case scalar(string(leksi)) : {
				appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, "<leksi> ");
			}
			
			case scalar(integer(number)) : {
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, " <number> ");
			}
			
			case fetchArrayDim(var,dim) : {
					if (pp(var) in moles && someExpr(scalar(string(dimension))) := dim)
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, " {$<moles[pp(var)]>.<dimension>} ");			
					elseif (pp(var) in moles && someExpr(scalar(integer(dimension))) := dim)
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, " {$<moles[pp(var)]>.<dimension>} ");
			}
			
			case var(name(name(metavliti))) : {
				if (pp(var(name(name(metavliti)))) in moles){
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, " $<moles[pp(var(name(name(metavliti))))]> ");		
				}
			}
			
			case scalar(encapsed(expressions)) : {
				encapsedCase2(expressions,moles);
			}
				
			case unaryOperation(operand,operation) :{
				unaryCase2(operand,operation,moles);
			}
			
			case assign(assignTo,assignExpr) :{
				if (var(name(name(metavliti))) := assignTo){
					if (pp(var(name(name(metavliti)))) in moles)
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, " $<moles[pp(var(name(name(metavliti))))]> = <pp(assignExpr)> ");
				}
			}
			
			case  binaryOperation(left,right,op)  : {
				binaryLeft2(left,right,op,moles);
				binaryRight2(left,right,op,moles);
			}
	}
}