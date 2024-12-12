for /r %%i in (*.vcxproj) do (
    echo %%i
    del "%%i"
)

if exist everything.sln (
    del "everything.sln"
)
