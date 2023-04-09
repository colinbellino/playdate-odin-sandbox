package game

import "core:fmt"
import "core:c"
import "core:os"
import "core:time"
import "core:log"
import "core:strings"
import "core:runtime"
import "core:mem"
import "core:math/rand"

import pd_api "pd_api"

State :: struct {
    allocator:          mem.Allocator,
    temp_allocator:     mem.Allocator,
    temp_arena:         runtime.Arena,

    logger:             log.Logger,

    menu_1:             ^pd_api.PDMenuItem,
    menu_2:             ^pd_api.PDMenuItem,
    menu_2_value:       i32,
    menu_3:             ^pd_api.PDMenuItem,

    // game state
    score : i32,
    maxBackgroundPlanes : i32,
    backgroundPlaneCount : i32,
    bgPlaneHeight : i32,

    maxEnemies : i32,
    enemyCount : i32,
    enemyPlaneHeight : i32,

    player : ^pd_api.LCDSprite,
    bulletHeight : i32,

    // background
    bgSprite : ^pd_api.LCDSprite,
    bgImage : ^pd_api.LCDBitmap,
    bgY : i32,
    bgH : i32,

    // cached images
    // LCDBitmap **explosionImages = nil,
    bulletImage: ^pd_api.LCDBitmap,
    enemyPlaneImage: ^pd_api.LCDBitmap,
    backgroundPlaneImage : ^pd_api.LCDBitmap,
}

pd: ^pd_api.PlaydateAPI;
state : ^State;

update : pd_api.PDCallbackFunction : proc (userdata: rawptr) -> c.int {
    context.logger = state.logger;
    context.allocator = state.allocator;
    context.temp_allocator = state.temp_allocator;

    // checkButtons();
    // checkCrank();

    // spawnEnemyIfNeeded();

    // spawnBackgroundPlaneIfNeeded();
    if state.backgroundPlaneCount < state.maxBackgroundPlanes {
        if rand.int31() % (120 / state.maxBackgroundPlanes) == 0 {
            plane : ^pd_api.LCDSprite = pd.sprite.newSprite();

            pd.sprite.setUpdateFunction(plane, updateBackgroundPlane);

            w : i32;
            pd.graphics.getBitmapData(state.backgroundPlaneImage, &w, &state.bgPlaneHeight, nil, nil, nil);

            pd.sprite.setImage(plane, state.backgroundPlaneImage, .kBitmapUnflipped);
            pd.sprite.moveTo(plane, f32((rand.int31() % 400) - w/2), f32(-state.bgPlaneHeight));
            pd.sprite.setZIndex(plane, 100);
            pd.sprite.addSprite(plane);

            state.backgroundPlaneCount += 1;

            log.debug("plane spawned!");
        }
    }

    pd.sprite.updateAndDrawSprites();

    free_all(context.temp_allocator);

    return 1;
}

update_background_sprite :: proc(s: ^pd_api.LCDSprite) {
    state.bgY += 1;
    if state.bgY > state.bgH {
        state.bgY = 0;
    }

    pd.sprite.markDirty(state.bgSprite);
}

draw_background_sprite :: proc(sprite: ^pd_api.LCDSprite, bounds: pd_api.PDRect, drawrect: pd_api.PDRect) {
    if state.menu_2_value == 0 {
        return;
    }
    pd.graphics.drawBitmap(state.bgImage, 0, state.bgY, .kBitmapUnflipped);
    pd.graphics.drawBitmap(state.bgImage, 0, state.bgY - state.bgH, .kBitmapUnflipped);
}

loadImageAtPath :: proc(path: cstring) -> ^pd_api.LCDBitmap {
    outErr : cstring;
    img : ^pd_api.LCDBitmap = pd.graphics.loadBitmap(path, &outErr);
    if outErr != nil {
        pd.system.error(strings.clone_to_cstring(fmt.tprintf("Error loading image at path '%s': %s", path, outErr)));
    }
    return img;
}

