module mine::Smarty

import mine::EvaluateExpressions;
import mine::EvaluateNonLiteral2;
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
	loc l = |file://C:/xampp/htdocs/PHPRefactoring/src/castsAndReferences.php|;  
	Script scr=loadPHPFile(l); 
	Expr display = propertyFetch(var(name(name("smarty"))),name(name("display(\'showTemplate.tpl\');\n\r")));
	Expr assignment;
	str initialText = "\<?php \r\ndefine(\'SMARTY_DIR\', \'C:/Smarty/libs/Smarty-3.1.13/libs/\');

	require_once(SMARTY_DIR . \'Smarty.class.php\');

	$smarty = new Smarty();

	$smarty-\>template_dir = \'C:/xampp/htdocs/smarty/templates\';
	$smarty-\>compile_dir  = \'C:/xampp/htdocs/smarty/templates_c\';
	$smarty-\>config_dir   = \'C:/xampp/htdocs/smarty/configs/\';
	$smarty-\>cache_dir    = \'C:/xampp/htdocs/smarty/cache/\';

\n\n"; 
	
	list[str] holes= [];
	map [int,str] mole = ();
	map [int,str] dynamicMole = ();
	map [str,str] moles = ();
	
	writeFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|, "{* Smarty *} \r\n");
	writeFile(|file://C:/xampp/htdocs/PHPRefactoring/src/showTemplate.php|, initialText);	
			
	// Here takes place the evaluation of the PHP program
	formOfStmt(scr.body,mole,moles,holes,i,dynamicMole);
	
	// Here we put the display template command in our new PHP program
	
	appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/showTemplate.php|, pp(display)); 
	appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/showTemplate.php|, "\n?\>");
	text(scr);
	println("finished");	
}

