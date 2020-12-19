Class fkh2020.Day19 Extends fkh2020.Base
{

ClassMethod expandToRe2(ByRef rules, num)
{
   
    If num=8 {
        Return ..expandToRe2(.rules,42)_"+"
    }
    If num=11{
        Set left=..expandToRe2(.rules,42)
        Set right=..expandToRe2(.rules,31)
        Set erg="(?:"
        For i=1:1:12{
            Set erg=erg_left_"{"_i_"}"
            Set erg=erg_right_"{"_i_"}"
            Set:i<12 erg=erg_"|"
        }
        Set erg=erg_")" 
        Return erg
    }
    
    Set r=$G(rules(num))
    #; Write "expand:",num," r:",r,!
    
    If (r["a")||(r["b") {
        Return r
    }    
    If r["|" {
        Set erg="(?:"
        Set left=$P(r," | ",1)
        Set right=$P(r," | ",2)
        Set num=$LOCATE(left,"\d+",1,e,value)
        While num {
            Set erg=erg_..expandToRe2(.rules,value)
            Set num=$LOCATE(left,"\d+",e,e,value)
        }
        Set erg=erg_"|"
        Set num=$LOCATE(right,"\d+",1,e,value)
        While num {
            Set erg=erg_..expandToRe2(.rules,value)
            Set num=$LOCATE(right,"\d+",e,e,value)
        }
        Set erg=erg_")"
        Return erg
    } Else {
        Set erg="(?:"
        Set num=$LOCATE(r,"\d+",1,e,value)
        While num {
            Set erg=erg_..expandToRe2(.rules,value)
            Set num=$LOCATE(r,"\d+",e,e,value)
        }
        Set erg=erg_")"
        Return erg        
    }
}

ClassMethod expandToRe(ByRef rules, num)
{
    
    Set r=$G(rules(num))
    #; Write "expand:",num," r:",r,!
    
    If (r["a")||(r["b") {
        Return r
    }    
    If r["|" {
        Set erg="(?:"
        Set left=$P(r," | ",1)
        Set right=$P(r," | ",2)
        Set num=$LOCATE(left,"\d+",1,e,value)
        While num {
            Set erg=erg_..expandToRe(.rules,value)
            Set num=$LOCATE(left,"\d+",e,e,value)
        }
        Set erg=erg_"|"
        Set num=$LOCATE(right,"\d+",1,e,value)
        While num {
            Set erg=erg_..expandToRe(.rules,value)
            Set num=$LOCATE(right,"\d+",e,e,value)
        }
        Set erg=erg_")"
        Return erg
    } Else {
        Set erg="(?:"
        Set num=$LOCATE(r,"\d+",1,e,value)
        While num {
            Set erg=erg_..expandToRe(.rules,value)
            Set num=$LOCATE(r,"\d+",e,e,value)
        }
        Set erg=erg_")"
        Return erg        
    }
}

/**
might need to bump framestack on your system:
d $SYSTEM.Util.SetFrameStackSize(500000)
and start a new shell after that
*/
ClassMethod part1()
{
    Set data = ##class(Utils.Base).load(2020,19)
    Set erg=0 
	Set iterator=data.%GetIterator()
    Set part=0    
    Set messages=-1
   	While iterator.%GetNext(.key,.val) { 
           If $L(val)<1{
               Set part=1
               Continue
           }
           If part=0 {
               Set rn=$P(val,":",1)
               Set rules(rn)=$REPLACE($P(val,": ",2),"""", "")
           }
           If part=1{
               Set messages($I(messages))=val
           }
            
       }
        
    Set retext=..expandToRe(.rules,0)
    Set pl("rule")=retext
    Do ##class(Utils.Base).foreach(.messages,"fkh2020.Day19","matchings",.pl)
    Set erg=$G(pl("count"))
    Return erg
}

ClassMethod matchings(k, v, ByRef payload)
{
    If $MATCH(v,$G(payload("rule"))){
        Set payload("count")=$G(payload("count"),0)+1
    }
}

ClassMethod part2()
{
    Set data = ##class(Utils.Base).load(2020,19)
    Set erg=0 
	Set iterator=data.%GetIterator()
    Set part=0    
    Set messages=-1
   	While iterator.%GetNext(.key,.val) { 
           If $L(val)<1{
               Set part=1
               Continue
           }
           If part=0 {
               Set rn=$P(val,":",1)
               Set rules(rn)=$REPLACE($P(val,": ",2),"""", "")
           }
           If part=1{
               Set messages($I(messages))=val
           }
            
       }           
    Set retext=..expandToRe2(.rules,0)
    Set pl("rule")=retext
    Do ##class(Utils.Base).foreach(.messages,"fkh2020.Day19","matchings",.pl)
    Set erg=$G(pl("count"))
    Return erg
}

}
