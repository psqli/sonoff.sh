# sonoff.sh

Control [Sonoff](https://sonoff.tech) single channel switches and bulbs using
the [DIY mode](https://sonoff.tech/diy-developer).

Supported devices:
[BASICR3](https://sonoff.tech/product/wifi-diy-smart-switches/basicr3),
[RFR3](https://sonoff.tech/product/wifi-smart-wall-swithes/rfr3),
[MINIR2](https://sonoff.tech/product/wifi-diy-smart-switches/sonoff-mini),
[B02-BL](https://sonoff.tech/product/b02-bl-b05-bl),
[B05-BL](https://sonoff.tech/product/b02-bl-b05-bl).

Sonoff API documentation is available
[here](https://sonoff.tech/sonoff-diy-developer-documentation-basicr3-rfr3-mini-http-api).

## Examples

Toggle switch:

```sh
./sonoff.sh 192.168.0.123 switch toggle
```

Get info about switch:

```sh
./sonoff.sh 192.168.0.123 info
```

Set bulb brightness to maximum, and set color to white:

```sh
./sonoff.sh 192.168.0.123 brgb 100 255 255 255
```

The same, but for white (warm/cold) bulbs:

```sh
./sonoff.sh 192.168.0.123 bwht 100 100
```

Set Wi-Fi network:

```sh
./sonoff.sh 192.168.0.123 wifi "Name" "p@ssword"
```
