module mine::Smarty

import util::Resources;
import lang::php::util::System;
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
import String;
import IO; 
import Map;
import List;
import Set;
import lang::java::jdt::Java;
import lang::java::jdt::JDT;

public void showTemplate(){
	int i=0;
	str printedText=""; 
	list[str] holes= [];
	map [int,str] mole = ();
	map [int,str] dynamicMole = ();
	map [str,str] moles = ();
	Expr assignment;
	str initialText = "\<?php \r\ndefine(\'SMARTY_DIR\', \'C:/Smarty/libs/Smarty-3.1.13/libs/\');

	require_once(SMARTY_DIR . \'Smarty.class.php\');

	$smarty = new Smarty();

	$smarty-\>template_dir = \'C:/xampp/htdocs/smarty/templates\';
	$smarty-\>compile_dir  = \'C:/xampp/htdocs/smarty/templates_c\';
	$smarty-\>config_dir   = \'C:/xampp/htdocs/smarty/configs/\';
	$smarty-\>cache_dir    = \'C:/xampp/htdocs/smarty/cache/\';

\n\n"; 


// file checking
	loc l = |file://C:/xampp/htdocs/PHPRefactoring/src/assignments.php|; 
	Script scr=loadPHPFile(l);
	str tempName="showTemplate";
	Expr display = propertyFetch(var(name(name("smarty"))),name(name("display(\'<tempName>.tpl\');\n\r")));
	writeFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, "{* Smarty *} \r\n");
	writeFile(|file://C:/xampp/htdocs/PHPRefactoring/src/<tempName>.php|, initialText);
	formOfStmt(scr.body,mole,moles,holes,i,dynamicMole,tempName);
	appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/<tempName>.php|, pp(display)); 
	appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/<tempName>.php|, "\n?\>");
	text(scr);

	
/*System checking
	loc l2= |file://C:/Users/Jim9/Desktop/SchoolMate_v1.5.4/schoolmate|;
	loc id=|file:///|;
	System sys=loadPHPFiles(l2);
	set[loc] setFiles=domain(sys);
	list[loc] filesLoc=toList(setFiles);
	//list[str] files=[];
	//for(x<-[0..size(filesLoc)]){
		//id=filesLoc[x];
		//files += ((id.extension == "php") ? id.file : []);
		//files[x]=replaceLast(files[x], ".php", "");
		
	//}
	map[int,str] names=();
	//println(size(files));
	//println(files);		
	
	for(int j <-[0..size(filesLoc)]){
		//names[j]=files[j];
		names[j]="temp<j>";
		//text(sys[filesLoc[j]].body);
		//break;
		Expr display = propertyFetch(var(name(name("smarty"))),name(name("display(\'<names[j]>.tpl\');\n\r")));
		writeFile(|file://C:/xampp/htdocs/smarty/templates/<names[j]>.tpl|, "{* Smarty *} \r\n");
		writeFile(|file://C:/xampp/htdocs/PHPRefactoring/src/<names[j]>.php|, initialText);	
		formOfStmt(sys[filesLoc[j]].body,mole,moles,holes,i,dynamicMole,names[j]);
		appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/<names[j]>.php|, pp(display)); 
		appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/<names[j]>.php|, "\n?\>");
	}
*/	
	println("finished");	
}

