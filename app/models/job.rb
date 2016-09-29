require 'elasticsearch/model'
class Job < ActiveRecord::Base
  belongs_to :category
  validates :category, presence: true
  has_attached_file :logo, styles: { medium: "300x300>"}
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
end
# Delete the previous articles index in Elasticsearch
Job.__elasticsearch__.client.indices.delete index: Job.index_name rescue nil

# Create the new index with the new mapping
Job.__elasticsearch__.client.indices.create \
  index: Job.index_name,
  body: { settings: Job.settings.to_hash, mappings: Job.mappings.to_hash }

Job.import # for auto sync model with elastic search
