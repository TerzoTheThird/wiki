@echo off
chcp 65001 >nul
cd /d "%~dp0"

where git >nul 2>nul
if errorlevel 1 (
  echo Git is not installed. Get it from https://git-scm.com/download/win and run this again.
  pause
  exit /b 1
)

if not exist ".git" (
  echo This folder is not a git repo yet. Follow the one-time setup first.
  pause
  exit /b 1
)

if not exist ".gitignore" (
  echo .obsidian/> .gitignore
  echo .trash/>> .gitignore
)

git add -A
git commit -m "wiki update %date% %time%"

git push -u origin main
if errorlevel 1 (
  echo.
  echo PUSH FAILED. Read the message above. Your changes are saved locally but NOT on GitHub.
  pause
  exit /b 1
)

echo.
echo Done. Now press Sync on the GitHub repo inside the Claude project.
pause