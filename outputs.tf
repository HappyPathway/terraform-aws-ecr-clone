output "images" {
  description = "Final full merge of images with extra details"
  value       = terraform_data.images.output
}

output "image_map" {
  value = {
    for image in terraform_data.images.output : image.name => image... # there might be multiple with the same name. using an ellipsis will group into lists.
  }
}
