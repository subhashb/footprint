# Overview

## 1.0.0.rc3 (branch: master)

### New Features

* Allow enabling/disabling of Footprint at Global level

        config.after_initialize do
          Footprint.enabled = false
        end
        
* Rake tasks for loading and extracting Impressions

        rake footprint:load[User] 
        rake footprint:extract[User]
        
* Store changes alone, during updates

* Option at model level to choose full record storage
        leave_a_track :impression_type => 'full'