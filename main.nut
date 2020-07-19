// dofiles
    dofile("decui/decui.nut");
    dofile("X3DEditor/X3DEditor_Main.nut");

function Script::ScriptLoad()  {
    UI.Label({
        id = "newLabelID"  
        Text = "Testing out 3D" 
        FontSize = 100
    })
    Sq3DEditor.Create3D("newLabelID");
}