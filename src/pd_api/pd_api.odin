package pd_api

foreign import "pd_api"

import _c "core:c"

PLAYDATEAPI_H :: 1;
pdext_display_h :: 1;
pdext_file_h :: 1;
SEEK_SET :: 0;
SEEK_CUR :: 1;
SEEK_END :: 2;
pdext_gfx_h :: 1;
LCD_COLUMNS :: 400;
LCD_ROWS :: 240;
LCD_ROWSIZE :: 52;
pdext_lua_h :: 1;
pdext_scoreboards_h :: 1;
pdext_sound_h :: 1;
AUDIO_FRAMES_PER_CYCLE :: 512;
NOTE_C4 :: 60;
pdext_sprite_h :: 1;
pdext_sys_h :: 1;

SDFile :: struct {};
LCDPattern :: [16]u8;
LCDColor :: _c.uintptr_t;
lua_State :: rawptr;
lua_CFunction :: #type proc(L : ^lua_State) -> _c.int;
AddScoreCallback :: #type proc(score : ^PDScore, errorMessage : cstring);
PersonalBestCallback :: #type proc(score : ^PDScore, errorMessage : cstring);
BoardsListCallback :: #type proc(boards : ^PDBoardsList, errorMessage : cstring);
ScoresCallback :: #type proc(scores : ^PDScoresList, errorMessage : cstring);
MIDINote :: _c.float;
sndCallbackProc :: #type proc(c : ^SoundSource);
signalStepFunc :: #type proc(userdata : rawptr, ioframes : ^_c.int, ifval : ^_c.float) -> _c.float;
signalNoteOnFunc :: #type proc(userdata : rawptr, note : _c.float, vel : _c.float, len : _c.float);
signalNoteOffFunc :: #type proc(userdata : rawptr, stopped : _c.int, offset : _c.int);
signalDeallocFunc :: #type proc(userdata : rawptr);
synthRenderFunc :: #type proc(userdata : rawptr, left : ^i32, right : ^i32, nsamples : _c.int, rate : u32, drate : i32) -> _c.int;
synthNoteOnFunc :: #type proc(userdata : rawptr, note : _c.float, velocity : _c.float, len : _c.float);
synthReleaseFunc :: #type proc(userdata : rawptr, stop : _c.int);
synthSetParameterFunc :: #type proc(userdata : rawptr, parameter : _c.int, value : _c.float) -> _c.int;
synthDeallocFunc :: #type proc(userdata : rawptr);
SequenceFinishedCallback :: #type proc(seq : ^SoundSequence, userdata : rawptr);
effectProc :: #type proc(e : ^SoundEffect, left : ^i32, right : ^i32, nsamples : _c.int, bufactive : _c.int) -> _c.int;
AudioSourceFunction :: #type proc(_context : rawptr, left : ^i16, right : ^i16, len : _c.int) -> _c.int;
RecordCallback :: #type proc(_context : rawptr, buffer : ^i16, length : _c.int) -> _c.int;
LCDSpriteDrawFunction :: #type proc(sprite : ^LCDSprite, bounds : PDRect, drawrect : PDRect);
LCDSpriteUpdateFunction :: #type proc(sprite : ^LCDSprite);
LCDSpriteCollisionFilterProc :: #type proc(sprite : ^LCDSprite, other : ^LCDSprite) -> SpriteCollisionResponseType;
PDCallbackFunction :: #type proc(userdata : rawptr) -> _c.int;
PDMenuItemCallbackFunction :: #type proc(userdata : rawptr);

PDSystemEvent :: enum i32 {
    kEventInit,
    kEventInitLua,
    kEventLock,
    kEventUnlock,
    kEventPause,
    kEventResume,
    kEventTerminate,
    kEventKeyPressed,
    kEventKeyReleased,
    kEventLowPower,
};

FileOptions :: enum i32 {
    kFileRead = 1,
    kFileReadData = 2,
    kFileWrite = 4,
    kFileAppend = 8,
};

LCDBitmapDrawMode :: enum i32 {
    kDrawModeCopy,
    kDrawModeWhiteTransparent,
    kDrawModeBlackTransparent,
    kDrawModeFillWhite,
    kDrawModeFillBlack,
    kDrawModeXOR,
    kDrawModeNXOR,
    kDrawModeInverted,
};

LCDBitmapFlip :: enum i32 {
    kBitmapUnflipped,
    kBitmapFlippedX,
    kBitmapFlippedY,
    kBitmapFlippedXY,
};

LCDSolidColor :: enum i32 {
    kColorBlack,
    kColorWhite,
    kColorClear,
    kColorXOR,
};

LCDLineCapStyle :: enum i32 {
    kLineCapStyleButt,
    kLineCapStyleSquare,
    kLineCapStyleRound,
};

LCDFontLanguage :: enum i32 {
    kLCDFontLanguageEnglish,
    kLCDFontLanguageJapanese,
    kLCDFontLanguageUnknown,
};

PDStringEncoding :: enum i32 {
    kASCIIEncoding,
    kUTF8Encoding,
    k16BitLEEncoding,
};

LCDPolygonFillRule :: enum i32 {
    kPolygonFillNonZero,
    kPolygonFillEvenOdd,
};

l_valtype :: enum i32 {
    kInt,
    kFloat,
    kStr,
};

LuaType :: enum i32 {
    kTypeNil,
    kTypeBool,
    kTypeInt,
    kTypeFloat,
    kTypeString,
    kTypeTable,
    kTypeFunction,
    kTypeThread,
    kTypeObject,
};

SoundFormat :: enum i32 {
    kSound8bitMono = 0,
    kSound8bitStereo = 1,
    kSound16bitMono = 2,
    kSound16bitStereo = 3,
    kSoundADPCMMono = 4,
    kSoundADPCMStereo = 5,
};

LFOType :: enum i32 {
    kLFOTypeSquare,
    kLFOTypeTriangle,
    kLFOTypeSine,
    kLFOTypeSampleAndHold,
    kLFOTypeSawtoothUp,
    kLFOTypeSawtoothDown,
    kLFOTypeArpeggiator,
    kLFOTypeFunction,
};

SoundWaveform :: enum i32 {
    kWaveformSquare,
    kWaveformTriangle,
    kWaveformSine,
    kWaveformNoise,
    kWaveformSawtooth,
    kWaveformPOPhase,
    kWaveformPODigital,
    kWaveformPOVosim,
};

TwoPoleFilterType :: enum i32 {
    kFilterTypeLowPass,
    kFilterTypeHighPass,
    kFilterTypeBandPass,
    kFilterTypeNotch,
    kFilterTypePEQ,
    kFilterTypeLowShelf,
    kFilterTypeHighShelf,
};

SpriteCollisionResponseType :: enum i32 {
    kCollisionTypeSlide,
    kCollisionTypeFreeze,
    kCollisionTypeOverlap,
    kCollisionTypeBounce,
};

PDButtons :: enum i32 {
    kButtonLeft = 1,
    kButtonRight = 2,
    kButtonUp = 4,
    kButtonDown = 8,
    kButtonB = 16,
    kButtonA = 32,
};

PDLanguage :: enum i32 {
    kPDLanguageEnglish,
    kPDLanguageJapanese,
    kPDLanguageUnknown,
};

PDPeripherals :: enum i32 {
    kNone = 0,
    kAccelerometer = 1,
    kAllPeripherals = 65535,
};

