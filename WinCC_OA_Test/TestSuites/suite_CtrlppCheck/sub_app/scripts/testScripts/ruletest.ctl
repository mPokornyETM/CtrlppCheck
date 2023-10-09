void main()
{
  if ( strlen(a) == 0 )
    DebugN("abc");
  if ( strlen(a) > 1 )
    DebugN("abc");
  if ( strlen(a) > 0 )
    DebugN("abc");
	
  for(int i = 1; i <= 10; i++)
  {
    anytype value;
    dpGet("abc", value);
  }
  
  bool value;
  while(!value)
  {
    dpGet("abc", value);
  }
  while(!value)
  {
    // dpGet("abc", value);
  }
  
  try
  {
  }
  catch
  {
  }

  // check for FATAL execution
  // general it is OK to use fatal logs. But it shall be checked manually if it is correct,
  // because the program will exit at this code line(s)
  throwError(makeError("", PRIO_FATAL, ERR_CONTROL, 0));
  throwError(makeError("", PRIO_FATAL, ERR_CONTROL, 0, "note1"));
  throwError(makeError("", PRIO_FATAL, ERR_CONTROL, 0, "note1", "note2"));
  throwError(makeError("", PRIO_FATAL, ERR_CONTROL, 0, "note1", "note2", "note3"));
  // this is OK
  throwError(makeError("", PRIO_SEVERE, ERR_CONTROL, 0, "note1", "note2", "note3"));
  throwError(makeError("", PRIO_WARNING, ERR_CONTROL, 0, "note1", "note2", "note3"));
  throwError(makeError("", PRIO_INFO, ERR_CONTROL, 0, "note1", "note2", "note3"));

  // check system() call
  // 1. qouted params
  // wrong way
  system("someProgam --help");
  string cmd = "someProgram --help";
  system(cmd);
  // correct way
  dyn_string progAndArgs = makeDynString("someProgram", "--help");
  system(progAndArgs);
  mapping options	= makeMapping("program", "someProgram", "arguments", makeDynString("--help"));
  system(options);


  // 2. it is unsafe to call programs outside WinCC OA scope
  // therefor the developer shall check if this call might be unsafe or not
  system(options);
}