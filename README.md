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
