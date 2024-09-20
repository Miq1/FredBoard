all: SFtest SFcli

OBJ = SFtest.o SFcli.o
CXXFLAGS = -Wextra
CPPFLAGS = 

DEPS := $(OBJ:.o=.d)
	-include $(DEPS)

SFtest: SFtest.o 
	$(CXX) $^ -o $@

SFcli: SFcli.o 
	$(CXX) $^ -o $@

%.o: %.cpp
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $<

.PHONY: clean all

clean:
	$(RM) core *.o *.d
