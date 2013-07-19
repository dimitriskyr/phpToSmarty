module mine::ControlFlow

import lang::php::util::Utils;
import lang::php::ast::AbstractSyntax;
import util::ValueUI;
import IO;
import Map;
import Set;
import List;
import util::ValueUI;
import lang::php::analysis::NamePaths;
import lang::php::analysis::cfg::CFG;
import lang::php::analysis::cfg::Label;
import lang::php::analysis::cfg::FlowEdge;
import lang::php::analysis::cfg::BuildCFG;
import lang::php::pp::PrettyPrinter;
import analysis::graphs::Graph;


alias System = map[loc fileloc, Script scr];

public void controlFlow(){

	loc l = |file://C:/xampp/htdocs/PHPRefactoring/src/ifStatement.php|; 
	Script scr=loadPHPFile(l);
	Graph[CFGNode] gr;
	<lscr, cfgs> = buildCFGsAndScript(scr);
	
	for (np <- cfgs) {
		gr = cfgAsGraph(cfgs[np]);
		text(gr);
	}
	
	
	list[Stmt] stmts=[];
	list[int] labs=[];
	map [int,Stmt] mapNodes = ();
	int i=0;
	
	
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
		
		if(<stmtNode(stmt1,lab(lstmt1)),_> := nodes){
			//println("EXPRESSION <expr1>");
			//println("EXPRESSION <expr2>");
			//println(i);
			i+=1;
			println("<i> stmtnode");
			stmts=stmts+stmt1;
			labs=labs+lstmt1;
			mapNodes= mapNodes + (lstmt1:stmt1);		
		}
		
		/*else if(<stmtNode(stmt1,lab(lstmt1)),scriptExit()> := nodes){
			//println("EXPRESSION <expr1>");
			//println("EXPRESSION <expr2>");
			//println(i);
			i+=1;
			println("<i> stmtnode");
			stmts=stmts+stmt1;
			labs=labs+lstmt1;
			mapNodes= mapNodes + (lstmt1:stmt1);		
		}*/
		
	}
	
	list[int] sortedLabs = sort (labs);	
	list[Stmt] listed = [];
	for (q <- [0..size(labs - 1)])
		listed= listed + mapNodes[sortedLabs[q]];
	text(labs);
	text(sortedLabs);
	text(listed);
}