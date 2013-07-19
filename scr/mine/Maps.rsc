module mine::Maps

import Map;
import IO;


public void mapping(){
	map [str,str] holes = () ;
	//println (holes["poutsa"] +" "+ holes["poustara"]);
	holes ["val1"] = "pswla";
	println (holes["val1"]);
	
	if("poutsa" in holes)
	println (holes["poutsa"]);
	
	holes ["val2"] = "mounitsa";
	println (holes);
}