Class fkh2020.Day12 Extends fkh2020.Base
{

ClassMethod part1()
{

    Set data = ##class(Utils.Base).load(2020,12)
    Set erg=0 
	Set iterator=data.%GetIterator()
    Set start=$LB(0,0)
    Set x=0,y=0
    Set heading=0
   	While iterator.%GetNext(.key,.val) { 
        Set d=$E(val,1)
        Set dist=$E(val,2,$L(val))
        If d="F" {
            If heading=0{
                Set x=x+dist
            }
            If heading=1 {
                Set y=y+dist
            }
            If heading=2 {
                Set x=x-dist
            } 
            If heading=3{
                Set y=y-dist 
            }
        }
        If d="N"{
            Set y=y-dist
        }
        If d="S" {
            Set y=y+dist
        }
        If d="E" {
            Set x=x+dist
        }
        If d="W" {
            Set x=x-dist
        }
        If d="L" {
            Set dist=dist/90
            Set heading=(heading-dist)#4
        }
        If d="R" {
            Set dist=dist/90
            Set heading=(heading+dist)#4
        }
        #; Write val,"  x:",x,"  y:",y,!
       }
    
    Set erg=##class(Utils.Base).manhattandist(start,$LB(x,y))
    
    Return erg
}

ClassMethod part2()
{
     Set data = ##class(Utils.Base).load(2020,12)
    Set erg=0 
	Set iterator=data.%GetIterator()
    Set start=$LB(0,0)
    Set x=0,y=0
    Set wx=10,wy=-1    
   	While iterator.%GetNext(.key,.val) { 
        Set d=$E(val,1)
        Set dist=$E(val,2,$L(val))
        If d="F" {
            Set x=x+(wx*dist)
            Set y=y+(wy*dist)            
        }
        If d="N"{
            Set wy=wy-dist
        }
        If d="S" {
            Set wy=wy+dist
        }
        If d="E" {
            Set wx=wx+dist
        }
        If d="W" {
            Set wx=wx-dist
        }
        If d="L" {
            Set dist=dist/90
            For i=1:1:dist{
                Write "l ",!
                Set t=wx
                Set wx=wy
                Set wy=-t                
            }
        }
        If d="R" {            
            Set dist=dist/90
            For i=1:1:dist{
                Set t=wx
                Set wx=-wy
                Set wy=t     
            }
        }
        Write val,"  x:",x,"  y:",y," wx:",wx," wy:",wy,!
       }
    
    Set erg=##class(Utils.Base).manhattandist(start,$LB(x,y))    
    Return erg
}

}
