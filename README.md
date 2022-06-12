# ADD THIS IN qb-inventory/html/js/app.js (Line 577)

```lua
        } else if (itemData.name == "stickynote") {
            $(".item-info-title").html('<p>' + itemData.label + '</p>')
            $(".item-info-description").html('<p>' + itemData.info.label + '</p>');
        } else if (itemData.name == "rentalpapers") {
            $(".item-info-title").html('<p>' + itemData.label + '</p>')
            $(".item-info-description").html('<p><strong>Name: </strong><span>'+ itemData.info.firstname + '</span></p><p><strong>Last Name: </strong><span>'+ itemData.info.lastname+ '</span></p><p><strong>Plate: </strong><span>'+ itemData.info.plate + '<p><strong>Model: </strong><span>'+ itemData.info.model +'</span></p>');
```

# ADD THIS IN qb-core/shared/items.lua

```lua
      ["rentalpapers"]                 = {["name"] = "rentalpapers",                     ["label"] = "Документи за наем на кола",             ["weight"] = 50,         ["type"] = "item",         ["image"] = "rentalpapers.png",         ["unique"] = true,         ["useable"] = false,     ["shouldClose"] = false,     ["combinable"] = nil,     ["description"] = "Лицето притежава автомобил под наем."},
```

Dependencies:
* [qb-core](https://github.com/qbcore-framework/qb-core)
* [qb-target](https://github.com/BerkieBb/qb-target)
* [nh-context](https://github.com/qbcore-framework/qb-menu)


![image](https://user-images.githubusercontent.com/64840882/173235128-6f68e71b-28fb-475b-af60-246d610db5dc.png)
![image](https://user-images.githubusercontent.com/64840882/173235140-b6da1ffb-4b73-4716-84c2-e80b45a3f773.png)
![image](https://user-images.githubusercontent.com/64840882/173235146-564d5db8-e0bc-479d-b869-b8e3a5431899.png)