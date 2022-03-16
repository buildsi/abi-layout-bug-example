CXXFLAGS = -g

.PHONY: default run clean
default: run

libgetemployee_v1.so: GetEmployees_v1.h GetEmployees.cpp
	@echo BUILDING libgetemployee_v1.so
	@rm -f GetEmployees.h
	@cp GetEmployees_v1.h GetEmployees.h
	@$(CXX) $(CXXFLAGS) -o libgetemployee.so -fPIC -shared GetEmployees.cpp
	@mv libgetemployee.so libgetemployee_v1.so

libgetemployee_v2.so: GetEmployees_v2.h GetEmployees.cpp
	@echo BUILDING libgetemployee_v2.so
	@rm -f GetEmployees.h 
	@cp GetEmployees_v2.h GetEmployees.h
	@$(CXX) $(CXXFLAGS) -o libgetemployee.so -fPIC -shared GetEmployees.cpp
	@mv libgetemployee.so libgetemployee_v2.so

printemployees_v1: PrintEmployees.cpp GetEmployees_v1.h libgetemployee_v1.so
	@echo BUILDING printemployees_v1 executable against libgetemployee_v1.so
	@rm -f GetEmployees.h libgetemployee.so
	@cp GetEmployees_v1.h GetEmployees.h
	@cp libgetemployee_v1.so libgetemployee.so
	@$(CXX) $(CXXFLAGS) -o $@ PrintEmployees.cpp -I . -Wl,-rpath,`pwd` -L. -lgetemployee

printemployees_v2: PrintEmployees.cpp GetEmployees_v2.h libgetemployee_v2.so
	@echo BUILDING printemployees_v2 executable against libgetemployee_v2.so
	@rm -f GetEmployees.h libgetemployee.so
	@cp GetEmployees_v2.h GetEmployees.h
	@cp libgetemployee_v2.so libgetemployee.so
	@$(CXX) $(CXXFLAGS) -o $@ PrintEmployees.cpp -I . -Wl,-rpath,`pwd` -L. -lgetemployee

run: printemployees_v1 printemployees_v2 libgetemployee_v1.so libgetemployee_v2.so
	@echo RUNNING printemployee_v1 against libgetemployee_v1.so
	@rm -f libgetemployee.so
	@cp libgetemployee_v1.so libgetemployee.so
	@./printemployees_v1 || true

	@echo RUNNING printemployee_v2 against libgetemployee_v2.so
	@rm -f libgetemployee.so
	@cp libgetemployee_v2.so libgetemployee.so
	@./printemployees_v2 || true

	@echo RUNNING printemployee_v1 against libgetemployee_v2.so
	@rm -f libgetemployee.so
	@cp libgetemployee_v2.so libgetemployee.so
	@./printemployees_v1 || true

	@echo RUNNING printemployee_v2 against libgetemployee_v1.so
	@rm -f libgetemployee.so
	@cp libgetemployee_v1.so libgetemployee.so
	@./printemployees_v2 || true

clean:
	rm -f libgetemployee_v1.so libgetemployee_v2.so libgetemployee.so printemployees_v1 printemployees_v2



