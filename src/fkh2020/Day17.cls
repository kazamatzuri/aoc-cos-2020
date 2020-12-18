Class fkh2020.Day17 Extends fkh2020.Base
{

ClassMethod getActiveN2(ByRef data, x, y, z, w)
{
    Set act=0    
    For tx=(x-1):1:(x+1){
        For ty=(y-1):1:(y+1){
            For tz=(z-1):1:(z+1){    
                For tw=(w-1):1:(w+1){
                    Set v=$G(data(tx,ty,tz,tw),".")
                        If v="#" {
                            Set act=act+1
                        }
} 
            }
        }
    }    
    Set v=$G(data(x,y,z,w),".")
    If v="#"{
        Set act=act-1
    }

    Return act
}

ClassMethod getActiveN(ByRef data, x, y, z)
{
    Set act=0    
    For tx=(x-1):1:(x+1){
        For ty=(y-1):1:(y+1){
            For tz=(z-1):1:(z+1){     
                Set v=$G(data(tx,ty,tz),".")
                If v="#" {
                    Set act=act+1
                }
            }
        }
    }    
    Set v=$G(data(x,y,z),".")
    If v="#"{
        Set act=act-1
    }

    Return act
}

ClassMethod part1()
{
    Set data = ##class(Utils.Base).load(2020,17)
    Set erg=0 
	Set iterator=data.%GetIterator()
   	While iterator.%GetNext(.key,.val) { 
           For i=1:1:$L(val){
               Set data(i,key,0)=$E(val,i)                              
           }
           Set maxx=$L(val)
       }
    
    Set maxy=data.%Size()
    #; ZWrite data
    Set maxz=0

    #; Return ..countAll(.data)
    Set dim=3
    Set r=0
    While r<6 {
        For tx=-(r+maxx+2):1:(r+maxx+2){
            For ty=-(r+maxy+2):1:(r+maxy+2){
                For tz=-(r+maxz+2):1:(r+maxz+2){                   
                    #; Write tx,ty,tz,!
                    Set v=$G(data(tx,ty,tz),".")
                    Set n=..getActiveN(.data,tx,ty,tz)                   
                    If (v="#"){                            
                            If ((n=2)||(n=3)){
                                #; Write r,"th round ",tx," ",ty," ",tz," act ",n,!
                                Set newdata(tx,ty,tz)="#"                        
                            } Else {
                                Set newdata(tx,ty,tz)="."                        
                            }
                    }
                    If ((v=".")&&(n=3)){
                        #; Write r,"th round ",tx," ",ty," ",tz," act ",n,!
                        Set newdata(tx,ty,tz)="#"
                    }
                }
        }            
        }
        Set r=r+1
        Kill data
        Merge data=newdata        
    }   
    Do ##class(Utils.Base).foreach(.data,"fkh2020.Day17","count",.number)    
    Return number
}

ClassMethod count(k, v, ByRef payload)
{
    If v="#" {
        Set payload=$G(payload,0)+1
    }
}

ClassMethod influenceNeighbours(k, v, ByRef output)
{
    Set values($I(values))=-1
    Set values($I(values))=0
    Set values($I(values))=1
    Set l=$L(k,",")
    Do ##class(Utils.Base).permutations(.values,l,.perms)
    If v="#"{
        Set l=$L(k,",")
        Set output("base")=k
        Do ##class(Utils.Base).foreach(.perms,"fkh2020.Day17","setN",.output)
    }
}

ClassMethod setN(k, v, ByRef output)
{
    Set base=$G(output("base"))
    Set newsub=""
    Set l=$L(base,"v")
    If (l=3)&&(v'="0,0,0"){
        Set s1=$P(base,",",1)+$P(v,",",1)
        Set s2=$P(base,",",2)+$P(v,",",2)
        Set s3=$P(base,",",3)+$P(v,",",3)
        Set output(s1,s2,s3)=$G(output(s1,s2,s3),0)+1
    }
    If (l=4)&&(v'="0,0,0,0"){
        Set s1=$P(base,",",1)+$P(v,",",1)
        Set s2=$P(base,",",2)+$P(v,",",2)
        Set s3=$P(base,",",3)+$P(v,",",3)
        Set s4=$P(base,",",4)+$P(v,",",4)
        Set output(s1,s2,s3)=$G(output(s1,s2,s3),0)+1
    }
}

ClassMethod part2()
{
   Set data = ##class(Utils.Base).load(2020,17)
    Set erg=0 
	Set iterator=data.%GetIterator()
   	While iterator.%GetNext(.key,.val) { 
           For i=1:1:$L(val){
               Set data(i,key,0,0)=$E(val,i)                              
           }
           Set maxx=$L(val)
       }
    
    Set maxy=data.%Size()
    Set maxw=0
    #; ZWrite data
    Set maxz=0

    #; Return ..countAll(.data)
    Set dim=3
    Set r=0
    While r<6 {
        For tx=-(r+maxx+2):1:(r+maxx+2){
            For ty=-(r+maxy+2):1:(r+maxy+2){
                For tz=-(r+maxz+2):1:(r+maxz+2){   
                    For tw=-(r+maxw+2):1:(r+maxw+2){   
                        #; Write tx,ty,tz,!
                        Set v=$G(data(tx,ty,tz,tw),".")
                        Set n=..getActiveN2(.data,tx,ty,tz,tw)                   
                        If (v="#"){                            
                                If ((n=2)||(n=3)){
                                    #; Write r,"th round ",tx," ",ty," ",tz," act ",n,!
                                    Set newdata(tx,ty,tz,tw)="#"                        
                                } Else {
                                    Set newdata(tx,ty,tz,tw)="."                        
                                }
                        }
                        If ((v=".")&&(n=3)){
                            #; Write r,"th round ",tx," ",ty," ",tz," act ",n,!
                            Set newdata(tx,ty,tz,tw)="#"
                        }
                    }
                }
            }            
        }
        Set r=r+1
        Kill data
        Merge data=newdata        
    }   
    Do ##class(Utils.Base).foreach(.data,"fkh2020.Day17","count",.number)    
    Return number
}

}
