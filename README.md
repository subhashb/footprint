# Footprint

**Footprint** is a **MongoDB-backed** versioning system for those **Big Applications** which have a need for storing

* Huge amounts of Version data for auditing purposes
* All states of a record for analysis by BI tools

But struggle because they cannot

* Use a simple database system due to performance constraints
* Shift to a NoSQL DB completely because of transaction requirements

Footprint integrates seamlessly into your ActiveRecord-driven Rails Application, effectively converting it into a Hybrid application, storing only version data (or **Impressions**, as they are called) in a MongoDB database.

## Installation

Add Footprint to your Gemfile:
    
```ruby
gem "footprint", "1.0.0.rc2"
```

Generate mongoid.yml if you don't have one in your project already

```bash
$ rails g mongoid:config
```

Modify your config/application.rb to use ActiveRecord generators by default

```ruby
config.generators do |g| 
  g.orm :active_record 
end
```

Add a special lookup for Mongoid gem: (will be removed when Mongoid 3.1.0 is released)

```ruby
gem "mongoid", :git => 'git@github.com:mongoid/mongoid.git'
```
    
## Setting Up Documents for your ActiveRecord models

Generate a document from an existing ActiveRecord Model

```bash
$ rails g footprint:document User
```

Add `leave_a_track` to your Model class

```ruby
class User < ActiveRecord::Base
  leave_a_track
  attr_accessible :name, :dob
end
```

## Handling Impressions

### Querying

Impressions (a.k.a versions) of a record are accessible through `impressions` attribute

```ruby
u = User.find(1)
u.impressions
```

### Collecting values

Collecting specific values in Impressions too is very similar to normal AR model behavior

```ruby
u = User.find(1)
u.impressons.collect { |imp| imp.name }
```

### Reviving a copy of the parent

Converting an Impression to an ActiveRecord model, to mirror the parent can be done via `as_parent` method

```ruby
User.create("name" => "Subhash", "join_date" => 2.days.ago) # User:1
u = User.find(1)
u.impressions.count # 1
u.name = "Subhash Bhushan"
u.save
u.impressions.count # 2
User copy_of_user_1 = u.impressions.last.as_parent
```

### Sorting

```ruby
p.impressions.asc(:updated_at)
p.impressions.order_by(:updated_at.asc)
p.impressions.desc(:updated_at)
```

For a complete list of sorting options: [Mongoid Sorting](http://mongoid.org/en/origin/docs/options.html#sorting)
    
### Pagination

`Kaminari` is the preferred way to paginate mongoid documents. `will_paginate_mongoid` gem is an option for those who already use `will_paginate`.
* [will_paginate_mongoid](https://github.com/lucasas/will_paginate_mongoid)
* [kaminari](https://github.com/amatsuda/kaminari) ([Example](http://code.dblock.org/mongoid-202-dropped-pagination-kaminari))

## Enabling/Disabling Footprint globally

Footprint is enabled by default. If you want to disable it globally, just include the following snippet in an environment file (like config/environments/development.rb or config/environments/test.rb)

```ruby
config.after_initialize do
  Footprint.enabled = false
end
```

## Setting up MongoDB

Getting a MongoDB instance up and running is pretty simple.
Visit [Installation Guides](http://docs.mongodb.org/manual/installation/) to set up one for your OS.

The tutorial [Getting Started with MongoDB Development](http://docs.mongodb.org/manual/tutorial/getting-started/) explains basics of connecting to a MongoDB instance and querying on collections

## Known Issues

* If you get a message that "ActiveRecord model 'Project' was not found" while generating a document, do `rake db:migrate` and then try generating the document again.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Inspirations

* [Paper Trail](https://github.com/airblade/paper_trail)
* [Mongoid](mongoid.org/en/mongoid/index.html)

## Resources

* MongoDB
  * [Why MongoDB](https://speakerdeck.com/jnunemaker/why-mongodb-is-awesome)
  * [Installation](http://docs.mongodb.org/manual/installation/)
  * [Hybrid Applications](http://www.slideshare.net/spf13/hybrid-mongodb-and-rdbms-applications)
* [Versioning Strategies](http://blog.jondh.me.uk/2011/11/relational-database-versioning-strategies/)