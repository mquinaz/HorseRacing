#http://www.gnu.org/software/make/manual/html_node/Implicit-Variables.html
CXX      := -g++
CXXFLAGS := -std=c++11 -Wall
#-L/usr/lib -lstdc++
LDFLAGS  := -L/usr/include -lsfml-audio -lsfml-graphics -lsfml-window -lsfml-system
BUILD    := ./build
OBJ_DIR  := $(BUILD)/objects
APP_DIR  := $(BUILD)
TARGET   := farmrace
INCLUDE  := -I/usr/include
SRC      := $(wildcard *.cpp) 
OBJECTS  := $(SRC:%.cpp=$(OBJ_DIR)/%.o)
#LDLIBS := $(shell pkg-config sfml-all --libs)

all: build $(APP_DIR)/$(TARGET)

$(OBJ_DIR)/%.o: %.cpp
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $(INCLUDE) -o $@ -c $<

$(APP_DIR)/$(TARGET): $(OBJECTS)
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $(INCLUDE) $(LDFLAGS) -o $(APP_DIR)/$(TARGET) $(OBJECTS)

.PHONY: all build clean debug release

build:
	@echo '** Building files...'
	@mkdir -p $(APP_DIR)
	@mkdir -p $(OBJ_DIR)

debug: CXXFLAGS += -DDEBUG -g
debug: all

release: CXXFLAGS += -O2
release: all

clean:
	@echo '** Removing files...'
	-@rm -rvf $(OBJ_DIR)/*
	-@rm -rvf $(APP_DIR)/*
