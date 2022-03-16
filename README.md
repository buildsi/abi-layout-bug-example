# Abi Data Layout

This fake application has an executable and library that respectively print and retrieve employee data.  
In version 1 of the application, the employeeid and vacationdays are 'int' values.  
In version 2 of the application, the employeeid and vacationdays are 'long' values.  
And when you mix the library and executable between v1 and v2, everything blows up.  
Note that there are no symbol problems with mixing libraries -- this ABI bug comes from data layout.

Also note this would be hard to debug in a big application.  
If you mix v1/v2 executable/library and step through the result with a debugger, none of the code looks off. 
It just looks like data magically corrupts itself when the getDinosaur() call returns.

This amazing example brought to you by [@mplegendre!](https://github.com/mplegendre)

## Usage

Run the example:

```bash
$ make
```

And then look at the source files to see the details of what is going on compared to
the output in the console.

```bash
RUNNING printemployee_v1 against libgetemployee_v1.so
Employee #1234 has 95 days of vacation.
Which is Vanessasaurus from Livermore Computing
RUNNING printemployee_v2 against libgetemployee_v2.so
Employee #1234 has 95 days of vacation.
Which is Vanessasaurus from Livermore Computing
RUNNING printemployee_v1 against libgetemployee_v2.so
Employee #1234 has 0 days of vacation.
Segmentation fault (core dumped)
RUNNING printemployee_v2 against libgetemployee_v1.so
Employee #408021894354 has 93897955274440 days of vacation.
Segmentation fault (core dumped)
```

Once you run the above and have the binary, try tracing the last call with gdb:

```bash
gdb ./printemployees_v2
```
```bash
(gdb) run
Starting program: /home/vanessa/Desktop/Code/abidatalayout/printemployees_v2 
Employee #408021894354 has 93824992325320 days of vacation.

Program received signal SIGSEGV, Segmentation fault.
__memmove_avx_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:436
436	../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S: No such file or directory.
```

And the backtrace with "bt"

```gdb
(gdb) bt
#0  __memmove_avx_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:436
#1  0x00007ffff7c64662 in _IO_new_file_xsputn (n=8314053326562812246, data=0xd, f=<optimized out>) at fileops.c:1236
#2  _IO_new_file_xsputn (f=0x7ffff7dc26a0 <_IO_2_1_stdout_>, data=0xd, n=8314053326562812246) at fileops.c:1197
#3  0x00007ffff7c583f1 in __GI__IO_fwrite (buf=0xd, size=1, count=8314053326562812246, fp=0x7ffff7dc26a0 <_IO_2_1_stdout_>)
    at libioP.h:948
#4  0x00007ffff7efa824 in std::basic_ostream<char, std::char_traits<char> >& std::__ostream_insert<char, std::char_traits<char> >(std::basic_ostream<char, std::char_traits<char> >&, char const*, long) () from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
#5  0x00005555555552b6 in main (argc=1, argv=0x7fffffffde98) at PrintEmployees.cpp:10
```

yikes!
