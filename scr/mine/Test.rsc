module mine::Test

import List;
import Exception;
import lang::php::util::Utils;
import lang::php::ast::AbstractSyntax;
import util::ValueUI;
import lang::php::pp::PrettyPrinter;
import lang::php::analysis::evaluators::Concatenation;
import lang::php::analysis::evaluators::Concatenation2;

import IO;

public void showText(int x){
	
	str printedText="";
	loc l = |file://C:/xampp/htdocs/PHPRefactoring/src/arrays.php|; 
	Script scr=loadPHPFile(l);
	//tree(scr);	
	Expr display = propertyFetch(var(name(name("smarty"))),name(name("display(\'hello.tpl\')")));
	Expr assignment;// propertyFetch(var(name(name("smarty"))),name(name("assign(\'<X>\',\'<Y>\')")));
	str initialText = "\<?php \r\ndefine(\'SMARTY_DIR\', \'C:/Smarty/libs/Smarty-3.1.13/libs/\');

	require_once(SMARTY_DIR . \'Smarty.class.php\');

	$smarty = new Smarty();

	$smarty-\>template_dir = \'C:/xampp/htdocs/smarty/templates\';
	$smarty-\>compile_dir  = \'C:/xampp/htdocs/smarty/templates_c\';
	$smarty-\>config_dir   = \'C:/xampp/htdocs/smarty/configs/\';
	$smarty-\>cache_dir    = \'C:/xampp/htdocs/smarty/cache/\';

	\n\r";	
	
	if (x==1){
		text(scr);
		text([c | /c:echo(_):= scr]); 
		text([p | /p:exprstmt(_):= scr]);
		text([p | /p:Expr::print(_):= scr]); 
		text([p | /p:concat(_):= scr]);
	}
	
// case 1: Reading a single/multi print or echo command from a php file
	else if (x==2){
		writeFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, "{* Smarty *} \r\n");	
		scr= visit(scr){
			case Expr::print(scalar(string(X))) : {
				printedText=X;
				appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, printedText );
			}	
			case echo([scalar(string(X))]) : {
				printedText=X;
				appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, printedText );
			}	
		}; 	
	writeFile(|file://C:/xampp/htdocs/PHPRefactoring/src/hello.php|, initialText);	
	appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/hello.php|, pp(display));
	appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/hello.php|, "\r\n?\>");	
	}
//case 2: Variable assignments and effort to print concatenations	
	else if(x==3){
		writeFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, "{* Smarty *} \r\n");	
		writeFile(|file://C:/xampp/htdocs/PHPRefactoring/src/hello.php|, initialText);	
		scr= visit(scr) {
			case Expr::print(scalar(string(X))) : {
				printedText=X;
				appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, printedText );
			}
			case binaryOperation(scalar(string(X)),var(name(name(Z))),concat()) : {
				printedText=X+"{$<Z>}";
				println(printedText);
				appendToFile(|file://C:/xampp/htdocs/smarty/templates/hello.tpl|, printedText );
			}	
			case assign (var(name(name(X))),scalar(string(Y))) : {
				assignment = propertyFetch(var(name(name("smarty"))),name(name("assign(\'<X>\',\'<(Y)>\')")));
				appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/hello.php|, pp(assignment));	
			}
			};
	appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/hello.php|, pp(display));
	appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/hello.php|, "\r\n?\>");		
	}
	
	else if(x==4){
		writeFile(|file://C:/xampp/htdocs/PHPRefactoring/src/hello.php|, initialText);
		printedText = concatenations(scr);
		appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/hello.php|, printedText);
		/*scr=visit(scr){
		case concat(): {
			printedText = concatenations(scr);
			//concatenations(scr);
			//appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/hello.php|, "hey");
			appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/hello.php|, printedText);	 
			}
		}*/
	}
	
	else if (x==5){
		writeFile(|file://C:/xampp/htdocs/PHPRefactoring/src/hello.php|, initialText);
		text(scr);
		Expr point;
		str newItems = "";
		scr= visit(scr) {
			case assign(var(name(name(X))),array(list[ArrayElement] items)):{
	    		for (point <- items)
					newItems += (pp(point)+","); 
				arrayAssignment = propertyFetch(var(name(name("smarty"))),name(name("assign(\'<X>\',array(<newItems>));")));
				appendToFile(|file://C:/xampp/htdocs/PHPRefactoring/src/hello.php|, pp(arrayAssignment));
			}
		}
	}
	text(scr);
	//print(pp(scr)); 
}