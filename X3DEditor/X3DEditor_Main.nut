/**
 * @file X3DEditor_Main.nut
 * @author =EK=UmaR^
 */
 

// load the files
local dir = "X3DEditor/"
local files = [
    "X3DEditor_Utils.nut"
];

foreach (FileName in files) {
    dofile(format("%s%s", dir, FileName));
}



// The class itself

class Sq3DEditor {

    // The id of the element being edited
    static Editing = null;

    // record the type of Editing
    static Type = Sq3DEditorType.POSITION;

    // records the key press
    static KeyPressed = null;

    // the sensivity of the movement
    static sensi = 0.05;

    static function Create3D(elementID) {
        // checking the element passed
        local element = UI.findById(elementID);
        if(!element) return Console.Print("[#ff0000]Error: [#ffffff]Wrong element id is passed.");

        // adding the 3d entity flag

        element.AddFlags(GUI_FLAG_3D_ENTITY);

        // tranforming it to the front of the player

        element.Set3DTransform(::GUI.ScreenPosToWorld(Vector(::GUI.GetScreenSize().X / 2, ::GUI.GetScreenSize().Y / 2, 0)), Vector(1.5675, 3.135, -1.5675), Vector(20, 5, 5));

        // The 3D Tranformation creates it a bit behind the player, lets set that out
        element.Position3D.X -= 5;
        
        // A bit of realigning of the sprite to move it to the center
        element.Position3D.Y -= 10;
        element.Position3D.Z += 5

        // storing the ID of the element being edited
        Sq3DEditor.Editing <- elementID;

        Console.Print("[#33ff33]Scs: [#ffffff]Element is in 3d now.");
    }


    // The function to fun constantly
    static function Process() {
    
        // check if element is being edited
        if(Sq3DEditor.Editing == null) return;

        // check if any key is pressed
        if(Sq3DEditor.KeyPressed == null) return;
        // get the element
        local e = UI.findById(Editing);

        local sensi = sensi.tofloat();

        // check if the player demanded stopping
        if(Sq3DEditor.KeyPressed == Sq3DEditorKey.StopKey)
        {
            Sq3DEditor.Editing <- null;
            Sq3DEditor.KeyPressed <- null;
            Console.Print("[#33ff33]Info: [#ffffff]Editing stopped.");
            // create the header of the text
            local Maintext = "UI." + (typeof e).slice(3, (typeof e).len()) + "(\"" + e.id + "\")";

            // add the flag
            local text = Maintext + ".AddFlags(GUI_FLAG_3D_ENTITY);\n";
            // set the position
            text += Maintext + ".Position3D = Vector(" + e.Position3D.X + ", " + e.Position3D.Y + ", " + e.Position3D.Z + ");\n";
            // set the rotation
            text += Maintext + ".Rotation3D = Vector(" + e.Rotation3D.X + ", " + e.Rotation3D.Y + ", " + e.Rotation3D.Z + ");\n";
            // set the size
            text += Maintext + ".Size3D = Vector(" + e.Size3D.X + ", " + e.Size3D.Y + ", " + e.Size3D.Z + ");";
            Console.Print(text);

            // copying the text to the clipboard
            System.SetClipboardText(text);
            Console.Print("[#33ff33]Scs: [#ffffff]Copied to clipboard!");

        }
        // changing the position / rotation / Size on keypress
        switch(Sq3DEditor.Type)
        {
            case Sq3DEditorType.POSITION:
                switch(Sq3DEditor.KeyPressed)
                {
                    case Sq3DEditorKey.Backward:
                        e.Position3D.X += sensi;
                    break;
                    case Sq3DEditorKey.Forward:
                        e.Position3D.X -= sensi;
                    break;
                    case Sq3DEditorKey.Right:
                        e.Position3D.Y += sensi;
                    break;
                    case Sq3DEditorKey.Left:
                        e.Position3D.Y -= sensi;
                    break;
                    case Sq3DEditorKey.PosRise:
                        e.Position3D.Z += sensi;
                    break;
                    case Sq3DEditorKey.PosFall:
                        e.Position3D.Z -= sensi;
                    break;
                }
            break;
            case Sq3DEditorType.ROTATION:
                switch(Sq3DEditor.KeyPressed)
                {
                    case Sq3DEditorKey.Forward:
                        e.Rotation3D.X += sensi;
                    break;
                    case Sq3DEditorKey.Backward:
                        e.Rotation3D.X -= sensi;
                    break;
                    case Sq3DEditorKey.Right:
                        e.Rotation3D.Y += sensi;
                    break;
                    case Sq3DEditorKey.Left:
                        e.Rotation3D.Y -= sensi;
                    break;
                    case Sq3DEditorKey.RotSlideRight:
                        e.Rotation3D.Z += sensi;
                    break;
                    // since with the delete key, we will use page down, we will use the old keybind
                    case Sq3DEditorKey.PosFall:
                        e.Rotation3D.Z -= sensi;
                    break;
                }
            break;
            case Sq3DEditorType.SIZE:
                switch(Sq3DEditor.KeyPressed)
                {
                    case Sq3DEditorKey.Right:
                        e.Size3D.X += sensi;
                    break;
                    case Sq3DEditorKey.Left:
                        e.Size3D.X -= sensi;
                    break;
                    case Sq3DEditorKey.Backward:
                        e.Size3D.Y += sensi;
                    break;
                    case Sq3DEditorKey.Forward:
                        e.Size3D.Y -= sensi;
                    break;
                }
            break;
        }
    }
}


// register all the keybinds

foreach (idx, Key in Sq3DEditorKey ) {
    UI.registerKeyBind({
        name = Key
        kp= KeyBind(Sq3DEditorKeyID[idx])
        onKeyUp = function() {
            // remove keypress to disable the movement
            Sq3DEditor.KeyPressed <- null;
        }
        onKeyDown = function() {
            // add the keypress name to start movement
            if(Sq3DEditor.Editing) Sq3DEditor.KeyPressed <- this.name;
        }
    })
}

// register Keybinds for the type change
foreach (idx, Key in Sq3DEditorType) {
    // made a local variable to store the value otherwise each keybind would have the same and the last value
    local i = Key;

    UI.registerKeyBind({
        name = idx
        kp= KeyBind(Sq3DEditorTypeKeyID[idx])
        onKeyDown = function() {
            if(Sq3DEditor.Editing)
            {
                Console.Print("[#33ff33]Info: [#ffffff]Editing object's " + this.name.tolower() + ".");
                // swithcing between position / rotation / size
                Sq3DEditor.Type <- i;
            }
        }
    })
}