@ECHO OFF

cd Choices


"%ProgramFiles%\7-Zip\7z.exe" a -tzip ..\Choices.pk3 * -mx9

cd ..\

copy "Choices.pk3" "..\..\..\Doom\RPGv4\Choices.pk3"

pause