PlaydateAPI :: struct {
    system : ^playdate_sys,
    file : ^playdate_file,
    graphics : ^playdate_graphics,
    sprite : ^playdate_sprite,
    display : ^playdate_display,
    sound : ^playdate_sound,
    lua : ^playdate_lua,
    json : ^playdate_json,
    scoreboards : ^playdate_scoreboards,
};

playdate_sys :: struct {
    realloc : #type proc(ptr : rawptr, size : _c.size_t) -> rawptr,
    formatString : #type proc(ret : ^cstring, fmt : cstring) -> _c.int,
    logToConsole : #type proc(fmt : cstring),
    error : #type proc(fmt : cstring),
    getLanguage : #type proc() -> PDLanguage,
    getCurrentTimeMilliseconds : #type proc() -> _c.uint,
    getSecondsSinceEpoch : #type proc(milliseconds : ^_c.uint) -> _c.uint,
    drawFPS : #type proc(x : _c.int, y : _c.int),
    setUpdateCallback : #type proc(update : PDCallbackFunction, userdata : rawptr),
    getButtonState : #type proc(current : ^PDButtons, pushed : ^PDButtons, released : ^PDButtons),
    setPeripheralsEnabled : #type proc(mask : PDPeripherals),
    getAccelerometer : #type proc(outx : ^_c.float, outy : ^_c.float, outz : ^_c.float),
    getCrankChange : #type proc() -> _c.float,
    getCrankAngle : #type proc() -> _c.float,
    isCrankDocked : #type proc() -> _c.int,
    setCrankSoundsDisabled : #type proc(flag : _c.int) -> _c.int,
    getFlipped : #type proc() -> _c.int,
    setAutoLockDisabled : #type proc(disable : _c.int),
    setMenuImage : #type proc(bitmap : ^LCDBitmap, xOffset : _c.int),
    addMenuItem : #type proc(title : cstring, callback : PDMenuItemCallbackFunction, userdata : rawptr) -> ^PDMenuItem,
    addCheckmarkMenuItem : #type proc(title : cstring, value : _c.int, callback : PDMenuItemCallbackFunction, userdata : rawptr) -> ^PDMenuItem,
    addOptionsMenuItem : #type proc(title : cstring, optionTitles : [^]cstring, optionsCount : _c.int, f : PDMenuItemCallbackFunction, userdata : rawptr) -> ^PDMenuItem,
    removeAllMenuItems : #type proc(),
    removeMenuItem : #type proc(menuItem : ^PDMenuItem),
    getMenuItemValue : #type proc(menuItem : ^PDMenuItem) -> _c.int,
    setMenuItemValue : #type proc(menuItem : ^PDMenuItem, value : _c.int),
    getMenuItemTitle : #type proc(menuItem : ^PDMenuItem) -> cstring,
    setMenuItemTitle : #type proc(menuItem : ^PDMenuItem, title : cstring),
    getMenuItemUserdata : #type proc(menuItem : ^PDMenuItem) -> rawptr,
    setMenuItemUserdata : #type proc(menuItem : ^PDMenuItem, ud : rawptr),
    getReduceFlashing : #type proc() -> _c.int,
    getElapsedTime : #type proc() -> _c.float,
    resetElapsedTime : #type proc(),
    getBatteryPercentage : #type proc() -> _c.float,
    getBatteryVoltage : #type proc() -> _c.float,
    getTimezoneOffset : #type proc() -> i32,
    shouldDisplay24HourTime : #type proc() -> _c.int,
    convertEpochToDateTime : #type proc(epoch : u32, datetime : ^PDDateTime),
    convertDateTimeToEpoch : #type proc(datetime : ^PDDateTime) -> u32,
};

playdate_file :: struct {
    geterr : #type proc() -> cstring,
    listfiles : #type proc(path : cstring, unamed0 : #type proc(path : cstring, userdata : rawptr), userdata : rawptr, showhidden : _c.int) -> _c.int,
    stat : #type proc(path : cstring, stat : ^FileStat) -> _c.int,
    mkdir : #type proc(path : cstring) -> _c.int,
    unlink : #type proc(name : cstring, recursive : _c.int) -> _c.int,
    rename : #type proc(from : cstring, to : cstring) -> _c.int,
    open : #type proc(name : cstring, mode : FileOptions) -> rawptr,
    close : #type proc(file : rawptr) -> _c.int,
    read : #type proc(file : rawptr, buf : rawptr, len : _c.uint) -> _c.int,
    write : #type proc(file : rawptr, buf : rawptr, len : _c.uint) -> _c.int,
    flush : #type proc(file : rawptr) -> _c.int,
    tell : #type proc(file : rawptr) -> _c.int,
    seek : #type proc(file : rawptr, pos : _c.int, whence : _c.int) -> _c.int,
};

