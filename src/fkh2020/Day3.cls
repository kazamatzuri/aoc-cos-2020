Class fkh2020.Day3 Extends fkh2020.Base
{

ClassMethod part1()
{
    Set data = ##class(Utils.Base).load(2020,3)
    Set erg=0 
	Set iterator=data.%GetIterator()
    Set y=1
    Set px=1
   	While iterator.%GetNext(.key,.val) { 
           Set l=$LENGTH(val)
           For i=1:1:l {
               Set c=$EXTRACT(val,i)
               Set map(y,i)=c                              
           }
           Set y=y+1
       }
    Set e1= ..ctree(3,1,.map)
    Write e1,!
    Return e1
}

ClassMethod ctree(r, d, ByRef map)
{
    Set erg=0        
    Set y=1,x=1
    While ((y+d)<=$ORDER(map(""),-1)){
        Set x=x+r
        Set y=y+d
        If $GET(map(y,((x-1)#31)+1),"")="#"{
            Set erg=erg+1
        }
    }
    Return erg
}

ClassMethod part2()
{
    Set data = ##class(Utils.Base).load(2020,3)
    Set erg=0 
	Set iterator=data.%GetIterator()
    Set y=1
    Set px=1
   	While iterator.%GetNext(.key,.val) { 
           Set l=$LENGTH(val)
           For i=1:1:l {
               Set c=$EXTRACT(val,i)
               Set map(y,i)=c                              
           }
           Set y=y+1
       }
    Set e1= ..ctree(1,1,.map)
    Set e2= ..ctree(3,1,.map)
    Set e3= ..ctree(5,1,.map)
    Set e4= ..ctree(7,1,.map)
    Set e5= ..ctree(1,2,.map)
    Write e1,!,e2,!,e3,!,e4,!,e5,!
    Return e1*e2*e3*e4*e5
}

}
