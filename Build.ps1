# Step 1: Generate favorites page
Write-Host "Step 1: Generating favorites page..." -ForegroundColor Cyan
.\FavGen\FavGen.exe './' './Pages/Favorites.md'

# Step 2: Validate templates and site generation
Write-Host "`nStep 2: Running site build validation..." -ForegroundColor Cyan
.\PPTail\PPTail.exe `
	'Provider=PPTail.Data.Forestry.Repository;FilePath=.\' `
	'Provider=PPTail.Output.FileSystem.Repository;FilePath=.\docs' `
	'Provider=PPTail.Templates.Yaml.ReadRepository;FilePath=.\Templates' `
	--ValidateOnly

# Gate: Review output before running the full build
Write-Host "`n--- Review the validation output above ---" -ForegroundColor Yellow
$response = Read-Host "Press Enter to run the full site build, or type 'q' to quit"
if ($response -eq 'q') {
    Write-Host "Build cancelled." -ForegroundColor Red
    exit 0
}

# Step 3: Run the full site build
Write-Host "`nStep 3: Running full site build..." -ForegroundColor Cyan
.\PPTail\PPTail.exe `
	'Provider=PPTail.Data.Forestry.Repository;FilePath=.\' `
	'Provider=PPTail.Output.FileSystem.Repository;FilePath=.\docs' `
	'Provider=PPTail.Templates.Yaml.ReadRepository;FilePath=.\Templates'

Write-Host "`nBuild complete." -ForegroundColor Green