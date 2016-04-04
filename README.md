# Garry's Mod Easy Addon Uploader

## Instructions

1. Create *the folder of your addon* in *garrysmod\addons* and place files in it.

2. Create a thumbnail for your addon: picture of 512x512 pixels.
Save it as a JPEG image in *the folder of your addon* and name it the same as *the folder of your addon*.
Choose quality 100 if possible.

3. Place *Upload.cmd* in *the folder of your addon*.

4. Run *Upload.cmd* and follow instructions until the window closes automatically.

If you do not want to place the addon in your *garrysmod\addons* folder then you need to make sure that the *GarrysMod* path is correct by editing *Upload.cmd*.

## Common issues

* *GMad* tells me that I have files that are not allowed by whitelist!
 * Remove useless files or blacklist them with the `"ignore"` section of your *addon.json*.
 * **Models** must be placed somewhere in the *models* folder.
 * **Sounds** must be placed somewhere in the *sound* folder.
 * **Materials**, textures and PNG images must be placed somewhere in the *materials* folder.
 * **Lua scripts** must be placed somewhere in the *lua* folder.
 * **Vehicle scripts** must be placed in the *scripts\vehicles* folder.
 * **Fonts** must be placed in the *resource\fonts* folder.
 * etc.
* I accidentally closed the window when it asked for the UID, I removed the *workshop_id.cmd*, or I mistyped the UID!
 * Create or edit the file *workshop_id.cmd*.
 * Place this code inside: `set WorkshopId=000000000`
 * Replace `000000000` by the UID of your addon. You can see it in the URL of your Workshop addon.
* I made a mistake in my *addon.json*, how do I re-generate it?
 * Remove *addon.json*. You will have to enter information again.

## Links

* [GMad usage](https://www.facepunch.com/showthread.php?t=1242185)
* [GMPublish usage](https://www.facepunch.com/showthread.php?t=1244179)
