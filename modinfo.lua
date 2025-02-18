name = "Deep freezer"
description = "Adds deep dark fantasy freezer to the game!\nA new end game refrigerator that has 12 slots and stops food spoilage."
author = "Erdutya & Buu"
version = "1.0.1"

api_version = 10

priority = -1
dst_compatible = true
all_clients_require_mod = true
client_only_mod = false

icon_atlas = "deep_freezer.xml"
icon = "deep_freezer.tex"

configuration_options =
{
    {
		name = "RECIPE",
		label = "Recipe difficulty",
		hover = "Adjust the recipe.",
		options =	{
						{description = "Normal", data = 0, hover = "2 cutstones; 4 bundle wraps; 1 blue gem;"},
                        {description = "Hard (2 gears)", data = 1, hover = "2 gears; 6 bundle wraps; 2 blue gems;"},
                        {description = "Hard (4 gears)", data = 2, hover = "4 gears; 6 bundle wraps; 2 blue gems;"},
						{description = "Hard (8 gears)", data = 3, hover = "8 gears; 6 bundle wraps; 2 blue gems;"},
                        {description = "Post-lunar", data = 4, hover = "1 restrained static; 2 gears; 4 scraps;"}
					},
		default = 0,
	},
}
