class Entry
  require 'carrierwave/orm/mongomapper'
  include MongoMapper::EmbeddedDocument

  attr_accessor :pending

  validates :snapshot, :body, :occurred_at, :presence => true, :unless => Proc.new{|e| e.pending }

  def self.categories
    Vehicle.mod_categories + [:journey, :journal, :bought, :sold]
  end

  mount_uploader :snapshot, SnapshotUploader

  key :category, String

  key :occurred_at, Date
  key :body, String
  key :location, Array

  def pending?
    pending || (!body && !snapshot_filename)
  end
end
