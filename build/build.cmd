@echo off
@REM Run build.sh with Git-Bash on Windows.
set git_path=C:\Program Files\Git\cmd\git.exe
for /f "delims=" %%F in ('where git') do set git_path=%%F
set git_path=%git_path:~0,-12%\bin\bash.exe
%git_path% %~dp0"/build.sh"