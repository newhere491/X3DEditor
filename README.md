# X3DEditor
3D Element editor of DecUI for VCMP (originally made for buildmode)

# Information
This snippet was made to allow people to easily find position, rotation and size of GUIElement in buildmode when converting an element to 3D. This snippet only supports elements made using DecUI.

#  Prerequisite
- [DecUI](https://github.com/newk5/decui/)

# Installation
1. Click the "Clone or download" button, select "Download ZIP".
1. Extract all the "X3DEditor-master/X3DEditor" folder to "store/script/..here"
1. Add the following code into your script:
```javascript
function Script::ScriptLoad() {
    dofile("X3DEditor/X3DEditor_Main.nut");
}

function Script::ScriptProcess() {
    Sq3DEditor.Process();
}
```

# Usage
Refer to the [wiki](https://github.com/newhere491/X3DEditor/wiki)
