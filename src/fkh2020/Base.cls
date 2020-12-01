Class fkh2020.Base Extends %RegisteredObject
{

ClassMethod run()
{
    Set r1=..part1()
    Set r2=..part2()
    Write "part1: ",r1,!
    Write "part2: ",r2,!
}

ClassMethod part1() [ Abstract ]
{
}

ClassMethod part2() [ Abstract ]
{
}

}