private void formOfStmt(list[Stmt] body, map[int,str] mole, map[str,str] moles, list[str] holes,int i,map[int,str] dynamicMole,str tempName) {
	bool printOrEcho=false;
	for (part<-body){
		println(tempName);
	//println(part);
		switch(part) {					
			
			case exprstmt(assign(X,Y)) : {
				//println(moles);
				if (fetchArrayDim(var(name(name("_GET"))),_) := Y || fetchArrayDim(var(name(name("_POST"))),_) := Y){
					appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/<tempName>.php|, pp(assign(X,Y)) + ";");
					dynamicMole[i+1]= "val<i+1>|escape:\'htmlall\'";
					moles[pp(X)]=dynamicMole[i+1];
					holes=holes+"val<i+1>";
					assignment = propertyFetch(var(name(name("smarty"))),name(name("assign(\'<holes[i]>\',<pp(X)>);\n\r")));
					appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/<tempName>.php|, "<pp(assignment)>\n");
					i+=1;
				} 
				else{				
					appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/<tempName>.php|, pp(assign(X,Y)) + ";");
					mole[i+1]= "val<i+1>";
					moles[pp(X)]=mole[i+1];
					holes=holes+"val<i+1>";
					assignment = propertyFetch(var(name(name("smarty"))),name(name("assign(\'<holes[i]>\',<pp(X)>);\n\r")));
					appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/<tempName>.php|, "<pp(assignment)>\n");
					i+=1;			
				}
			}
			
			case exprstmt(assignWOp(X,Y,op)) : {
				if (fetchArrayDim(var(name(name("_GET"))),_) := Y || fetchArrayDim(var(name(name("_POST"))),_) := Y){
					appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/<tempName>.php|, pp(assignWOp(X,Y,op)) + ";");
					dynamicMole[i+1]= "val<i+1>|escape:\'htmlall\'";
					moles[pp(X)]=dynamicMole[i+1];
					holes=holes+"val<i+1>";
					assignment = propertyFetch(var(name(name("smarty"))),name(name("assign(\'<holes[i]>\',<pp(X)>);\n\r")));
					appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/<tempName>.php|, "<pp(assignment)>\n");
					i+=1;
					}
				else{		
					appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/<tempName>.php|, pp(assignWOp(X,Y,op)) + ";");
					mole[i+1]= "val<i+1>";
					moles[pp(X)]=mole[i+1];
					holes=holes+"val<i+1>";
					assignment = propertyFetch(var(name(name("smarty"))),name(name("assign(\'<holes[i]>\',<pp(X)>);\n\r")));
					appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/<tempName>.php|, "<pp(assignment)>\n");
					i+=1;
				}
			}
			
			case exprstmt(refAssign(X,Y)) : {
				if (fetchArrayDim(var(name(name("_GET"))),_) := Y || fetchArrayDim(var(name(name("_POST"))),_) := Y){
					appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/<tempName>.php|, pp(assign(X,Y)) + ";");
					dynamicMole[i+1]= "val<i+1>|escape:\'htmlall\'";
					moles[pp(X)]=dynamicMole[i+1];
					holes=holes+"val<i+1>";
					assignment = propertyFetch(var(name(name("smarty"))),name(name("assignByRef(\'<holes[i]>\',<pp(X)>);\n\r")));
					appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/<tempName>.php|, "<pp(assignment)>\n");
					i+=1;
					}
				else{		
					appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/<tempName>.php|, pp(assign(X,Y)) + ";");
					mole[i+1]= "val<i+1>";
					moles[pp(X)]=mole[i+1];
					holes=holes+"val<i+1>";
					assignment = propertyFetch(var(name(name("smarty"))),name(name("assignByRef(\'<holes[i]>\',<pp(X)>);\n\r")));
					appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/<tempName>.php|, "<pp(assignment)>\n");
					i+=1;
				}
		}
				
			case \while(cond,body1) : {
				map[str,str] tempMoles=moles;
				for (part1<-body1){
					printOrEcho=isPrintOrEcho(part1);
				}
				if(printOrEcho){
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, "{while ");
					evaluateNonLiteral2(cond,moles,tempName);
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, "}");
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
					formOfStmt(body1,mole,tempMoles,holes,i,dynamicMole,tempName);
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, "{/while}");
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
						//appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/tempName|, "<pp(assignment)>\n");
						i+=1;
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, 
						"{foreach from=$<moles[pp(arrayExpr)]> item=<moles[pp(asVar)]>}");
						formOfStmt(body1,mole,moles,holes,i,dynamicMole,tempName);
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, "{/foreach}");
					}
					
					elseif (pp(arrayExpr) in moles && someExpr(var(name(name(key)))) := keyvar && var(name(name(variable))) := asVar){
						mole[i+1]= "val<i+1>";
						moles[pp(asVar)]=mole[i+1];
						holes=holes+"val<i+1>";
						assignment = propertyFetch(var(name(name("smarty"))),name(name("assign(\'<holes[i]>\',<pp(asVar)>);\n\r")));
						//appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/tempName|, "<pp(assignment)>\n");
						i+=1;
						println(i);
						mole[i+1]= "val<i+1>";
						moles[pp(keyvar)]=mole[i+1];
						holes=holes+"val<i+1>";	
						assignment = propertyFetch(var(name(name("smarty"))),name(name("assign(\'<holes[i]>\',<pp(keyvar)>);\n\r")));
						//appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/tempName|, "<pp(assignment)>\n");
						i+=1;
						println(i);
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, 
						"{foreach from=$<moles[pp(arrayExpr)]> key=<moles[pp(keyvar)]> item=<moles[pp(asVar)]>}"); 
						formOfStmt(body1,mole,moles,holes,i,dynamicMole,tempName);
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, "{/foreach}");
					}
				}
			}
			
			//case function(name, byRef, params, body1) : {
				//	formOfStmt(body1,mole,moles,holes,i,dynamicMole,tempName);
			//}	
			
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
									formOfStmt(body1,mole,moles,holes,i,dynamicMole,tempName);
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
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, "{if ");
					evaluateExpression(cond,moles,tempName);
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, " }");
					formOfStmt(body1,mole,moles,holes,i,dynamicMole,tempName);
					for(elseif <- elseIfs){
						if (elseIf(cond2,body2):= elseif){
							appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, "{elseif ");
								evaluateExpression(cond2,moles,tempName);
								appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, " }");
								formOfStmt(body2,mole,moles,holes,i,dynamicMole,tempName);
						}
					}
					if ( someElse(\else(body3)) := elseClause){
						appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, "{else} ");
						formOfStmt(body3,mole,moles,holes,i,dynamicMole,tempName);
					}			
					appendToFile(|file://C:/xampp/htdocs/smarty/templates/<tempName>.tpl|, "{/if}");
				}
			}
				
			case echo(X) :{	
				for (echoExpression <- X){
					printedText=evaluateExpression(echoExpression,moles,tempName);
				}
			}
		
			case exprstmt(Expr::print(printExpression)) : {
				printedText=evaluateExpression(printExpression,moles,tempName);						
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
			/*for (part1<-body1){
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
			return printOrEcho=false;*/
			return printOrEcho;
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

//todo functioncall