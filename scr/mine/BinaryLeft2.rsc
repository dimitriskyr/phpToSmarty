module mine::BinaryLeft2

import IO;
import lang::php::util::Utils;
import lang::php::ast::AbstractSyntax;
import lang::php::pp::PrettyPrinter;
import mine::EncapsedCase2;
import mine::UnaryCase2;
import mine::BinaryRight2;

public void binaryLeft2(Expr left,Expr right,Op op,map[str,str] moles){
		switch (left) {
			
			case scalar(string(leksi)) : {
				appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|, "<leksi> ");
			}
			
			case scalar(integer(number)) : {
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|, "<number> ");
			}
			
			case fetchArrayDim(var,dim) : {
					if (pp(var) in moles && someExpr(scalar(string(dimension))) := dim)
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|, " {$<moles[pp(var)]>.<dimension>} ");			
					elseif (pp(var) in moles && someExpr(scalar(integer(dimension))) := dim)
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|, " {$<moles[pp(var)]>.<dimension>} ");
			}
			
			case var(name(name(metavliti))) : {
				if (pp(var(name(name(metavliti)))) in moles){
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|, "$<moles[pp(var(name(name(metavliti))))]> ");		
				}
			}
			
			case scalar(encapsed(expressions)) : {
				encapsedCase2(expressions,moles);
			}
				
			case unaryOperation(operand,operation) :{
				unaryCase2(operand,operation,moles);
			}
			
			case fetchConst(X) : {
				appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|,  pp(X) );
			}
			
			case assign(assignTo,assignExpr) :{
				if (var(name(name(metavliti))) := assignTo){
					if (pp(var(name(name(metavliti)))) in moles)
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|, "$<moles[pp(var(name(name(metavliti))))]> = <pp(assignExpr)> ");
				}
			}
			
			case  binaryOperation(leftExpr,rightExpr,oper)  : {
				binaryLeft2(leftExpr,rightExpr,oper,moles);
				binaryRight2(leftExpr,rightExpr,oper,moles);
			}
			
			default : {
				println ("nothing");
			}		
		}
}