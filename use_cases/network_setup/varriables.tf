// If this flag is set, the module shall stop executing if there is a mismatched in device vession or Host attribute is mismatched
// Otherwise continue to run.
variable asserts {
  type = list(string)
  default = ["Version", "HostAttributeMismatched"]
}


