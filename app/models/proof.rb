class Proof < Struct.new(:theorems, :traits)
  def as_json *_
    {
      theorems: theorems.map do |t|
        {
          uid:  t.id,
          name: t.name
        }
      end,
      traits: traits.map do |t|
        {
          uid: t.id,
          property: {
            uid:  t.property.id,
            name: t.property.name
          },
          value: t.value_id == Universe.true_id
        }
      end
    }
  end
end
