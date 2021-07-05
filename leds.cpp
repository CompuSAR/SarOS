#include <stdint.h>

void ledsOn() {
    static constexpr intptr_t baseAddress = 0x0300B000;
    static constexpr intptr_t PC_CFG1 = baseAddress + 0x004c;
    *reinterpret_cast<volatile uint32_t *>(PC_CFG1) = 0x77117777;

    static constexpr intptr_t PC_DAT = baseAddress + 0x0058;
    *reinterpret_cast<volatile uint32_t *>(PC_DAT) = 0x3000;
}

extern "C"
void reset() {
    ledsOn();

    while(true)
        ;
}
