class Viewer
  def spaces
    Space.all
  end

  def properties
    Property.all
  end

  def traits
    Trait.includes(:space, :property, :value).all
  end
end
