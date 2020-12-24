Class fkh2020.Day24 Extends fkh2020.Base
{

ClassMethod part1()
{
    Set data = ##class(Utils.Base).load(2020,24)
    Set erg=0 
	Set iterator=data.%GetIterator()
   	While iterator.%GetNext(.key,.val) { 
           s directions($I(directions))=val
       }

    s d=$O(directions(""),1,val)
    s token=""
    
    while d'="" {
        
        s x=0,y=0        
        s token=""
        for i=1:1:$L(val){                        
            s token=token_$E(val,i)
            //e se sw w nw ne
            if token="e" {
                s x=x+1
                s token=""
            } elseif token="se" {
                s x=x+1
                s y=y-1
                s token=""
            } elseif token="sw"{
                s y=y-1
                s token=""
            } elseif token="w" {
                s x=x-1
                s token="" 
            } elseif token="nw"{
                s x=x-1
                s y=y+1
                s token=""
            } elseif token="ne" {
                s y=y+1
                s token=""
            }
            
        }
        
        if '$D(tiles(x,y)) {
            s tiles(x,y)=""
        } else {
            k tiles(x,y)
        }
        s d=$O(directions(d),1,val)
    }    
    Do ##class(Utils.Base).foreach(.tiles,"fkh2020.Day24","count",.number)       
    Return number
}

ClassMethod count(k, v, ByRef payload)
{
    
    Set payload=$G(payload,0)+1
}

ClassMethod part2()
{
    Set data = ##class(Utils.Base).load(2020,24)
    Set erg=0 
	Set iterator=data.%GetIterator()
   	While iterator.%GetNext(.key,.val) { 
           s directions($I(directions))=val
       }

    s d=$O(directions(""),1,val)
    s token=""
    
    while d'="" {        
        s x=0,y=0        
        s token=""
        for i=1:1:$L(val){                        
            s token=token_$E(val,i)
            //e se sw w nw ne
            if token="e" {
                s x=x+1
                s token=""
            } elseif token="se" {
                s x=x
                s y=y-1
                s token=""
            } elseif token="sw"{
                s x=x-1
                s y=y-1                
                s token=""
            } elseif token="w" {
                s x=x-1
                s token="" 
            } elseif token="nw"{                
                s y=y+1
                s token=""
            } elseif token="ne" {
                s x=x+1
                s y=y+1
                s token=""
            }            
        }
        
            if '$D(tiles(x,y)) {
                s tiles(x,y)=""
            } else {
                k tiles(x,y)
            }
        s d=$O(directions(d),1,val)
    }    
    s day=0        
    while day<100  {
        k neighbours
        k payload
        Do ##class(Utils.Base).foreach(.tiles,"fkh2020.Day24","process",.neighbours)        
        m payload("tiles")=tiles
        Do ##class(Utils.Base).foreach(.neighbours,"fkh2020.Day24","newgen",.payload)
        k tiles
        k payload("tiles")
        
        m tiles=payload        
        s number=0
        Do ##class(Utils.Base).foreach(.tiles,"fkh2020.Day24","count",.number)
        
        s day=day+1
        w day,": ",number,!
    }
        
    Return number
}

ClassMethod test()
{
    s tiles(0,0)=""
    s tiles(1,0)=""
    Do ##class(Utils.Base).foreach(.tiles,"fkh2020.Day24","process",.neighbours)
    zw neighbours
}

ClassMethod process(k, v, ByRef payload)
{
    s x=$P(k,",",1)
    s y=$P(k,",",2)    
    for delta=$LB(x-1,y-1),$LB(x,y-1),$LB(x,y+1),$LB(x+1,y+1),$LB(x+1,y),$LB(x-1,y) {        
        s tx=$LG(delta,1)
        s ty=$LG(delta,2)
        d $I(payload(tx,ty))
    }
}

ClassMethod newgen(k, v, ByRef payload)
{
    
    s x=$P(k,",",1)
    s y=$P(k,",",2)        
    if $D(payload("tiles",x,y)) {
        if (v=0)||(v>2){
            //not keeping black
            k payload("tiles",x,y)
        } else {
            s payload(x,y)=""
        }
    } else {
        if v=2 {
            s payload(x,y)=""
        } 
    }
}

}
