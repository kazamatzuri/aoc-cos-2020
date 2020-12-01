/// library to help with graph problems
Class Utils.Graph Extends %RegisteredObject
{

Property nodes [ MultiDimensional ];

Property nodecount As %Integer [ InitialExpression = 0 ];

Property edges [ MultiDimensional ];

Property cache [ MultiDimensional ];

// add a node index 

Method addNode(x)
{
	If '$DATA(..nodes(x)){
		Set ..nodes(x)=""
		Set ..nodecount=..nodecount+1
	}
}

// add an edge between two nodes

Method addEdge(x, y, cost As %Integer = 1)
{
	Do ..addNode(x)
	Do ..addNode(y)
	Set ..edges(x,y)=cost
}

/// accepts a $LB list of nodes to which it will
/// precompute the shortest path
Method preCompute(nodes As %String)
{
	For n1=1:1:$LISTLENGTH(nodes){
		For n2=n1:1:$LISTLENGTH(nodes){
			Set path=..shortestPath($LISTGET(nodes,n1),$LISTGET(nodes,n2))
			Set ..cache(n1,n2)=path
			Set ..cache(n2,n1)=path
		}
	}
}

// returns the number of connected components in the graph

Method connectedComponents()
{
	Set count=0
	Set t=$ORDER(..nodes(""))
	While t'="" {
		If '$DATA(visited(t)) {
			Set count=count+1
			Set visited(t)=""
			Do ..visit(t,.visited)
		}
		Set t=$ORDER(..nodes(t))
	}
	Return count
}

// internal

Method visit(t, ByRef visited)
{
	
	Set n=$ORDER(..edges(t,"")) 
	While n'="" {
		If '$DATA(visited(n)) {
			Set visited(n)=""
			Do ..visit(n,.visited)
		}
		Set n=$ORDER(..edges(t,n))
	}
}

Method shortestPath(x, y)
{
	
	If $DATA(..cache(x,y)){
		Return ..cache(x,y)
	}
	Set path(0,x)=$LISTBUILD(x)
	Set c=$ORDER(path(""))	
	While c'="" {
		Set loc=$ORDER(path(c,""))
		Set pathtaken=$GET(path(c,loc))	
		If loc=y{
			Return pathtaken
		}
		Kill path(c,loc)
		Set n=$ORDER(..edges(loc,""))
		
		While n'="" {
			If '$DATA(visited(n)){
				Set length=$LISTLENGTH(pathtaken)+1
				Set path(length,n)=pathtaken_$LISTBUILD(n)
				Set visited(n)=""
			}
			Set n=$ORDER(..edges(loc,n))
		}
		Set c=$ORDER(path(""))
	}
	
	Return ""
}

}
