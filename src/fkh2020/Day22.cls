Class fkh2020.Day22 Extends fkh2020.Base
{

ClassMethod part1()
{
    
    Set data = ##class(Utils.Base).load(2020,22)
    Set erg=0 
	Set iterator=data.%GetIterator()
    Set p=1
   	While iterator.%GetNext(.key,.val) { 
           If p=1{
            If $MATCH(val,"\d+") {
                Set cards1($I(cards))=val
            }
           }
           If p=2{
               If $MATCH(val,"\d+") {
                     Set cards2($I(cards))=val
                }
           }
           If $L(val)<1{
               Set p=2
           }

       }

    #; ZWrite cards1
    #; ZWrite cards2

    
    Set pi1=$O(cards1(""))
    Set pi2=$O(cards2(""))

    Set r=0
    While (pi1'="") && (pi2'="") {
        Set r=r+1
        #; Write "round: ",r,!        
        Do ..round(.cards1,.cards2)
        
        Set pi1=$O(cards1(""))
        Set pi2=$O(cards2(""))             
    }
    If pi1="" {
        #; Write "player 2 wins",!
        Set f=1
        Set i=$O(cards2(""),-1,v)
        Set score=0
        While i'="" {
            Set score=score+ (f*v)
            Set f=f+1
            Set i=$O(cards2(i),-1,v)
        }
    }
    If pi2="" {
        #; Write "player 1 wins",!
        Set f=1
        Set i=$O(cards1(""),-1,v)
        Set score=0
        While i'="" {
            Set score=score+ (f*v)
            Set f=f+1
            Set i=$O(cards1(i),-1,v)
        }
    }
    #; Write r,!
    Return score
}

ClassMethod round(ByRef cards1, ByRef cards2)
{
    Set p1=""
    Set p2=""
    #; ZWrite cards1
    Set i1=$O(cards1(""),1,p1)
    Set i2=$O(cards2(""),1,p2)
    Set l1=$O(cards1(""),-1)
    Set l2=$O(cards2(""),-1)

    Kill cards1(i1)
    #; Write "--",!
    #; ZWrite cards1
    #; ZWrite cards1
    Kill cards2(i2)
    #; Write "p1 plays",p1,!
    #; Write "p2 plays",p2,!
    If p1>p2 {
        #; Write "p1 wins round",!
        #; ZWrite cards1
        Set cards1(l1+1)=p1
        Set cards1(l1+2)=p2        
        #; ZWrite cards1
    }
    If p2>p1 {
        #; Write "p2 wins round",!
        Set cards2(l2+1)=p2
        Set cards2(l2+2)=p1
    }
}

ClassMethod recgame(ByRef cards1, ByRef cards2)
{
    Set debug=0
    Kill setupsseen
    
    Set pi1=$O(cards1(""))
    Set pi2=$O(cards2(""))

    Set r=0
    While (pi1'="") && (pi2'="") {
        Set k1="",k2=""
        Set i1=$O(cards1(""),1,v)
        While i1'="" {
            Set:$L(k1)>1 k1=k1_","
            Set k1=k1_v
            Set i1=$O(cards1(i1),1,v)
        }
        Set i2=$O(cards2(""),1,v)
        While i2'="" {
            Set:$L(k2)>1 k2=k2_","
            Set k2=k2_v
            Set i2=$O(cards2(i2),1,v)
        }
        Write:debug "incoming cards1: ",k1,!
        Write:debug "incoming cards2: ",k2,!
        Set k=k1_k2
        Set k=##class(%SYSTEM.Encryption).Base64Encode(##class(%SYSTEM.Encryption).MD5Hash(k))
        If $D(setupsseen(k)){
            Write:debug "win by seen before",!
            Return 1
        }

        Set r=r+1
        #; Write "round: ",r,!

        Set i1=$O(cards1(""),1,p1)
        Set i2=$O(cards2(""),1,p2)
        Set l1=$O(cards1(""),-1)
        Set l2=$O(cards2(""),-1)
        Kill cards1(i1)
        Kill cards2(i2)
        Set num1=(l1-i1)
        Set num2=(l2-i2)
        Write:debug "-- Round ",r," --",!
        Write:debug "p1 plays: ",p1, "  num1 ",num1,!
        Write:debug "p2 plays: ",p2,"  num2 ",num2,!

        If (num1>=p1)&&(num2>=p2){
            Kill subc1,subc2
            For i=1:1:p1{
                If $G(cards1(i1+i))="" {
                    Break
                }
                Set subc1($I(subc1))=$G(cards1(i1+i))
            }
            For i=1:1:p2{
                If $G(cards2(i2+i))="" {
                    Break
                }
                Set subc2($I(subc2))=$G(cards2(i2+i))
            }
            Write:debug "initiating subgame in round ",r,!
            Set subgame=..recgame(.subc1,.subc2) 
            If subgame {
                Write:debug "p1 wins subgame",!
                Set cards1(l1+1)=p1
                Set cards1(l1+2)=p2
            } Else {
                Write:debug "p2 wins subgame",!
                Set cards2(l2+1)=p2
                Set cards2(l2+2)=p1
            }
        } Else {
            If p1>p2 {
            Write:debug "p1 wins round ",r," by drawn number ",p1,!
            #; ZWrite cards1
            Set cards1(l1+1)=p1
            Set cards1(l1+2)=p2
            #; Write "cards added",!        
            #; ZWrite cards1
            }
            If p2>p1 {
                Write:debug "p2 wins round ",r," by drawn number ",p2,!               
                Set cards2(l2+1)=p2
                Set cards2(l2+2)=p1
            }
            
        }
        Set pi1=$O(cards1(""))
        Set pi2=$O(cards2(""))   
        Set setupsseen(k)=""          
    }
    If pi1="" {
        Write:debug "player 2 wins subgame",!
        Return 0
    }
    If pi2="" {
        Write:debug "player 1 wins subgame",!
        Return 1
    }
}

ClassMethod part2()
{
   Set data = ##class(Utils.Base).load(2020,22)
    Set erg=0 
	Set iterator=data.%GetIterator()
    Set p=1
   	While iterator.%GetNext(.key,.val) { 
           If p=1{
            If $MATCH(val,"\d+") {
                Set cards1($I(cards))=val
            }
           }
           If p=2{
               If $MATCH(val,"\d+") {
                     Set cards2($I(cards))=val
                }
           }
           If $L(val)<1{
               Set p=2
           }

       }

    #; ZWrite cards1
    #; ZWrite cards2
    Set onewins=..recgame(.cards1,.cards2)       
    If onewins {
        Write "player 1 wins",!
        Set f=1
        Set i=$O(cards1(""),-1,v)
        Set score=0
        While i'="" {
            Set score=score+ (f*v)
            Set f=f+1
            Set i=$O(cards1(i),-1,v)
        }
    } Else {
        Write "player 2 wins",!
        Set f=1
        Set i=$O(cards2(""),-1,v)
        Set score=0
        While i'="" {            
            Set score=score+ (f*v)
            Set f=f+1
            Set i=$O(cards2(i),-1,v)
        }
    }
    
    Return score
}

}
