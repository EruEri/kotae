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

type answer =
| Empty
| OneOf of string list
| AllOf of string list
[@@deriving yojson]

type question = {
  question: string;
  image: string option;
  answer: answer
}
[@@deriving yojson]

type questions = question list
[@@deriving yojson]


let rec create_from_stdin path questions = 
  try 
    let () = Printf.printf "What is the quesion ?\n>>> %!" in
    let question = read_line () in
    let () = Printf.printf "Does it has an image ?\n>>> %!" in
    let image_path = String.trim @@ read_line () in
    let image = match image_path with
      | s when s = String.empty -> None
      | s when try Sys.is_regular_file s with _ -> false ->
        let open Configuration in
        let name = Filename.basename s in
        let image_target_dir = kotae_home_path / path in
        let _ = Sys.command @@ Printf.sprintf "cp %s %s" s image_target_dir in
        Some name
      | s -> 
        let () = Printf.eprintf "Not a regular file : %s\n" s  in 
        None
    in
    let () = Printf.printf "Answers ?:\n  - Empty mean no reply\n  - +(answer|...)+ mean all the answers\n  - (answer|...) means one of the anwser\n%!" in
    let () = Printf.printf ">>> " in
    let answer = String.trim @@ read_line () in
    let answer = match answer with
      | s when String.empty = s -> Empty
      | s when String.starts_with ~prefix:"+" s -> 
        let ss = String.split_on_char '|' @@ String.sub s 1 (String.length s - 1 ) in
        AllOf ss
      | s ->
        let ss = String.split_on_char '|' s in
        OneOf ss
    in
    let question = {
      question; image; answer
    } in 
    let () = Printf.printf "Answer added: %s \n\n" question.question in
    create_from_stdin path @@ question::questions
  with End_of_file -> List.rev questions


let create_from_stdin path = create_from_stdin path []


let save path questions = 
  let open Configuration in
  let path = Printf.sprintf "%s.json" kotae_home_path / path  in
  Yojson.Safe.to_file path @@ questions_to_yojson questions