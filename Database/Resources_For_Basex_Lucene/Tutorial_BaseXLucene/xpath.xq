collection("Movies")


(: doc("Movies") :)



(: collection("Movies")//* :)

(: collection("Movies")//@* :)


(: collection("Movies")//movie[@*] :)







(: collection("Movies")//actors :)



(: collection("Movies")//@title :)





(: collection("Movies")//actors[last()-1] :) 




(: collection("Movies")//actors[position()<3] :)




(:  collection("Movies")//movie/rating[imdbRating>7.5] :)

