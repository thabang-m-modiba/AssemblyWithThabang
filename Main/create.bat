@echo off
REM Mr. A. Maganlal
REM Computer Science 3B 2016 - 2025
REM This batch file is setup to be more robust than previous versions
setlocal enabledelayedexpansion
set PROJNAME=%~1
set ERRMSG=

if "%PROJNAME%"=="" (
    echo Usage: create [asmFileNameWithoutExtension]
    echo All asm files must be in the 'src' folder!
    goto END
)

:CLEAN
echo ~~~ Cleaning project ~~~
DEL /S %PROJNAME%.exe %PROJNAME%.ilk %PROJNAME%.pdb %PROJNAME%.lst %PROJNAME%.obj > NUL
IF /I "%ERRORLEVEL%" NEQ "0" (
    set ERRMSG=ERROR Cleaning
    GOTO ERROR
)

:ASSEMBLE
echo ~~~ Assembling project ~~~
.\assembler\ml.exe /coff /Fl /Fo .\bin\%PROJNAME%.obj  /Zi /c .\src\%PROJNAME%.asm
REM Workaround for lst error
move %PROJNAME%.lst .\bin\%PROJNAME%.lst > NUL
IF /I "%ERRORLEVEL%" NEQ "0" (
    set ERRMSG=Assembling ERROR. Check error messages!
    GOTO ERROR
)

:LINK
echo ~~~ Linking project ~~~
.\assembler\link.exe /debug /subsystem:console /entry:start /out:.\bin\%PROJNAME%.exe .\bin\%PROJNAME%.obj .\assembler\kernel32.lib .\assembler\io.lib
IF /I "%ERRORLEVEL%" NEQ "0" (
    set ERRMSG=Linking ERROR. Check error messages!
    GOTO ERROR
)

:RUN
echo ~~~ Running project ~~~
bin\%PROJNAME%.exe
IF /I "%ERRORLEVEL%" NEQ "0" (
    set ERRMSG=Program has crashed. Maybe check the debugger.
    GOTO ERROR
)
GOTO END

:ERROR
powershell -command "Write-Host '### An error has occured ###' -ForegroundColor Red"
powershell -command "Write-Host '%ERRMSG%' -ForegroundColor Red"
pause

:END
echo ~~~ End ~~~