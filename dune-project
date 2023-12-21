(lang dune 3.12)

(version "0.1.0")

(name kotae)

(generate_opam_files true)

(source
 (github EruEri/kotae))

(authors "EruEri")

(maintainers "EruEri")

(license GPL-3.0)

(package
 (name kotae)
 (synopsis "A question-answer manager")
 (description "Kotae is a command-line tool to create and execise on question-answers")
 (depends ocaml dune)
 (tags
  ("cli" "question-answer")))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
