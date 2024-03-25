param(
    [Parameter(Mandatory=$true)]
    [System.String]
    $Project,

    [System.String] $SingleFile = 'true'
)

if (!(Get-Command -ErrorAction Ignore -Type Application dotnet)) {
    Write-Warning 'dotnet was not found'
    Write-Host 'you have to install .NET SDK 7.0 to build this application'
    Write-Host 'you can download it here https://dotnet.microsoft.com/en-us/download/dotnet/'
    return
}

$ErrorActionPreference = "Stop"

if(Test-Path -Path $Project -PathType Leaf)
{
    $projectName = [System.IO.Directory]::GetParent($Project).Name
}
elseif(Test-Path -Path $Project -PathType Container)
{
    $projectName = (Get-Item $Project).Name
}
else
{
    Write-Warning "sprecified project '$Project' does not exist"
    return
}

if (($projectName -ne 'AvaloniaApplication1.Android') -and ($projectName -ne 'AvaloniaApplication1.Desktop'))
{
    Write-Warning "'$Project' is not supported"
    return
}

if ($projectName -eq 'AvaloniaApplication1.Android')
{
    dotnet publish $Project --configuration Release --output publish/android --runtime android-arm64 --self-contained --property:JavaSdkDirectory="c:\Program Files (x86)\Android\openjdk\jdk-17.0.8.101-hotspot"
}
elseif ($projectName -eq 'AvaloniaApplication1.Desktop')
{
    dotnet publish $Project --configuration Release --output publish/desktop --runtime win-x64 --self-contained --property:DebugType=None --property:DebugSymbols=false --property:IncludeNativeLibrariesForSelfExtract=true --property:PublishSingleFile=$SingleFile
}
