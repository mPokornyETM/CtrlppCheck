// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright Copyright 2023 SIEMENS AG
             SPDX-License-Identifier: GPL-3.0-only
  @author mPokorny
*/

// Libraries used (#uses)
#uses "classes/projectEnvironment/ProjEnvComponent"
#uses "classes/projectEnvironment/ProjEnvProject"
#uses "classes/globalStorage/GlobalStorage"

//-----------------------------------------------------------------------------
/**Generate a full documentation from the project files. See also DoxygenGenerator
*/
void main()
{
  const string sourcePathRoot = dirName(PROJ_PATH);
//   const string sourcePathTests = sourcePathRoot + "WinCC_OA_Test/";
  const string sourcePathQualityChecks = sourcePathRoot + "WinCCOA_QualityChecks/";
  const string sourcePathDocs = sourcePathRoot + "docs/";
  const string target = sourcePathRoot + "help/";

  DebugTN("sourcePathRoot", sourcePathRoot);
  DebugTN("sourcePathQualityChecks", sourcePathQualityChecks);
  DebugTN("sourcePathDocs", sourcePathDocs);
  DebugTN("target", target);
  
  rmdir(target, TRUE);

  /// create a dummy helper project.
  // we need to compose all necessary sources and then
  // start doxygen.ctl with some one WinCC OA project

  ProjEnvProject helpProject = ProjEnvProject("WinCCOA_QualityChecks_help");
  helpProject.setInstallDir(dirName(PROJ_PATH));
  helpProject.setVersion(VERSION);
  helpProject.setRunnable(FALSE);
  helpProject.setPackageSelection(ProjEnvProjectPackageSelection::EmptyDb);
  helpProject.setName(helpProject.getId());
  helpProject.setLanguages(makeDynString("en_US.utf8"));

  // if exists for some reason, just remove it
  if (helpProject.exists())
    helpProject.deleteProj();

  helpProject.create();

  rmdir(helpProject.getDir() + SCRIPTS_REL_PATH, true);
  copyAllFilesRecursive(sourcePathQualityChecks + SCRIPTS_REL_PATH, helpProject.getDir() + SCRIPTS_REL_PATH);
  rmdir(helpProject.getDir() + PICTURES_REL_PATH, true);
  copyAllFilesRecursive(sourcePathQualityChecks + PICTURES_REL_PATH, helpProject.getDir() + PICTURES_REL_PATH);
  rmdir(helpProject.getDir() + DATA_REL_PATH, true);
  copyAllFilesRecursive(sourcePathQualityChecks + DATA_REL_PATH + "qualityGates", helpProject.getDir() + DATA_REL_PATH + "qualityGates");

  copyAllFilesRecursive(sourcePathDocs + "projectDocu", helpProject.getDir() + DATA_REL_PATH + "projectDocu");
  copyAllFilesRecursive(sourcePathDocs + "docuSources", helpProject.getDir() + DATA_REL_PATH + "docuSources");
//   copyFile(sourcePathRoot + "README.md", helpProject.getDir() + DATA_REL_PATH + "docuSources/" + "README.md");

  ProjEnvComponent ctrlMan = ProjEnvComponent(CTRL_COMPONENT);

  ctrlMan.setOptions(makeDynString("-n", "doxygen.ctl"));
  ctrlMan.setProj(helpProject.getId());
  ctrlMan.setNum(101);
  
  GlobalStorage storage;
  storage.setValue("doxygen/projectName", helpProject.getName());
  storage.setValue("doxygen/outputDirectory", target);
  storage.setValue("doxygen/advancedConfig", 1);
  storage.setValue("doxygen/excludePatterns", "*/example*");
  storage.setValue("doxygen/readme", helpProject.getDir() + DATA_REL_PATH + "docuSources/" + "README.md");
  storage.setValue("doxygen/bugLinkFormat", "https://github.com/siemens/CtrlppCheck/issues/%s");
  storage.setValue("doxygen/todoLinkFormat", "https://github.com/siemens/CtrlppCheck/issues/%s");

  const int exitCode = ctrlMan.start();

  copyAllFilesRecursive(helpProject.getDir() + LOG_REL_PATH, target + LOG_REL_PATH);

  storage.removeKey("doxygen/projectName");
  storage.removeKey("doxygen/outputDirectory");
  storage.removeKey("doxygen/advancedConfig");
  storage.removeKey("doxygen/excludePatterns");
  storage.removeKey("doxygen/readme");
  storage.removeKey("doxygen/bugLinkFormat");
  storage.removeKey("doxygen/todoLinkFormat");

  helpProject.deleteProj();
  
  if (exitCode != 0)
  {
    throwError(makeError("", PRIO_FATAL, ERR_CONTROL, 54, "doxygen.ctl crashed", exitCode));
  }
}