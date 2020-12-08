Class fkh2020.Base Extends %RegisteredObject
{

ClassMethod run()
{
   
    Set p1start=$PIECE($ZTIMESTAMP,",",2)
    Set r1=..part1()
    Set p1end=$PIECE($ZTIMESTAMP,",",2)
    Set p2start=$PIECE($ZTIMESTAMP,",",2)
    Set r2=..part2()
    Set p2end=$PIECE($ZTIMESTAMP,",",2)
    Write "part1: ",r1,!
    Write "part2: ",r2,!
    Write "runtime p1:",p1end-p1start,!
    Write "runtime p2:",p2end-p2start,!
}

ClassMethod part1() [ Abstract ]
{
}

ClassMethod part2() [ Abstract ]
{
}

}
