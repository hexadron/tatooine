Paperclip::Attachment.default_options.merge!(
  storage: :s3,
  s3_credentials: {
    access_key_id: S3[:key],
    secret_access_key: S3[:secret]
  },
  s3_host_name: "s3-sa-east-1.amazonaws.com",
  bucket: S3[:bucket],
  path: "/tatooine/:attachment/:id/:style/:filename",
  default_url: "/images/:style/missing.png",
  styles: {
    medium: "300x300>",
    thumb: "100x100>",
    tile: '225>x127>'
  },
  default_style: :medium
)