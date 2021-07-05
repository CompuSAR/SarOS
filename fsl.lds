MEMORY { .sram : ORIGIN = 0x20060, LENGTH = 0xbf00 }
MEMORY { .error : ORIGIN = 0xff0000, LENGTH = 0 }
OUTPUT_FORMAT("elf64-littleaarch64", "elf64-littleaarch64", "elf64-littleaarch64")
OUTPUT_ARCH(aarch64)
ENTRY(_start)
SECTIONS
{
    .text : {
        . = ALIGN(8);
        boot0.o (.text*)
        *(.text*)
    } >.sram
    .data : {
        . = ALIGN(8);
        *(.data)
    } >.sram
    .rodata : {
        . = ALIGN(8);
        *(.rodata)
    } >.sram

    /DISCARD/ : { *(.eh_frame) }

    .debug_info : { *(.debug_info) }
    .debug_abbrev : { *(.debug_abbrev) }
    .debug_loc : { *(.debug_loc) }
    .debug_aranges : { *(.debug_aranges) }
    .debug_line : { *(.debug_line) }
    .debug_str : { *(.debug_str) }
    .debug_ranges : { *(.debug_ranges) }
    .comment : { *(.comment) }

    .unknown : { *(.*) } >.error
}
