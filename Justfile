all: test

run:
  stack run

test:
  stack test

watch:
  chmod go-w .ghci .
  ghcid --test Spec.main
