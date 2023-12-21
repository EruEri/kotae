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

let name = "kotae"

let version =
  let s =
    match Build_info.V1.version () with
    | None ->
        "n/a"
    | Some v ->
        Build_info.V1.Version.to_string v
  in
  Printf.sprintf "%s" s


let doc = "A quesion-answer manager"

let man = []

let info = 
  Cmd.info ~doc ~man ~version name

let subcommands = []

let cmd  = Cmd.group info subcommands

let eval () = Cmd.eval cmd