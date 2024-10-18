#
# Module manifest for module 'KubeSnapIt'
#
# Generated by: Richard Hooper
#
# Generated on: 14/10/2024
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'KubeSnapIt.psm1'

# Version number of this module.
ModuleVersion = '0.0.2'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '086ed606-6f52-449c-9998-fc02efc0a347'

# Author of this module
Author = 'Richard Hooper'

# Company or vendor of this module
CompanyName = 'Pixel Robots'

# Copyright statement for this module
Copyright = '(c) Richard Hooper. All rights reserved.'

# Description of the functionality provided by this module
Description = 'A tool to create, manage, and restore snapshots of Kubernetes objects, providing peace of mind during cluster operations.'

# Minimum version of the PowerShell engine required by this module
# PowerShellVersion = ''

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# ClrVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = 'Invoke-KubeSnapIt'

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = '*'

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = '*'

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @('Kubernetes', 'PowerShell', 'Windows', 'DevOps', 'KubeSnapIt', 'Snapshots', 'Backup', 'Restore', 'K8s', 'K8sSnapshots','diff')

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/KubeDeckio/KubeSnapIt/blob/main/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/KubeDeckio/KubeSnapIt/'

        # A URL to an icon representing this module.
        IconUri = 'https://github.com/KubeDeckio/KubeSnapIt/blob/main/images/KubeSnapIt.png'

        # ReleaseNotes of this module
        ReleaseNotes = 'https://github.com/KubeDeckio/KubeSnapIt/blob/main/README.md'

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        RequiredModules = @(@{ModuleName="powershell-yaml"; ModuleVersion="0.4.2"})

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

