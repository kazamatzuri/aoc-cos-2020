Class fkh2020.Day7 Extends fkh2020.Base
{

ClassMethod part1()
{
    Set data = ##class(Utils.Base).load(2020,7)
    Set erg=0 
	Set iterator=data.%GetIterator()
    Set rules={}

   	While iterator.%GetNext(.key,.val) { 
            If val'["no other bags"{
                Set outer=$ZSTRIP($PIECE(val," bags contain ",1),"<>W")
                Set contains=$ZSTRIP($PIECE(val," bags contain ",2),"<>W")

                For i=1:1:$LENGTH(contains,","){
                    Set item=$PIECE(contains,",",i)
                    Set item=$ZSTRIP(item,"<>W")
                    Set num=$EXTRACT(item,1)
                    Set color=$PIECE(item," ",2,3)

                    Set reverse(color)=$GET(reverse(color),"")_$LISTBUILD(outer)
                }
            
            }
        } 
    #; ZWrite reverse
    Kill found
    Set found=0
    Do ..findpath("shiny gold",.found,.reverse)
    Return found
    Return erg
}

ClassMethod findpath(color, ByRef found, ByRef reverse)
{
    For i=1:1:$LISTLENGTH($GET(reverse(color),"")) {
        Set c=$LISTGET(reverse(color),i)
        If $DATA(found(c))'=1{
            Do $INCREMENT(found)
        }
        Set found(c)=""
        
        Do ..findpath(c,.found,.reverse)
    }
}

ClassMethod part2()
{
    Set data = ##class(Utils.Base).load(2020,7)
    Set erg=0 
	Set iterator=data.%GetIterator()
    Set rules={}

   	While iterator.%GetNext(.key,.val) { 
            If val'["no other bags"{
                Set outer=$ZSTRIP($PIECE(val," bags contain ",1),"<>W")
                Set contains=$ZSTRIP($PIECE(val," bags contain ",2),"<>W")
                #; Write outer,!
                #; Write contains,!
                Set innerlist=[]
                For i=1:1:$LENGTH(contains,","){
                    Set item=$PIECE(contains,",",i)
                    Set item=$ZSTRIP(item,"<>W")
                    Set num=$EXTRACT(item,1)
                    Set color=$PIECE(item," ",2,3)
                    #; Write outer, " contains ", num," ",color,!
                    Set inneritem={}
                    Set inneritem.color=color
                    Set inneritem.num=num
                    Do innerlist.%Push(inneritem)
                    Set reverse(color)=$GET(reverse(color),"")_$LISTBUILD(outer)
                }
                Do rules.%Set(outer,innerlist)            
            }
        } 
    #; Write rules.%Get("shiny gold")
    Return ..findcost("shiny gold",.rules)
}

ClassMethod findcost(color, ByRef rules)
{
    Set sum=0
    Set items=rules.%Get(color)
    ZWrite items
    If items'=""{        
        Set it=items.%GetIterator()
        While it.%GetNext(.key,.val){
            Write val.num,!
            Set sum=sum+val.num
            Set sum=sum+(val.num*..findcost(val.color,.rules))
        }
    }
    Return sum
}

}