playdate_graphics :: struct {
    video : ^playdate_video,
    clear : #type proc(color : _c.uintptr_t),
    setBackgroundColor : #type proc(color : LCDSolidColor),
    setStencil : #type proc(stencil : ^LCDBitmap),
    setDrawMode : #type proc(mode : LCDBitmapDrawMode),
    setDrawOffset : #type proc(dx : _c.int, dy : _c.int),
    setClipRect : #type proc(x : _c.int, y : _c.int, width : _c.int, height : _c.int),
    clearClipRect : #type proc(),
    setLineCapStyle : #type proc(endCapStyle : LCDLineCapStyle),
    setFont : #type proc(font : ^LCDFont),
    setTextTracking : #type proc(tracking : _c.int),
    pushContext : #type proc(target : ^LCDBitmap),
    popContext : #type proc(),
    drawBitmap : #type proc(bitmap : ^LCDBitmap, x : _c.int, y : _c.int, flip : LCDBitmapFlip),
    tileBitmap : #type proc(bitmap : ^LCDBitmap, x : _c.int, y : _c.int, width : _c.int, height : _c.int, flip : LCDBitmapFlip),
    drawLine : #type proc(x1 : _c.int, y1 : _c.int, x2 : _c.int, y2 : _c.int, width : _c.int, color : _c.uintptr_t),
    fillTriangle : #type proc(x1 : _c.int, y1 : _c.int, x2 : _c.int, y2 : _c.int, x3 : _c.int, y3 : _c.int, color : _c.uintptr_t),
    drawRect : #type proc(x : _c.int, y : _c.int, width : _c.int, height : _c.int, color : _c.uintptr_t),
    fillRect : #type proc(x : _c.int, y : _c.int, width : _c.int, height : _c.int, color : _c.uintptr_t),
    drawEllipse : #type proc(x : _c.int, y : _c.int, width : _c.int, height : _c.int, lineWidth : _c.int, startAngle : _c.float, endAngle : _c.float, color : _c.uintptr_t),
    fillEllipse : #type proc(x : _c.int, y : _c.int, width : _c.int, height : _c.int, startAngle : _c.float, endAngle : _c.float, color : _c.uintptr_t),
    drawScaledBitmap : #type proc(bitmap : ^LCDBitmap, x : _c.int, y : _c.int, xscale : _c.float, yscale : _c.float),
    drawText : #type proc(text : rawptr, len : _c.size_t, encoding : PDStringEncoding, x : _c.int, y : _c.int) -> _c.int,
    newBitmap : #type proc(width : _c.int, height : _c.int, bgcolor : _c.uintptr_t) -> ^LCDBitmap,
    freeBitmap : #type proc(unamed0 : ^LCDBitmap),
    loadBitmap : #type proc(path : cstring, outerr : ^cstring) -> ^LCDBitmap,
    copyBitmap : #type proc(bitmap : ^LCDBitmap) -> ^LCDBitmap,
    loadIntoBitmap : #type proc(path : cstring, bitmap : ^LCDBitmap, outerr : ^cstring),
    getBitmapData : #type proc(bitmap : ^LCDBitmap, width : ^_c.int, height : ^_c.int, rowbytes : ^_c.int, mask : ^^u8, data : ^^u8),
    clearBitmap : #type proc(bitmap : ^LCDBitmap, bgcolor : _c.uintptr_t),
    rotatedBitmap : #type proc(bitmap : ^LCDBitmap, rotation : _c.float, xscale : _c.float, yscale : _c.float, allocedSize : ^_c.int) -> ^LCDBitmap,
    newBitmapTable : #type proc(count : _c.int, width : _c.int, height : _c.int) -> ^LCDBitmapTable,
    freeBitmapTable : #type proc(table : ^LCDBitmapTable),
    loadBitmapTable : #type proc(path : cstring, outerr : ^cstring) -> ^LCDBitmapTable,
    loadIntoBitmapTable : #type proc(path : cstring, table : ^LCDBitmapTable, outerr : ^cstring),
    getTableBitmap : #type proc(table : ^LCDBitmapTable, idx : _c.int) -> ^LCDBitmap,
    loadFont : #type proc(path : cstring, outErr : ^cstring) -> ^LCDFont,
    getFontPage : #type proc(font : ^LCDFont, c : u32) -> ^LCDFontPage,
    getPageGlyph : #type proc(page : ^LCDFontPage, c : u32, bitmap : ^^LCDBitmap, advance : ^_c.int) -> ^LCDFontGlyph,
    getGlyphKerning : #type proc(glyph : ^LCDFontGlyph, glyphcode : u32, nextcode : u32) -> _c.int,
    getTextWidth : #type proc(font : ^LCDFont, text : rawptr, len : _c.size_t, encoding : PDStringEncoding, tracking : _c.int) -> _c.int,
    getFrame : #type proc() -> ^u8,
    getDisplayFrame : #type proc() -> ^u8,
    getDebugBitmap : #type proc() -> ^LCDBitmap,
    copyFrameBufferBitmap : #type proc() -> ^LCDBitmap,
    markUpdatedRows : #type proc(start : _c.int, end : _c.int),
    display : #type proc(),
    setColorToPattern : #type proc(color : ^_c.uintptr_t, bitmap : ^LCDBitmap, x : _c.int, y : _c.int),
    checkMaskCollision : #type proc(bitmap1 : ^LCDBitmap, x1 : _c.int, y1 : _c.int, flip1 : LCDBitmapFlip, bitmap2 : ^LCDBitmap, x2 : _c.int, y2 : _c.int, flip2 : LCDBitmapFlip, rect : LCDRect) -> _c.int,
    setScreenClipRect : #type proc(x : _c.int, y : _c.int, width : _c.int, height : _c.int),
    fillPolygon : #type proc(nPoints : _c.int, coords : ^_c.int, color : _c.uintptr_t, fillrule : LCDPolygonFillRule),
    getFontHeight : #type proc(font : ^LCDFont) -> u8,
    getDisplayBufferBitmap : #type proc() -> ^LCDBitmap,
    drawRotatedBitmap : #type proc(bitmap : ^LCDBitmap, x : _c.int, y : _c.int, rotation : _c.float, centerx : _c.float, centery : _c.float, xscale : _c.float, yscale : _c.float),
    setTextLeading : #type proc(lineHeightAdustment : _c.int),
    setBitmapMask : #type proc(bitmap : ^LCDBitmap, mask : ^LCDBitmap) -> _c.int,
    getBitmapMask : #type proc(bitmap : ^LCDBitmap) -> ^LCDBitmap,
    setStencilImage : #type proc(stencil : ^LCDBitmap, tile : _c.int),
    makeFontFromData : #type proc(data : ^LCDFontData, wide : _c.int) -> ^LCDFont,
};

playdate_sprite :: struct {
    setAlwaysRedraw : #type proc(flag : _c.int),
    addDirtyRect : #type proc(dirtyRect : LCDRect),
    drawSprites : #type proc(),
    updateAndDrawSprites : #type proc(),
    newSprite : #type proc() -> ^LCDSprite,
    freeSprite : #type proc(sprite : ^LCDSprite),
    copy : #type proc(sprite : ^LCDSprite) -> ^LCDSprite,
    addSprite : #type proc(sprite : ^LCDSprite),
    removeSprite : #type proc(sprite : ^LCDSprite),
    removeSprites : #type proc(sprites : ^^LCDSprite, count : _c.int),
    removeAllSprites : #type proc(),
    getSpriteCount : #type proc() -> _c.int,
    setBounds : #type proc(sprite : ^LCDSprite, bounds : PDRect),
    getBounds : #type proc(sprite : ^LCDSprite) -> PDRect,
    moveTo : #type proc(sprite : ^LCDSprite, x : _c.float, y : _c.float),
    moveBy : #type proc(sprite : ^LCDSprite, dx : _c.float, dy : _c.float),
    setImage : #type proc(sprite : ^LCDSprite, image : ^LCDBitmap, flip : LCDBitmapFlip),
    getImage : #type proc(sprite : ^LCDSprite) -> ^LCDBitmap,
    setSize : #type proc(s : ^LCDSprite, width : _c.float, height : _c.float),
    setZIndex : #type proc(sprite : ^LCDSprite, zIndex : i16),
    getZIndex : #type proc(sprite : ^LCDSprite) -> i16,
    setDrawMode : #type proc(sprite : ^LCDSprite, mode : LCDBitmapDrawMode),
    setImageFlip : #type proc(sprite : ^LCDSprite, flip : LCDBitmapFlip),
    getImageFlip : #type proc(sprite : ^LCDSprite) -> LCDBitmapFlip,
    setStencil : #type proc(sprite : ^LCDSprite, stencil : ^LCDBitmap),
    setClipRect : #type proc(sprite : ^LCDSprite, clipRect : LCDRect),
    clearClipRect : #type proc(sprite : ^LCDSprite),
    setClipRectsInRange : #type proc(clipRect : LCDRect, startZ : _c.int, endZ : _c.int),
    clearClipRectsInRange : #type proc(startZ : _c.int, endZ : _c.int),
    setUpdatesEnabled : #type proc(sprite : ^LCDSprite, flag : _c.int),
    updatesEnabled : #type proc(sprite : ^LCDSprite) -> _c.int,
    setCollisionsEnabled : #type proc(sprite : ^LCDSprite, flag : _c.int),
    collisionsEnabled : #type proc(sprite : ^LCDSprite) -> _c.int,
    setVisible : #type proc(sprite : ^LCDSprite, flag : _c.int),
    isVisible : #type proc(sprite : ^LCDSprite) -> _c.int,
    setOpaque : #type proc(sprite : ^LCDSprite, flag : _c.int),
    markDirty : #type proc(sprite : ^LCDSprite),
    setTag : #type proc(sprite : ^LCDSprite, tag : u8),
    getTag : #type proc(sprite : ^LCDSprite) -> u8,
    setIgnoresDrawOffset : #type proc(sprite : ^LCDSprite, flag : _c.int),
    setUpdateFunction : #type proc(sprite : ^LCDSprite, func : LCDSpriteUpdateFunction),
    setDrawFunction : #type proc(sprite : ^LCDSprite, func : LCDSpriteDrawFunction),
    getPosition : #type proc(sprite : ^LCDSprite, x : ^_c.float, y : ^_c.float),
    resetCollisionWorld : #type proc(),
    setCollideRect : #type proc(sprite : ^LCDSprite, collideRect : PDRect),
    getCollideRect : #type proc(sprite : ^LCDSprite) -> PDRect,
    clearCollideRect : #type proc(sprite : ^LCDSprite),
    setCollisionResponseFunction : #type proc(sprite : ^LCDSprite, func : ^LCDSpriteCollisionFilterProc),
    checkCollisions : #type proc(sprite : ^LCDSprite, goalX : _c.float, goalY : _c.float, actualX : ^_c.float, actualY : ^_c.float, len : ^_c.int) -> ^SpriteCollisionInfo,
    moveWithCollisions : #type proc(sprite : ^LCDSprite, goalX : _c.float, goalY : _c.float, actualX : ^_c.float, actualY : ^_c.float, len : ^_c.int) -> ^SpriteCollisionInfo,
    querySpritesAtPoint : #type proc(x : _c.float, y : _c.float, len : ^_c.int) -> ^^LCDSprite,
    querySpritesInRect : #type proc(x : _c.float, y : _c.float, width : _c.float, height : _c.float, len : ^_c.int) -> ^^LCDSprite,
    querySpritesAlongLine : #type proc(x1 : _c.float, y1 : _c.float, x2 : _c.float, y2 : _c.float, len : ^_c.int) -> ^^LCDSprite,
    querySpriteInfoAlongLine : #type proc(x1 : _c.float, y1 : _c.float, x2 : _c.float, y2 : _c.float, len : ^_c.int) -> ^SpriteQueryInfo,
    overlappingSprites : #type proc(sprite : ^LCDSprite, len : ^_c.int) -> ^^LCDSprite,
    allOverlappingSprites : #type proc(len : ^_c.int) -> ^^LCDSprite,
    setStencilPattern : #type proc(sprite : ^LCDSprite, pattern : [8]u8),
    clearStencil : #type proc(sprite : ^LCDSprite),
    setUserdata : #type proc(sprite : ^LCDSprite, userdata : rawptr),
    getUserdata : #type proc(sprite : ^LCDSprite) -> rawptr,
    setStencilImage : #type proc(sprite : ^LCDSprite, stencil : ^LCDBitmap, tile : _c.int),
};

