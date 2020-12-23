Class fkh2020.Day23 Extends fkh2020.Base
{

ClassMethod part1()
{
   Set label="137826495"
    #; Set label="389125467"
       
    Set first="",prev=""
    For i=1:1:($L(label)){
        Do $I(data)    
        Set data(data)=$E(label,i)

        
        Set dict($E(label,i))=data
        If first="" {
            Set first=data
        }
        If prev'="" {
            Set right(prev)=data
            Set left(data)=prev
        }
        Set prev=data
    }    
    
    Set last=prev
    Set right(last)=first
    Set left(first)=last

    Set maxlabel=9

    Set currentcup=first   

    #; Write "current cup label:",currentcup.label,!
    #; Write "maxlabel: ",maxlabel,!
    Set move=0    
    While move<100 {
      
        #; Write "-- move ",move,"--",!        
        #; Write "cups: "
        #; Set start=first
        #; For i=1:1:maxlabel{
        #;     Write:start=currentcup "("
        #;     Write start.label
        #;     Write:start=currentcup ")"
        #;     Set start=start.right
        #; }
        #; Write !        
        Set currentlabel=data(currentcup)
        Set pickup=""

        Set t1=right(currentcup)
        Set t2=right(t1)
        Set t3=right(t2)
        Set right(currentcup)=right(t3)
        Set left(right(t3))=currentcup
        
        Set pickup=$LB(data(t1),data(t2),data(t3))
        Set dest=""
        #; Write "cl:",currentlabel,!
        Set ceiling=currentlabel-1
        Set:ceiling=0 ceiling=maxlabel        
        While ##class(Utils.Base).inList(ceiling,pickup){     
            Set ceiling=ceiling-1
            If ceiling<=0 {
                Set ceiling=maxlabel
            }                
        }
        Set dest=dict(ceiling)        
        Set t=right(dest)
        Set right(dest)=t1
        Set left(t1)=dest
        Set right(t3)=t
        Set left(t)=t3
        
        #; Write "pickup: ",pickup,!
        #; Write "dest label: ",dest.label,!
        Set currentcup=right(currentcup)     
        Set move=move+1
    }   
    Set erg=""
    Set start=right(dict(1))
    For i=1:1:maxlabel-1{
        Set erg=erg_data(start)
        Set start=right(start)
    }     
    Write erg,!   
    Return erg
}

ClassMethod part2()
{
    Set label="137826495"
    #; Set label="389125467"
       
    Set first="",prev=""
    For i=1:1:($L(label)){
        Do $I(data)    
        Set data(data)=$E(label,i)
        
        Set dict($E(label,i))=data
        If first="" {
            Set first=data
        }
        If prev'="" {
            Set right(prev)=data
            Set left(data)=prev
        }
        Set prev=data
    }    
    For i=10:1:1000000{
        Do $I(data)    
        Set data(data)=i
        
        Set dict(i)=data
        If first="" {
            Set first=data
        }
        If prev'="" {
            Set right(prev)=data
            Set left(data)=prev
        }
        Set prev=data
    }   
    
    Set last=prev
    Set right(last)=first
    Set left(first)=last

    Set maxlabel=1000000

    Set currentcup=first   

    #; Write "current cup label:",currentcup.label,!
    #; Write "maxlabel: ",maxlabel,!
    Set move=0    
    While move<10000000 {
      
        If (move#100000)=0 {
            Write move,!
        }
        Set currentlabel=data(currentcup)
        Set pickup=""

        Set t1=right(currentcup)
        Set t2=right(t1)
        Set t3=right(t2)
        Set right(currentcup)=right(t3)
        Set left(right(t3))=currentcup
        
        Set pickup=$LB(data(t1),data(t2),data(t3))
        Set dest=""
        #; Write "cl:",currentlabel,!
        Set ceiling=currentlabel-1
        Set:ceiling=0 ceiling=maxlabel        
        While ##class(Utils.Base).inList(ceiling,pickup){     
            Set ceiling=ceiling-1
            If ceiling<=0 {
                Set ceiling=maxlabel
            }                
        }
        Set dest=dict(ceiling)        
        Set t=right(dest)
        Set right(dest)=t1
        Set left(t1)=dest
        Set right(t3)=t
        Set left(t)=t3
        
        #; Write "pickup: ",pickup,!
        #; Write "dest label: ",dest.label,!
        Set currentcup=right(currentcup)     
        Set move=move+1
    }   
    Set start=right(dict(1))
    
    
    Set start=dict(1)
    Set f1=right(start)
    Set f2=right(f1)
    Set erg=data(f1)*data(f2)
    Return erg
}

}
