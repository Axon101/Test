# Connect to your SharePoint site
Connect-PnPOnline -Url "https://wkx8x.sharepoint.com/" -UseWebLogin

# Get all sites and filter by URL containing "work sites"
$sites = Get-PnPTenantSite | Where-Object { $_.Url -like "*sites*" }

# Display the filtered sites
$sites | Format-Table -Property Url, Title, Template

# Loop through each site and retrieve navigation links
foreach ($site in $sites) {
    Write-Host "Site: $($site.Title)"
    
    # Connect to the current site
    Connect-PnPOnline -Url $site.Url -UseWebLogin
    
    # Get navigation links for the current site
    $navigationLinks = Get-PnPNavigationNode -Location TopNavigationBar
    
    # Display navigation links
    foreach ($link in $navigationLinks) {
        Write-Host "Navigation Link: $($link.Title) - URL: $($link.Url)"
    }
	
	# Get navigation links for the current site
    $quickLinks = Get-PnPNavigationNode -Location QuickLaunch
    
    # Display navigation links
    foreach ($link in $quickLinks) {
        Write-Host "Quick Link: $($link.Title) - URL: $($link.Url)"
    }
	
	# Get navigation links for the current site
    $footerLinks = Get-PnPNavigationNode -Location Footer
    
    # Display navigation links
    foreach ($link in $footerLinks) {
        Write-Host "Footer Link: $($link.Title) - URL: $($link.Url)"
    }
}

# Disconnect from SharePoint site
Disconnect-PnPOnline
