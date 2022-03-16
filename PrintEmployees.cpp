#include <iostream>
#include <ostream>
#include "GetEmployees.h"

int main(int argc, char *argv[])
{
   Employee *dino = getDinosaur();
   std::cout << "Employee #" << dino->employeeid << " has " << dino->vacationdays << " days of vacation.\n";
   std::flush(std::cout);
   std::cout << "Which is "<< dino->name << " from " << dino->division << "\n";
   return 0;
}
