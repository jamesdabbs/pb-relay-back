module Page
  Classes = {
    Space    => SpacePage,
    Property => PropertyPage,
    Trait    => TraitPage,
    Theorem  => TheoremPage
  }

  def self.for_revision rev, obj=nil
    for_object obj || rev.item
  end

  def self.for_object obj
    Classes.fetch(obj.class).new obj
  end
end
