data "archive_file" "OnConnectZip" {
  type        = "zip"
  source_dir = "../app/onConnect/"
  output_path = "../app/dist/onConnect.zip"
}

data "archive_file" "OnDisconnectZip" {
  type        = "zip"
  source_dir = "../app/onDisconnect/"
  output_path = "../app/dist/onDisconnect.zip"
}

data "archive_file" "MessageZip" {
  type        = "zip"
  source_dir = "../app/sendMessage/"
  output_path = "../app/dist/sendMessage.zip"
}