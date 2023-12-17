@page FAQs FAQs
  \tableofcontents
  
  
@section faq1 How can I change ... ?
To change the ... are available:
1. By using the config entry ...
2. By setting the environment variable ...

@section faq2 How to use the ... CTRL extension
The ... CTRL extension provides functions that can be used for tests written in CTRL.

... functions list ...

They have the following in common:
+ They display a message in the Log Viewer ... .
+ They return 0 if the ... .
+ Their first parameter must be the test ... .

@section faq3 How to deal with operating system dependencies in test cases?
You can use conditional statements based on the _ANDROID, _IOS, _OSX, _SOLARIS, _UNIX and _WIN32 symbolic constants, the value
of which is either true or false, depending on the operating system being used.

Example
```
const string LINE_BREAK = _WIN32 ? "\r\n" : "\n";
```