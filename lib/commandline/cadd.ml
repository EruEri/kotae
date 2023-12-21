(**********************************************************************************************)
(*                                                                                            *)
(* This file is part of kotae: a question-answer manager                                      *)
(* Copyright (C) 2023 Yves Ndiaye                                                             *)
(*                                                                                            *)
(* kotae is free software: you can redistribute it and/or modify it under the terms           *)
(* of the GNU General Public License as published by the Free Software Foundation,            *)
(* either version 3 of the License, or (at your option) any later version.                    *)
(*                                                                                            *)
(* kotae is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;         *)
(* without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR           *)
(* PURPOSE.  See the GNU General Public License for more details.                             *)
(* You should have received a copy of the GNU General Public License along with kotae.        *)
(* If not, see <http://www.gnu.org/licenses/>.                                                *)
(*                                                                                            *)
(**********************************************************************************************)

open Cmdliner

type t = {
  path: string
}

let name = "add"


let term_path = Arg.(
  required 
    & pos 0 (some string) None 
    & info ~doc:"Path of the subject" ~docv:"subject" []
)

let term_cmd run =
  let combine path = run {path}
  in
  Term.(const combine $ term_path)


let doc = "Add questions to $(mname)"

let man = [

]

let cmd run = 
  let info = Cmd.info name ~doc ~man in
  Cmd.v info (term_cmd run)

let run args = 
  let {path} = args in
  let basedir = Filename.dirname path in
  let code = Sys.command @@ Printf.sprintf "mkdir -p %s" basedir in  
  let () = match code with
    | 0 -> ()
    | _ -> exit code
  in
  let questions = Libkotae.Questions.create_from_stdin path in
  let () = Libkotae.Questions.save path questions in
  ()

let command = cmd run