updateBackgroundPlane :: proc(s: ^pd_api.LCDSprite) {
    x, y : c.float;
    pd.sprite.getPosition(s, &x, &y);

    newY : i32 = i32(y) + 2;

    if ( newY > 400 + state.bgPlaneHeight )
    {
        pd.sprite.removeSprite(s);
        pd.sprite.freeSprite(s);
        state.backgroundPlaneCount -= 1;
    }
    else
    {
        pd.sprite.moveTo(s, x, f32(newY));
    }
}

@export
eventHandler :: proc (playdate: ^pd_api.PlaydateAPI, event: pd_api.PDSystemEvent, arg: u32) -> c.int {
    #partial switch event {
        case .kEventInit: {
            pd = playdate;
            pd.display.setRefreshRate(60);
            pd.system.setUpdateCallback(update, nil);

            allocator := mem.Allocator { playdate_heap_allocator_proc, nil };
            context.allocator = allocator;

            state = new(State, allocator);
            state.allocator = allocator;

            alloc_error := runtime.arena_init(&state.temp_arena, 1 * mem.Kilobyte, allocator);
            if alloc_error > .None {
                pd.system.error("arena_init error");
                return 1;
            }
            temp_allocator := mem.Allocator { runtime.arena_allocator_proc, &state.temp_arena };
            state.temp_allocator = temp_allocator;
            context.temp_allocator = state.temp_allocator;

            state.logger = log.Logger { playdate_console_logger_proc, nil, .Debug, log.Default_Console_Logger_Opts };
            context.logger = state.logger;

            if state.allocator.procedure == nil {
                log.error("allocator:      KO");
            } else {
                log.debug("allocator:      OK");
            }
            if state.temp_allocator.procedure == nil {
                log.error("temp_allocator: KO");
            } else {
                log.debug("temp_allocator: OK");
            }

            state.maxBackgroundPlanes = 10;
            state.maxEnemies = 10;
            state.menu_2_value = 1;
            state.bulletImage = loadImageAtPath("images/doubleBullet");
            state.enemyPlaneImage = loadImageAtPath("images/plane1");
            state.backgroundPlaneImage = loadImageAtPath("images/plane2");
            state.bgImage = loadImageAtPath("images/background");

            {
                state.menu_1 = pd.system.addMenuItem("Menu 1", menu_item_callback, nil);
                state.menu_2 = pd.system.addCheckmarkMenuItem("Menu 2", 1, menu_checkmark_callback, nil);
                options : []cstring = { "Option1", "Option2", "Option3"}
                state.menu_3 = pd.system.addOptionsMenuItem("Menu 3", &options[0], 3, menu_option_callback, nil);
            }

            { // setupBackground();
                state.bgSprite = pd.sprite.newSprite();

                pd.graphics.getBitmapData(state.bgImage, nil, &state.bgH, nil, nil, nil);

                pd.sprite.setUpdateFunction(state.bgSprite, update_background_sprite);
                pd.sprite.setDrawFunction(state.bgSprite, draw_background_sprite);

                bgBounds := pd_api.PDRectMake(0, 0, 400, 240);
                pd.sprite.setBounds(state.bgSprite, bgBounds);
                pd.sprite.setZIndex(state.bgSprite, 0);
                pd.sprite.addSprite(state.bgSprite);
            }
            
            // player = createPlayer(200, 180);
        }

        case .kEventResume: {
            context.allocator = state.allocator;
            context.temp_allocator = state.temp_allocator;
            context.logger = state.logger;

            log.debug("Game resumed!");
        }
    }
    
    return 0;
}

menu_item_callback : pd_api.PDMenuItemCallbackFunction = proc(userdata : rawptr) {
    context.allocator = state.allocator;
    context.temp_allocator = state.temp_allocator;
    context.logger = state.logger;

    log.debug("menu_1");
}

menu_checkmark_callback : pd_api.PDMenuItemCallbackFunction = proc(userdata : rawptr) {
    context.allocator = state.allocator;
    context.temp_allocator = state.temp_allocator;
    context.logger = state.logger;

    state.menu_2_value = pd.system.getMenuItemValue(state.menu_2);
    log.debugf("menu_2: %v", state.menu_2_value);
}

