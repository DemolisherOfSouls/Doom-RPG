
cd "Choices\Compile\"

for %%f in (.\*) do (
"D:\Programs\ACC\acc.exe" %%f
move /y "%%~nf.o" "..\ACS\%%~nf.acs_o"
)

pause