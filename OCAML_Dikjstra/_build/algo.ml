open Ford_fulkerson
open Graph
open Gfile


let algo outfile src dest g =
  let chemin = trouver_chemin g src dest in 

  let rec maj_graph g = function
    |[] -> g
    |chemin -> let flow= (flow_chemin chemin)
      in
      Printf.printf "flot max : %d\n" flow; let g2 = (maj_chemin chemin g flow)
      in
      maj_retour src g2 flow chemin;
      maj_graph g2 (trouver_chemin g2 src dest)
  in
  let graph_final = (maj_graph g chemin)
  in
  let graph_string = Graph.map graph_final (fun x->x) (string_of_int)
  in
  export graph_string outfile
