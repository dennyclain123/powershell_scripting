$day = Read-Host "What is Today"
switch ($day){
"Monday" {"Today is Monday";break}
"Tuesday" {"Today is Tuesday";break}
"Wednesday" {"Today is Wednesday";break}
"Thursday" {"Today is Thursday";break}
"Friday" {"Today is Friday;break"}
"Saturday" {"Today is Saturday";break}
"Sunday" {"Today is Sunday";break}
default {"Invalid Input";break}
}