%.png : %.dot
		dot -Tpng $< -o $@

all: $(patsubst %.dot, %.png, $(wildcard *.dot))