playdate_display :: struct {
    getWidth : #type proc() -> _c.int,
    getHeight : #type proc() -> _c.int,
    setRefreshRate : #type proc(rate : _c.float),
    setInverted : #type proc(flag : _c.int),
    setScale : #type proc(s : _c.uint),
    setMosaic : #type proc(x : _c.uint, y : _c.uint),
    setFlipped : #type proc(x : _c.int, y : _c.int),
    setOffset : #type proc(x : _c.int, y : _c.int),
};

playdate_sound :: struct {
    channel : ^playdate_sound_channel,
    fileplayer : ^playdate_sound_fileplayer,
    sample : ^playdate_sound_sample,
    sampleplayer : ^playdate_sound_sampleplayer,
    synth : ^playdate_sound_synth,
    sequence : ^playdate_sound_sequence,
    effect : ^playdate_sound_effect,
    lfo : ^playdate_sound_lfo,
    envelope : ^playdate_sound_envelope,
    source : ^playdate_sound_source,
    controlsignal : ^playdate_control_signal,
    track : ^playdate_sound_track,
    instrument : ^playdate_sound_instrument,
    getCurrentTime : #type proc() -> u32,
    addSource : #type proc(callback : ^AudioSourceFunction, _context : rawptr, stereo : _c.int) -> ^SoundSource,
    getDefaultChannel : #type proc() -> ^SoundChannel,
    addChannel : #type proc(channel : ^SoundChannel) -> _c.int,
    removeChannel : #type proc(channel : ^SoundChannel) -> _c.int,
    setMicCallback : #type proc(callback : ^RecordCallback, _context : rawptr, forceInternal : _c.int),
    getHeadphoneState : #type proc(headphone : ^_c.int, headsetmic : ^_c.int, unamed0 : #type proc(headphone : _c.int, mic : _c.int)),
    setOutputsActive : #type proc(headphone : _c.int, speaker : _c.int),
    removeSource : #type proc(source : ^SoundSource) -> _c.int,
    signal : ^playdate_sound_signal,
};

playdate_lua :: struct {
    addFunction : #type proc(f : lua_CFunction, name : cstring, outErr : ^cstring) -> _c.int,
    registerClass : #type proc(name : cstring, reg : ^lua_reg, vals : ^lua_val, isstatic : _c.int, outErr : ^cstring) -> _c.int,
    pushFunction : #type proc(f : lua_CFunction),
    indexMetatable : #type proc() -> _c.int,
    stop : #type proc(),
    start : #type proc(),
    getArgCount : #type proc() -> _c.int,
    getArgType : #type proc(pos : _c.int, outClass : ^cstring) -> LuaType,
    argIsNil : #type proc(pos : _c.int) -> _c.int,
    getArgBool : #type proc(pos : _c.int) -> _c.int,
    getArgInt : #type proc(pos : _c.int) -> _c.int,
    getArgFloat : #type proc(pos : _c.int) -> _c.float,
    getArgString : #type proc(pos : _c.int) -> cstring,
    getArgBytes : #type proc(pos : _c.int, outlen : ^_c.size_t) -> cstring,
    getArgObject : #type proc(pos : _c.int, type : cstring, outud : ^^LuaUDObject) -> rawptr,
    getBitmap : #type proc(pos : _c.int) -> ^LCDBitmap,
    getSprite : #type proc(pos : _c.int) -> ^LCDSprite,
    pushNil : #type proc(),
    pushBool : #type proc(val : _c.int),
    pushInt : #type proc(val : _c.int),
    pushFloat : #type proc(val : _c.float),
    pushString : #type proc(str : cstring),
    pushBytes : #type proc(str : cstring, len : _c.size_t),
    pushBitmap : #type proc(bitmap : ^LCDBitmap),
    pushSprite : #type proc(sprite : ^LCDSprite),
    pushObject : #type proc(obj : rawptr, type : cstring, nValues : _c.int) -> ^LuaUDObject,
    retainObject : #type proc(obj : ^LuaUDObject) -> ^LuaUDObject,
    releaseObject : #type proc(obj : ^LuaUDObject),
    setUserValue : #type proc(obj : ^LuaUDObject, slot : _c.uint),
    getUserValue : #type proc(obj : ^LuaUDObject, slot : _c.uint) -> _c.int,
    callFunction_deprecated : #type proc(name : cstring, nargs : _c.int),
    callFunction : #type proc(name : cstring, nargs : _c.int, outerr : ^cstring) -> _c.int,
};

playdate_json :: struct {};

