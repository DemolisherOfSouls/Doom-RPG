@ECHO OFF

cd Choices

"%ProgramFiles%\WinRAR\winrar.exe" a -r -afzip Choices.pk3 *

cd ..\

move /y Choices\Choices.pk3 Debug\Choices.pk3

pause