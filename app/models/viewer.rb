class Viewer
  def spaces
    Space.all
  end

  def properties
    Property.all
  end

  def traits
    Trait.
      includes(:space, :property, :value).
      where(space: spaces, property: properties)
  end

  def theorems
    Theorem.all
  end
end
