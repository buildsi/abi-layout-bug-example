#include "GetEmployees.h"

Employee *getDinosaur() {
   Employee *vanessa = new Employee();
   vanessa->employeeid = 1234;
   vanessa->vacationdays = 95;
   vanessa->name = "Vanessasaurus";
   vanessa->division = "Livermore Computing";
   return vanessa;
}