playdate_scoreboards :: struct {
    addScore : #type proc(boardId : cstring, value : u32, callback : AddScoreCallback) -> _c.int,
    getPersonalBest : #type proc(boardId : cstring, callback : PersonalBestCallback) -> _c.int,
    freeScore : #type proc(score : ^PDScore),
    getScoreboards : #type proc(callback : BoardsListCallback) -> _c.int,
    freeBoardsList : #type proc(boardsList : ^PDBoardsList),
    getScores : #type proc(boardId : cstring, callback : ScoresCallback) -> _c.int,
    freeScoresList : #type proc(scoresList : ^PDScoresList),
};

FileStat :: struct {
    isdir : _c.int,
    size : _c.uint,
    m_year : _c.int,
    m_month : _c.int,
    m_day : _c.int,
    m_hour : _c.int,
    m_minute : _c.int,
    m_second : _c.int,
};

LCDRect :: struct {
    left : _c.int,
    right : _c.int,
    top : _c.int,
    bottom : _c.int,
};

LCDBitmap :: struct {};

LCDBitmapTable :: struct {};

LCDFont :: struct {};

LCDFontData :: struct {};

LCDFontPage :: struct {};

LCDFontGlyph :: struct {};

LCDVideoPlayer :: struct {};

playdate_video :: struct {
    loadVideo : #type proc(path : cstring) -> ^LCDVideoPlayer,
    freePlayer : #type proc(p : ^LCDVideoPlayer),
    setContext : #type proc(p : ^LCDVideoPlayer, _context : ^LCDBitmap) -> _c.int,
    useScreenContext : #type proc(p : ^LCDVideoPlayer),
    renderFrame : #type proc(p : ^LCDVideoPlayer, n : _c.int) -> _c.int,
    getError : #type proc(p : ^LCDVideoPlayer) -> cstring,
    getInfo : #type proc(p : ^LCDVideoPlayer, outWidth : ^_c.int, outHeight : ^_c.int, outFrameRate : ^_c.float, outFrameCount : ^_c.int, outCurrentFrame : ^_c.int),
    getContext : #type proc(p : ^LCDVideoPlayer) -> ^LCDBitmap,
};

LuaUDObject :: struct {};

LCDSprite :: struct {};

lua_reg :: struct {
    name : cstring,
    func : lua_CFunction,
};

lua_val :: struct {
    name : cstring,
    type : l_valtype,
    v : AnonymousUnion0,
};

PDScore :: struct {
    rank : u32,
    value : u32,
    player : cstring,
};

PDScoresList :: struct {
    boardID : cstring,
    count : _c.uint,
    lastUpdated : u32,
    playerIncluded : _c.int,
    limit : _c.uint,
    scores : ^PDScore,
};

PDBoard :: struct {
    boardID : cstring,
    name : cstring,
};

PDBoardsList :: struct {
    count : _c.uint,
    lastUpdated : u32,
    boards : ^PDBoard,
};

SoundSource :: struct {};

playdate_sound_source :: struct {
    setVolume : #type proc(c : ^SoundSource, lvol : _c.float, rvol : _c.float),
    getVolume : #type proc(c : ^SoundSource, outl : ^_c.float, outr : ^_c.float),
    isPlaying : #type proc(c : ^SoundSource) -> _c.int,
    setFinishCallback : #type proc(c : ^SoundSource, callback : sndCallbackProc),
};

FilePlayer :: struct {};

playdate_sound_fileplayer :: struct {
    newPlayer : #type proc() -> ^FilePlayer,
    freePlayer : #type proc(player : ^FilePlayer),
    loadIntoPlayer : #type proc(player : ^FilePlayer, path : cstring) -> _c.int,
    setBufferLength : #type proc(player : ^FilePlayer, bufferLen : _c.float),
    play : #type proc(player : ^FilePlayer, repeat : _c.int) -> _c.int,
    isPlaying : #type proc(player : ^FilePlayer) -> _c.int,
    pause : #type proc(player : ^FilePlayer),
    stop : #type proc(player : ^FilePlayer),
    setVolume : #type proc(player : ^FilePlayer, left : _c.float, right : _c.float),
    getVolume : #type proc(player : ^FilePlayer, left : ^_c.float, right : ^_c.float),
    getLength : #type proc(player : ^FilePlayer) -> _c.float,
    setOffset : #type proc(player : ^FilePlayer, offset : _c.float),
    setRate : #type proc(player : ^FilePlayer, rate : _c.float),
    setLoopRange : #type proc(player : ^FilePlayer, start : _c.float, end : _c.float),
    didUnderrun : #type proc(player : ^FilePlayer) -> _c.int,
    setFinishCallback : #type proc(player : ^FilePlayer, callback : sndCallbackProc),
    setLoopCallback : #type proc(player : ^FilePlayer, callback : sndCallbackProc),
    getOffset : #type proc(player : ^FilePlayer) -> _c.float,
    getRate : #type proc(player : ^FilePlayer) -> _c.float,
    setStopOnUnderrun : #type proc(player : ^FilePlayer, flag : _c.int),
    fadeVolume : #type proc(player : ^FilePlayer, left : _c.float, right : _c.float, len : i32, finishCallback : sndCallbackProc),
    setMP3StreamSource : #type proc(player : ^FilePlayer, unamed0 : #type proc(data : ^u8, bytes : _c.int, userdata : rawptr) -> _c.int, userdata : rawptr, bufferLen : _c.float),
};

AudioSample :: struct {};

SamplePlayer :: struct {};

playdate_sound_sample :: struct {
    newSampleBuffer : #type proc(byteCount : _c.int) -> ^AudioSample,
    loadIntoSample : #type proc(sample : ^AudioSample, path : cstring) -> _c.int,
    load : #type proc(path : cstring) -> ^AudioSample,
    newSampleFromData : #type proc(data : ^u8, format : SoundFormat, sampleRate : u32, byteCount : _c.int) -> ^AudioSample,
    getData : #type proc(sample : ^AudioSample, data : ^^u8, format : ^SoundFormat, sampleRate : ^u32, bytelength : ^u32),
    freeSample : #type proc(sample : ^AudioSample),
    getLength : #type proc(sample : ^AudioSample) -> _c.float,
};

playdate_sound_sampleplayer :: struct {
    newPlayer : #type proc() -> ^SamplePlayer,
    freePlayer : #type proc(player : ^SamplePlayer),
    setSample : #type proc(player : ^SamplePlayer, sample : ^AudioSample),
    play : #type proc(player : ^SamplePlayer, repeat : _c.int, rate : _c.float) -> _c.int,
    isPlaying : #type proc(player : ^SamplePlayer) -> _c.int,
    stop : #type proc(player : ^SamplePlayer),
    setVolume : #type proc(player : ^SamplePlayer, left : _c.float, right : _c.float),
    getVolume : #type proc(player : ^SamplePlayer, left : ^_c.float, right : ^_c.float),
    getLength : #type proc(player : ^SamplePlayer) -> _c.float,
    setOffset : #type proc(player : ^SamplePlayer, offset : _c.float),
    setRate : #type proc(player : ^SamplePlayer, rate : _c.float),
    setPlayRange : #type proc(player : ^SamplePlayer, start : _c.int, end : _c.int),
    setFinishCallback : #type proc(player : ^SamplePlayer, callback : sndCallbackProc),
    setLoopCallback : #type proc(player : ^SamplePlayer, callback : sndCallbackProc),
    getOffset : #type proc(player : ^SamplePlayer) -> _c.float,
    getRate : #type proc(player : ^SamplePlayer) -> _c.float,
    setPaused : #type proc(player : ^SamplePlayer, flag : _c.int),
};

