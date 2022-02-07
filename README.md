# rimjob

This is a mod for FiveM / GTA V that aims to create some more depth top the car boosting scene (PVP).

## Features:
* Stealing Players custom Rims
* You can steal players wheels and put them on your vehicle, pretty straight forward
* Metadata in the item is stored when the wheels  are removed so you can then use them on another vehicle


## Configuration

You can change the default wheels, the progress bar times and animations if you know what you're doing

## Compatibility
Since its been developed for a server running on a customised QBUS framework it's been adapted to run on the latest qb-core release

## Download

https://github.com/sgtherbz/stolenrims

## Installation
* Go to your inventory app.js and locate the function "FormatItemInfo" and find a long list of elseif statements relating to formatting items meta
    Find a place to add the following line :

            "}else if (itemData.name == "stolenrims") {
                $(".item-info-title").html('<p>'+itemData.label+'</p>')
                $(".item-info-description").html('<p>'+ itemData.info.label + '</span></p><p><strong>Type: </strong><span>' + itemData.info.wheeltype + '</span></p><p><strong>Index: </strong><span>' + itemData.info.wheelindex +'</p>');
            
    (It will vary from inventory to inventory where exactly your functin is located but the basic use of metadata I believe remains the same troughout)
* Added the png files in the img folder
* Added these items to your shared.lua
	["stolenrims"] 					 = {["name"] = "stolenrims", 					["label"] = "Rims", 					["weight"] = 20000, 	["type"] = "item", 		["image"] = "stolenrims.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Nice set of rims."},
	["stolenrims2"] 				 = {["name"] = "stolenrims2", 					["label"] = "Scrapyard Rims", 			["weight"] = 20000, 	["type"] = "item", 		["image"] = "stolenrims2.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Not so nice set of scrapyard rims."},
	["rimtool"] 					 = {["name"] = "rimtool", 						["label"] = "Universal Socket", 		["weight"] = 10000, 	["type"] = "item", 		["image"] = "stolenrims3.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Handy tool for removing locknuts from wheels."},
  
* ensure rpbase-rimjob
* use the item near a vehicle that hasn't got stock wheels on


If you run a FiveM server, you know what to do... but these are the basic instructions, in case you forgot:

* Copy the resource to your Resources folder
* Add a line to your cfg: ensure [foldername]
* Restart server or
* Refresh + ensure [foldername]

Where [foldername] is the folder in Resources where the .lua files are located.


## Disclaimer
* As a full time developer for a unique server suport won't be offered its pretty straight forward how this works
