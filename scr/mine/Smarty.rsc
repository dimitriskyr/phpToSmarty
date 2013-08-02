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
	loc l = |file://C:/xampp/htdocs/PHPRefactoring/src/arrays.php|; 
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
	map [int,str] dynamicMole = (0 : "val1|escape:\'htmlall\'" , 1 : "val2|escape:\'htmlall\'", 2 : "val3|escape:\'htmlall\'",
	 3 : "val4|escape:\'htmlall\'" , 4 : "val5|escape:\'htmlall\'");
	map [str,str] moles = ();
	
	writeFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, "{* Smarty *} \r\n");
	writeFile(|file://C:/xampp/htdocs/PHPRefactoring/src/hello.php|, initialText);	
	
	visit (scr){
		
		case assign(X,Y) : {
			if (fetchArrayDim(var(name(name("_GET"))),_) := Y){
				appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/hello.php|, pp(assign(X,Y)) + ";\n\r");
				moles[pp(X)]=dynamicMole[i];
				assignment = propertyFetch(var(name(name("smarty"))),name(name("assign(\'<holes[i]>\',<pp(X)>);\n\r")));
				appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/hello.php|, pp(assignment));
				i+=1;
			}
			else{	
				appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/hello.php|, pp(assign(X,Y)) + ";\n\r");
				moles[pp(X)]=mole[i];
				assignment = propertyFetch(var(name(name("smarty"))),name(name("assign(\'<holes[i]>\',<pp(X)>);\n\r")));
				appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/hello.php|, pp(assignment));
				i+=1;
			}
			print(moles);
		}
		
		case refAssign(X,Y) : {
			if (fetchArrayDim(var(name(name("_GET"))),_) := Y){
				appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/hello.php|, pp(assign(X,Y)) + ";\n\r");
				moles[pp(X)]=dynamicMole[i];
				assignment = propertyFetch(var(name(name("smarty"))),name(name("assignByRef(\'<holes[i]>\',<pp(X)>);\n\r")));
				appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/hello.php|, pp(assignment));
				i+=1;
				}
			else{		
				appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/hello.php|, pp(assign(X,Y)) + ";\n\r");
				moles[pp(X)]=mole[i];
				assignment = propertyFetch(var(name(name("smarty"))),name(name("assignByRef(\'<holes[i]>\',<pp(X)>);\n\r")));
				appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/hello.php|, pp(assignment));
				i+=1;
			}
		}
	};
		
	// Here takes place the evaluation of the PHP program
	
	formOfStmt(scr.body,mole,moles,holes,i);
		
	/*visit (scr){
		
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

private void formOfStmt(list[Stmt] body, map[int,str] mole, map[str,str] moles, list[str] holes,int i) {
			for (part<-body){
				switch(part) {
				
					case foreach(arrayExpr, keyvar, byRef, asVar, body1) : {
								
						if (pp(arrayExpr) in moles && noExpr() := keyvar && var(name(name(variable))) := asVar){
							moles[pp(asVar)]=mole[i];
							i+=1;
							assignment = propertyFetch(var(name(name("smarty"))),name(name("assign(\'<holes[i]>\',<pp(asVar)>);\n\r")));
							appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, 
							"{foreach from=$<moles[pp(arrayExpr)]> item=<moles[pp(asVar)]>}");
							formOfStmt(body1,mole,moles,holes,i);
							appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, "{/foreach}");
						}
				
						elseif (pp(arrayExpr) in moles && someExpr(var(name(name(key)))) := keyvar && var(name(name(variable))) := asVar){
							moles[pp(asVar)]=mole[i];
							assignment = propertyFetch(var(name(name("smarty"))),name(name("assign(\'<holes[i]>\',<pp(asVar)>);\n\r")));
							i+=1;
							moles[pp(keyvar)]=mole[i];
							i+=1;
							assignment = propertyFetch(var(name(name("smarty"))),name(name("assign(\'<holes[i]>\',<pp(keyvar)>);\n\r")));
							appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, 
							"{foreach from=$<moles[pp(arrayExpr)]> key=<moles[pp(keyvar)]> item=<moles[pp(asVar)]>}"); 
							formOfStmt(body1,mole,moles,holes,i);
							appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, "{/foreach}");
						}
					}
					
					case exprstmt(call(funName, parameters)) :{
						for (aPart<-body){
							switch (aPart){
								case function(name, byRef, params, body1) : {
									if( name == pp(funName)){
										formOfStmt(body1,moles);
									}
								}
							}
						}
					}
									
					case \if(cond, body1, elseIfs, elseClause) :{
						print("hell");
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, "{if ");
						evaluateExpression(cond,moles);
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, " }");
						formOfStmt(body1,moles);
				
						for(elseif <- elseIfs){
							if (elseIf(cond2,body2):= elseif){
								appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, "{elseif ");
									evaluateExpression(cond2,moles);
									appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, " }");
									formOfStmt(body2,moles);
							}
						}
				
						if ( someElse(\else(body3)) := elseClause){
							appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, "{else} ");
							formOfStmt(body3,moles);
						}			
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, "{/if}");
					}
				
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