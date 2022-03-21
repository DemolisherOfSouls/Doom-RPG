
cd "..\Choices\Compile\"

for %%f in (.\*) do (
acc %%f
move /y "%%~nf.o" "..\ACS\%%~nf.acs_o"
)

pause
