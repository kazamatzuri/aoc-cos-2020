Class fkh2020.Day1 Extends fkh2020.Base
{

ClassMethod part1()
{
    Set data = ##class(Utils.Base).load(2020,1)
    Set erg=0 
	Set iterator=data.%GetIterator()
   	While iterator.%GetNext(.key,.val) { 
		   Set it2=data.%GetIterator()            
               While it2.%GetNext(.k2,.v2){
                   If (val+v2=2020)  {
                    #;    Write val," ",v2," = ",val*v2,!
                       Return val*v2
                   }
               }
           }
    Return erg
}

ClassMethod part2()
{
    Set data = ##class(Utils.Base).load(2020,1)
    Set erg=0 
	Set iterator=data.%GetIterator()
   	While iterator.%GetNext(.key,.val) { 
		   Set it2=data.%GetIterator()            
               While it2.%GetNext(.k2,.v2){
                   Set it3=data.%GetIterator()            
                            While it3.%GetNext(.k3,.v3){                                
                                If (val+v2+v3=2020)  {
                                    #; Write val," ",v2," ",v3," = ",val*v2*v3,!
                                   Return val*v2*v3
                                }
                            }
                        }
               }
    Return erg
}

}
