TARGETS = 1_dup 2_pipe 3_pipefork

.PHONY: clean

all: $(TARGETS)

%: %.c
	gcc $< -o $@

clean:
	rm -f $(TARGETS)