menu_option_callback : pd_api.PDMenuItemCallbackFunction = proc(userdata : rawptr) {
    context.allocator = state.allocator;
    context.temp_allocator = state.temp_allocator;
    context.logger = state.logger;

    menu_value := pd.system.getMenuItemValue(state.menu_3);
    log.debugf("menu_3: %v", menu_value);
}

playdate_heap_allocator_proc :: proc(
    allocator_data: rawptr, mode: mem.Allocator_Mode,
    size, alignment: int,
    old_memory: rawptr, old_size: int, location := #caller_location,
) -> ([]byte, mem.Allocator_Error)  {
    switch mode {
        case .Alloc, .Alloc_Non_Zeroed: {
            // pd.system.logToConsole(".Alloc");
            ptr := pd.system.realloc(nil, uint(size));
            return mem.byte_slice(ptr, size), nil;
        }

        case .Free: {
            // pd.system.logToConsole(".Free");
            pd.system.realloc(old_memory, 0);
        }

        case .Free_All: {
            pd.system.error(".Free_All");
            return nil, .Mode_Not_Implemented;
        }

        case .Resize: {
            pd.system.error(".Resize");
            ptr := pd.system.realloc(old_memory, uint(size));
            return mem.byte_slice(ptr, size), nil;
        }

        case .Query_Features:
            pd.system.logToConsole(".Query_Features");
            set := (^mem.Allocator_Mode_Set)(old_memory);
            if set != nil {
                set^ = { .Alloc, .Alloc_Non_Zeroed, .Free, .Query_Features};
            }
            return nil, nil;

        case .Query_Info: {
            pd.system.logToConsole(".Query_Info");
            return nil, .Mode_Not_Implemented;
        }
    }

    return nil, nil;
}

playdate_console_logger_proc :: proc(logger_data: rawptr, level: log.Level, text: string, options: log.Options, location := #caller_location) {
    context.allocator = state.allocator;
    context.temp_allocator = state.temp_allocator;

    str := strings.clone_to_cstring(text, state.temp_allocator);
    if level == .Error {
        pd.system.error(str);
    } else {
        pd.system.logToConsole(str);
    }

    // data := cast(^log.File_Console_Logger_Data)logger_data
    // h: os.Handle = os.stdout if level <= .Error else os.stderr
    // if data.file_handle != os.INVALID_HANDLE {
    // 	h = data.file_handle
    // }
    // backing: [1024]byte //NOTE(Hoej): 1024 might be too much for a header backing, unless somebody has really long paths.
    // buf := strings.builder_from_bytes(backing[:])

    // log.do_level_header(options, level, &buf)

    // when time.IS_SUPPORTED {
    // 	if log.Full_Timestamp_Opts & options != nil {
    // 		fmt.sbprint(&buf, "[")
    // 		t := time.now()
    // 		y, m, d := time.date(t)
    // 		h, min, s := time.clock(t)
    // 		if .Date in options { fmt.sbprintf(&buf, "%d-%02d-%02d ", y, m, d)    }
    // 		if .Time in options { fmt.sbprintf(&buf, "%02d:%02d:%02d", h, min, s) }
    // 		fmt.sbprint(&buf, "] ")
    // 	}
    // }

    // log.do_location_header(options, &buf, location)

    // if .Thread_Id in options {
    // 	// NOTE(Oskar): not using context.thread_id here since that could be
    // 	// incorrect when replacing context for a thread.
    // 	fmt.sbprintf(&buf, "[{}] ", os.current_thread_id())
    // }

    // if data.ident != "" {
    // 	fmt.sbprintf(&buf, "[%s] ", data.ident)
    // }
    // //TODO(Hoej): When we have better atomics and such, make this thread-safe
    // fmt.fprintf(h, "%s%s\n", strings.to_string(buf), text)
}