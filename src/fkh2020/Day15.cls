Class fkh2020.Day15 Extends fkh2020.Base
{

ClassMethod part1()
{
    Set input="20,0,1,11,6,3"
    For i=1:1:$L(input,",") {
        Set nums($I(nums))=$P(input,",",i)
        Set numbers($P(input,",",i))=$LB(i)       
    }
    Set last=3

    For i=7:1:2020 {
        If $LL($G(numbers(last)))=1{
            Set said=0
        } Else {
            Set times=$G(numbers(last))
            Set said=$LG(times,2)-$LG(times,1)            
        }
        If $D(numbers(said)){
            Set numbers(said)=$LB($LG($G(numbers(said)),-1),i)
        } Else {
            Set numbers(said)=$LB(i)
        }
        Set last=said
    }

    Return said
}

ClassMethod part2()
{
    Kill ^numbers
    Set input="20,0,1,11,6,3"
    For i=1:1:$L(input,",") {
        Set nums($I(nums))=$P(input,",",i)
        Set ^numbers($P(input,",",i))=$LB(i)       
    }
    Set last=3

    For i=7:1:30000000 {
        If $LL($G(^numbers(last)))=1{
            Set said=0
        } Else {
            Set times=$G(^numbers(last))
            Set said=$LG(times,2)-$LG(times,1)            
        }
        If $D(^numbers(said)){
            Set ^numbers(said)=$LB($LG($G(^numbers(said)),-1),i)
        } Else {
            Set ^numbers(said)=$LB(i)
        }
        Set last=said
    }
    Kill ^numbers
    Return said
}

}