private void formOfStmt(list[Stmt] body, map[int,str] mole, map[str,str] moles, list[str] holes,int i,map[int,str] dynamicMole) {
	bool printOrEcho=false;
	for (part<-body){
	println(part);
		switch(part) {					
			
			case exprstmt(assign(X,Y)) : {
				println(moles);
				if (fetchArrayDim(var(name(name("_GET"))),_) := Y){
					appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/showTemplate.php|, pp(assign(X,Y)) + ";");
					dynamicMole[i+1]= "val<i+1>|escape:\'htmlall\'";
					moles[pp(X)]=dynamicMole[i+1];
					holes=holes+"val<i+1>";
					assignment = propertyFetch(var(name(name("smarty"))),name(name("assign(\'<holes[i]>\',<pp(X)>);\n\r")));
					appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/showTemplate.php|, "<pp(assignment)>\n");
					i+=1;
				} 
				else{				
					appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/showTemplate.php|, pp(assign(X,Y)) + ";");
					mole[i+1]= "val<i+1>";
					moles[pp(X)]=mole[i+1];
					holes=holes+"val<i+1>";
					assignment = propertyFetch(var(name(name("smarty"))),name(name("assign(\'<holes[i]>\',<pp(X)>);\n\r")));
					appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/showTemplate.php|, "<pp(assignment)>\n");
					i+=1;			
				}
			}
			
			case exprstmt(assignWOp(X,Y,op)) : {
				if (fetchArrayDim(var(name(name("_GET"))),_) := Y){
					appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/showTemplate.php|, pp(assignWOp(X,Y,op)) + ";");
					dynamicMole[i+1]= "val<i+1>|escape:\'htmlall\'";
					moles[pp(X)]=dynamicMole[i];
					holes=holes+"val<i+1>";
					assignment = propertyFetch(var(name(name("smarty"))),name(name("assign(\'<holes[i]>\',<pp(X)>);\n\r")));
					appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/showTemplate.php|, "<pp(assignment)>\n");
					i+=1;
					}
				else{		
					appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/showTemplate.php|, pp(assignWOp(X,Y,op)) + ";");
					mole[i+1]= "val<i+1>";
					moles[pp(X)]=mole[i+1];
					holes=holes+"val<i+1>";
					assignment = propertyFetch(var(name(name("smarty"))),name(name("assign(\'<holes[i]>\',<pp(X)>);\n\r")));
					appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/showTemplate.php|, "<pp(assignment)>\n");
					i+=1;
				}
			}
			
			case exprstmt(refAssign(X,Y)) : {
				if (fetchArrayDim(var(name(name("_GET"))),_) := Y){
					appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/showTemplate.php|, pp(assign(X,Y)) + ";");
					dynamicMole[i+1]= "val<i+1>|escape:\'htmlall\'";
					moles[pp(X)]=dynamicMole[i];
					holes=holes+"val<i+1>";
					assignment = propertyFetch(var(name(name("smarty"))),name(name("assignByRef(\'<holes[i]>\',<pp(X)>);\n\r")));
					appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/showTemplate.php|, "<pp(assignment)>\n");
					i+=1;
					}
				else{		
					appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/showTemplate.php|, pp(assign(X,Y)) + ";");
					mole[i+1]= "val<i+1>";
					moles[pp(X)]=mole[i+1];
					holes=holes+"val<i+1>";
					assignment = propertyFetch(var(name(name("smarty"))),name(name("assignByRef(\'<holes[i]>\',<pp(X)>);\n\r")));
					appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/showTemplate.php|, "<pp(assignment)>\n");
					i+=1;
				}
		}
				
			case \while(cond,body1) : {
				map[str,str] tempMoles=moles;
				for (part1<-body1){
					printOrEcho=isPrintOrEcho(part1);
				}
				if(printOrEcho){
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|, "{while ");
					evaluateNonLiteral2(cond,moles);
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|, "}");
					for (aPart <- body1){
						if(exprstmt(unaryOperation(operand,operation)) := aPart){
							if(pp(operand) in moles && postInc() := operation){
								tempMoles[pp(operand)]="<moles[pp(operand)]>++";
							}
							elseif(pp(operand) in moles && postDec() := operation){
								tempMoles[pp(operand)]="<moles[pp(operand)]>--";
							}
							else {
							  // bail out!
							  ;
							}
						}
					}
					formOfStmt(body1,mole,tempMoles,holes,i,dynamicMole);
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|, "{/while}");
			   }			
		    }
								
			case foreach(arrayExpr, keyvar, byRef, asVar, body1) : {
				for (part1<-body1){								
					printOrEcho=isPrintOrEcho(part1);		
				}
				if(printOrEcho==true){		
					if (pp(arrayExpr) in moles && noExpr() := keyvar && var(name(name(variable))) := asVar){
						mole[i+1]= "val<i+1>";
						moles[pp(asVar)]=mole[i+1];
						println(moles);
						holes=holes+"val<i+1>";
						assignment = propertyFetch(var(name(name("smarty"))),name(name("assign(\'<holes[i]>\',<pp(asVar)>);\n\r")));
						//appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/showTemplate.php|, "<pp(assignment)>\n");
						i+=1;
						println(i);
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|, 
						"{foreach from=$<moles[pp(arrayExpr)]> item=<moles[pp(asVar)]>}");
						formOfStmt(body1,mole,moles,holes,i,dynamicMole);
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|, "{/foreach}");
					}
					
					elseif (pp(arrayExpr) in moles && someExpr(var(name(name(key)))) := keyvar && var(name(name(variable))) := asVar){
						mole[i+1]= "val<i+1>";
						moles[pp(asVar)]=mole[i+1];
						holes=holes+"val<i+1>";
						assignment = propertyFetch(var(name(name("smarty"))),name(name("assign(\'<holes[i]>\',<pp(asVar)>);\n\r")));
						//appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/showTemplate.php|, "<pp(assignment)>\n");
						i+=1;
						println(i);
						mole[i+1]= "val<i+1>";
						moles[pp(keyvar)]=mole[i+1];
						holes=holes+"val<i+1>";	
						assignment = propertyFetch(var(name(name("smarty"))),name(name("assign(\'<holes[i]>\',<pp(keyvar)>);\n\r")));
						//appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/showTemplate.php|, "<pp(assignment)>\n");
						i+=1;
						println(i);
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|, 
						"{foreach from=$<moles[pp(arrayExpr)]> key=<moles[pp(keyvar)]> item=<moles[pp(asVar)]>}"); 
						formOfStmt(body1,mole,moles,holes,i,dynamicMole);
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|, "{/foreach}");
					}
				}
			}
					
			case exprstmt(call(funName, parameters)) :{
				for (aPart<-body){
					println(aPart);
					switch (aPart){
						case function(name, byRef, params, body1) : {
							println("yessss");
							if( name == pp(funName)){
								for (part1<-body1){								
									printOrEcho=isPrintOrEcho(part1);		
								}
								if(printOrEcho==true){
									formOfStmt(body1,mole,moles,holes,i,dynamicMole);
								}
							}
						}
					}
				}
			}
									
			case \if(cond, body1, elseIfs, elseClause) :{
				for (part1<-body1){
					printOrEcho=isPrintOrEcho(part1);
				}
				if(printOrEcho){
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|, "{if ");
					evaluateExpression(cond,moles);
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|, " }");
					formOfStmt(body1,mole,moles,holes,i,dynamicMole);
					for(elseif <- elseIfs){
						if (elseIf(cond2,body2):= elseif){
							appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|, "{elseif ");
								evaluateExpression(cond2,moles);
								appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|, " }");
								formOfStmt(body2,mole,moles,holes,i,dynamicMole);
						}
					}
					if ( someElse(\else(body3)) := elseClause){
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|, "{else} ");
						formOfStmt(body3,mole,moles,holes,i,dynamicMole);
					}			
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/showTemplate.tpl|, "{/if}");
				}
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

