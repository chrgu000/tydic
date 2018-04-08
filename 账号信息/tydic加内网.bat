route delete 135.0.0.0
route add 135.0.0.0 mask 255.0.0.0 135.32.91.2 -p
route delete 0.0.0.0
route add 0.0.0.0 mask 0.0.0.0 192.168.1.1 -p