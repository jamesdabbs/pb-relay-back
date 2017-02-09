class TraitsController < ApplicationController
  before_action :set_json

  def index
    spaces = Space.
               limit(params[:spaces]).
               each_with_object({}) do |s,h|
      h[s.id] = s.name
    end

    properties = Property.
                   limit(params[:properties]).
                   each_with_object({}) do |p,h|
      h[p.id] = p.name
    end

    yes = Value.find_by name: "True"

    traits = {}
    Trait.find_each do |t|
      next unless spaces[t.space_id] && properties[t.property_id]
      traits[t.space_id] ||= {}
      traits[t.space_id][t.property_id] = {
        value:   t.value_id == yes.id,
        deduced: t.deduced
      }
    end

    render json: {
      spaces:     spaces,
      properties: properties,
      traits:     traits
    }
  end
end
