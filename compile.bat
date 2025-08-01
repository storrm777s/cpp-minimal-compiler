@echo off
for /f %%a in ('echo prompt $E^| cmd') do set "ESC=%%a"
set start=%time%
echo Compiler: ^>^>Compiling...
g++ -I. -Wall *.cpp -o main.exe
set end=%time%
for /f "tokens=1-4 delims=:.," %%a in ("%start%") do set /a startMS=%%a*3600000+%%b*60000+%%c*1000+%%d
for /f "tokens=1-4 delims=:.," %%a in ("%end%") do set /a endMS=%%a*3600000+%%b*60000+%%c*1000+%%d
set /a elapsed=endMS - startMS
if %elapsed% lss 0 set /a elapsed+=86400000
set /a seconds=elapsed / 1000
set /a deci=(elapsed %% 1000) / 100
if %errorlevel% neq 0 (
    echo Compiler: %ESC%[31m^>^>Compilation failed after %ESC%[94m%seconds%.%deci%s%ESC%[0m
) else (

    echo Compiler: %ESC%[92mBuild successful.%ESC%[0m
    echo Compiler: %ESC%[36mCompiled within: %ESC%[94m%seconds%.%deci%s%ESC%[0m
    echo.
    echo Compiler: ^>^>Running main.exe...
    echo Compiler: --------------------
    main.exe
)
echo Compiler: %ESC%[92mFinished running.%ESC%[0m [PRESS ANY KEY TO EXIT]
pause >nul
