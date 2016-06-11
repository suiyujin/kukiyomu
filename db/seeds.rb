require 'csv'

def make_dummy_data(data)
    data[1..-1].map { |d| Hash[*data[0].zip(d).flatten] }
end

# parents
Parent.create()
p 'parents inserted.'

# children
Child.create(make_dummy_data(CSV.read('db/seed_data/children.csv')))
p 'children inserted.'

# worries
Worry.create(make_dummy_data(CSV.read('db/seed_data/worries.csv')))
p 'worry inserted.'

# bursts
Burst.create(make_dummy_data(CSV.read('db/seed_data/bursts.csv')))
p 'bursts inserted.'

