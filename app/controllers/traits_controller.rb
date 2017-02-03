class TraitsController < ApplicationController
  before_action :set_json

  def index
    traits = {}
    Trait.all.includes(:value).find_each do |t|
      traits[t.space_id] ||= {}
      traits[t.space_id][t.property_id] = (t.value.name == "True")
    end

    spaces = Space.find_each.each_with_object({}) do |s,h|
      h[s.id] = s.name
    end

    properties = Property.find_each.each_with_object({}) do |p,h|
      h[p.id] = p.name
    end

    render json: {
      spaces:     spaces,
      properties: properties,
      traits:     traits
    }
  end
end