PDSynthSignalValue :: struct {};

PDSynthSignal :: struct {};

playdate_sound_signal :: struct {
    newSignal : #type proc(step : signalStepFunc, noteOn : signalNoteOnFunc, noteOff : signalNoteOffFunc, dealloc : signalDeallocFunc, userdata : rawptr) -> ^PDSynthSignal,
    freeSignal : #type proc(signal : ^PDSynthSignal),
    getValue : #type proc(signal : ^PDSynthSignal) -> _c.float,
    setValueScale : #type proc(signal : ^PDSynthSignal, scale : _c.float),
    setValueOffset : #type proc(signal : ^PDSynthSignal, offset : _c.float),
};

PDSynthLFO :: struct {};

playdate_sound_lfo :: struct {
    newLFO : #type proc(type : LFOType) -> ^PDSynthLFO,
    freeLFO : #type proc(lfo : ^PDSynthLFO),
    setType : #type proc(lfo : ^PDSynthLFO, type : LFOType),
    setRate : #type proc(lfo : ^PDSynthLFO, rate : _c.float),
    setPhase : #type proc(lfo : ^PDSynthLFO, phase : _c.float),
    setCenter : #type proc(lfo : ^PDSynthLFO, center : _c.float),
    setDepth : #type proc(lfo : ^PDSynthLFO, depth : _c.float),
    setArpeggiation : #type proc(lfo : ^PDSynthLFO, nSteps : _c.int, steps : ^_c.float),
    setFunction : #type proc(lfo : ^PDSynthLFO, unamed0 : #type proc(lfo : ^PDSynthLFO, userdata : rawptr) -> _c.float, userdata : rawptr, interpolate : _c.int),
    setDelay : #type proc(lfo : ^PDSynthLFO, holdoff : _c.float, ramptime : _c.float),
    setRetrigger : #type proc(lfo : ^PDSynthLFO, flag : _c.int),
    getValue : #type proc(lfo : ^PDSynthLFO) -> _c.float,
    setGlobal : #type proc(lfo : ^PDSynthLFO, global : _c.int),
};

PDSynthEnvelope :: struct {};

playdate_sound_envelope :: struct {
    newEnvelope : #type proc(attack : _c.float, decay : _c.float, sustain : _c.float, release : _c.float) -> ^PDSynthEnvelope,
    freeEnvelope : #type proc(env : ^PDSynthEnvelope),
    setAttack : #type proc(env : ^PDSynthEnvelope, attack : _c.float),
    setDecay : #type proc(env : ^PDSynthEnvelope, decay : _c.float),
    setSustain : #type proc(env : ^PDSynthEnvelope, sustain : _c.float),
    setRelease : #type proc(env : ^PDSynthEnvelope, release : _c.float),
    setLegato : #type proc(env : ^PDSynthEnvelope, flag : _c.int),
    setRetrigger : #type proc(lfo : ^PDSynthEnvelope, flag : _c.int),
    getValue : #type proc(env : ^PDSynthEnvelope) -> _c.float,
    setCurvature : #type proc(env : ^PDSynthEnvelope, amount : _c.float),
    setVelocitySensitivity : #type proc(env : ^PDSynthEnvelope, velsens : _c.float),
    setRateScaling : #type proc(env : ^PDSynthEnvelope, scaling : _c.float, start : _c.float, end : _c.float),
};

PDSynth :: struct {};

playdate_sound_synth :: struct {
    newSynth : #type proc() -> ^PDSynth,
    freeSynth : #type proc(synth : ^PDSynth),
    setWaveform : #type proc(synth : ^PDSynth, wave : SoundWaveform),
    setGenerator : #type proc(synth : ^PDSynth, stereo : _c.int, render : synthRenderFunc, noteOn : synthNoteOnFunc, release : synthReleaseFunc, setparam : synthSetParameterFunc, dealloc : synthDeallocFunc, userdata : rawptr),
    setSample : #type proc(synth : ^PDSynth, sample : ^AudioSample, sustainStart : u32, sustainEnd : u32),
    setAttackTime : #type proc(synth : ^PDSynth, attack : _c.float),
    setDecayTime : #type proc(synth : ^PDSynth, decay : _c.float),
    setSustainLevel : #type proc(synth : ^PDSynth, sustain : _c.float),
    setReleaseTime : #type proc(synth : ^PDSynth, release : _c.float),
    setTranspose : #type proc(synth : ^PDSynth, halfSteps : _c.float),
    setFrequencyModulator : #type proc(synth : ^PDSynth, mod : ^PDSynthSignalValue),
    getFrequencyModulator : #type proc(synth : ^PDSynth) -> ^PDSynthSignalValue,
    setAmplitudeModulator : #type proc(synth : ^PDSynth, mod : ^PDSynthSignalValue),
    getAmplitudeModulator : #type proc(synth : ^PDSynth) -> ^PDSynthSignalValue,
    getParameterCount : #type proc(synth : ^PDSynth) -> _c.int,
    setParameter : #type proc(synth : ^PDSynth, parameter : _c.int, value : _c.float) -> _c.int,
    setParameterModulator : #type proc(synth : ^PDSynth, parameter : _c.int, mod : ^PDSynthSignalValue),
    getParameterModulator : #type proc(synth : ^PDSynth, parameter : _c.int) -> ^PDSynthSignalValue,
    playNote : #type proc(synth : ^PDSynth, freq : _c.float, vel : _c.float, len : _c.float, _when : u32),
    playMIDINote : #type proc(synth : ^PDSynth, note : _c.float, vel : _c.float, len : _c.float, _when : u32),
    noteOff : #type proc(synth : ^PDSynth, _when : u32),
    stop : #type proc(synth : ^PDSynth),
    setVolume : #type proc(synth : ^PDSynth, left : _c.float, right : _c.float),
    getVolume : #type proc(synth : ^PDSynth, left : ^_c.float, right : ^_c.float),
    isPlaying : #type proc(synth : ^PDSynth) -> _c.int,
    getEnvelope : #type proc(synth : ^PDSynth) -> ^PDSynthEnvelope,
};

ControlSignal :: struct {};

playdate_control_signal :: struct {
    newSignal : #type proc() -> ^ControlSignal,
    freeSignal : #type proc(signal : ^ControlSignal),
    clearEvents : #type proc(control : ^ControlSignal),
    addEvent : #type proc(control : ^ControlSignal, step : _c.int, value : _c.float, interpolate : _c.int),
    removeEvent : #type proc(control : ^ControlSignal, step : _c.int),
    getMIDIControllerNumber : #type proc(control : ^ControlSignal) -> _c.int,
};

PDSynthInstrument :: struct {};

