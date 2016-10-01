require 'elasticsearch/model'
class Job < ActiveRecord::Base
  attr_writer :current_step

  belongs_to :category
  validates :category, presence: true
  validates :job_title, :description, :headquarters, :apply, :name, :email, presence: true
  has_attached_file :logo, styles: { medium: "300x300>"}
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  def current_step
    @current_step || steps.first
  end

  def steps
    %w[form preview confirmation]
  end

  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end
end
# Delete the previous articles index in Elasticsearch
Job.__elasticsearch__.client.indices.delete index: Job.index_name rescue nil

# Create the new index with the new mapping
Job.__elasticsearch__.client.indices.create \
  index: Job.index_name,
  body: { settings: Job.settings.to_hash, mappings: Job.mappings.to_hash }

Job.import # for auto sync model with elastic search
