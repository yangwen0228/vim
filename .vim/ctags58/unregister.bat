@echo off
setlocal enabledelayedexpansion
echo Windows Registry Editor Version 5.00> register.reg
echo.>>register.reg
echo [-HKEY_LOCAL_MACHINE\SOFTWARE\ctags58\ctags]>> register.reg
echo.>>register.reg
echo [-HKEY_LOCAL_MACHINE\SOFTWARE\ctags58]>> register.reg
regedit /s register.reg
if exist register.reg del register.reg
