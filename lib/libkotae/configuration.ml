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

let name = "kotae"

let (/) = Filename.concat

let xdg = Xdg.create ~env:Sys.getenv_opt () 

let xdg_data_dir = Xdg.data_dir xdg
let xdg_config_dir = Xdg.config_dir xdg

let kotae_home_path = xdg_data_dir / name
let kotae_config_path = xdg_config_dir / name


