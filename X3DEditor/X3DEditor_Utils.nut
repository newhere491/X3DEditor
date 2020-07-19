/**
 * @file X3DEditor_Utils.nut
 * @author =EK=UmaR^
 */

Sq3DEditorKey <- {
    Left            = "Sq3DEditor_Left",
    Forward         = "Sq3DEditor_Forward",
    Right           = "Sq3DEditor_Right",
    Backward        = "Sq3DEditor_Backward",
    PosRise         = "Sq3DEditor_Rise",
    PosFall         = "Sq3DEditor_Fall",
    RotSlideRight   = "Sq3DEditor_RotRight",
    StopKey         = "Sq3DEditor_StopKey"
}

Sq3DEditorKeyID <- {
    Left            = 0x25,
    Forward         = 0x26,
    Right           = 0x27,
    Backward        = 0x28,
    PosRise         = 0x21,
    PosFall         = 0x22,
    RotSlideRight   = 0x2E,
    StopKey         = 0x08
}

enum _Sq3DEditorType {
    POSITION,
    ROTATION,
    SIZE
}

Sq3DEditorTypeKeyID <- {
    POSITION = 0x31,
    ROTATION = 0x32,
    SIZE     = 0x33
}


Sq3DEditorType <- getconsttable().rawget("_Sq3DEditorType");