private bool isPrintOrEcho(Stmt body){
	bool printOrEcho=true;
	switch(body) {
	
		case \while(cond,body1) : {
			for (part1<-body1){
				if(echo(_) !:= part1 && exprstmt(Expr::print(_)) !:= part1){
					printOrEcho=isPrintOrEcho(part1);
					if(printOrEcho)
						return printOrEcho;
					else
						continue;
				}
				else
					return printOrEcho;
			}
			return printOrEcho=false;
		}
		
		case function(name, byRef, params, body1) : {
			for (part1<-body1){
				if(echo(_) !:= part1 && exprstmt(Expr::print(_)) !:= part1){
					printOrEcho=isPrintOrEcho(part1);
					if(printOrEcho)
						return printOrEcho;
					else
						continue;
				}
				else
					return printOrEcho;
			}
			return printOrEcho=false;
		
		}
		
		
		case foreach(arrayExpr, keyvar, byRef, asVar, body1) : {
			for (part1<-body1){
				if(echo(_) !:= part1 && exprstmt(Expr::print(_)) !:= part1){
					printOrEcho=isPrintOrEcho(part1);
					if(printOrEcho)
						return printOrEcho;
					else
						continue;
				}
				else
					return printOrEcho;
			}
			return printOrEcho=false;
		}
		
		case \if(cond, body1, elseIfs, elseClause) :{
			for (part1<-body1){
				if(echo(_) !:= part1 && exprstmt(Expr::print(_)) !:= part1){
					printOrEcho=isPrintOrEcho(part1);
					if(printOrEcho)
						return printOrEcho;
					else 
						continue;
				}
				else
					println("there is");
					return printOrEcho;
			}
			return printOrEcho=false;
		}
		
		case exprstmt(call(funName,parameters)) :{
			return printOrEcho;
		}
		
		case echo(X) : return printOrEcho;
			
		case exprstmt(Expr::print(printExpression)) : return printOrEcho;
		
		default : break;
	}	
}					

//todo casts, functioncall