class Revision < ApplicationRecord
  belongs_to :user, class_name: 'RemoteUser'

  # FIXME: have item_class, not item_type
  belongs_to :item, polymorphic: true

  serialize :body, JSON

  def get key
    body[key] || body[key.camelize(:lower)]
  end

  def item
    @item ||= item_class.constantize.find_by id: item_id
  end
end
