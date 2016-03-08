h2_version <- "1.3.176"

maven_jar <- function(group_id, artifact_id, version) {
	sprintf("http://search.maven.org/remotecontent?filepath=%s/%s/%s/%s-%s.jar",
		gsub("\\.", "/", group_id), artifact_id, version, artifact_id, version)
}

url <- maven_jar("com/h2database", "h2", h2_version)

# appveyor cannot verify repo1.maven.org's certificate
if (.Platform$OS.type == "windows") {
	options("download.file.extra" = "--no-check-certificate")
}

dest_dir <- "../inst/java"
dest_filename <- sprintf("h2-%s.jar", h2_version)
dest_path <- file.path(dest_dir, dest_filename)

if (!file.exists(dest_path)) {
	dir.create(dirname(dest_path), recursive = TRUE)
	success <- download.file(url, dest_path, method = "wget")
	if (success != 0) {
		stop("Download of h2 jar failed")
	}
}
