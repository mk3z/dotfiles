let
  mkez = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKVXV+51+7Evucq9Qi9QCs2LugQii6AjvDfIg3u7oiOe";
in {
  "password.age".publicKeys = [mkez];
  "borg.age".publicKeys = [mkez];
}
