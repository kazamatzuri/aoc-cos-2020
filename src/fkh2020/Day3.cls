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
               Set map(i,y)=c                              
           }
           Set y=y+1
       }
    Set px=4
    For y=2:1:324 {
        Set c=$GET(map(((px-1)#31)+1,y),"")
        Write c,!
        If c="#" {
            Set erg=erg+1
        }
        Set px=px+3
    }
    Return erg
}

ClassMethod ctree(r, d, ByRef map)
{
    Set erg=0    
    Set px=r+1
    For y=(1+d):d:324 {
        Set c=$GET(map(((px-1)#31)+1,y),"")
        Write c,!
        If c="#" {
            Set erg=erg+1
        }
        Set px=px+r
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
               Set map(i,y)=c                              
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
