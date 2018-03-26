open Graph
open Ford_fulkerson
open Algo
    

let () =

  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf "\nUsage: %s infile source sink outfile\n\n%!" Sys.argv.(0) ;
      exit 0
    end ;

  let infile = Sys.argv.(1)
  and source = Sys.argv.(2)
  and sink = Sys.argv.(3)
  and outfile = Sys.argv.(4) in

  let graph = Gfile.from_file infile in

  let graph2 = Graph.map graph (fun x->x) int_of_string in
(*  let graph3 = Graph.map graph2 (fun x -> x*10) (fun x -> x+1) in
    let graph4 = Graph.map graph3 string_of_int string_of_int in*)

  algo outfile source sink graph2

      
(*  let () = Gfile.write_file outfile graph4 in ()
    
  let () = Gfile.export graph4 "dotgraph" in ()*)
      
