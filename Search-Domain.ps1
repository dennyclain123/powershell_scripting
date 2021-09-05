[CmdletBinding()]
    PARAM(
        [Parameter(
            ValueFromPipelineByPropertyName=$true,
            ValueFromPipeline=$true)]
        [Alias("Computer")]
        [String[]]$ComputerName,

        [Alias("ResultLimit","Limit")]
        [int]$SizeLimit='100',

        [Parameter(ValueFromPipelineByPropertyName=$true)]
        [Alias("Domain")]
        [String]$DomainDN=$(([adsisearcher]"").Searchroot.path),

        [Alias("RunAs")]
        [System.Management.Automation.Credential()]
        $Credential = [System.Management.Automation.PSCredential]::Empty

    )#PARAM

    PROCESS{
        if ($ComputerName){
            Write-Verbose -Message "One or more ComputerName specified"
            foreach ($item in $ComputerName){
                try{
                    # Building the basic search object with some parameters
                    Write-Verbose -Message "COMPUTERNAME: $item"
                    $Searcher = New-Object -TypeName System.DirectoryServices.DirectorySearcher -ErrorAction 'Stop' -ErrorVariable ErrProcessNewObjectSearcher
                    $Searcher.Filter = "(&(objectCategory=Computer)(name=$item))"
                    $Searcher.SizeLimit = $SizeLimit
                    $Searcher.SearchRoot = $DomainDN

                    # Specify a different domain to query
                    if ($PSBoundParameters['DomainDN']){
                        if ($DomainDN -notlike "LDAP://*") {$DomainDN = "LDAP://$DomainDN"}#if
                        Write-Verbose -Message "Different Domain specified: $DomainDN"
                        $Searcher.SearchRoot = $DomainDN}#if ($PSBoundParameters['DomainDN'])

                    # Alternate Credentials
                    if ($PSBoundParameters['Credential']) {
                        Write-Verbose -Message "Different Credential specified: $($Credential.UserName)"
                        $Domain = New-Object -TypeName System.DirectoryServices.DirectoryEntry -ArgumentList $DomainDN,$($Credential.UserName),$($Credential.GetNetworkCredential().password) -ErrorAction 'Stop' -ErrorVariable ErrProcessNewObjectCred
                        $Searcher.SearchRoot = $Domain}#if ($PSBoundParameters['Credential'])

                    # Querying the Active Directory
                    Write-Verbose -Message "Starting the ADSI Search..."
                    foreach ($Computer in $($Searcher.FindAll())){
                        Write-Verbose -Message "$($Computer.properties.name)"
                        New-Object -TypeName PSObject -ErrorAction 'Continue' -ErrorVariable ErrProcessNewObjectOutput -Property @{
                            "Name" = $($Computer.properties.name)
                            "DNShostName"    = $($Computer.properties.dnshostname)
                            "Description" = $($Computer.properties.description)
                            "OperatingSystem"=$($Computer.Properties.operatingsystem)
                            "WhenCreated" = $($Computer.properties.whencreated)
                            "DistinguishedName" = $($Computer.properties.distinguishedname)}#New-Object
                    }#foreach $Computer

                    Write-Verbose -Message "ADSI Search completed"
                }#try
                catch{
                    Write-Warning -Message ('{0}: {1}' -f $item, $_.Exception.Message)
                    if ($ErrProcessNewObjectSearcher){Write-Warning -Message "PROCESS BLOCK - Error during the creation of the searcher object"}
                    if ($ErrProcessNewObjectCred){Write-Warning -Message "PROCESS BLOCK - Error during the creation of the alternate credential object"}
                    if ($ErrProcessNewObjectOutput){Write-Warning -Message "PROCESS BLOCK - Error during the creation of the output object"}
                }#catch
            }#foreach $item


        }#if $ComputerName
        else {
            Write-Verbose -Message "No ComputerName specified"
            try{
                # Building the basic search object with some parameters
                Write-Verbose -Message "List All object"
                $Searcher = New-Object -TypeName System.DirectoryServices.DirectorySearcher -ErrorAction 'Stop' -ErrorVariable ErrProcessNewObjectSearcherALL
                $Searcher.Filter = "(objectCategory=Computer)"
                $Searcher.SizeLimit = $SizeLimit

                # Specify a different domain to query
                if ($PSBoundParameters['DomainDN']){
                    $DomainDN = "LDAP://$DomainDN"
                    Write-Verbose -Message "Different Domain specified: $DomainDN"
                    $Searcher.SearchRoot = $DomainDN}#if ($PSBoundParameters['DomainDN'])

                # Alternate Credentials
                if ($PSBoundParameters['Credential']) {
                    Write-Verbose -Message "Different Credential specified: $($Credential.UserName)"
                    $DomainDN = New-Object -TypeName System.DirectoryServices.DirectoryEntry -ArgumentList $DomainDN, $Credential.UserName,$Credential.GetNetworkCredential().password -ErrorAction 'Stop' -ErrorVariable ErrProcessNewObjectCredALL
                    $Searcher.SearchRoot = $DomainDN}#if ($PSBoundParameters['Credential'])

                # Querying the Active Directory
                Write-Verbose -Message "Starting the ADSI Search..."
                foreach ($Computer in $($Searcher.FindAll())){
                    try{
                        Write-Verbose -Message "$($Computer.properties.name)"
                        New-Object -TypeName PSObject -ErrorAction 'Continue' -ErrorVariable ErrProcessNewObjectOutputALL -Property @{
                            "Name" = $($Computer.properties.name)
                            "DNShostName"    = $($Computer.properties.dnshostname)
                            "Description" = $($Computer.properties.description)
                            "OperatingSystem"=$($Computer.Properties.operatingsystem)
                            "WhenCreated" = $($Computer.properties.whencreated)
                            "DistinguishedName" = $($Computer.properties.distinguishedname)}#New-Object
                    }#try
                    catch{
                        Write-Warning -Message ('{0}: {1}' -f $Computer, $_.Exception.Message)
                        if ($ErrProcessNewObjectOutputALL){Write-Warning -Message "PROCESS BLOCK - Error during the creation of the output object"}
                    }
                }#foreach $Computer

                Write-Verbose -Message "ADSI Search completed"

            }#try

            catch{
                Write-Warning -Message "Something Wrong happened"
                if ($ErrProcessNewObjectSearcherALL){Write-Warning -Message "PROCESS BLOCK - Error during the creation of the searcher object"}
                if ($ErrProcessNewObjectCredALL){Write-Warning -Message "PROCESS BLOCK - Error during the creation of the alternate credential object"}

            }#catch
        }#else
    }#PROCESS
    end{Write-Verbose -Message "Script Completed"}