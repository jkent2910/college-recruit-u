class Photo < ActiveRecord::Base
  belongs_to :college

  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "missing.png"
  validates_attachment :photo,
                       content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
                       size: { less_than: 2.megabytes }
end
