open Graph
open List

(*La fonction trouver chemin qui cherche le chemin le plus court entre la source et la destination en prenant en compte les sommets déjà visités*)
let trouver_chemin g src dest  = 
  let rec appartient element liste =
    match liste with
    |[]-> false
    |actuel::reste -> if element= actuel then true else appartient element reste in
  let choix_optimal list1 list2 =
    if length (list1) = 0 then list2 else
    if length (list2) = 0 then list1 else
      if length (list1) < length (list2) then list1 else list2 in
  let rec chercher_chemin chemin parcouru = function
    |[]->[]
    |(e , id)::reste -> if appartient id parcouru then chercher_chemin chemin parcouru reste else
      (if id=dest then (append chemin [(e,id)])
      else choix_optimal (chercher_chemin (append chemin [(e,id)]) (id::parcouru) (find_vertex g id).outedges) (chercher_chemin chemin parcouru reste)) in
  chercher_chemin [] [] (find_vertex g src).outedges



(* Cette fonction nous permet de trouver le flow minimal (celui que l'on va utiliser) au sein du chemin que l'on parcourt*)

let flow_chemin chemin =

  let rec flow_min min = function
    |[]->min
    |(e, id)::reste -> if e<min then flow_min e reste else flow_min min reste in
  flow_min 999 chemin



(* Cette fonction met a jour les valeurs des labels le long du chemin "chemin", on soustrait le flow *)

let maj_chemin chemin g flow =
  let rec appartient element liste =
    match liste with
    |[]-> false
    |actuel::reste -> if element= actuel then true else appartient element reste in

  let rec maj_edges = function
    |[]->[]
    |(e, id)::reste -> if appartient (e, id) chemin then
        if e-flow = 0 then (maj_edges reste) else ((e-flow, id)::(maj_edges reste))
      else ((e, id)::(maj_edges reste))
  in

  let maj_vertex_info =
    (fun x -> { label= x.label ; id=x.id ; outedges = maj_edges x.outedges ; inedges = maj_edges x.inedges})
  in

  {vertices = map_hashtbl g.vertices maj_vertex_info}



(* Cette fonction permet d'ajouter le retour sur le chemin trouvé précédemment, on ajoute l'arrête si elle n'éxistait pas, sinon on la met a jour en ajoutant le flow trouvé avec les fonctions précédentes.*)
                   
let rec maj_retour source g flow = function
  |[]->()
  |(e, id)::reste -> add_edge_addition g id source flow;
    maj_retour id g flow reste

 (*   let print g source dest acu
        trouver chemin (liste)
        flow min liste --> acu + flow  
          maj_chemin
          maj_retour
          print g2 source dest  


    let main outfile src dest g =
      let flow = 0 in
      let path = trouver_chemin g src dest in 
    
    let rec maj_graph g = function
      |[] -> g
      |chemin -> let flow= (flow_chemin chemin)
        in
        let g2 = (maj_chemin g flow chemin)
        in
        maj_retour g2 flow src chemin;
        maj_graph g2 (trouver_chemin g2 src dest)
      in
      let graph_final = (maj_graph g chemin)
      in
      let graph_string = map graph_final (fun x->x) (string_of_int)
      in
      export outfile graph_string*)

     
      
    