playdate_sound_instrument :: struct {
    newInstrument : #type proc() -> ^PDSynthInstrument,
    freeInstrument : #type proc(inst : ^PDSynthInstrument),
    addVoice : #type proc(inst : ^PDSynthInstrument, synth : ^PDSynth, rangeStart : _c.float, rangeEnd : _c.float, transpose : _c.float) -> _c.int,
    playNote : #type proc(inst : ^PDSynthInstrument, frequency : _c.float, vel : _c.float, len : _c.float, _when : u32) -> ^PDSynth,
    playMIDINote : #type proc(inst : ^PDSynthInstrument, note : _c.float, vel : _c.float, len : _c.float, _when : u32) -> ^PDSynth,
    setPitchBend : #type proc(inst : ^PDSynthInstrument, bend : _c.float),
    setPitchBendRange : #type proc(inst : ^PDSynthInstrument, halfSteps : _c.float),
    setTranspose : #type proc(inst : ^PDSynthInstrument, halfSteps : _c.float),
    noteOff : #type proc(inst : ^PDSynthInstrument, note : _c.float, _when : u32),
    allNotesOff : #type proc(inst : ^PDSynthInstrument, _when : u32),
    setVolume : #type proc(inst : ^PDSynthInstrument, left : _c.float, right : _c.float),
    getVolume : #type proc(inst : ^PDSynthInstrument, left : ^_c.float, right : ^_c.float),
    activeVoiceCount : #type proc(inst : ^PDSynthInstrument) -> _c.int,
};

SequenceTrack :: struct {};

playdate_sound_track :: struct {
    newTrack : #type proc() -> ^SequenceTrack,
    freeTrack : #type proc(track : ^SequenceTrack),
    setInstrument : #type proc(track : ^SequenceTrack, inst : ^PDSynthInstrument),
    getInstrument : #type proc(track : ^SequenceTrack) -> ^PDSynthInstrument,
    addNoteEvent : #type proc(track : ^SequenceTrack, step : u32, len : u32, note : _c.float, velocity : _c.float),
    removeNoteEvent : #type proc(track : ^SequenceTrack, step : u32, note : _c.float),
    clearNotes : #type proc(track : ^SequenceTrack),
    getControlSignalCount : #type proc(track : ^SequenceTrack) -> _c.int,
    getControlSignal : #type proc(track : ^SequenceTrack, idx : _c.int) -> ^ControlSignal,
    clearControlEvents : #type proc(track : ^SequenceTrack),
    getPolyphony : #type proc(track : ^SequenceTrack) -> _c.int,
    activeVoiceCount : #type proc(track : ^SequenceTrack) -> _c.int,
    setMuted : #type proc(track : ^SequenceTrack, mute : _c.int),
    getLength : #type proc(track : ^SequenceTrack) -> u32,
    getIndexForStep : #type proc(track : ^SequenceTrack, step : u32) -> _c.int,
    getNoteAtIndex : #type proc(track : ^SequenceTrack, index : _c.int, outStep : ^u32, outLen : ^u32, outNote : ^_c.float, outVelocity : ^_c.float) -> _c.int,
    getSignalForController : #type proc(track : ^SequenceTrack, controller : _c.int, create : _c.int) -> ^ControlSignal,
};

SoundSequence :: struct {};

playdate_sound_sequence :: struct {
    newSequence : #type proc() -> ^SoundSequence,
    freeSequence : #type proc(sequence : ^SoundSequence),
    loadMidiFile : #type proc(seq : ^SoundSequence, path : cstring) -> _c.int,
    getTime : #type proc(seq : ^SoundSequence) -> u32,
    setTime : #type proc(seq : ^SoundSequence, time : u32),
    setLoops : #type proc(seq : ^SoundSequence, loopstart : _c.int, loopend : _c.int, loops : _c.int),
    getTempo : #type proc(seq : ^SoundSequence) -> _c.int,
    setTempo : #type proc(seq : ^SoundSequence, stepsPerSecond : _c.int),
    getTrackCount : #type proc(seq : ^SoundSequence) -> _c.int,
    addTrack : #type proc(seq : ^SoundSequence) -> ^SequenceTrack,
    getTrackAtIndex : #type proc(seq : ^SoundSequence, track : _c.uint) -> ^SequenceTrack,
    setTrackAtIndex : #type proc(seq : ^SoundSequence, track : ^SequenceTrack, idx : _c.uint),
    allNotesOff : #type proc(seq : ^SoundSequence),
    isPlaying : #type proc(seq : ^SoundSequence) -> _c.int,
    getLength : #type proc(seq : ^SoundSequence) -> u32,
    play : #type proc(seq : ^SoundSequence, finishCallback : SequenceFinishedCallback, userdata : rawptr),
    stop : #type proc(seq : ^SoundSequence),
    getCurrentStep : #type proc(seq : ^SoundSequence, timeOffset : ^_c.int) -> _c.int,
    setCurrentStep : #type proc(seq : ^SoundSequence, step : _c.int, timeOffset : _c.int, playNotes : _c.int),
};

TwoPoleFilter :: struct {};

playdate_sound_effect_twopolefilter :: struct {
    newFilter : #type proc() -> ^TwoPoleFilter,
    freeFilter : #type proc(filter : ^TwoPoleFilter),
    setType : #type proc(filter : ^TwoPoleFilter, type : TwoPoleFilterType),
    setFrequency : #type proc(filter : ^TwoPoleFilter, frequency : _c.float),
    setFrequencyModulator : #type proc(filter : ^TwoPoleFilter, signal : ^PDSynthSignalValue),
    getFrequencyModulator : #type proc(filter : ^TwoPoleFilter) -> ^PDSynthSignalValue,
    setGain : #type proc(filter : ^TwoPoleFilter, gain : _c.float),
    setResonance : #type proc(filter : ^TwoPoleFilter, resonance : _c.float),
    setResonanceModulator : #type proc(filter : ^TwoPoleFilter, signal : ^PDSynthSignalValue),
    getResonanceModulator : #type proc(filter : ^TwoPoleFilter) -> ^PDSynthSignalValue,
};

OnePoleFilter :: struct {};

playdate_sound_effect_onepolefilter :: struct {
    newFilter : #type proc() -> ^OnePoleFilter,
    freeFilter : #type proc(filter : ^OnePoleFilter),
    setParameter : #type proc(filter : ^OnePoleFilter, parameter : _c.float),
    setParameterModulator : #type proc(filter : ^OnePoleFilter, signal : ^PDSynthSignalValue),
    getParameterModulator : #type proc(filter : ^OnePoleFilter) -> ^PDSynthSignalValue,
};

BitCrusher :: struct {};

playdate_sound_effect_bitcrusher :: struct {
    newBitCrusher : #type proc() -> ^BitCrusher,
    freeBitCrusher : #type proc(filter : ^BitCrusher),
    setAmount : #type proc(filter : ^BitCrusher, amount : _c.float),
    setAmountModulator : #type proc(filter : ^BitCrusher, signal : ^PDSynthSignalValue),
    getAmountModulator : #type proc(filter : ^BitCrusher) -> ^PDSynthSignalValue,
    setUndersampling : #type proc(filter : ^BitCrusher, undersampling : _c.float),
    setUndersampleModulator : #type proc(filter : ^BitCrusher, signal : ^PDSynthSignalValue),
    getUndersampleModulator : #type proc(filter : ^BitCrusher) -> ^PDSynthSignalValue,
};

RingModulator :: struct {};

playdate_sound_effect_ringmodulator :: struct {
    newRingmod : #type proc() -> ^RingModulator,
    freeRingmod : #type proc(filter : ^RingModulator),
    setFrequency : #type proc(filter : ^RingModulator, frequency : _c.float),
    setFrequencyModulator : #type proc(filter : ^RingModulator, signal : ^PDSynthSignalValue),
    getFrequencyModulator : #type proc(filter : ^RingModulator) -> ^PDSynthSignalValue,
};

