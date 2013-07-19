module mine::BinaryLeft

import IO;
import lang::php::util::Utils;
import lang::php::ast::AbstractSyntax;
import lang::php::pp::PrettyPrinter;
import mine::EncapsedCase;
import mine::UnaryCase;
import mine::BinaryRight;

public void binaryLeft(Expr left,Expr right,Op op,map[str,str] moles){
		switch (left) {
			
			case scalar(string(leksi)) : {
				appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, "<leksi> ");
			}
			
			case scalar(integer(number)) : {
				if (concat() := op)
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, " <number> ");
				else
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, " <number> ");
			}
			
			case var(name(name(metavliti))) : {
				if (pp(var(name(name(metavliti)))) in moles){
					if (concat() := op)
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, " {$<moles[pp(var(name(name(metavliti))))]>} ");
					else
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, " {$<moles[pp(var(name(name(metavliti))))]>} ");		
				}
			}
			
			case scalar(encapsed(expressions)) : {
				encapsedCase(expressions,moles);
			}
				
			case unaryOperation(operand,operation) :{
				unaryCase(operand,operation,moles);
			}
			
			case assign(assignTo,assignExpr) :{
				if (var(name(name(metavliti))) := assignTo){
					if (pp(var(name(name(metavliti)))) in moles)
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, " $<moles[pp(var(name(name(metavliti))))]> = <pp(assignExpr)> ");
				}
			}
			
			case  binaryOperation(leftExpr,rightExpr,oper)  : {
				binaryLeft(leftExpr,rightExpr,oper,moles);
				binaryRight(leftExpr,rightExpr,oper,moles);
			}
			
			default : {
				println ("paparitses");
			}		
		}
	}