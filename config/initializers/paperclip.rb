Paperclip::Attachment.default_options[:storage] = :s3
Paperclip::Attachment.default_options[:s3_credentials] = "#{Rails.root}/config/s3.yml"
Paperclip::Attachment.default_options[:s3_permissions] = :public_read
Paperclip::Attachment.default_options[:s3_protocol] = "https"
