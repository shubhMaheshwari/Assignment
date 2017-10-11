TARGETS = p1 p2 p3_threads p3_process

.PHONY: clean

all: $(TARGETS)

%: %.c
	gcc $< -lpthread -o $@

clean:
	rm -f $(TARGETS)