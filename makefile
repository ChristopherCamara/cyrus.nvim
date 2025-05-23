SRC=./src/
BUILD=./build/
LIB=./lib/
OUTPUT_NAME=socket_lib.so

CFLAGS=-I/opt/homebrew/include/luajit-2.1
LDFLAGS=-shared -L/opt/homebrew/lib -lluajit
SRCS := $(wildcard $(SRC)*.c)
OBJECTS := $(SRCS:$(SRC)%.c=$(BUILD)%.o)
OUTPUT := $(LIB)$(OUTPUT_NAME)

all: dirs install

dirs:
	mkdir -p $(BUILD) $(LIB)

$(BUILD)%.o: $(SRC)%.c
	${CC} -c $< -o $@ $(CFLAGS)

$(OUTPUT): $(OBJECTS)
	${CC} $(LDFLAGS) $(wildcard $(BUILD)*.o) -o $@

install: $(OUTPUT)
	cp $(OUTPUT) ./lua/cyrus/$(OUTPUT_NAME)

.PHONY = clean

clean:
	rm -f ./lua/cyrus/$(OUTPUT_NAME)
	rm -rf $(BUILD) $(LIB)
