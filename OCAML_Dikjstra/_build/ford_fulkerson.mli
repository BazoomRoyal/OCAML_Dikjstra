open Graph

val trouver_chemin: ('v, 'e) graph -> id -> id -> ('e * id) list

val flow_chemin: (int * id) list -> int

val maj_chemin:  (int * id) list -> ('v, int) graph -> int -> ('v, int) graph

val maj_retour:  Graph.id -> ('v, int) graph -> int -> (int * id) list -> unit



(* 
Compilateur au max ?? 
*)
