hub_names = ["XR-SFO_3-Hub"]
leaf_names = [
  "XR-SFO_3-1",
  "XR-SFO_3-2",
  "XR-SFO_3-3",
  "XR-SFO_3-4"
]

leaf-2-hub-dscids = {
  XR-SFO_3-1 = {
    XR-SFO_3-Hub-BW1 = { hubdscgid = "1", leafdscgid = "1", hubdscidlist = ["5", "1", "7", "3"], leafdscidlist = ["1", "2", "3", "4"] }
  },
  XR-SFO_3-2 = {
    XR-SFO_3-Hub-BW2 = { hubdscgid = "2", leafdscgid = "1", hubdscidlist = ["9", "11", "13", "15"], leafdscidlist = ["1", "2", "3", "4"] }
  },
  XR-SFO_3-3 = {
    XR-SFO_3-Hub-BW3 = { hubdscgid = "3", leafdscgid = "1", hubdscidlist = ["2", "4", "6", "8"], leafdscidlist = ["1", "2", "3", "4"] }
  },
  XR-SFO_3-4 = {
    XR-SFO_3-Hub-BW1 = { hubdscgid = "4", leafdscgid = "1", hubdscidlist = ["3", "10", "12", "16"], leafdscidlist = ["1", "2", "3", "4"] }
  },
}

client-2-dscg = {
  XR-SFO_3-Hub = {
    lc-XR-SFO_3-1 = {
      clientid = "1"
      dscgid   = "1"
    },
    lc-XR-SFO_3-2 = {
      clientid = "2"
      dscgid   = "2"
    },
    lc-XR-SFO_3-3 = {
      clientid = "3"
      dscgid   = "3"
    },
    lc-XR-SFO_3-4 = {
      clientid = "4"
      dscgid   = "4"
  } },
  XR-SFO_3-1 = {
    lc-XR-SFO_3-Hub-1 = {
      clientid = "1"
      dscgid   = "1"
  } },
  XR-SFO_3-2 = {
    lc-XR-SFO_3-Hub-2 = {
      clientid = "1"
      dscgid   = "1"
  } },
  XR-SFO_3-3 = {
    lc-XR-SFO_3-Hub-3 = {
      clientid = "1"
      dscgid   = "1"
  } },
  XR-SFO_3-4 = {
    lc-XR-SFO_4-Hub-3 = {
      clientid = "1"
      dscgid   = "1"
  } }
}


