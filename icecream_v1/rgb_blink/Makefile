COMPONENT = up5k
PACKAGE = sg48

VERILOG_FILES = rgb_blink.v
PCF_FILE = rgb_blink.pcf

FLASHROM_LAYOUT = icecream_v1.flash_layout
FLASHROM_IMAGE = bitstream

FLASH_SIZE = 16777216

all: rgb_blink.bin

flash: rgb_blink.bin_padded
	flashrom -p usbblaster_spi -N -l "$(FLASHROM_LAYOUT)" -i "$(FLASHROM_IMAGE)" -w "$<"

rgb_blink.json: $(VERILOG_FILES)
	yosys -p "synth_ice40 -json $@" $(VERILOG_FILES)

%.asc: %.json $(PCF_FILE)
	nextpnr-ice40 "--$(COMPONENT)" --package "$(PACKAGE)" --pcf "$(PCF_FILE)" --json "$<" --asc "$@"

%.bin: %.asc
	icepack "$<" "$@"

%.bin_padded: %.bin
	dd if=/dev/zero of="$@" iflag=count_bytes count="$(FLASH_SIZE)"
	dd if="$<" of="$@" conv=notrunc