DelayLine :: struct {};

DelayLineTap :: struct {};

playdate_sound_effect_delayline :: struct {
    newDelayLine : #type proc(length : _c.int, stereo : _c.int) -> ^DelayLine,
    freeDelayLine : #type proc(filter : ^DelayLine),
    setLength : #type proc(d : ^DelayLine, frames : _c.int),
    setFeedback : #type proc(d : ^DelayLine, fb : _c.float),
    addTap : #type proc(d : ^DelayLine, delay : _c.int) -> ^DelayLineTap,
    freeTap : #type proc(tap : ^DelayLineTap),
    setTapDelay : #type proc(t : ^DelayLineTap, frames : _c.int),
    setTapDelayModulator : #type proc(t : ^DelayLineTap, mod : ^PDSynthSignalValue),
    getTapDelayModulator : #type proc(t : ^DelayLineTap) -> ^PDSynthSignalValue,
    setTapChannelsFlipped : #type proc(t : ^DelayLineTap, flip : _c.int),
};

Overdrive :: struct {};

playdate_sound_effect_overdrive :: struct {
    newOverdrive : #type proc() -> ^Overdrive,
    freeOverdrive : #type proc(filter : ^Overdrive),
    setGain : #type proc(o : ^Overdrive, gain : _c.float),
    setLimit : #type proc(o : ^Overdrive, limit : _c.float),
    setLimitModulator : #type proc(o : ^Overdrive, mod : ^PDSynthSignalValue),
    getLimitModulator : #type proc(o : ^Overdrive) -> ^PDSynthSignalValue,
    setOffset : #type proc(o : ^Overdrive, offset : _c.float),
    setOffsetModulator : #type proc(o : ^Overdrive, mod : ^PDSynthSignalValue),
    getOffsetModulator : #type proc(o : ^Overdrive) -> ^PDSynthSignalValue,
};

SoundEffect :: struct {};

playdate_sound_effect :: struct {
    newEffect : #type proc(_proc : ^effectProc, userdata : rawptr) -> ^SoundEffect,
    freeEffect : #type proc(effect : ^SoundEffect),
    setMix : #type proc(effect : ^SoundEffect, level : _c.float),
    setMixModulator : #type proc(effect : ^SoundEffect, signal : ^PDSynthSignalValue),
    getMixModulator : #type proc(effect : ^SoundEffect) -> ^PDSynthSignalValue,
    setUserdata : #type proc(effect : ^SoundEffect, userdata : rawptr),
    getUserdata : #type proc(effect : ^SoundEffect) -> rawptr,
    twopolefilter : ^playdate_sound_effect_twopolefilter,
    onepolefilter : ^playdate_sound_effect_onepolefilter,
    bitcrusher : ^playdate_sound_effect_bitcrusher,
    ringmodulator : ^playdate_sound_effect_ringmodulator,
    delayline : ^playdate_sound_effect_delayline,
    overdrive : ^playdate_sound_effect_overdrive,
};

SoundChannel :: struct {};

playdate_sound_channel :: struct {
    newChannel : #type proc() -> ^SoundChannel,
    freeChannel : #type proc(channel : ^SoundChannel),
    addSource : #type proc(channel : ^SoundChannel, source : ^SoundSource) -> _c.int,
    removeSource : #type proc(channel : ^SoundChannel, source : ^SoundSource) -> _c.int,
    addCallbackSource : #type proc(channel : ^SoundChannel, callback : ^AudioSourceFunction, _context : rawptr, stereo : _c.int) -> ^SoundSource,
    addEffect : #type proc(channel : ^SoundChannel, effect : ^SoundEffect),
    removeEffect : #type proc(channel : ^SoundChannel, effect : ^SoundEffect),
    setVolume : #type proc(channel : ^SoundChannel, volume : _c.float),
    getVolume : #type proc(channel : ^SoundChannel) -> _c.float,
    setVolumeModulator : #type proc(channel : ^SoundChannel, mod : ^PDSynthSignalValue),
    getVolumeModulator : #type proc(channel : ^SoundChannel) -> ^PDSynthSignalValue,
    setPan : #type proc(channel : ^SoundChannel, pan : _c.float),
    setPanModulator : #type proc(channel : ^SoundChannel, mod : ^PDSynthSignalValue),
    getPanModulator : #type proc(channel : ^SoundChannel) -> ^PDSynthSignalValue,
    getDryLevelSignal : #type proc(channel : ^SoundChannel) -> ^PDSynthSignalValue,
    getWetLevelSignal : #type proc(channel : ^SoundChannel) -> ^PDSynthSignalValue,
};

PDRect :: struct {
    x : _c.float,
    y : _c.float,
    width : _c.float,
    height : _c.float,
};

CollisionPoint :: struct {
    x : _c.float,
    y : _c.float,
};

CollisionVector :: struct {
    x : _c.int,
    y : _c.int,
};

SpriteCollisionInfo :: struct {
    sprite : ^LCDSprite,
    other : ^LCDSprite,
    responseType : SpriteCollisionResponseType,
    overlaps : u8,
    ti : _c.float,
    move : CollisionPoint,
    normal : CollisionVector,
    touch : CollisionPoint,
    spriteRect : PDRect,
    otherRect : PDRect,
};

SpriteQueryInfo :: struct {
    sprite : ^LCDSprite,
    ti1 : _c.float,
    ti2 : _c.float,
    entryPoint : CollisionPoint,
    exitPoint : CollisionPoint,
};

CWCollisionInfo :: struct {};

CWItemInfo :: struct {};

PDDateTime :: struct {
    year : u16,
    month : u8,
    day : u8,
    weekday : u8,
    hour : u8,
    minute : u8,
    second : u8,
};

PDMenuItem :: struct {};

AnonymousUnion0 :: struct #raw_union {
    intval : _c.uint,
    floatval : _c.float,
    strval : cstring,
};

@(default_calling_convention="c")
foreign pd_api {

    @(link_name="eventHandler")
    eventHandler :: proc(playdate : ^PlaydateAPI, event : PDSystemEvent, arg : u32) -> _c.int ---;

    @(link_name="LCDMakeRect")
    LCDMakeRect :: proc(x : _c.int, y : _c.int, width : _c.int, height : _c.int) -> LCDRect ---;

    @(link_name="LCDRect_translate")
    LCDRect_translate :: proc(r : LCDRect, dx : _c.int, dy : _c.int) -> LCDRect ---;

    @(link_name="SoundFormat_bytesPerFrame")
    SoundFormat_bytesPerFrame :: proc(fmt : SoundFormat) -> u32 ---;

    @(link_name="pd_noteToFrequency")
    pd_noteToFrequency :: proc(n : _c.float) -> _c.float ---;

    @(link_name="pd_frequencyToNote")
    pd_frequencyToNote :: proc(f : _c.float) -> _c.float ---;

    // @(link_name="PDRectMake")
    // PDRectMake :: proc(x : _c.float, y : _c.float, width : _c.float, height : _c.float) -> PDRect ---;
}

PDRectMake :: proc(x : _c.float, y : _c.float, width : _c.float, height : _c.float) -> PDRect {
    r : PDRect = { x = x, y = y, width = width, height = height };
	return r;
};