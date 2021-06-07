deploy:
	az deployment sub create \
		--location australiaeast
		--template-file main.bicep \
		--parameters baseRgName=purviewlab \
		--parameters location=australiaeast \
		--parameters numberOfDeployments=10