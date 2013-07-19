module mine::Smarty

import mine::EvaluateExpressions;
import lang::php::util::Utils;
import lang::php::ast::AbstractSyntax;
import util::ValueUI;
import lang::php::pp::PrettyPrinter;
import analysis::graphs::Graph;
import lang::php::analysis::NamePaths;
import lang::php::analysis::cfg::CFG;
import lang::php::analysis::cfg::Label;
import lang::php::analysis::cfg::FlowEdge;
import lang::php::analysis::cfg::BuildCFG;
import IO;
import Map;
import List;

public void showTemplate(){
	int i=0;
	str printedText="";
	loc l = |file://C:/xampp/htdocs/PHPRefactoring/src/ifStatement.php|; 
	Script scr=loadPHPFile(l);
	Expr display = propertyFetch(var(name(name("smarty"))),name(name("display(\'hello.tpl\');\n\r")));
	Expr assignment;
	str initialText = "\<?php \r\ndefine(\'SMARTY_DIR\', \'C:/Smarty/libs/Smarty-3.1.13/libs/\');

	require_once(SMARTY_DIR . \'Smarty.class.php\');

	$smarty = new Smarty();

	$smarty-\>template_dir = \'C:/xampp/htdocs/smarty/templates\';
	$smarty-\>compile_dir  = \'C:/xampp/htdocs/smarty/templates_c\';
	$smarty-\>config_dir   = \'C:/xampp/htdocs/smarty/configs/\';
	$smarty-\>cache_dir    = \'C:/xampp/htdocs/smarty/cache/\';

	\n\r"; 
	
	list[str] holes= ["val1","val2","val3","val4","val5","val6","val7","val8","val9"];
	map [int,str] mole = (0 : "val1" , 1 : "val2" , 2 : "val3" , 3 : "val4", 4 : "val5", 5 : "val6");
	map [str,str] moles = ();
	Graph[CFGNode] gr;
	<lscr, cfgs> = buildCFGsAndScript(scr);
	
	for (np <- cfgs) {
		gr = cfgAsGraph(cfgs[np]);
		text(gr);
	}
	
	writeFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, "{* Smarty *} \r\n");
	writeFile(|file://C:/xampp/htdocs/PHPRefactoring/src/hello.php|, initialText);	
	
	visit (scr){
		
		case assign(X,Y) : {	
			appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/hello.php|, pp(assign(X,Y)) + ";\n\r");
			moles[pp(X)]=mole[i];
			assignment = propertyFetch(var(name(name("smarty"))),name(name("assign(\'<holes[i]>\',<pp(X)>);\n\r")));
			//println(pp(assignment));
			appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/hello.php|, pp(assignment));
			i+=1;
		}
		
		case refAssign(X,Y) : {	
			appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/hello.php|, pp(assign(X,Y)) + ";\n\r");
			moles[pp(X)]=mole[i];
			//println(pp(X));
			assignment = propertyFetch(var(name(name("smarty"))),name(name("assignByRef(\'<holes[i]>\',<pp(X)>);\n\r")));
			//println(pp(assignment));
			appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/hello.php|, pp(assignment));
			i+=1;
		}
		
		
		/*case echo(X) :{	
			for (echoExpression <- X){
				printedText=evaluateExpression(echoExpression,moles);
			}
		}
		
		case Expr::print(printExpression) : {
			printedText=evaluateExpression(printExpression,moles);
		}*/
	};
	
	list[Stmt] stmts=[];
	list[int] labs=[];
	map [int,Stmt] mapNodes = ();
	int j=0;
	
	for (nodes <- gr){
		
		/*if (<stmtNode(stmt1,lab(lstmt1)),stmtNode(stmt2,lstmt2)> := nodes){
		//println("STATEMENT <stmt1>");
		//println("STATEMENT <stmt2>");
		//println(i); 
		i+=1;
		println("<i> stmtnode");
		stmts=stmts+stmt1;
		labs=labs+lstmt1;
		mapNodes = mapNodes + (lstmt1 : stmt1);
		}*/
		
		/*else if(<stmtNode(stmt1,lab(lstmt1)),_> := nodes){
			//println("EXPRESSION <expr1>");
			//println("EXPRESSION <expr2>");
			//println(i);
			i+=1;
			println("<i> stmtnode");
			stmts=stmts+stmt1;
			labs=labs+lstmt1;
			mapNodes= mapNodes + (lstmt1:stmt1);		
		}*/
		
		if(<stmtNode(stmt1,lab(lstmt1)),scriptExit()> := nodes){
			//println("EXPRESSION <expr1>");
			//println("EXPRESSION <expr2>");
			//println(i);
			i+=1;
			println("<i> stmtnode");
			stmts=stmts+stmt1;
			labs=labs+lstmt1;
			mapNodes= mapNodes + (lstmt1:stmt1);		
		}
		
		else if(<stmtNode(stmt1,lab(lstmt1)),exprNode(expr1,lexpr1)> := nodes){
			//println("EXPRESSION <expr1>");
			//println("EXPRESSION <expr2>");
			//println(i);
			i+=1;
			println("<i> stmtnode");
			stmts=stmts+stmt1;
			labs=labs+lstmt1;
			mapNodes= mapNodes + (lstmt1:stmt1);		
		}
	}
	
	text(labs);
	
	list[int] sortedLabs = sort (labs);	
	list[Stmt] listed = [];
	for (q <- [0..size(labs - 1)])
		listed= listed + mapNodes[sortedLabs[q]];
		
	text(listed);
		
	for (state <- listed){
		if (\if(cond, body, elseIfs, elseClause) := state){
		appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, "{if ");
			evaluateExpression(cond,moles);
			appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, " }");
			echoOrPrint(body,moles);
				
			for(elseif <- elseIfs){
				if (elseIf(cond2,body2):= elseif){
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, "{elseif ");
					evaluateExpression(cond2,moles);
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, " }");
					echoOrPrint(body2,moles);
				}
			}
				
			if ( someElse(\else(body3)) := elseClause){
				appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, "{else} ");
				echoOrPrint(body3,moles);
			}			
			appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, "{/if}");
		}
		
		if(echo(X) := state){	
			for (echoExpression <- X){
				printedText=evaluateExpression(echoExpression,moles);
			}
		}
		
		if (Expr::print(printExpression) := state) {
			printedText=evaluateExpression(printExpression,moles);
		}
		
	}
	
	
	/*visit (scr){
		
		case \if(cond, body, elseIfs, elseClause) : {
			appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, "{if ");
			evaluateExpression(cond,moles);
			appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, " }");
			echoOrPrint(body,moles);
				
			for(elseif <- elseIfs){
				if (elseIf(cond2,body2):= elseif){
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, "{elseif ");
					evaluateExpression(cond2,moles);
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, " }");
					echoOrPrint(body2,moles);
				}
			}
				
			if ( someElse(\else(body3)) := elseClause){
				appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, "{else} ");
				echoOrPrint(body3,moles);
			}			
			appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, "{/if}");
		}
		
		case function(name, byRef, params, body) : {
			echoOrPrint(body,moles);
			for (partt <- body){
				switch (partt){
					case \if(cond, body, elseIfs, elseClause) : {
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, "{if ");
						evaluateExpression(cond,moles);
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, " }");
						echoOrPrint(body,moles);
							
						for(elseif <- elseIfs){
							if (elseIf(cond2,body2):= elseif){
								appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, "{elseif ");
								evaluateExpression(cond2,moles);
								appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, " }");
								echoOrPrint(body2,moles);
							}
						}
							
						if ( someElse(\else(body3)) := elseClause){
							appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, "{else} ");
							echoOrPrint(body3,moles);
						}			
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, "{/if}");
					}
				}
			}
		}
		
		case foreach(arrayExpr, keyvar, byRef, asVar, body) : {
								
			if (pp(arrayExpr) in moles && noExpr() := keyvar && var(name(name(variable))) := asVar){
				appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, 
				"{foreach from=$<moles[pp(arrayExpr)]> item=<variable>} 
				\<li\>{<pp(asVar)>}\</li\> {/foreach}");
			}
				
			if (pp(arrayExpr) in moles && someExpr(var(name(name(key)))) := keyvar && var(name(name(variable))) := asVar){
				appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, 
				"{foreach from=$<moles[pp(arrayExpr)]> key=<key> item=<variable>} 
				\<li\>{$<key>}: {<pp(asVar)>}\</li\> {/foreach}");
			}
		}
		
		case \while(cond,body) : {
			
			appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, "{while ");
			evaluateExpression(cond,moles);
			appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, "}");
			echoOrPrint(body,moles);
			appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, "{/while}");
		}
	};*/
	
	appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/hello.php|, pp(display)); 
	appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/hello.php|, "\r\n?\>");
	text(scr);
	println("finished");	
}

private void echoOrPrint(list[Stmt] body, map[str,str] moles){
	for (part<-body){
				switch(part) {
				
					case echo(X) :{	
						for (echoExpression <- X){
							printedText=evaluateExpression(echoExpression,moles);
						}
					}
		
					case exprstmt(Expr::print(printExpression)) : {
						printedText=evaluateExpression(printExpression,moles);						
					}			
				}
			}
}