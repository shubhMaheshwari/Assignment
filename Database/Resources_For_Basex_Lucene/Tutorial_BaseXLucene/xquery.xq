for $x in collection("Movies")/root/movie
where $x/rating/imdbRating > 7.5
order by $x/@title
return <results>{$x/@title}</results> 


(: for $x in doc("Movies")/root/movie
return $x/actors[position()<3] :)

(: for $x in doc("Movies")/root
return $x/movie[position()<5 and position()>2] :)


(: for $x in doc("Movies")//actors 
return $x :)



(: let $x := (1 to 5)
let $p := 1
for $t in $x
where $t>2
let $temp := ($t - $p)
return <value>{$temp}</value> :)




(: for $x in collection("Movies")/root/movie
order by $x/@title
return <name>{$x/@title}</name> :)




(: for $x in collection("Movies")/root/movie
order by $x/@title
return <name label = "{data($x/@title)}"></name> :)

(: for $x in collection("Movies")/root/movie
order by $x/@title descending
return <name label = "{data($x/@title)}"></name> :)


(: for $x in collection("Movies")/root/movie
order by $x/@title
return if ($x/rating/imdbRating > 7.5)
then <good><name>{$x/@title}</name></good>
else <bad><name>{$x/@title}</name></bad> :)





(: for $x in (1 to 5)
return <test>{$x}</test> :)




(: for $x in (10,20), $y in (100,200)
return <test>x={$x} and y={$y}</test> :) 


(: for $x at $i in collection("Movies")/root/movie
return <results>{$i}. <name>{data($x/@title)}</name></results>
:)





(: <ul>
{
for $x in doc("Movies")/root/movie
order by $x/@title
return <li>{data($x/@title)}</li>
}
</ul> :) 



(: for $x in collection("Movies")/root/movie
return <results> <name>{upper-case($x/@title)}</name> </results>  :)





(:  for $x in collection("Movies")/root/movie
return <results> <name>{substring($x/@title, 1, 4)}</name> </results> :)




(: for $x in collection("Movies")/root/movie
return <results> <name>{substring($x/@title, 2)}</name> </results> :)



(: for $x in doc("Movies")/root/movie/actors/../@title
return $x :)



(: for $x in collection("Movies")/root/movie
return if (count($x/actors)>2)
then <good>{$x/actors}</good>
else <bad>{$x/actors}</bad> :)







(: declare function local:minPrice($d as xs:decimal)
as xs:decimal?
{
let $disc := ($d) mod 100
return ($disc)
};


for $x in collection("Movies")/root/movie
return
<minPrice>{data($x/rating/imdbVotes)}'- ' {local:minPrice(($x/rating/imdbVotes))}</minPrice> :)





(: declare function local:minPrice($d as xs:decimal,$p as xs:float)
as xs:float?
{
let $disc := ($d) mod 100
let $temp := ($p * $disc)
return round($temp)
};


for $x in collection("Movies")/root/movie
return
<minPrice>{data($x/rating/imdbVotes)}'- '{data($x/rating/imdbRating)}'- ' {local:minPrice(($x/rating/imdbVotes),($x/rating/imdbRating))}</minPrice> :)
