// Wait, then transition to the other room. An instance sits in both demo
// rooms, so the demo ping-pongs. goto() no-ops while a transition is active.
alarm[0] = 150;   // ~2.5s at 60fps
