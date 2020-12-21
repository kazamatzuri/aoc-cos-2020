Class fkh2020.Day21 Extends fkh2020.Base
{

ClassMethod part1()
{
    Set data = ##class(Utils.Base).load(2020,21)
    Set erg=0 
	Set iterator=data.%GetIterator()
   	While iterator.%GetNext(.key,.val) { 
            Set foodstring=$P(val," (",1)
            Set allergenstring=$REPLACE($REPLACE($P(val," (",2),")",""),",","")
            Set allergenstring=$REPLACE(allergenstring,"contains ","")
            Set ingreds=""
            Set allergs=""            
            For i=1:1:$L(foodstring," "){
                Set f=$P(foodstring," ",i)                
                Set ingreds=ingreds_$LB(f)
                Set allingredients(f)=""                
            }
            For t=1:1:$L(allergenstring," "){
                Set a=$P(allergenstring," ",t)
                Set allallergens(a)=""                                    
                Set allergs=allergs_$LB(a)
            }
            Set food($I(food))=$LB(ingreds,allergs)
       }
    
    Set a=$O(allallergens(""))
    While a'="" {
        Kill allpossible
        Merge allpossible=allingredients
        Set f=$O(food(""),1,v)
        While f'="" {
            Set ingreds=$LG(v,1)
            Set allergs=$LG(v,2)
            If ##class(Utils.Base).inList(a,allergs) {
                Set idx=$O(allpossible(""))                
                While idx'="" {
                    If '(##class(Utils.Base).inList(idx,ingreds)){
                        Kill allpossible(idx)
                    }
                    Set idx=$O(allpossible(idx))
                }
            }
            Set f=$O(food(f),1,v)
        }    

        Merge possiblea=allpossible            
        Set a=$O(allallergens(a))
    }

    Set pi=$O(allingredients(""),1,i)
    While pi'="" {
        If '$D(possiblea(pi)){
            Set safe(pi)=""
        }
        Set pi=$O(allingredients(pi),1,i)
    }

    Set erg=0
    Set f=$O(food(""),1,v)
        While f'="" {
            Set ingreds=$LG(v,1)
            Set allergs=$LG(v,2)
            For idx=1:1:$LL(ingreds) {
                Set i=$LG(ingreds,idx)
                If $D(safe(i)){
                    Set erg=erg+1
                }
            }            
            Set f=$O(food(f),1,v)
        }

    Return erg
}

ClassMethod part2()
{
    Set data = ##class(Utils.Base).load(2020,21)
    Set erg=0 
	Set iterator=data.%GetIterator()
   	While iterator.%GetNext(.key,.val) { 
            Set foodstring=$P(val," (",1)
            Set allergenstring=$REPLACE($REPLACE($P(val," (",2),")",""),",","")
            Set allergenstring=$REPLACE(allergenstring,"contains ","")
            Set ingreds=""
            Set allergs=""            
            For i=1:1:$L(foodstring," "){
                Set f=$P(foodstring," ",i)                
                Set ingreds=ingreds_$LB(f)
                Set allingredients(f)=""                
            }
            For t=1:1:$L(allergenstring," "){
                Set a=$P(allergenstring," ",t)
                Set allallergens(a)=""                                    
                Set allergs=allergs_$LB(a)
            }
            Set food($I(food))=$LB(ingreds,allergs)
       }
    
    Set a=$O(allallergens(""))
    While a'="" {
        Kill allpossible
        Merge allpossible=allingredients
        Set f=$O(food(""),1,v)
        While f'="" {
            Set ingreds=$LG(v,1)
            Set allergs=$LG(v,2)
            If ##class(Utils.Base).inList(a,allergs) {
                Set idx=$O(allpossible(""))                
                While idx'="" {
                    If '(##class(Utils.Base).inList(idx,ingreds)){
                        Kill allpossible(idx)
                    }
                    Set idx=$O(allpossible(idx))
                }
            }
            Set f=$O(food(f),1,v)
        }    

        Merge possibleevil=allpossible            
        Set a=$O(allallergens(a))
    }

    Set a=$O(allallergens(""))
    While a'="" {
        Set list=""
        Set p=$O(possibleevil(""))
        While p'=""{
            Set list=list_$LB(p)
            Set p=$O(possibleevil(p))
        }
        Set triggers(a)=list
        Set a=$O(allallergens(a))
    }
    
    Set f=$O(food(""),1,v)
        While f'="" {
            Set ingreds=$LG(v,1)
            Set allergs=$LG(v,2)
            For idx=1:1:$LL(allergs) {
                Set a=$LG(allergs,idx)
                For i=1:1:$LL($G(triggers(a))) {
                    Set ing=$LG($G(triggers(a)),i)
                    If '(##class(Utils.Base).inList(ing,ingreds)){
                        Set triggers(a)=##class(Utils.Base).removeFromList(ing,$G(triggers(a)))                       
                    }
                }
            }            
            Set f=$O(food(f),1,v)
        }
        
    
    While ..stillwork(.triggers){
        Kill found
        Set a=$O(triggers(""),1,i)
        While a'=""{
            If $LL(i)=1 {
                For x=1:1:$LL(i){
                    Set f=$LG(i,x)
                    Set found(f)=""
                }
            }
            Set a=$O(triggers(a),1,i)
        }

        Set a=$O(triggers(""),1,i)        
        While a'=""{
            If $LL(i)>1 {
                Set f=$O(found(""))
                While f'=""{
                    #; Write "updating removing ",f,!
                    #; ZWrite triggers(a)
                    Set triggers(a)=##class(Utils.Base).removeFromList(f,$G(triggers(a)))
                    #; ZWrite triggers(a)
                    Set f=$O(found(f))
                }
            }
            Set a=$O(triggers(a),1,i)
        }            
    }
    
    Set erg=""
    Set a=$O(triggers(""),1,i)        
        While a'=""{
            If $L(erg)>1{
                Set erg=erg_","            
            }
            Set erg=erg_$LG(i,1)
            Set a=$O(triggers(a),1,i)        
        }            
    
    Return erg



    #; Set pi=$O(allingredients(""),1,i)
    #; While pi'="" {
    #;     If '$D(possibleevil(pi)){
    #;         Set safe(pi)=""
    #;     }
    #;     Set pi=$O(allingredients(pi),1,i)
    #; }

    #; Set erg=0
    #; Set f=$O(food(""),1,v)
    #;     While f'="" {
    #;         Set ingreds=$LG(v,1)
    #;         Set allergs=$LG(v,2)
    #;         For idx=1:1:$LL(ingreds) {
    #;             Set i=$LG(ingreds,idx)
    #;             If $D(safe(i)){
    #;                 Set erg=erg+1
    #;             }
    #;         }            
    #;         Set f=$O(food(f),1,v)
    #;     }

    #; Return erg
}

ClassMethod stillwork(ByRef triggers)
{
    Set t=$O(triggers(""),1,l)
    While t'="" {
        If $LL(l)>1{
            Return 1
        }
        Set t=$O(triggers(t),1,l)
    }
    Return 0
}

}
