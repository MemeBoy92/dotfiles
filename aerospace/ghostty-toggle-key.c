#include <ApplicationServices/ApplicationServices.h>

int main(void) {
    CGEventSourceRef source = CGEventSourceCreate(kCGEventSourceStateHIDSystemState);

    // Virtual key 0x32 = Grave Accent (` / ~ / backquote)
    CGEventRef down = CGEventCreateKeyboardEvent(source, 0x32, true);
    CGEventRef up   = CGEventCreateKeyboardEvent(source, 0x32, false);

    // Modifier flags: Cmd (Super) + Ctrl + Alt (Option) + Shift
    CGEventFlags flags = kCGEventFlagMaskCommand | 
                         kCGEventFlagMaskControl | 
                         kCGEventFlagMaskAlternate | 
                         kCGEventFlagMaskShift;

    CGEventSetFlags(down, flags);
    CGEventSetFlags(up, flags);

    // Post to Annotated Session Event Tap to trigger global hotkeys reliably
    CGEventPost(kCGAnnotatedSessionEventTap, down);
    CGEventPost(kCGAnnotatedSessionEventTap, up);

    CFRelease(down);
    CFRelease(up);
    if (source) CFRelease(source);
    return 0;
}
