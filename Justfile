all: run test

run:
  stack run

test:
  stack test

watch:
  ghcid --test Spec.main
