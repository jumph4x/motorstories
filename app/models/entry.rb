class Entry
  require 'carrierwave/orm/mongomapper'
  include MongoMapper::EmbeddedDocument

  attr_accessor :pending

  validates :snapshot, :body, :occurred_at, :presence => true, :unless => Proc.new{|e| e.pending }

  def self.categories
    Vehicle.mod_categories + [:journey, :journal]
  end

  mount_uploader :snapshot, SnapshotUploader

  key :category, String

  key :occurred_at, Time
  key :body, String
  key :location, Array

  def pending?
    pending || (!body && !snapshot)
  end
end
