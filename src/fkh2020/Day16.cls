Class fkh2020.Day16 Extends fkh2020.Base
{

ClassMethod part1()
{
    Set scanning=1
    Set data = ##class(Utils.Base).load(2020,16)
    Set erg=0 
	Set iterator=data.%GetIterator()
   	While iterator.%GetNext(.key,.val) {
           If $L(val)> 0 { 
            If scanning=1 {
                Set name=$P(val,":",1)
                Set lowerstr=$ZSTRIP($P(val," ",2),"<>W")
                Set higherstr=$ZSTRIP($P(val," ",4),"<>W")
                Set rules(name)=$LB($LB($P(lowerstr,"-",1),$P(lowerstr,"-",2)),$LB($P(higherstr,"-",1),$P(higherstr,"-",2)))            
            } ElseIf scanning=2{
               If val'[":" {
                   Set your=val
               }
            } ElseIf scanning=3{
               If val'[":" {
                   Set nearby($I(nearby))=val
               }           
            } 
           } Else {
               Set scanning=scanning+1
           }

       }
    Set erg=..errorRate(.nearby,.rules)
    Return erg
}

ClassMethod checkRule(rule, num)
{
     #; Write "checking ",num," against",!
                #; ZWrite rule
    Set r1=$LG(rule,1)
    Set l1=$LG(r1,1)
    Set h1=$LG(r1,2)
    Set r2=$LG(rule,2)
    Set l2=$LG(r2,1)
    Set h2=$LG(r2,2)   
    If (((num>=l1) && (num<=h1))||((num>=l2)&&(num<=h2))){
        #; Write "valid",!
        Return 1                                  
    }
    Return ""
}

ClassMethod failsAny(ByRef rules, ticket)
{
        Set valid=0
        #; Write v,!
        For i=1:1:$L(ticket,",") {            
            Set num=$P(ticket,",",i)   
            #; Write "num:",num,!         
            Set r=$O(rules(""),1,rule)
            Set fits=0
            While r'="" {
                Set fits=..checkRule(rule,num)
                Set r=$O(rules(r),1,rule)
                If (fits){
                    Set valid=1
                    Quit                    
                }                
            }
            If 'fits{
                #; Write "invalid num ",num,!
                Set invalidnum=num
                Set valid=0
                Quit
            }  
        }   
        If 'valid {
            Return invalidnum
        } 
        Return ""
}

ClassMethod errorRate(ByRef nearby, ByRef rules)
{
    Set invalidsum=0
    Set n=$O(nearby(""),1,v)
    While n'=""{   
        Set fails=..failsAny(.rules,v)
        If fails'="" {
            Kill nearby(n)
            Set invalidsum=invalidsum+fails
        } 
        Set n=$O(nearby(n),1,v)
    }
    Return invalidsum
}

ClassMethod part2()
{
    Set scanning=1
    Set data = ##class(Utils.Base).load(2020,16)
    Set erg=0 
	Set iterator=data.%GetIterator()
   	While iterator.%GetNext(.key,.val) {
           If $L(val)> 0 { 
            If scanning=1 {
                Set name=$P(val,":",1)
                Set rest=$P(val,":",2)
                Set lowerstr=$ZSTRIP($P(rest," ",2),"<>W")
                Set higherstr=$ZSTRIP($P(rest," ",4),"<>W")
                Set rules(name)=$LB($LB($P(lowerstr,"-",1),$P(lowerstr,"-",2)),$LB($P(higherstr,"-",1),$P(higherstr,"-",2)))            
            } ElseIf scanning=2{
               If val'[":" {
                   Set your=val
               }
            } ElseIf scanning=3{
               If val'[":" {
                   Set nearby($I(nearby))=val
               }           
            } 
           } Else {
               Set scanning=scanning+1
           }
       }
    Set erg=..errorRate(.nearby,.rules)
    Set numfields=$L(your,",")
    For i=1:1:numfields {
        Merge possible(i)=rules
    }
    
    For i=1:1:numfields {
        Set n=$O(nearby(""),1,v)
        While n'=""{   
            Set num=$P(v,",",i)
            Set r=$O(possible(i,""),1,rule)
            Set fits=0
            While r'="" {
                Set fits=..checkRule(rule,num)                                
                If ('fits){
                    #; Write "removing ",r," from ",i,!
                    #; ZWrite rule
                    Kill possible(i,r)
                    Quit                    
                }     
                Set r=$O(possible(i,r),1,rule)                
            }
            Set n=$O(nearby(n),1,v)
        }
    }
    
    
    For x=1:1:numfields{
        Set r=$O(rules(""))
        While r'="" {    
            Set found=0
            For i=1:1:numfields {
                If $D(possible(i,r)){
                    Set found=found+1
                    Set foundin=i
                }
            }
            If found=1{
                Write "narrowing down ",r," to ",foundin,!
                For t=1:1:numfields {
                    If t'=foundin{
                        Kill possible(t,r)
                    } 
                }
                Kill possible(foundin)
                Set result(r)=foundin
            }
            Set r=$O(rules(r))
        }
        }
    #; ZWrite result
    Set l=$O(result(""),1,v)
    Set erg=1
    While l'=""{
        Write l,!
        If l["departure"{
            Set erg=erg*$P(your,",",v)
        }
        Set l=$O(result(l),1,v)
    }
    Return erg
}

}
