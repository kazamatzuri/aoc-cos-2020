Class fkh2020.Day2 Extends fkh2020.Base
{

ClassMethod part1()
{
    Set data = ##class(Utils.Base).load(2020,2)
    Set erg=0 
	Set iterator=data.%GetIterator()
   	While iterator.%GetNext(.key,.val) { 
		  Set min=$PIECE(val,"-",1)
          Set max=$PIECE($PIECE(val,"-",2)," ",1)
          Set c=$REPLACE($PIECE(val," ",2),":","")
          Set p=$PIECE(val," ",3)          
          Set ct=$LISTLENGTH($LISTFROMSTRING(p,c))-1
          If ((ct>=min) && (ct<=max)) {
              Set erg=erg+1
          }
       }
    Return erg
}

ClassMethod part2()
{
    Set data = ##class(Utils.Base).load(2020,2)
    Set erg=0 
	Set iterator=data.%GetIterator()
   	While iterator.%GetNext(.key,.val) { 
		  Set min=$PIECE(val,"-",1)
          Set max=$PIECE($PIECE(val,"-",2)," ",1)
          Set c=$REPLACE($PIECE(val," ",2),":","")
          Set p=$PIECE(val," ",3) 
          
          If ((($EXTRACT(p,min)=c) && ($EXTRACT(p,max)'=c))||(($EXTRACT(p,min)'=c) && ($EXTRACT(p,max)=c))) {
              Write c," ",$EXTRACT(p,min)," ",$EXTRACT(p,max),!
              Set erg=erg+1
          }
       }
    Return erg
}

}
