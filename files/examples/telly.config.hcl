"Discovery" = {
  "Device-Auth" = "telly123"
  "Device-Firmware-Name" = "hdhomeruntc_atsc"
  "Device-Firmware-Version" = "20150826"
  "Device-Friendly-Name" = "telly"
  "Device-ID" = 12345678
  "Device-Manufacturer" = "Silicondust"
  "Device-Model-Number" = "HDTC-2US"
  "Device-UUID" = ""
  "SSDP" = true
}

"IPTV" = {
  "Starting-Channel" = 10000
  "Streams" = 1
  "XMLTV-Channels" = true
}

"Log" = {
  "Level" = "info"
  "Requests" = true
}

"Source" = {
  "Filter" = "YOUR_FILTER_REGULAR_EXPRESSION"
  "FilterKey" = "group-title"
  "FilterRaw" = false
  "Name" = ""
  "Password" = "YOUR_IPTV_PASSWORD"
  "Provider" = "Iris"
  "Sort" = "group-title"
  "Username" = "YOUR_IPTV_USERNAME"
}

"Source" = {
  "Name" = ""
  "Password" = "XML-Identifier"
  "Provider" = "IPTV-EPG"
  "Username" = "M3U-Identifier"
}

"Source" = {
  "EPG" = "http://myprovider.com/epg.xml"
  "Filter" = "YOUR_FILTER_REGULAR_EXPRESSION"
  "FilterKey" = "group-title"
  "FilterRaw" = false
  "M3U" = "http://myprovider.com/playlist.m3u"
  "Name" = ""
  "Provider" = "Custom"
  "Sort" = "group-title"
}

"Web" = {
  "Base-Address" = "0.0.0.0:6077"
  "Listen-Address" = "0.0.0.0:6077"
}