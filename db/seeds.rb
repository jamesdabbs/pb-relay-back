spaces = 20.times.map do |i|
  DB::Space.create! name: "Space #{i}", description: "-"
end

props = 20.times.map do |i|
  DB::Property.create! name: "Property #{i}", description: "-"
end

spaces.each do |s|
  props.sample(rand 15 .. 20).each do |p|
    DB::Trait.create! space: s, property: p, value: ["True", "False"].sample, description: "-"
  end
end
