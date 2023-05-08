data "archive_file" "query_blacklist" {
  type        = "zip"
  source_dir = "../app/query-blacklist/"
  output_path = "../app/dist/query-blacklist.zip"
}